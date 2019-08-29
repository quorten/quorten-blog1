---
layout: post
title: Key features and APIs to emulate in a minimal computer system
date: 2019-08-28 19:41 -0500
author: quorten
categories: [unlipic, computer-history, reiterate]
tags: [unlipic, computer-history, reiterate]
---

So, one thing that I am still disappointed about are the breaking
changes made to GTK+ and SDL.  Wow, well I wrote some software against
these systems, and now it has been rendered obsolete.  Where am I
going to go next?

Luckily, I don't need to look too far to answer this question.
Windows API, Windows GDI, and X11, despite being feature limited and
not feeling like your first choice when you want to write a new
application rapidly, are still alive and well in modern operating
systems, and they have maintained their backwards compatibility.  And
come on, these are more than 20 years old!  Likewise, Qt is a rather
old widget toolkit, but it has aged well with excellent backwards
compatibility.  So, the choice is clear.  Don't move forward to the
new versions of GTK+ and SDL.  Move sideways or even downward with Qt,
Windows API, and X11.

Again, I reiterate, because this is important!  Qt is one of the few
to hold solid and true to backwards compatibility, and it has made
them wildly popular in recent years when everyone else has failed.

Point in hand, if you are building a computer system from scratch,
Windows API, X11, OpenGL, and Qt are the GUI and graphics standards to
emulate.  PostScript, PDF, and HTML rendering should be implemented as
higher-level applications on top of these APIs.  OpenCL and
Vulkan... as I see it, those are for the bigger, more highly evolved
systems.

<!-- more -->

How important is PostScript and PDF, you wonder?  Very important.
Unix old-timers loved printed manuals, and we can all see why before
the advent of 4K monitors at reasonable prices.  Early computer
displays were standard definition resolution or lower, e.g. 640 x 480.
With these resolutions, you cannot have fancy typography, which for
many people can be quite an eyesore, not to mention that even with
bare-bones typography, you still can't see very much text
simultaneously.  If you want a workspace where you can see both the
text of your documentation/manuals and your code at the same time, you
will find yourself very short-handed.
