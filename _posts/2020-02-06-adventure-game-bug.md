---
layout: post
title: Interesting bug in the original Adventure game
date: 2020-02-06 21:40 -0600
author: quorten
categories: [twitter, random-software]
tags: [twitter, random-software]
---

Oh, wow, here is an interesting bug in the original Adventure game,
purportedly whose discovery was not published until relatively
recently.  What is it?  It is peculiarities with how the capacity of
containers are counted in your inventory.  A quirk in the rules
required some exceptional condition handling code to be copied and
pasted throughout many different other locations in the code, but some
locations were missed.  The result?  You can effectively increase your
inventory capacity by one.

20200206/https://quuxplusone.github.io/blog/2020/02/06/water-bottle-bug/
