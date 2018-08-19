---
layout: post
title: "Interesting computer history questions: Monitor colors, Unix pipes"
author: quorten
date: 2018-06-21 17:01 -0500
categories: [tour-de-force]
tags: [tour-de-force]
---

Important!  Discussion about early computer monitors and their various
colors.  Why did the early home computer monitors use white on blue?
The main reason was cost: doing so made it possible to repurpose an
old, low-resolution black and white television or a color television
for use with a computer.

As for the alternatives that used green or amber screens.  These were
more expensive phosphors because the equipment was more expensive to
support the high horizontal resolutions of 80 columns.  Due to
technical complications of the video bandwidth circuitry scanning
limits, slower phosphors had to be used too which caused ghosting
artifacts when displaying moving objects on those monitors.  Yeah,
we're talking _slow_ on the old equipment.  Not only is the software
writing to the display slow, but the refresh of the display itself is
slow.

<!-- more -->

20180621/https://retrocomputing.stackexchange.com/questions/6797/why-were-early-personal-computer-monitors-not-green

Important!  Want to learn all about video circuitry timing on vintage
equipment?  Don Lancaster's "TV Typewriter Cookbook" is the place to
go.

Another interesting history question.  How do pipes save memory on
early Unix?

20180621/https://unix.stackexchange.com/questions/450877/how-do-pipelines-limit-memory-usage

So, here's where the indication that early Unix was very disk heavy
comes into play.  (Yes, we see much of the same notion even on modern
Unix, compared to alternatives.)  A pipeline is executed in a serial
manner: one program is swapped into memory, executed, and the bounded
buffer it reads/writes goes to disk.  Then the next program is swapped
into memory, overwriting the previous one, and the process continues.

This is another interesting retro question, interesting why/how it is
being asked.  Why did it take so long for PCs to be able to shut
themselves off?  Basically, segmentation, fragmentation, no clear
party defining the standard of the PC market, and even the computing
world not knowing the future of computing at the time.

20180621/https://retrocomputing.stackexchange.com/questions/6780/its-now-safe-to-turn-off-your-computer
