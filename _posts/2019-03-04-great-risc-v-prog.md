---
layout: post
title: Exciting progress on the custom RISC-V project
date: 2019-03-04 22:07 -0600
author: quorten
categories: [raspberry-pi, tour-de-force, unlipic]
tags: [raspberry-pi, tour-de-force, unlipic]
---

What is the current status of the EOMA Earth Friendly Computing
Devices project?  On the one hand, I see no updates on the Crowdsupply
project page.

20190304/https://www.crowdsupply.com/eoma68/micro-desktop

On the other hand, I do know that there is still being progress made
by the same community on the RISC-V project.  So, let's see where that
is at.

20190304/https://www.crowdsupply.com/libre-risc-v/m-class  
20190304/https://www.crowdsupply.com/libre-risc-v/m-class/updates/microarchitecture-by-osmosis  
20190304/https://www.crowdsupply.com/libre-risc-v/m-class/updates/modernising-1960s-computer-technology-learning-from-the-cdc-6600  
20190304/https://www.crowdsupply.com/libre-risc-v/m-class/updates/microarchitectural-decisions

So, the most exciting thing that I wanted to point out.  There is a
architectural processor optimization that was implemented in the CDC
6600 decades ago, yet somehow this was not picked up by modern Intel
and ARM processors.  Out-of-order processor execution can be
implemented either by the Tomosalu Algorithm with a reorder buffer or
by scoreboarding.  Tomosalu Algorithm is straightforward to implement,
but scoreboarding, in the common interpretation of implementation, is
energy intensive due to the use of content-addressable memory.
However, the two methods can be understood to be functionally
identical by the means of implementing a single-bit logical AND
decision tree.  I haven't completely$ explained this here (see the
articles for details), but the overall implementation and its results
is ingenious.  It allows you to get powerful out-of-order execution
capabilities for a very low power budget.

<!-- more -->

Now, with the consideration of an extended instruction set for 3D
capabilities in mind, there are other processor implementation
specifics to watch out for when using many technologies together.

But yes, I think this project is overall exciting, and it is great for
me personally to look at how some of my computer architecture
knowledge that I learned in college, but is not used in 99% of the
relevant job market, can be put to use... but not necessarily to
profit.  Yes, anyways it's fun to follow along the project and think
of how improvements can be made to the implementation of today's
processors.
