---
layout: post
title: Finally, more info from game devs
author: quorten
date: 2018-07-05 18:45 -0500
categories: [random-software]
tags: [random-software]
---

Oh, finally!  After so many years after the original games were
written, we are getting more information from the game developers
about their development.  Yes, these _proprietary_ games.

20180705/https://www.codeofhonor.com/blog/tough-times-on-the-road-to-starcraft

Now this is some really interesting commentary about data structures,
but in the end the advice isn't as clever as the author hypes it up to
be.  But, the point that I extract for design of my emtlib are as
follows:

* Support embedding your linked list data structures inside other data
  structures.
* "Favor composition over inheritance."  Use a function to determine
  the location of the linked list structure within the larger
  structure.
* Want to support fast save and load of the data structures?  On one
  hand, I've setup support for offsets rather than pointers, this
  makes load and save a breeze when you have only a single allocation
  chunk.  Yet another possibility is "lazy pointer cache," but that
  only works in one direction.
* Absolutely do make sure to use proper code library templating.

20180705/https://www.codeofhonor.com/blog/avoiding-game-crashes-related-to-linked-lists
