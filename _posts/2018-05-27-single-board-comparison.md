---
layout: post
title: Single-board computer comparison in 2018
author: quorten
date: 2018-05-27 19:00 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, so now I'm thinking about buying a second Raspberry Pi for the
purpose of setting up a dedicated home server.  My current solution,
that of using an old laptop, appeared to be a good idea when it was
first setup, but given the fact that basically I'm the only local user
interested in using it, it no longer seems to make sense to allocate
such a high power budget for a machine running 24/7.  Hence my plans
to migrate to a low-power single-board computer.

But, before I go out and just buy another Raspberry Pi, I should
evaluate the current state of the single-board computer market.
Already there has been lots of quibbling about competitors to the
Raspberry Pi that are technologically superior, so I should see if one
of those will better meet my needs than a Raspberry Pi.  And indeed,
one of them definitely does better meet my needs: Banana Pi.

<!-- more -->

So, how did I go about coming to that conclusion?  First I went to the
Wikipedia article on "Comparison of single-board computers":

20180527/https://en.wikipedia.org/wiki/Comparison_of_single-board_computers

Now you're presented with this nearly innumerable list of single-board
computers.  How do you figure out what to look for?  Of course, you
want to look for _new_ models of single board computers.
Conveniently, there is a table column with the release date of the
boards that you can sort by.

After doing that, I've distilled down to a small number of best
choices:

* Orange Pi
* Raspberry Pi
* Le Potato
* Banana Pi

So now searching down more information on each of these individually
is easy.

* Orange Pi looks kind of old and not kept as up-to-date or featureful
  as the alternatives, so that is out of the list.

* Le Potato and Banana Pi both look promising for this one reason:
  they use the Allwinner chipset, and therefore are supported by the
  `linux-sunxi` project and use an industry-standard U-boot process.
  Personally, one of the things I hate the most of the Raspberry Pi is
  the non-standard boot process it uses.  Why?  Because I can't use
  the Raspberry Pi out-of-the-box to learn about and practice the boot
  process on other small embedded devices like a router or a smart
  switch!

* So finally, the tie-breaker between Le Potato and Banana Pi: Banana
  Pi has more boards available and purports wider operating system
  support.

Hence, the clear winner is the Banana Pi.

Are there any caveats between the Banana Pi and the Raspberry Pi?
Sure, but none of them concern me.  These are things like the
following:

* Different boot process.  As I've noted, that is a deliberately
  desired feature of mine, not a shortcoming.

* Physical form factor is not _exactly_ compatible with the Raspberry
  Pi: I'm building my own device designs by hand and by 3D printing,
  so I can adapt to the changes easily.  Plus, I haven't actually
  finished building my first Raspberry Pi design either.

* Finally, an interesting observation about the Banana Pi website
  versus the Raspberry Pi.  The Banana Pi website is clearly more
  manufacturer oriented, whereas the Raspberry Pi website is more
  hobbyist and educational oriented.  This might dissuade the newest
  of new users, but the most prolific users in the market,
  i.e. professional users and advanced hobbyists, will welcome the
  changes to the website.

----------

20180527/DuckDuckGo le potato

Ah, what is said on the KickStarter page is quite interesting.  They
say they are professional engineers that you won't find the quality
they provide much elsewhere.  And I agree.

What is meant by "libre"?  That means that they computer hardware
design is libre, although the parts and the software might not be.
The designers strive to avoid proprietary interfaces that would result
in vendor lock-in.

20180527/https://www.kickstarter.com/projects/librecomputer/libre-computer-board-next-gen-4k-sbc-dev-board-for  
20180527/https://en.wikipedia.org/wiki/Libre_Computer_Project  
20180527/https://www.kickstarter.com/projects/librecomputer/libre-computer-board-tritium-sbc-linux-android-7-n  
20180527/https://libre.computer/products/boards/all-h3-cc/

Yes!  `linux-sunxi` uses U-boot, so we're in good business.

20180527/http://linux-sunxi.org/Main_Page

For the Banana Pi, these designers are clearly doing a better job by
including that aren't included on the Raspberry Pi like SATA drive
interfaces and LVDS display interfaces.  Therefore, reusing an old
laptop display is much easier, for example.  Or, setting up a
high-capacity NAS can be done efficiently, but the data transfer speed
will be the apparent bottleneck, unfortunately.

20180527/https://en.wikipedia.org/wiki/Banana_Pi#Banana_Pi_BPI-W2  
20180527/DuckDuckGo banana pi review  
20180527/https://www.gadgetdaily.xyz/makeblock-starter-robot-kit-review/  
20180527/http://www.banana-pi.org/

----------

These are some interesting and important historic single-board
computers mentioned in the Wikipedia article.

20180527/https://en.wikipedia.org/wiki/DreamPlug  
20180527/https://en.wikipedia.org/wiki/SheevaPlug

The Free Software Foundation's page on single-board computers hasn't
been updated since 2015.  However, the content is still mostly
relevant.  So, what are the main caveats against boards like the
Banana Pi?  The GPU and VPU.  Other than that, they have an acceptable
boot process, unlike the Raspberry Pi.

20180527/DuckDuckGo free software foundation single board computers  
20180527/https://www.fsf.org/resources/hw/single-board-computers
