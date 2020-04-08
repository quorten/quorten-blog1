---
layout: post
title: Beware of diode package sizes
date: 2020-03-31 18:47 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Recently, I received a purchase I placed on Digi-Key.  I looked at the
physical size of the Schottky diodes I purchased, and wow, they were
big.  Not just the diode package, but the wires to the diode itself
were too large in diameter to fit through the through-holes on my
perfboard.  No worries, in all other electrical specifications, they
were good for my purposes, I just needed to give them a
"surface-mount" style treatment to connect them to my perfboard and
all was good.

But, the moral of the story, if Digi-Key doesn't tell you the specific
dimensions of a component but just gives you a size code such as
DO-204AC (DO-15), then make sure to look up that standard package's
dimensions and verify the component will fit in the board mounting you
desire for it.

Here is the Wikipedia article that lists the dimensions info on the
DO-204 standard.

20200331/https://en.wikipedia.org/wiki/DO-204

Note that transistors have similar standard size codes, you should
check those to make sure you are getting something that will work well
for you.
