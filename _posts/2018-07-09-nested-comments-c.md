---
layout: post
title: Nested comments and C compilers
author: quorten
date: 2018-07-09 18:00 -0500
categories: [random-software]
tags: [random-software]
---

Very interesting.  You can write a C program that when compiled,
indicates whether the compiler allows nesting or not.

20180709/DuckDuckGo c nested comment  
20180709/https://stackoverflow.com/questions/6698039/nested-comments-in-c-c#6698115

Well, I guess nested comments is a distinct artifact of the Borland
C/C++ compilers.  Most other mainstream compilers appear not to
support it, but were explicitly rigged up so that they issue an error
message should someone run through some Borland C/C++ code that
contains nested comments.

This is a funny StackOverflow answer, in light of this knowledge.

20180709/https://stackoverflow.com/questions/2969198/why-are-nested-comments-forbidden  
20180709/DuckDuckGo borland c nested comments  
20180709/http://edn.embarcadero.com/article/20997
