---
layout: post
title: Debounce a button using a capacitor
date: 2020-03-12 23:36 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Can you debounce a tactile switch using a capacitor?  Well, let's
search around.  Now here are some stachoverflow folks who don't know
what they are talking about.

20200312/DuckDuckGo capacitor button debouncing  
20200312/https://electronics.stackexchange.com/questions/64770/is-it-possible-to-use-just-a-capacitor-to-debounce-a-button#64771

Okay, let's cut through that nonsense and I'll provide my own accurate
explanation.  Yes, you can debounce a tactile switch using a
capacitor, and you can also debounce a selector switch using two
capacitors.  Here's how.

A resistor together with a capacitor between your GPIO input and
power/ground acts as a low-pass filter.  It wil work with both pull-up
and pull-down circuits if wired correctly.  Here's how it works.
Either the capacitor is empty and it will need to be charged up, or it
is "full" (charged up to same voltage) and needs to be discharged.
Not until the capacitor charge and voltage changes will the voltage to
the GPIO input change.

For a pull-up input, wire the capacitor between the input and positive
voltage supply.  For a pull-down input, wire the capacitor between the
input and ground.  Although, if you are using ceramic capacitors, it
doesn't really matter which way you do it since the polarity is
invertable and actually both ways work.
