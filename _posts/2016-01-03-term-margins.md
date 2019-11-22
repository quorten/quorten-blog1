---
layout: post
title: Terminal margin questions answered
date: 2016-01-03 21:00 -0600
author: quorten
categories: [tour-de-force]
tags: [tour-de-force]
---

Oh yeah!  Add to Tour de Force.  On reading the documentation of GNU
Screen.  Auto-margin terminals.  This answers all your questions that
you had about how terminals would behave when you type to the edge of
the screen.  Does it automatically wrap to the next line, does the
additional text get truncated, or does the additional text overwrite
the last character in place?  This is the more technical terminology
for this behavior.  "Magic" margins allow you to type the last column
on your screen before wrapping to the next line.

This terminology comes from Terminfo.

20160103/http://pubs.opengroup.org/onlinepubs/7908799/xcurses/terminfo.html
