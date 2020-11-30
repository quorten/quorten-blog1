---
layout: post
title: Verilog sequential logic timing explained
date: 2020-11-28 16:41 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Sequential logic in Verilog, at the outset, is a little bit tricky
because you must be careful to use the non-blocking assignment
operator `<=` instead of the blocking assignment operator `=`,
otherwise you'll get incorrect simulation results.  Okay, so now
you've written up some sequential logic in Verilog and you get around
to simulating it.  "Wait a minute," you're wondering.  "Sequential
logic models the process of reading and writing to latch registers.
This means when I perform an action on the risng edge of the clock,
the results of it won't be visible until the next rising edge of the
clock, right?"  Well, not quite.

Take, for example, the following simple Verilog code to implement a
shift register.

<!-- more -->

```
module myshift (n_rst, clk, in, out);
  input wire n_rst, clk, in;
  output wire out;
  reg in0, in1, in2, in3;

  assign out = in3;

  always @(negedge n_rst) begin
    in0 <= 0; in1 <= 0; in2 <= 0; in3 <= 0;
  end

  always @(posedge clk) begin
    if (n_rst) begin
      in0 <= in;
      in1 <= in0;
      in2 <= in1;
      in3 <= in2;
    end
  end
endmodule
```

So, what happens here?  When is the input value read, when does the
output value change?  Verilog turns out to be pretty tricky in this
regard.  As a simulation platform, Verilog is specified to execute
non-blocking assignments as follows: "the input value is evaluated
immediately, and the output is assigned after a delay."  But, what
exactly is that delay?  If no delay is explicitly specified, this is
simply "as short of a delay as possible," namely the very next
simulation cycle.  The simulation time cycle granularity is derived
from your `timescale` specification, and generally you specify your
timescale to be substantially smaller than your clock period.

So, this means... in simulation, all non-blocking assignments will
retrieve the old register values first, then write the new register
values second, but because it will be so fast, when you look at the
VCD oscilloscope traces, it will appear as if the new output value is
being propagated on the same rising edge of the clock where you are
computing it.  But, in fact, there is an infinitesimal delay between
these two events.

The problem with this method of simulation is obvious.  As a designer,
you're getting the wrong idea of how the circuit will work in hardware
at face-value.  However, under a very restricted set of conditions,
this simulation convention is an accurate and computationally
efficient model of how the real hardware would behave:

* There is only a single clock frequency governing sequential logic.

* All sequential logic actions are triggered on the same edge of the
  clock.  For example, only the rising edge of the clock is triggered.

* All combinatorial logic outputs are computed from sequential logic
  inputs governed by the same single clock frequency.  This means
  there must be no no asynchronous inputs: they must be properly
  buffered to implement synchronous input signal delays.  The only
  exception is the `RESET` signal.  However, since low-end FPGAs don't
  support asynchronous `RESET` anyways, it might as well be easier to
  model all inputs as synchronous.

* When looking at VCD oscilloscope traces, you can understand that
  there is an implicit separation of signal reads happening before
  signal assigns.  For example, if you see the output signal changing
  on the rising edge of the clock, implicitly the input signals were
  read on the preceding falling edge of the clock.

* As a designer, you are fully aware that when you specify sequential
  logic actions triggered on the rising edge of the clock (for
  example), this means your VCD oscilloscope output will look as if
  you are intending the final write to occur on the rising edge, while
  the read and compute is implicitly occurring on the falling edge.

If any of those assumptions are not true, of the consequences are
undesirable, then you can specify a delay between when the input is
evaluated and when a non-blocking assignment actually occurs.
Example:

```
module myshift (n_rst, clk, in, out);
  input wire n_rst, clk, in;
  output wire out;
  reg in0, in1, in2, in3;

  assign out = in3;

  always @(negedge n_rst) begin
    in0 <= 0; in1 <= 0; in2 <= 0; in3 <= 0;
  end

  always @(negedge clk) begin
    if (n_rst) begin
      in0 <= @(posedge clk) in;
      in1 <= @(posedge clk) in0;
      in2 <= @(posedge clk) in1;
      in3 <= @(posedge clk) in2;
    end
  end
endmodule
```

This enforces, in the software simulation, that on the falling edge of
the clock, the input values are read and computed, and not until the
rising edge of the clock are the new output values propagated.

This is a faithful simulation of the behavior of hardware latches as
typically used for registers in simple computers: the latch mechanism
itself essentially has two levels of storage, at any given time one is
locked for writes while the other is unlocked.  The current level of
the clock determines which set is locked/unlocked.  So, for example,
the falling edge of the clock is the first instant when the clock goes
low, this is when we compute the new register value from the old value
and latch this into the first level of storage, while the second level
remains locked so that we can compute the first level
deterministically.  Then, on the rising edge of the clock, the first
instant when the clock goes high, we lock the first level of storage
but the second level is unlocked, this causes the latched values to
propagate to the register's final output values that can then be used
for computation in the next cycle, along with output to external
peripherals.

In more advanced and powerful hardware design, you might use an edge
triggering circuit and high-speed latches instead.  Essentially, the
rising and/or falling edge of the clock can be transformed into a
high-frequency pulse, and this pulse can drive the latch registers in
lieu of direct drive by the clock signal.  Furthermore, it is possible
to use D flip-flops with only a "single level of storage" rather than
conventional two-level latches if the high-frequency circuit operation
is timed correctly.  Obviously, this requires more powerful hardware
capabilities, and especially for hobbyists, this can mean the need to
use rather expensive FPGAs for this design.  Hence, my emphasis on
designs that are more permissive toward low-speed logic, and
especially logic that isn't so sensitive to critically signal-timed
simulations.

For the case of combinatorial logic, it is also possible to specify
delays to model.  Note, of course, that those delays specified are
non-synthesizable specifications.  Two notable cases to model.

* "Inertial delay," a gate's resistance to change causes input
  glitches to not propagate to output.  Use delayed evaluation
  blocking assignments.  However, I must note that this method of
  modeling inertial delay is only an approximation of a true integral
  simulation behavior.  Example:

  ```
  #5 out = in;
  ```

  Repeated over several iterations, though, the overall result is
  integration over 50% of the specified time delay, provided that
  there is not artificial alignment of sampling in the simulation with
  respect to the input signal changes.  An easy way to avoid this
  would be to use a somewhat large prime number for the delay, though
  this also comes at the expense of longer simulation times.

* "Transport delays," a gate's switching logic causes a slow-down in
  when the signal gets propagated to the output.  Use delayed
  assignment non-blocking assignments.  This method of simulation is
  precise.  Example:

  ```
  out <= #5 in;
  ```

Here is the great resource I found to help clear up my lack of
understanding in Verilog high frequency timing.

20201128/DuckDuckGo verilog what is the delay of non-blocking
  assignment  
20201128/https://www.sutherland-hdl.com/papers/1996-CUG-presentation_nonblocking_assigns.pdf
