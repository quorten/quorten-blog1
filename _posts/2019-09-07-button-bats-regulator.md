---
layout: post
title: "Are button cell batteries wired directly without voltage
        regulators?  Most likely, yes."
date: 2019-09-07 22:23 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

For my DSLR camera remote, I was wondering if I couldn't get it to
work because the battery got drained out because my push button repair
may have turned out to be a bit too jittery.  Good thing I got the one
with the replaceable battery.

The first thing I did was measure the battery voltage with a voltmeter
when it wasn't working.  2.9 volts, yeah that's lower than the earlier
times when I measured at 3 volts exactly, but that shouldn't be too
bad, should it?  So long as it uses a switch mode power supply.  Do
these tiny low current electronics use switch mode power supplies, or
do they wire up to the battery directly?  I searched around for this
on the Internet, and after weeding through some StackExchange
questions where people clearly didn't know what they were doing, yeah,
it looks like it is plausible that the coin cell electronics may wire
up to the batteries directly.  Also, the coin cell batteries
themselves tend to have a high internal resistance, so it is important
that you do not try to draw too much current from them, and also that
you avoid continuous current draw.  Suffice it to say, it's safe to
assume that coin cell battery electronics are more sensitive to
battery voltage changes than AA battery cell electronics.  Not to
mention that the coin cell batteries themselves have a reputation for
outputting a more stable voltage than AA battery cells.

20190907/DuckDuckGo does cmos clock battery use boost circuit  
20190907/DuckDuckGo 3 volt button cell battery microcontroller boost
  power supply  
20190907/DuckDuckGo do coin cell electronics use voltage regulators  
20190907/https://electronics.stackexchange.com/questions/261124/coin-cell-regulation-required
