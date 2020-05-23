---
layout: post
title: "The original Apple II did **not** have a vertical blanking
        interrupt"
date: 2020-05-23 13:28 -0500
author: quorten
categories: [raspberry-pi, unlipic]
tags: [raspberry-pi, unlipic]
---

After having come quite a long ways in my software framebuffer
software, I thought my programming skills may now be up to the
challenge of programming 2D and 3D graphics on the Apple II computer.
But, a first question to answer, how fast would my various subroutines
run?  I would have to write a simple benchmark program to answer that
question.  It should be easy, just run in a loop, and time the
results.  But wait, how do I do timing on the Apple II computer?

On a modern computer, there is a dedicated timer chip or subunit of
the CPU that does exactly that: timing.  Since this timer is
independent of the computations happening on the CPU, it is very easy
to use for the purpose of measuring wall clock time.  Alas, the
original Apple II computer had no such chip, that's why early game
software all used CPU cycle counting for timing.

But surely, there's still a better way, isn't there?  The vertical
retrace happens at a deterministic interval on graphics output, about
1/30 of a second in NTSC.  I can just hook up a vertical blanking
interval interrupt handler and count the number of vertical retraces
to measure wall clock time.  Well, yeah... in my particular case with
my Apple IIc Plus, I can do that.  However, the only reason why I can
do that is because the Apple IIc Plus includes built-in mouse support,
and the Apple II mouse card patched in support for vertical blanking
interrupts as the original Apple II computer didn't have it.

<!-- more -->

Yep, that's right.  The original Apple II computer didn't even have a
vertical blanking interval interrupt.  That's why CPU cycle counting
was so predominant in early game software, and that caused early game
software to run too fast the moment you ran it on a CPU with a higher
clock speed.  On the original Apple II, if you wanted flicker-free
drawing, your only means to do so was to rely on double buffering page
flipping, which was easily doable since the Apple II provides two
pages of video memory and a soft switch to flip which one is active.
Well, at least it's not as bad as the original Atari 2600 that didn't
even have a framebuffer, so you had to shift out bits as the CRT beam
was flying across the television.

20200523/DuckDuckGo apple ii vertical blanking interrupt  
20200523/https://www.folklore.org/StoryView.py?story=Apple_II_Mouse_Card.txt
