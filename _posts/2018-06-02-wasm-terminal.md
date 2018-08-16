---
layout: post
title: In-browser terminal window in WebAssembly programs
author: quorten
date: 2018-06-02 01:41 -0500
categories: [misc]
tags: [misc]
---

Okay, so playing around with WebAssembly.  I want to compile more
sophisticated command-line applications to run in the browser, but the
default WebAssembly shell isn't good enough.  So, what are my options?
Well, there are some JavaScript terminal emulators that can be put up
as front-ends to your WebAssembly.  Er, well, Asm.js at the moment due
to a glitch between the Fetch API and WebAssembly output as of today.

20180602/https://stackoverflow.com/questions/48292269/how-can-i-run-an-interactive-program-compiled-with-emscripten-in-a-web-page  
20180602/https://gist.github.com/jcubic/87f2b4c5ef567be43796e179ca08c0da  
20180602/DuckDuckGo emscripten fetch  
20180602/https://kripken.github.io/emscripten-site/docs/api_reference/fetch.html  
20180602/DuckDuckGo FETCH not yet compatible with wasm
  (shared.make_fetch_worker is asm.js-specific)  
20180602/https://www.mail-archive.com/emscripten-discuss@googlegroups.com/msg07288.html

Oh, and to mention this while we're at it, WebAssembly output is now
the default!  No need to switch it on anymore.

Finally, since the Fetch API is asynchronous, you need to setup some
"cothreads" to use it in larger programs that expect a synchronous
API.
