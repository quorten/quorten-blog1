---
layout: post
title: "Another Open Hardware CPU and modern computing project"
date: 2020-07-27 02:16 -0500
author: quorten
categories: [raspberry-pi, unlipic]
tags: [raspberry-pi, unlipic]
---

In addition to Open Cores, here is yet another project to build modern
computer components as Open Hardware.  This one, this time, is instead
very much a one-man effort.  This one person, however, is an academic,
so it appears, so even though it is a one-man effort, it appears the
project gets plenty of publicity.  There is also a nice blog with
plenty of information on lessons learned from this one person.

The FPGA board is an ICO board, and the name of the board mounting
project for the CPU is ICOZIP.

20200727/https://github.com/ZipCPU/icozip  
20200727/http://icoboard.org/  
20200727/https://github.com/ZipCPU/zipcpu  
20200727/http://zipcpu.com/  
20200727/http://zipcpu.com/about/

This is a great article on four keys to making FPGA hardware designs
that "just work."  Yes, it does hinge upon the idea of formal
verification, clearly specifying the behavior in terms of "contracts,"
and testing all possible code paths.

20200727/http://zipcpu.com/formal/2020/06/12/four-keys.html

This is a great article on phase-locked-loop (PLL) problems and
debugging them.  Clock syncing in advanced sequential logic is no
joke!

20200727/http://zipcpu.com/blog/2017/09/14/even-i-get-stuck.html
