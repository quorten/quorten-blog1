---
layout: post
title: Multithreading in Emscripten
author: quorten
date: 2018-06-11 17:13 -0500
categories: [misc]
tags: [misc]
---

Important!  So, you're asking about multithreading in Emscripten?  How
does it work?  What are the limitations?

Okay, so here's the lowdown as I understand it.  WebWorkers are the
base implementation.  At one point in time, SharedArrayBuffers were
used on top of these to effectively implement multithreading, but for
the time being this feature was disabled in light of the Meltdown and
Spectre vulnerabilities.  Until the feature gets re-enabled,
true multithreading in Emscripten is out of the game.

Okay, so what features do WebWorkers provide you with?  Can you start
a process and deliver messages to it like you would with Unix I/O?
Unfortunately, the setup seems more contrived.  You can deliver
messages, but messages are processed in a batch manner.  A message,
one delivered, calls an event notification, and the next message
processing will be delayed until that function exits.  Sorry, looks
like Unix-like `read()` is not supported.

20180611/DuckDuckGo emscripten webworkers  
20180611/https://floooh.github.io/2013/01/13/multithreading-in-emscripten-with-html5.html  
20180611/DuckDuckGo emscripten threads  
20180611/https://stackoverflow.com/questions/27473959/thread-using-emscripten#31466135  
20180611/https://kripken.github.io/emscripten-site/docs/porting/pthreads.html  
20180611/https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API  
20180611/https://developer.mozilla.org/en-US/docs/Web/API/Worker  
20180611/https://developer.mozilla.org/en-US/docs/Web/API/EventListener
