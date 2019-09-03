---
layout: post
title: Lowdown on real-time Linux GPIO hardware control on Raspberry Pi
date: 2018-12-28 18:14 -0600
author: quorten
categories: [raspberry-pi, linux-audio, reiterate]
tags: [raspberry-pi, linux-audio, reiterate]
---

So, I've learned about realtime Linux before from my experience with
Linux Audio, ALSA, JACK, and the like.  So, I have a nifty Raspberry
Pi trick up my sleeve related to this.  Despite the common conception
in Raspberry Pi hardware projects that _all_ high frequency hardware
control requires a microcontroller, indeed there are some important
circumstances where an additional microcontroller is not needed.  Most
importantly, by being able to eschew with a microcontroller where it
is not needed, you can reduce the cost of your final product.

### Review of Linux Audio with ALSA/JACK

So, let's review.  How does realtime Linux Audio with ALSA/JACK work?
First of all, you must make sure your Linux kernel is realtime
capable.  In the past, during the heyday of Linux kernel 2.6.x on x86
CPU hardware, getting good realtime performance meant tweaking the
kernel config, applying the Linux realtime kernel patches, and custom
compiling your own kernel.  However, in later versions of Linux, after
kernel 3.x or so, it was no longer necessary to custom compile your
kernel to get good realtime performance.

<!-- more -->

Once you have the right kernel, the next step is to configure system
privileges to allow a restricted subset of processes to access the
realtime capabilities.  In the Linux Audio and ALSA/JACK world, this
means assigning the elevated privileges to the `audio` group.  You
would edit `/etc/security/limits.d/audio.conf` to add the following
lines to enable users of the `audio` group permissions to (1) assign
realtime priority to threads and (2) call `mlock()` and `mlockall()`
to pin process memory to RAM to prevent it from being paged out to
disk.  Memory paging to disk incurs a significant time overhead and
can easily cause a thread to fail to meet its realtime deadlines.  All
of this complex explanation is boiled down to adding only a few lines
to the file `/etc/security/limits.d/audio.conf`:

```
@audio   -  rtprio     99
#@audio   -  memlock    unlimited
@audio   -  memlock    2097152
#@audio   -  nice      -19
```

Okay, so a few last notes are worth mentioning here due to the
inclusion of a few extra commented lines that came from a live system.
One possible tweak is to allow the audio group the `nice` value that
corresponds to the highest possible priority, -19.  However, I have it
commented out as it seemed not to make a difference for me in
practice.  Another specific is on the value of `memlock`: `unlimited`
is commented out and replaced with a fixed limit since a runaway
`memlock` allocation could freeze the system.

Also, as part of configuration, you need to make sure that the high
resolution multimedia timer module, `snd_hrtimer`, is loaded into your
running kernel.  However, not all Linux Audio applications require
access to the high resolution multimedia timer.  We'll cover more on
this later.

So, let's talk more about the audio timers.  First of all, the sound
card is an important piece of hardware governing audio timing and
control.  Modern PCM sound cards are designed to assume that there is
going to be some latency between host CPU interactions with the sound
card hardware.  However, PCM sampled audio is a very time performance
critical application.  Most consumer PCM sound card have a sampling
rate fixed at 48 kHz.  Professional PCM sound cards can have much
higher sampling rates, but although they can also have lower sampling
rates, the lowest sampling rates supported in hardware are not much
lower than the fixed sampling rate of consumer PCM sound cards.  This
means that during audio recording or playback, the sound card must
perform an input/output operation continuously 48 thousand times a
second, without delays lasting longer than 1/48000 of a second.  The
low-level hardware analog-to-digital and digital-to-analog converters
factor in a time delay of their own right, approximately half a
millisecond with variations depending on the specific hardware,
leaving even less time for the remaining logic to act.

Although modern CPUs are very fast, a modern time-sliced, pre-emptive
multitasking operating system with hardware abstraction and a device
driver model schedules in much larger time slices than the duration of
a single PCM sound sample.  Therefore, in order to enable the ability
of modern computers to work with sound cards, the sound card must
feature _buffers_.  An input buffer stores up recored sound until the
operating system can get a large time slice to process the data in
bulk, and an output buffer allows the operating system to send sound
output in bulk in a larger time slice.  For the sake of streaming
audio input and audio output, the sound card can also send the host
CPU interrupts when the input buffer is approaching full, or when the
output buffer is approaching empty.  The CPU must respond to this
request before the buffers are completely full or empty.  In ALSA/JACK
terminology, a failure to empty the input buffer before it is
completely full is called a _buffer overrun_.  Likewise, a failure to
fill the output buffer before it is completely empty is called a
_buffer underrun_.  The combination of either of the two events is
referred to an an "XRUN," "X" being an variable corresponding to
either "under" or "over."

For most consumer applications such as IP telephone conversations,
video chat, watching streaming Internet videos, listening to music,
and so on, relatively large audio buffers are perfectly acceptable
because there are much longer delays within the telecommunication
network mask the local delay due to audio buffers between the
operating system and the sound card.  Matter of fact, larger audio
buffers are preferred for typical consumer applications because this
allows the energy hungry CPU to go completely to sleep, which saves
energy and prolongs battery life compared to running at a certain
clock rate to keep interacting with the sound card.  By contrast, for
audio production, live performances, and virtual musical instruments,
the smallest audio buffers possible are preferred because this
translates to the lowest possible latency in the digital computer
system, and all other factors have already been controlled to minimize
latency as much as possible, such as having the live audience on the
same physical premises as the live performers.

Earlier I mentioned that not all Linux Audio applications need the
high resolution multimedia timer.  Just to clarify given the most
recent points I've mentioned, I was referring to _realtime_ Linux
audio applications.  Anyways, now the explanation about the specifics
of high resolution multimedia timer can be made obvious.  The sound
card interrupts for buffer filling and emptying is one source of
regular timer ticking, and this is also a reliably synchronized time
source.  For the most basic of audio applications, running off of the
number of samples sent or received over the audio interface is good
enough for their timing needs.  Only in more advanced applications is
it necessary to have additional high-resolution timing features and
functions, and this is where `snd_hrtimer`, the Linux high resolution
multimedia timer, comes into play.

What are the limitations of realtime Linux Audio with ALSA/JACK?
Realtime Linux Audio can still work well with latencies such as 3 ms
to 10 ms.  For comparison, the amount of time for sound to travel
through one meter of air at sea level is approximately 3 ms.  So, a
few milliseconds of latency is acceptable as it translates simply to
the instrument's "sounding board" being a few meters further away from
the performer, but latencies much longer than this can quickly make a
virtual instrument unplayable.  Also, due to the assumption that a
sound card has buffers, the host CPU is allowed more leeway jitter on
_when_ it responds: to maintain 3 ms latency or better, it can respond
with a delay anywhere between 1.5 ms and 3 ms.  By contrast, some
motor control applications may require much tighter polling loops than
this.  Or, even if they do not require tighter polling loops, they may
have requirement that they respond every 3 ms with a jitter of no more
than 0.1 ms.  If this is the case, then you _really_ know that you
need to use a microcontroller for your hardware control.  Otherwise,
hardware control using Linux realtime threads could just as well be a
viable option for you.

But, I must also recognize the alternate path that many beginners
before me have taken.  Previously, indeed during the times when a
standard Linux kernel build wasn't good enough for realtime audio,
according to one review written for the Gertboard on Amazon, realtime
threads on Linux were "black arts of Linux and C" that required
compiling your own kernel.  By contrast, offloading time-critical
programming to an AVR series ATmega (i.e. Arduino) microcontroller was
"much easier."  (Note that quoted phrases may not be exact.)

### Aside: How exactly does built-in Raspberry Pi audio function?

Why couldn't I get JACK to work on my Raspberry Pi in 2012?  Well,
with the current review and a few other tidbits of knowledge about
Linux, Debian, JACK, and Raspberry Pi at the time, we can try to draw
a few conclusions as to why this wouldn't work very well.  However, as
it turns out that my conclusions reached that it should work okay,
this will end up being mainly a primer on the specifics of audio
input/output on a Raspberry Pi.

First of all, all of my previous discussion assumed that the sound
card hardware had hardware audio buffers for input and output.  It's
tough to see how this works on the Raspberry Pi, but with some careful
analysis, you can see that all models of the Raspberry Pi with builtin
audio output do in fact have a hardware audio output buffer of some
sort.  So, let's take a look for ourselves.

Unfortunately, accurate information on the is a bit harder to come by
than you think it should.  I checked out one of the more recent links
to the Raspberry Pi schematics but didn't see the discrete analog
audio filtering circuits in the links I found.  Also, Wikipedia seemed
to hint that the built-in audio output might use I2S on the later
board revisions.  Nevertheless, I did find that Hackaday.  I'll
clarify the Wikipedia statement in a bit.

20181229/DuckDuckGo raspberry pi audio pwm  
20181229/https://hackaday.com/2018/07/13/behind-the-pin-how-the-raspberry-pi-gets-its-audio/  
20181229/https://www.raspberrypi.org/forums/viewtopic.php?p=73184  
20181229/https://en.wikipedia.org/wiki/Raspberry_Pi  
20181229/https://en.wikipedia.org/wiki/RC_circuit  
20181229/https://en.wikipedia.org/wiki/Pulse-density_modulation  
20181229/https://en.wikipedia.org/wiki/Low-pass_filter  
20181124/https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

First, the information I gleaned from Hackaday.  Indeed, the Hackaday
analysis confirms my earlier readings.  The Raspberry Pi, including
all revisions that have built-in audio output, uses both PWM channels
available to correspondingly generate the left and right audio
channels in the stereo audio output.  The original model basically had
two simple RC (resistor-capacitor) low-pass filters: first a low-pass
filter to convert pulse-density modulated (PDM) sound into an analog
waveform, then a high-pass filter to remove extra low frequencies that
can cause uncomfortable rumbling and damage to audio equipment.
Pulse-density modulated sound uses a higher frequency of 1 bits where
the amplitude of the waveform should be higher, and a lower frequency
of 1 bits where the amplitude of the waveform should be lower.  A
low-pass filter simply smoothes out this high-frequency waveform by
averaging it out over a larger time period, and the analog waveform is
generated simple as that.  Finally, the Raspberry Pi has one last
diode bridge tidbit of hardware simply for the sake of electrical
protection ans isolation of the circuitry from stay currents on the
audio input.

So, what about my earlier comment on hints that later board revisions
might use I2S for the built-in audio output?  As it turns out, the
correct clarification is that earlier board revisions didn't have I2S
wired up _at all_.  The pins to the BCM2835 were left unconnected
because they were inner pins on the BGA (ball grid array) package, and
connecting them would have required complex vias that would have
increased the board manufacturing cost.  However, revision 2 of the
board did include wiring to connect I2S to the GPIO pin header, so
effectively all modern boards have I2S available at the GPIO pin
header.  However, since there is only one I2S output interface
available, for a simple analog output circuit to use this, it would
need to include additional logic to deserialize the stereo channels.
That is simply not the case on the Raspberry Pi.  That's how we know
that PWM is still used for the later boards.

So, let's get into the details of how this PWM interface works.  The
Broadcom BCM2835 ARM peripherals specification is great help in
understanding the features, functions, and capabilities of the BCM2835
hardware PWM support module.  As it turns out, the PWM has multiple
modes of operating.  The simplest modes simply output a PWM signal at
a fixed frequency, but the most interesting mode to us is the one that
outputs a bit stream onto the PWM line.  This mode happens to support
a FIFO queue with a depth of **eight 32-bit words.**  (Or is it 16
32-bit words?  Unfortunately the specification isn't clear here.)
There you go, that's a hardware audio output buffer right there.

However, some calculations show that this is a rather small hardware
audio buffer.  To ideally represent an 8-bit PCM sample in PDM, you
would need 256 PDM samples.  The PWM clock is nominally 100 MHz, but
it can be reconfigured to run at other speeds.  I have yet to find
information on what nominal PWM frequency is used by the Raspberry Pi
built-in audio output.  If we assume it's the default, then we have
2083 PDM samples per PCM sample at 48 kHz.  That's only eight 8-bit
PCM audio samples, but it's too short for a single 16-bit PCM audio
sample.  Alternatively, it's enough for one 11-bit PCM audio sample,
which is the purported audio quality from the Raspberry Pi forum.

Now, if you're liberal, you can use an _error diffusion_ technique to
approximately represent higher resolution PCM samples in a smaller
amount of PDM space.  The thing about error diffusion is that when you
have multiple consecutive samples of similar value, which is often the
case for audio signals, you can end up getting a more accurate
representation of the original value over the longer time period.  So,
if we assume assume we're willing to pack eight times as many 8-bit
PCM samples using error diffusion, our hardware audio output buffer
might have a total of 64 PCM samples.  That's still tight realtime
deadline to meet, and that's even when we're making compromises on
sound quality to get there.  Suffice it to say, for this reason, we
_know_ that some kernel-mode realtime thread is being used
successfully on the Raspberry Pi to implement its built-in audio
output, and apparently it works quite well.

However, it would have been really nice and smart to use the
integrated I2S interface for the audio output.  First off, it has 64
32-bit words for its FIFO queue, which means that the realtime thread
responsible for filling the hardware audio output buffer can run on a
looser schedule.  However, this is still a pretty tight realtime
deadline to meet.

Here's another interesting capability of the I2S interface.  The I2S
interface supports two PDM microphone inputs.  So, you wonder, how do
you construct a PDM microphone?  Unfortunately, it's not as easy as
construction a PDM output.  You have to use a delta-sigma modulator
that involves some op-amp circuits, an op-amp itself requiring 20
transistors.

https://en.wikipedia.org/wiki/Delta-sigma_modulation  
https://en.wikipedia.org/wiki/Op_amp_integrator  
https://en.wikipedia.org/wiki/Operational_amplifier

Personally, I was quite impressed to see the Raspberry Pi use a audio
PWM circuit similar to the one that is used in the original Macintosh.
Actually, it is a little bit better than the original Macintosh
circuit.  The Raspberry Pi uses PDM to allow for both variable
frequency and variable amplitude waveforms, whereas the original
Macintosh only uses PWM to modulate the frequency.  However, upon
closer analysis, I can see that Raspberry Pi technique does cause
audio quality problems compared to the modern techniques.  Indeed,
given that the Macintosh computer was a first of its kind, we had
different standards for audio quality back then than we do now,
markedly lower standards to be specific.

Suffice it to say, if you are going to be running JACK, you probably
want an audio input/output solution that is more adept toward audio
production use.  At the very least, you can get some better quality
options by using a small USB-connected audio adapter, which
technically functions as an additional sound card of its own.  The
main limitation of this technique for realtime use is potential USB
bus contention.  To get better quality than that, the _ne ultra_
option is to use one of those _audiophile_ branded Pi HAT sound cards
purpose-built for the Raspberry Pi.  Not only do they feature
excellent DAC (digital to analog) and ADC (analog to digital)
converters, but surely they have better options of audio buffering,
and being connected to one of the GPIO pin header interfaces (I2C,
SPI, I2S, individual GPIO pins, etc.), they have the lowest possible
latency as an external board.

----------

### Real-time hardware control on Raspberry Pi

Programming realtime audio applications via JACK is easy and simple.
I've personally done it once before, but I will not cover the
specifics here.  If you want to see the main application I did
programming with JACK for, check out Slider Wave Editor, now recently
uploaded to my GitHub account for your convenience:

JJJ TODO: Verify modern compile and add link!

20181228/https://github.com/quorten/slider

So, all that being said, how do you build a more general-purpose
real-time application for the purpose of controlling hardware
connected to a Raspberry Pi?  Well, right off the bat, I can say that
what I know about the generic techniques for doing so are that they
are not as easy as they are for programming realtime Linux audio
applications.  Maybe I am unaware of a framework has emerged to make
programming realtime threads on embedded Linux boards easy like
programming realtime audio, but no worries.  You don't have to add too
many additional things into your program to make a generic realtime
program.

So, first things first, make sure your system is compiled and
configured for realtime support.  This is basically the same as was
previously described for Linux realtime audio, but of course you are
going to use a group other than `audio` for the realtime permissions,
maybe like `rpihw` to designate your processes that are in charge of
direct access to hardware connected to your Raspberry Pi.

Your second concern is to verify that you have a reliable realtime
timer source that you can use to synchronize starting your realtime
processing thread.  In Linux realtime audio programming, you have the
luxury of the sound card interrupts, which are propagated through
ALSA, to JACK, and finally to your realtime audio application.  For
most Raspberry Pi style hardware interfacing, you unfortunately won't
have access to such a dedicated hardware interrupt line.  (Sometimes
you'll be able to setup an interrupt on the rising or falling edge of
a GPIO input.)  However, you can achieve a similar effect through the
generic Linux high resolution timer, `hrtimer`.  Make sure this module
is either compiled-in (check for CONFIG_HIGH_RES_TIMERS=y in your
compile-time Linux kernel config) or loaded so it will be ready to
use.  Although it might be possible to use `snd_hrtimer`, I wouldn't
recommend it for general-purpose, non-multimedia applications.

Note that on Raspbian, unlike on Debian, the compile-time kernel
config file is not included on the installed system.  You can find the
default kernel config file in the kernel source code.  If you do need
to rebuild your kernel, you'll find that the process for Raspbian is
not the same process as is used for standard Debian-based
distributions.  Find the information on how to perform the
Raspbian-specific process here.

20181228/DuckDuckGo raspberry pi linux config settings  
20181228/DuckDuckGo raspberry pi linux kernel config file  
20181228/https://www.raspberrypi.org/documentation/linux/kernel/configuring.md  
20181228/https://www.raspberrypi.org/documentation/linux/kernel/building.md

Now, the rest concerns how you write your realtime process that
controls your hardware, so you can relax from all the sysadmining and
concentrate on some coding for the next long while.

The very first thing you should do is call `mlockall()` at the very
start of your `main()` function.  Technically you may only need
realtime threads in your realtime process, but if you don't want any
confusion as to whether memory is or is not used by a thread and thus
needs to be locked.  Also, keep in mind that memory is locked on page
granularity, so if you do want to do such a scheme, you must adjust
your real time thread's memory allocations accordingly and avoid doing
things that would call `malloc()` onto a thread-shared heap.

```
#include <unistd.h>
#include <limits.h>
#include <sys/mman.h>

int
main (int argc, char *argv)
{
  mlockall (MCL_CURRENT | MCL_FUTURE);
  /* Parse command line arguments...  */
```

Oh, before we get too far, let me review another important point.
Again, I reiterate, because this is important!  You have seen that I
have chosen C/C++ as the programming language of choice for writing
this realtime application.  As I have already mentioned, it is
important that you can control dynamic memory allocation behavior for
realtime applications.  Ultimately you want to _limit_ or _eliminate_
the need for dynamic memory allocation.  The C programming language is
a great language for this purpose, even if referenced tongue-and-cheek
for this facet.  Second, in the interest of speed, you want to have a
nice fast compiled programming language.  Although I have previously
recommended Golang as a nice, fast, compiled high-level programming
language for the Raspberry Pi that will not slow you down as much as
Python does on the limited hardware, alas, its dependence on garbage
collection and dynamic memory allocation knocks it out of the realtime
programming race.  Sorry, maybe a future revision of Golang will have
better luck next time with static memory allocation for realtime
performance.

Well, anyways, back to the coding.  Now that you have your process
memory pinned to RAM, you need to spawn a realtime thread and schedule
it to run periodically on a high resolution timer, accurate for
realtime scheduling.  For setting up real-time scheduling, we have
`sched_setscheduler()` for kernel thread IDs and `pthread_set_sched()`
for `pthread` thread IDs.  For the high resolution timer, we have
`hrtimer`.

Use `SCHED_RR` ("round robin scheduler") for the realtime priority of
most realtime threads.  `SCHED_FIFO` should be used with utmost care
only for realtime threads that _must_ run for longer than a time slice
because it essentially locks up the system until the realtime thread
yields back control.

So, now we're ready to continue our example with creating a realtime
thread, albeit without the callback/sleep timer loop structure
configured.

```
#include <unistd.h>
#include <limits.h>
#include <sys/mman.h>
#include <pthread.h>
#include <signal.h>
#include <sched.h>

void *
thread_func(void *data)
{
  /* Do something in a realtime loop.  */
  pthread_exit ((void *)0);
}

/* Thread ID of the realtime worker thread.  */
pthread_t rt_tid;

int
main (int argc, char *argv)
{
  mlockall (MCL_CURRENT | MCL_FUTURE);

  /* Parse command line arguments...  */

  { /* Create our realtime thread.  */
    int result;
    struct sched_param rt_sched_param;
    pthread_attr_t rt_attr;
    void *arg = NULL; /* Pass a parameter to the thread */
    rt_sched_param.sched_priority = SCHED_RR;
    result = pthread_attr_init (&rt_attr);
    if (result != 0) {
      /* Handle error */
    }
    result = pthread_attr_setinheritsched (&rt_attr, PTHREAD_EXPLICIT_SCHED);
    if (result != 0) {
      /* Handle error */
    }
    result = pthread_attr_setschedparam (&rt_attr, &rt_sched_param);
    if (result != 0) {
      /* Handle error */
    }
    result = pthread_create (&rt_tid, &rt_attr, arg, thread_func);
    if (result != 0) {
      /* Handle error */
    }
  }

  ...

  /* Signal the thread that it's time to exit.  */
  pthread_kill (rt_tid, SIGINT);

  { /* Wait for the thread to exit gracefully.  */
    int result;
    void *status;
    result = pthread_join (rt_tid, &status);
    if (result != 0) {
      /* Handle error */
    }
    /* If applicable, check status and act accordingly.  */
  }

  /* Use `pthread_exit()' to exit `main()' since we are using
     `pthread` threads elsewhere.  */
  pthread_exit ((void *)0);
}
```

20181228/DuckDuckGo linux realtime threads motor control  
20181228/http://www.embedded.com:80/design/operating-systems/4371651/Comparing-the-real-time-scheduling-policies-of-the-Linux-kernel-and-an-RTOS-  
20181228/https://stackoverflow.com/questions/10502508/real-time-programming-with-linux  
20181228/http://man7.org/linux/man-pages/man2/sched_setscheduler.2.html  
20181228/http://man7.org/linux/man-pages/man3/pthread_setschedparam.3.html  
20181229/http://man7.org/linux/man-pages/man3/pthread_attr_setschedparam.3.html  
20181229/http://man7.org/linux/man-pages/man3/pthread_attr_setinheritsched.3.html  
20181229/https://computing.llnl.gov/tutorials/pthreads/

More discussion is needed on the specifics of sending signals to
realtime threads.  With non-realtime threads, shared memory and
mutexes is a pretty good way to setup basic communication between
threads.  Unfortunately, such a naive implementation doesn't work well
with realtime threads.  Typically, a realtime thread polls
periodically at strict time intervals and spends most of the time
sleeping.  The idea in the common case is that you want to send data
to the thread while it is sleeping, not while it is running, because
the interruption can fool with its realtime execution.  So, it turns
out that you can reasonably do that by sending a signal to your
realtime thread, via `pthread_kill()`.  How do you pass data to your
realtime thread?  When you created the thread with `pthread_create()`,
you sent it an argument, presumably a pointer to a context structure.
You can set a variable value within that context structure.  When the
signal handler is called, you can copy that data to the realtime
thread's local context.

How can you be sure that when you send a signal to the realtime
thread, you are not interrupting it?  By definition, the realtime
thread runs at higher priority than the rest of the process, and it
gracefully goes to sleep when it is done with its processing, so
whenever the rest of the normal process is executing, you can be sure
that you are not doing anything in the middle of a realtime thread's
execution, unless it was being too slow and had to be interrupted at
time slice expiry before its task was complete.  Even in this case,
you are only slowing down a slow thread by a little bit more.

Now, if you are careful with mutexes and shared memory, you can also
use this as a means to communicate with a realtime thread, but this is
a bit more complex.  The main problem is when your non-realtime thread
may grab the lock, get interrupted, then the realtime thread starts
executing, but it must get interrupted to context switch to the
non-realtime thread that is holding the lock.  The non-realtime thread
is then executed at realtime priority until it release the lock, then
gets immediately interrupted, and the realtime thread resumes
execution.  First of all, make sure your non-realtime thread's locked
sections are as short as possible.  Second, use
`pthread_mutexattr_setprotocol()` with `PTHREAD_PRIO_INHERIT` to
ensure that the realtime thread can resume the non-realtime thread at
realtime priority to unblock itself.  However, as you can see, due to
the context switches, the worst-case execution of this technique is
more expensive than is the case with the signal sending technique.

An alternative, and my preferred, technique that eliminates this
expense is by setting up the realtime thread to try to see if it can
acquire the lock without blocking (via `pthread_mutex_trylock()`), and
if not, it uses an older cached value of the variable in question.
Chances are that if were planning on using the signaling technique,
your code is already setup very similar to this approach.  On one
hand, I prefer the signaling technique to the
`pthread_mutex_trylock()` technique as it makes the main body of the
realtime thread code conceivably simpler.  On the other hand,
signaling arguably requires more code to implement the thread signal
handler.

An interesting case of communicating with a realtime thread is that of
double buffering.  The idea is that your non-realtime thread writes to
one buffer, while the realtime thread reads from the other.  Once your
application is done writing, you want to swap the buffers.  This is
simply changing the value of a single integer variable, very easy to
do within a small locked section.  But, what if you still get
interrupted in there?  What can your realtime thread do?  Well, as it
turns out, by definition, your application is done writing buffers
when it is swapping buffers, so either buffer may be used.  For
simplicity, we can save the old current buffer pointer and just keep
using that, which is exactly the same as the method previously
mentioned.

20190102/DuckDuckGo send a signal to a thread only if its sleeping  
20190102/https://linux.die.net/man/2/tgkill  
20190102/https://linux.die.net/man/7/signal  
20190102/https://linux.die.net/man/3/pthread_kill  
20190102/DuckDuckGo do not send a signal to a running thread  
20190102/DuckDuckGo realtime thread signal
20190102/DuckDuckGo realtime mutex priority  
20190102/https://stackoverflow.com/questions/27134152/condition-variables-and-real-time-priorities-in-pthreads  
20190102/https://linux.die.net/man/3/pthread_mutexattr_setprotocol  
20190102/DuckDuckGo pass an integer via a signal handler  
20190102/https://stackoverflow.com/questions/6970224/providing-passing-argument-to-signal-handler  
20190102/DuckDuckGo pthread mutex trylock  
20190102/https://linux.die.net/man/3/pthread_mutex_trylock

RTLinux is an interesting system that runs realtime threads outside
the Linux kernel and makes the Linux kernel fully pre-emptable as a
seprate process.  However, I can simply reckon that it has failed to
gain popularity, so realtime threads within Linux is the mainstay
solution for now.  Besides, modern Linux kernel versions have had all
spinlocks overhauled so that they are fully preemptable, which
basically means that beyond drivers, the rest of the Linux kernel can
be pre-empted by your realtime code in functionally the same way.  As
usual, the typical problem in real-world systems resulting in
non-ideal behavior can be traced back to drivers.

20181228/https://en.wikipedia.org/wiki/RTLinux

Now, onto the subject of `hrtimer`.  There are two ways to use
`hrtimer`.  The first, and recommended, way is to use the `hrtimer`
features and functions as they are exposed through the POSIX
`nanosleep()` and `clock_nanosleep()` routines.  Typically, you're
going to want to use `clock_nanosleep()` as its more advanced features
and functions sufficiently covers the requirements of most realtime
applications.  Unfortunately, the `clock_nanosleep()` function is a
rather low-level function, whereas the `hrtimer` routines are nice,
high-level, but not necessarily portable.  Also, it appears that there
is nothing `hrtimer` can do that you can't do with building a
front-end on top of `clock_nanosleep()`.  So, let's go ahead and
create such a simple wrapper implementation.

Typically, you should use `CLOCK_MONOTONIC` since typical realtime
functions such as scanning a display, scanning a keyboard, controlling
a motor, and so on, mainly require that the task be done periodically
within some bounded response time.  The long-term synchronization with
wall clock time is unimportant for most such tasks, and the potential
clock jumps that might be required to bring the clock into sync with
wall clock time would cause a failure to meet a realtime deadline.
Only if it's more important to keep in sync with wall clock time such
that time jumps can be justified should you use `CLOCK_REALTIME`.

20181228/DuckDuckGo linux run thread on high resolution timer tick  
20181228/https://elinux.org/High_Resolution_Timers  
20181228/http://pubs.opengroup.org/onlinepubs/009695399/basedefs/time.h.html  
20181228/http://pubs.opengroup.org/onlinepubs/009695399/functions/clock_nanosleep.html  
20181228/http://pubs.opengroup.org/onlinepubs/009695399/functions/nanosleep.html  
20181228/https://lwn.net/Articles/167897/  
20181228/DuckDuckGo raspberry pi hrtimer  
20181228/https://raspberrypi.stackexchange.com/questions/8586/arm-timer-in-kernel-module-with-precision-less-than-microsecond

So, the final, but most important, question that has been left
unanswered.  How do you access GPIO pins in a platform-independent way
on Linux in C?  Now that's a trick question.  There are mainly three
different ways to access GPIO pins on Linux in a C user-mode process.

1. Export the pins via `sysfs` and access them under
   `/sys/class/gpio/gpio0`, etc.

2. Access the pins via `mmap()` of the `/dev/gpiomem` file.

3. Access the pins via `mmap()` of the `/dev/mem` file, with the range
   limited to the range of physical memory that contains the GPIO
   data.

Apparently, the performance of approaches #2 and #3 must be identical,
otherwise the popular `python-gpiozero` Raspberry Pi GPIO library
might not prefer to use `/dev/gpiomem` in its native implementation.
Likewise, `python-gpiozero` has a class implemented for accessing GPIO
via `sysfs`, but nowhere does the higher level code link to that
low-level implementation.  Although these direct memory access methods
are the faster way to access GPIO pins (the only intermediary is the
virtual memory address translation system), they are not as portable
as the slower `sysfs` method.

20181228/DuckDuckGo linux gpio

These two links are good sources for information on how to use `sysfs`
to control GPIO pins.  Unfortunately, it doesn't look like `sysfs`
GPIO pin control includes the ability to set the pull-up/pull-down
termination capability of the SoC (system-on-a-chip), but maybe I just
have to investigate further.

20181228/https://elinux.org/GPIO  
20181228/https://emcraft.com/stm32f429discovery/controlling-gpio-from-linux-user-space

Here are the GitHub repositories for the Python `gpiozero` module and
the RPi.GPIO module.  The former is the popular high-level interface
to GPIO from Python, the latter is the preferred low-level, optimized,
C implementation with CPython bindings.  Great references if you want
to learn mainly how to interface with the GPIO pins on Raspberry Pi
for the sake of writing realtime C code that interacts with GPIO.

20181228/https://github.com/RPi-Distro/python-gpiozero  
20181228/https://github.com/Tieske/rpi-gpio

So, that being said, I'm wondering.  Has someone already went out and
written a nice kernel-mode driver for scanning a calculator-style
matrix keyboard and multiplexed 7-segment display for Linux?

Failed search.

20181228/DuckDuckGo linux driver raspberry pi 4 digit 7 segment led
  display 16 key matrix keyboard

----------

Finally, another consideration.  Like I said earlier, one of the main
problems with realtime execution is poorly programmed drivers.
Luckily, Linux makes this problem relatively easy to trace down by
displaying realtime kernel threads in the process listings from either
`ps` or `top`.  So, how does this picture look on a default install of
Raspbian fron NOOBS?  I ran the following command to get an idea of
the default realtime thread resource consumption on Raspbian 8.0
"Jessie".

    ps -eLo rtprio,pid,user,args

I've found only realtime thread: `rtkit`.  What's that?  Searching on
the Internet, others have been surmounted with panic and fear.  "It's
a rootkit!"  Now, actually it turns out to only be one of those
annoying GNOME abstraction-style services: the purpose is to allow
user-mode processes to request realtime execution resources via DBus
without requiring elevated or root permissions.  The main process that
uses this is PulseAudio.  So, suffice it to say, this is nothing that
you really need to worry about interfering with realtime execution.
In the past, however, some users have reported that this is
responsible for freezing their computer.  Some commentators have also
noted that this could host an opportune security vulnerability to
breach.

20181230/DuckDuckGo rtkit  
20181230/https://askubuntu.com/questions/48888/why-is-rtkit-daemon-eating-100-of-my-cpu

----------

JJJ TODO FIXUP!

* Discussion on double-buffering for read.  Need separate double
  buffers for read buffers and write buffers.

  KEY ASSUMPTION: there are only two users of the double-buffering
  system.  The realtime thread, and the non-realtime thread.  If there
  can be more than two non-realtime users, their access patterns must
  be coalesced to effectively be a single user.  The key problem that
  you could otherwise have is two user threads reserved both of the
  two double buffers.

  Concurrent read access as-is is perfectly fine.  Concurrent write
  access does not work, on the other hand.  A more elaborite multi-use
  front end must be coded up.  For keyboards and modern desktops,
  we've learned that there should be limits to concurrent read, namely
  that of the keyboard focus mechanism.  Only the alternative global
  hotkey mechanism, typically bound to a function key, makes logical
  sense.

  So, you have a few stages.

  1. Realtime hardware scanning/polling loop
  2. Realtime preprocess, i.e. change event generation and debounce
     filtering
  3. Realtime event queueing
  4. Host operating system event queueing
  5. Application event processing

  However, if this is generalized to the circular buffer concept, then
  you simply only need to make sure that the realtime thread has its
  own two slot reserved: current and past.  Or you could use a memory
  allocation generalized concept for circular buffers...

  Okay, I'll stop there.  That's definitely too complicated for
  realtime control loops.  Double buffering is the limit on the bridge
  between realtime and non-realtime.  The only other change we may
  support?  Rather than fixed buffers, you have a "double buffer" of
  pointers, the pointers in the two slots being able to be rewritten
  as you please.  Due to the realtime code needing to save the old
  pointer, we'll need a method where the realtime code can signal that
  it's completely done with a buffer, but it doesn't get freed until
  the non-realtime code starts.

  Wait, we have a quick exit in this case.  The latent hold will only
  happen in the last moments during a swap buffers call.  Therefore,
  all buffer allocation and freeing can happen entirely on the
  non-realtime side.

* TODO: Update discussion.  Assumption that realtime thread runs on
  same CPU as non-realtime thread.  If they are different, then what?
  Then you _can_ get problems where sending a signal would interrupt
  the realtime thread in progress.  Also, in this case, continuing to
  run the other thread until it exits its locked section is not as
  bad.

* Go up the stack on keyboard controllers.  After scanning the
  keyboard matrix to determine the current state, you want to
  translate this into scancode events.  The first step is to generate
  a stream of changes between matrix scan images.  The second step is
  to debounce this, if necessary.  Finally, you send the processed
  stream of key change events to higher level software.

  ADVANCED: Driver for a general-purpose Linux keyboard input that can
  type on the console and in Xorg.

