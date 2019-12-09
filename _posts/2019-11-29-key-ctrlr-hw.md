---
layout: post
title: How to build a keyboard controller in pure hardware circuits
date: 2019-11-29 23:41 -0600
author: quorten
categories: [raspberry-pi, unlipic]
tags: [raspberry-pi, unlipic]
---

A matrix scanning keyboard controller connected to a computer via
serial communications.  Yes, indeed this is an easy concept to build
out in software via a microcontroller, but Don Lancaster's TV
Typerwriter was all hardware based, as were other early computer
terminals.  So, ultimately, the question comes down to "how do you
build a keyboard controller in pure hardware circuits?"  The solution
is simple once you think through things a bit.

The key to realize is that the entire process can be drafted around
the concept of a big central clock that drives the entire controller,
and higher-level operations can be designed around "outer loops" that
run on slower clocks.  Here is an abstract listing from fastest
looping, lowest-level operation to slowest-looping, highest-level
operation.

1. Shift out UART buffer, i.e. serialize a single 8-bit UART character
   that corresponds to a key event message.

2. Scan a single key.

3. Scan a single column (column-major) or row (row-major).

4. Scan the entire keyboard matrix.

5. Cycle through old, new, and current keyboard state buffers.

<!-- more -->

Yep, it's really as easy as that.  You really only need four frequency
dividers, and the outer-most frequency divider can simply be a
counter.

### Basic Design

The basic hardware design can be explained as follows.

To scan the keyboard matrix, you simply connect the corresponding
clock frequencies to shift registers.  In the case of a column-major
matrix, the row scan is a parallel in, serial out (PISO) shift
register for reading the contents of the selected column, and the
column scan is a serial in, parallel out (SIPO) shift register for
seleccting the column.  The output of the SIPO shift register is fed
back to the input for a continuous select single column scan loop.  A
RESET must zero the register and prime it with a one at the input.

The continuous stream of PISO shift outputs will give you a sequential
list of keyboard state images at each consecutive keyboard scan cycle.
You then want to translate this "absolute state" image into a "delta
state" image.  What keyboard state changes happen from one scan cycle
to the next?  This can be determined simply by comparing the old
keyboard state to the new keyboard state.  From such a comparison, you
can generate a "delta keyboard state" image, with one of the following
"delta state" values for every key.

1. `old == new => nil`
2. `!old & new => keydown`
3. `old & !new => keyup`

The absolute keyboard state images can be stored in a circular buffer
with three elements: old, current, and new.  "New" is where the
keyboard matrix scan in progress is stored to, so as to not interfere
with the keyboard state comparison circuit.

Finally, once you have the delta keyboard state image, you simply need
to scan through each entry and shift it out through the UART.  For
`nil` events, you can simply use silence on the UART, i.e. the line is
simply held high and no character is encoded and sent.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2019-11-29-keyscan_hardware.svg"
        width="1400" height="650">
  <img src="{{ site.baseurl }}/blog/images/2019-11-29-keyscan_hardware.png"
       alt="Electrical outlets picture"
       width="1400" height="650" />
</object>

### Design Considerations

* The need for detecting ghost keys can be eliminated by using diode
  isolation on every single key in the keyboard matrix to support
  n-key rollover.

* Assume the UART runs at a high enough clock speed so messages never
  need to get buffered or discarded.

* However, one practical way to limit the required speed of the UART
  is to limit the number of keys that can be pressed simultaneously,
  as would be the case with ghost key detection.

* Ghost key detection can be implemented by incrementing a counter as
  we scan the keyboard.  If any ghost keys are detected, we discard
  the entire keystate buffer by refusing to increment the CNTR.  To
  implement this logic proper, we need to allocate extra time cycles,
  literally like special buffer positions for "ghost keys."  This is
  the cycle where the decision is made whether or not to increment
  CNTR, and to reset the ghost key counter.

  Additionally, we could also encode a special message on the UART to
  indicate ghost keys were detected and the entire instantaneous
  keyboard state was discarded.

* A hardware keyboard controller can pipeline multiple stages and run
  them simultaneously, but a software keyboard controller can only run
  sequentially.  Therefore, a hardware design can scan the keyboard
  more frequently, though not necessarily faster.

* General design considerations with memory buffers.  Generally, we
  want to be careful about simultaneous access, whether it be read or
  write, because that may mean we may need multiport memory.  A
  general trick to eliminate this is to define sub-cycles where each
  user accesses the memory only on alternating cycles.  If the same
  item is accessed at the same time, multi-read single-write style,
  this can be done in the same cycle.

  Another trick is to use double-buffering in place of triple
  buffering.  If one user loops through the buffer at an offset
  compared to another user, effectively the two users will access a
  whole older or whole newer copy of the same bufer.  However, this
  also requires one extra buffer entry to preserve consistency for the
  very first and last elements.

### Running the UART off an independent clock

It is possible to run the UART off of a fully independent clock from
that of the matrix keyboard scanner.  However this comes at the risk
of buffer overruns if the UART character clock runs at a slower speed
than the matrix keyboard scanner clock.  This means that you need
additional logic circuits for a FIFO send buffer, a buffer overrun
message, and selective accumulation and clearing of delta keyboard
state based off of whether a particular message reached the UART FIFO
yet.

How do we handle message discarding on buffer overruns?  We keep a
delta keyboard state image of key messages that have not yet reached
the UART FIFO.  In the event that the UART FIFO is full but the
pending delta key event for that key was nil, no data was lost, simply
a delay was introduced.  But, if there is already an existing keydown
or keyup event in the delta keyboard state image and we must write a
competing event, then a full keypress event was lost.

The idea is that we want to take a full keyboard buffer and delta
encode it into messages in such a way that the host computer is
notified of the most up-to-date state as soon as possible.  This is
why we let new key state changes on the same key overwrite old ones
rather than discard new key states.  Otherwise, missed messages can
result in a key getting stuck in the wrong state on the host.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2019-11-29-keyscan_uart_fifo.svg"
        width="1375" height="550">
  <img src="{{ site.baseurl }}/blog/images/2019-11-29-keyscan_uart_fifo.png"
       alt="Electrical outlets picture"
       width="1375" height="550" />
</object>

### MIDI Keyboard Controller in Hardware

One of the most sophisticated keyboards to implement is a MIDI
keyboard.  Not only does this require n-key rollover, but it also
requires reporting the key "velocity" or how "hard," i.e. how much
force, the key was struck with.  On an acoustic piano, the loudness of
a note is determined by the amount of force exerted into the piano
keys, which determines, through lever action, the amount of force the
hammers strike the piano strings with, and therefore the amplitude of
their vibration and the emitted sound.  More force corresponds to
greater acceleration, which likewise corresponds to a greater average
speed when a piano key passes between two fixed points.  By placing
two switches at separate depth points for a single key and measuring
the time difference that those switches are triggered at, the average
velocity can be determined, and therefore the acceleration, force, and
corresponding sound amplitude.

The simplest MIDI keyboard controller would just double the number of
reported key events and report it all back to the host computer for
processing, but why not build this directly into the hardware keyboard
controller?  That helps reduce computational load on the host computer
and provides for a more convenient programming interface, although it
does not result in a faster keyboard scanning rate.

So, here's how to do the modification for MIDI keyboard timing in the
keyboard controller.  First keydown switch sets a "half keydown" state
in the delta keyboard state buffer, which is not sent out.  It
includes the time code.  Next keydown switch sets a "full keydown"
state in the delta keyboard state buffer, which overwrites the
location of the half keydown state and stores the delta time code,
with saturating arithmetic.  The full keydown message is send out to
the UART.  Likewise can be done for keyup.

Additionally, another modification we could make is to also encode the
time code of key events into the key messages _in the controller
itself_.  This eliminates the need for the host computer to respond to
key events in realtime and attach time codes to them.  But, how
exactly can this be advantageous?  Doesn't the host computer need to
immediately respond on the interrupt anyways?  Not necessarily.  If
there is a UART FIFO receive buffer, then the host computer can take
its time.  This would typically be okay for key events from a
"typewriter" keyboard, but it would be unacceptably inaccurate for
musical input.  Ultimately, however, the keyboard time codes are
measured on a circular buffer, and "ping messages" would be needed so
that the host computer can keep track of time code wraparounds.

What about encoding the messages so they specify a delta between the
last message instead of a quasi-absolute time?  In general, that's
harder to program against because all such messages must be processed
in-order.  With a quasi-absolute time code, some degree of
out-of-order and parallel is permitted, thus also allowing for
programming more performant code.
