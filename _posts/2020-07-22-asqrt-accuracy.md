---
layout: post
title: "Scratch notes evaluating accuracy of approximate square root"
date: 2020-07-22 21:00 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

Here is just some of my scratch notes on the idea of improving the
accuracy of my approximate square root operator.

<!-- more -->

```
0b100000000 = 256
0b10000 = 16

0b11111111 = 255
0b1111 = 15
0b1000 = 8

0b11000000 = 192
0b1100 = 12
0b1000 = 8

0b10100000 = 160
0b1010 = 10

0b10010000 = 144
0b1001 = 9

0b10110000 = 176
0b1011 = 11

0b11010000 = 208
0b1101 = 13

0b11100000 = 224
0b1110 = 14

0b111110000 = 496
real ~= 22
0b11111 = 31
better approx
0b10111 = 23

0b100010000 = 272
real ~= 16
better approx
0b10001 = 17
squared = 289
```
