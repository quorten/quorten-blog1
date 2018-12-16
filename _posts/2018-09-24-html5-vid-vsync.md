---
layout: post
title: HTML 5 video vertical sync issues
author: quorten
date: 2018-09-24 1:20 -0500
categories: [media-prog]
tags: [media-prog]
---

So, I was watching some of my newly converted videos that are
compatible with HTML 5 video in Firefox, and I noticed that the video
playback tended to tear in fullscreen.  That is, there was a problem
with vertical sync, or vsync as those of us in the graphics world know
it is (affectionally) called.  So, why was this the case?  As it turns
out, Firefox has long had a problem with not properly implementing
vsync.  The primary issue is that its timer code for
`requestAnimationFrame()` is broken, and that broken code is
apparently also used to drive HTML 5 video playback.  Unfortunately,
there are no signs that this issue will be fixed in the near future.
So, if you want to see tear-free video, switch to Chromium.

20180924/DuckDuckGo firefox html 5 video vertical sync  
20180924/DuckDuckGo firefox html 5 video tearing

This is a very interesting website with a full explanation of the
Firefox vsync problem.

20180924/https://www.vsynctester.com/  
20180924/https://www.vsynctester.com/manual.html  
20180924/https://www.vsynctester.com/firefoxisbroken.html

Project Silk for Firefox purportedly would have fixed the tearing
problems, but that project got canceled and never made it into
mainline Firefox.

20180924/https://hacks.mozilla.org/2015/01/project-silk/

<!-- more -->

Another HTML 5 animation/video testing site.

20180924/http://jankfree.org/

This is an interesting site that has a variety of tests you can run
against your LCD monitor.  A DLSR camera is a must-have measurement
tool for some of the tests like input lag.  Also, a CRT monitor is a
must-have for some of the tests like input lag.

20180924/http://www.lagom.nl/lcd-test/

This is an interesting blog post by a former Mozilla executive.  The
name says it all: Chrome won.

20180924/https://web.archive.org/web/20170719192956/https://andreasgal.com/2017/05/25/chrome-won/
