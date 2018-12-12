---
layout: post
title: "Network equipment power consumption considerations for battery
        backup, and connecting broadcast television to the home
        network"
author: quorten
date: 2018-08-12 14:15 -0500
categories: [battery-backup, home-network]
tags: [battery-backup, home-network]
---

Battery backup system notes.

So, you're wondering, what are the power supply considerations for
providing battery backup to your network equipment?  After
investigating this, I can summarize this as follows.

* Does providing battery backup to only wired Ethernet equipment save
  energy compared to providing battery backup to only Wi-Fi wireless
  equipment?  Suffice it to say, when the decision is between Ethernet
  and Wi-Fi, the power savings are minimal, except when Wi-Fi
  encryption is used, which is explained further in the next points.

* The main factor to consider when calculating power consumption is
  the number of computer boards being powered.  When speaking of
  enabling or disabling functions on a single board, the power savings
  are minimal compared to speaking of enabling and disabling entire
  boards.

  For this reason, not supporting Ethernet under battery backup power
  can save you energy if this means you do not need to supply power to
  as many switches.  Either you have one big switch that consumes a
  lot of energy, or you have multiple switch boxes that together
  consume a lot of energy.

* For modern network equipment, the single biggest factor in the power
  consumption of a board is the power consumption of the computational
  (CPU, memory) equipment on the board.  The more powerful this
  equipment needs to be, the more energy it must consume, and the more
  energy must end up being wasted as heat.

  For this reason, not supporting wireless communications under
  battery backup power mainly saves energy if only for not requiring
  powering a computationally expensive encryption engine for Wi-Fi
  security.

  If for wired communications, you only have one switch box, and your
  Wi-Fi support comes from a different box, not supporting Wi-Fi will
  save you energy.

<!-- more -->

* Finally, the board that connects to your Internet Service Provider.
  This may end up consuming a lot of energy to supply the needs of the
  telecommunications protocol.  Thus, not needing to power this device
  can save you energy, but that means that you will not be able to
  access the Internet either.  Suffice it to say, the power
  requirements of this device will be the primary determinant in what
  kind of battery system you will need.  The rest of the network
  equipment on the other side is much easier to support, in terms of
  power consumption.

----------

So now I'm wondering.  Where do you look for a lower power cable
modem?

20180812/DuckDuckGo low power internet cable modem  
20180812/https://arris.secure.force.com/consumers/articles/General_FAQs/SB6183-Cable-Signal-Levels  

Well, it's inconclusive, other than the fact that your local area's
cable standards will dictate what transmit signal strength your
equipment must provide.

But, for sure for the local intranet side, there's plenty of options
to reduce power consumption.  Unmanaged switches can go as low as 3.3
W max power consumption.

20180812/DuckDuckGo low power ethernet switch  
20180812/https://blogs.cisco.com/enterprise/reduce-switch-power-consumption-by-up-to-80  
20180812/https://www.tomshardware.com/reviews/unmanaged-gigabit-ethernet-switch-roundup,4321.html  
20180812/DuckDuckGo TP-LINK TL-SG108 8-Port  
20180812/https://www.tp-link.com/us/products/details/cat-42_TL-SG108.html

Yeah, that's a nice power consumption and all, but we really want a
switch with PoE also.

20180812/DuckDuckGo lowest power poe ethernet switch

Looking for a PoE injector?  NETGEAR equipment is still the way to go,
even in 2018.

20180812/https://globenewswire.com/news-release/2018/06/26/1529607/0/en/NETGEAR-Launches-Industry-s-First-Unmanaged-Switch-With-Flexible-Power-Over-Ethernet-Options.html

Well, as it turns out, that is much harder to come by.

So, looking at the Wikipedia Comparison of single-board computers
page, I found two good ones.  Discount the Intel one because I don't
want an Intel X-Y-Z for a low-power computer.

20180812/https://en.wikipedia.org/wiki/Comparison_of_single-board_computers

This one looks good, though.  But the caveat?  PoE is achieved via a
custom modification.

20180812/https://boundarydevices.com/product/nitrogen6x-board-imx6-arm-cortex-a9-sbc/

This one is too specific to routers.  Otherwise, if you want a
router-like device, this may be a good option.

20180812/https://mikrotik.com/product/RB450G

Okay, now what about television?  That's another pain point.  Nowadays
you may have one really good broadcast TV antenna on the roof but
multiple televisions that would want to access that high quality
signal.  Or it may simply be that you have one cable TV input to the
house, and the same deal that multiple televisions also want to access
that.  So what can you do?  Well, the ideal solution is to go all IP.
You route the television signals into a certain kind of server box
that can then tune to multiple channels simultaneously.  IP computer
clients then make requests to that box to choose which channels they
want to stream.

So, there are such solutions for this out here.  The problem, of
course, is with interoperability and standards.  What is the protocol
that clients use to select the channel they want to watch?  Yes, the
implementation is there, but the user interface is still kind of
clumsy.

20180812/DuckDuckGo broadcast tv to ethernet bridge  
20180812/https://www.quora.com/How-can-I-send-the-whole-cable-TV-signal-over-ethernet-Is-there-this-magical-devices-than-converts-the-signal-to-be-sent-over-an-IP-network-Can-I-buy-it-on-B-H-or-some-other-place-like-that  
20180812/https://en.wikipedia.org/wiki/Elgato

But indeed, the problem is this.  The fact that it is so hard to shop
for and find these devices...  Maybe that's just because regardless,
the devices do require some technical effort to setup, hence their
lack of popularity.

Interesting other article here.  People that observe that Wi-Fi "slows
down over time."

20180812/https://www.quora.com/Why-does-a-Wi-Fi-router-slow-down-over-time

Oh. and now that we've mentioned all of that.  Another audacious goal:
send a composite video signal over Ethernet so that you can access
your DVDs over the IP network.  Of course... it's far more popular to
rip the DVDs to hard drive storage and then access that over the
network.  Or even more popular, just search the Internet and hope that
somebody else did the ripping for you.  Alas in this most extreme
case, payment methods to the producers are uncertain.  In the end it
is the network service provider that gets primary payments, not the
content producer.
