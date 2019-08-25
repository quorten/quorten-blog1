---
layout: post
title: Looking for options for a modern GUI widget toolkit
date: 2019-07-18 16:29 -0500
author: quorten
categories: [misc]
tags: [misc]
---

Previously, I've coded some GUIs with GTK+, but GTK+ is a no-go
because of the recent events of breaking changes and other things that
many application developers simply didn't agree with.  The choice is
then between Qt and WxWidgets.  Both are C++.  So I'll go with
WxWidgets since it's lighter, right?  Well, wait, not so fast.  People
are disliking WxWidgets too for introducing breaking changes like
GTK+.  Okay, so there only is one choice, and that is Qt.

And since my software was supposed to be like PCManFM... now that
makes it even easier, now that PCManFM is also on Qt.

If you want GTK+ or WxWidgets for a light weight GUI toolkit,
keep it to the old versions.

Thinking about building a new light weight GUI toolkit that can be
ubiquitous?  Follow in the footsteps of Qt.  Thankfully, this also
does mean that you can use low-level Macintosh Toolbox or Windows API
style primitives upon which the higher level is built.  You could even
use X11, for those who care.

If you really read into how old Trolltech operated internally, they
really put a lot of ephasis on API compatibility.

Now X11 is good too... but then there's Wayland display server.  So,
let's be really firm on this one.  When everyone in the graphics and
GUI world didn't care about API compatibility, they (Qt) were the last
holdout.  And yet, this is making them wildly popular among
application developers.  Turns out, application developers nowadays
don't want to experiment with new stuff and breaking changes.

<!-- more -->

So, about Qt?  Yeah, they're engineering style really isn't like West
Coast, it's more like Minnesota engineering.  Where are they, again?
Oh yeah, right, Finland.  Well, I reckon their engineering culture
must share a lot of similarities with Minesota engineering, they're
about the same population and surface area as Minnesota, but further
North.

Trolltech => The Qt Company

20190718/https://en.wikipedia.org/wiki/The_Qt_Company

20190718/https://en.wikipedia.org/wiki/WxWidgets#cite_note-36  
20190718/https://news.ycombinator.com/item?id=7993240

Well, at least there's a bright side to all of this.  When the tech
world was previously indecisive about converging on a single GUI API
as a standard, the arbitrary foolishness of the other parties really
helped narrow down the choices and guide the industry as a whole to
unanimous agreement on a single standard.
