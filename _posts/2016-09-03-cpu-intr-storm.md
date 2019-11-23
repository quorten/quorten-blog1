---
layout: post
title: Processor interrupts preventing useful progress
date: 2016-09-03 21:00 -0600
author: quorten
categories: [unlipic]
tags: [unlipic]
---

So what were you saying about processor interrupts?  That it is not a
problem that they can prevent useful progress.  Actually, this is a
recognized problem, you just had to search harder for the standard
literature that names it.  It is called "interrupt storm."  Although,
one may be led to believe that the negative consequences of interrupt
storms are entirely operating system problems, given practical rate
limits in devices sending interrupts.  Or is this not true?  Is it
really true that the hardware can generate interrupts in a way that is
totally impossible for software to properly handle?  Well, I don't
know, but the general problem associated with this is well-recognized.

20160903/https://en.wikipedia.org/wiki/Interrupt_storm  
20160903/https://en.wikipedia.org/wiki/Advanced_Programmable_Interrupt_Controller
