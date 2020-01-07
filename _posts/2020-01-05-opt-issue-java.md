---
layout: post
title: Interesting optimization issues with Java software
date: 2020-01-05 01:48 -0600
author: quorten
categories: [unlipic, twitter]
tags: [unlipic, twitter]
---

This is an interesting article about how some simple one-line changes
in some Java code resulted in significant memory performance
improvements when running with an old version of Java.

The biggest trick for me to note?  Initializing Hash empty objects
that never get used.  Ever.  Why?  Well, that's just what sloppy Java
programmers do in big enterprise software.

In my own simple C software, I have always assumed no such sloppiness,
and matter of fact I can't due to the need to support
initialize-in-place.  But alas, this got to the designers of Java and
they did modify later versions of Java to never allocate any memory
for an empty Hash set until the first element is avctually written.

20200105/http://blog.pitest.org/how-i-once-saved-half-a-million-dollars-with-a-single-character-code-change/
