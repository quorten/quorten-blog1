---
layout: post
title: "Reflecting on WebAssembly industry-wide adoption and
        containers in the browser"
author: quorten
date: 2018-07-26 18:51 -0500
categories: [random-software]
tags: [random-software]
---

So, reflecting upon standards in the computer industry.  Was it Google
that needed to be kum-by-yayed and have gourmet garden visits in order
to adopt the standard.  It was indeed Google Native Client that was
the reason they were reluctant to adopt the standard, correct?  Well,
let's see.  We can check Wikipedia.  Of course, Wikipedia won't tell
you the exact reasons why, but they will tell you if the technology is
still in use or not.  And indeed, Google Native Client was
discontinued, deprecated in favor of WebAssembly.

<!-- more -->

So, that closes the picture.  We know Mozilla and Apple were champions
of using plain JavaScript.  Asm.js came from plain JavaScript then
morphed into WebAssembly.  Microsoft was in favor of enhancing
JavaScript to eliminate the need for plugins for a long time, and
indeed on their new Edge browser, they disabled plugin support
entirely.  So, out of the major browser vendors, Microsoft, Apple,
Google, and Mozilla, Google was the odd one out in technology
adoption.

20180726/https://en.wikipedia.org/wiki/Google_Native_Client

Nevertheless, one really interesting thing came out of Google Native
Client: ZeroVM.  Single process virtualization using Google Native
Client runtime.  Indeed, very similar to the concepts of Docker,
Emscripten, and WebAssembly here, but much more limited than any of
those other mentioned technologies.  So similar, that even the
Wikipedia article lists Docker in the "See also" section.

So, your idea of running Docker in the browser?  It is fully justified
as a possibility, it's just that the industry needs to advance to get
there fully and adopt a standard way of doing it.  All of the
technologies have been designed and implemented already.

20180726/https://en.wikipedia.org/wiki/ZeroVM
