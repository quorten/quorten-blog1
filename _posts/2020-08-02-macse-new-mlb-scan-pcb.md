---
layout: post
title: "Reverse engineering the Macintosh SE main logic board project,
        how to digitize a multilayer PCB"
date: 2020-08-02 02:07 -0500
author: quorten
categories: [vintage-computing, mac-classic, raspberry-pi]
tags: [vintage-computing, mac-classic, raspberry-pi]
---

This is a very interesting 68kMLA thread on reverse engineering the
Macintosh SE main logic board and custom chips.  And... now I've made
myself also become a key contributor!

20200802/https://68kmla.org/forums/index.php?app=forums&module=forums&controller=topic&id=60059&page=5&app=forums&module=forums&id=60059

So, how do we start out?  We need to obtain scans of the main logic
board, depopulated of all discrete components.  Indeed, this is
bringing to full fruition an idea I had before about reverse
engineering existing electronics.  But, the means and methods go even
further than that.  How do you do this with internal layer printed
circuit boards?  The approach is, well, quite clever, though it
involves brute force.  In general, you actually can't shine bright
light at a PCB and hope to see shadows of the internal layers.
However, you can take a grinder to the surface to grind away the top
layers.  The internal layers will then be visible and you can scan
them accordingly.  Yes, unfortunately, it is a destructive process, so
you really do need spare copies on hand unless you think you can get
it right the first time!

Commodore 64 on an FPGA?  Yes, it's happened.  Ultimate 64 Elite is
the name of the game.  Look here.

20200802/https://ultimate64.com/Ultimate-64-Elite
