---
layout: post
title: "The new Windows, why I hate it, and reflections on
        single-board computers and home servers"
author: quorten
date: 2018-08-22 14:52 -0500
categories: [random-software, raspberry-pi, reiterate]
tags: [random-software, raspberry-pi, reiterate]
---

First of all, finding out how to control the Windows Update settings
is much more complicated nowadays: you have to go fish through a new
"Settings" app that is not even linked from the Control Panel.

20180821/DuckDuckGo windows server 2016 manually check for updates  
20180821/https://heresjaken.com/install-updates-windows-server-2016/

Second, modern Windows assumes an unlimited bandwidth connection
unless you state otherwise.

20180821/DuckDuckGo how does windows determine if a connection is metered
20180821/https://www.howtogeek.com/226722/HOW-WHEN-AND-WHY-TO-SET-A-CONNECTION-AS-METERED-ON-WINDOWS-10/

Third, Windows assumes that you are connected to a _symmetric_
unlimited connection by having peer-to-peer updates enabled by
default, when in fact many Internet users are connected through
asymmetric connections with faster download speed than upload speed.

<!-- more -->

20180821/https://www.howtogeek.com/224981/how-to-stop-windows-10-from-uploading-updates-to-other-pcs-over-the-internet/  
20180821/https://www.howtogeek.com/223068/what-you-need-to-know-about-windows-update-on-windows-10/

But, the biggest thing that I don't like about modern Windows.  For
sure, it is the new policy that new CPUs won't be allowed to get
security updates on older versions of Windows.

20180821/https://www.howtogeek.com/311743/how-and-why-microsoft-blocks-windows-7-updates-on-new-pcs/

What is Microsoft's justification for adding this restriction?

> "Windows 7 was designed nearly 10 years ago before any x86/x64 SOCs
> existed. For Windows 7 to run on any modern silicon, device drivers
> and firmware need to emulate Windows 7’s expectations for interrupt
> processing, bus support, and power states—which is challenging for
> WiFi, graphics, security, and more. As partners make customizations
> to legacy device drivers, services, and firmware settings, customers
> are likely to see regressions with Windows 7 ongoing servicing."

----------

More words deserve to be said about the modern generation of System on
a Chip (SoC) computers.  First of all, one thing that I can agree that
I never liked about their design was their tendency to require a
custom Linux kernel or other OS kernel that would bundle customer
proprietary device drivers into the operating system installation.
This, at the outset, is a terrible hardware design when thinking about
the future software support for such hardware.  Incidentally, however,
there are multiple factors at play that are incentivizing these
conditions:

* Modern SoC design leverages much more control to the designer:
  because virtually all components exist on a single chip, a system
  designer leverages a huge amount of control through computer design
  software alone.  Historically this wasn't the case when the hardware
  was spread out across multiple chips and boards, because the
  practical engineering required would practically entail more
  interations on physical hardware model testing.

* Modern hardware sales specifications closely follow those of the
  smartphone: an ubiquituous computer that is so close to the body of
  the human buyer and user that throwing out the old device and buying
  a new one is a breeze.  Unfortunately we cannot say the same about
  industrial equipment and smart home/office network devices, for
  example.

* For the two reasons above combined, SoC designs iterate much faster
  than computers of times past.

* Microcontrollers are frequently used in industrial
  environments/users and therefore needed a long-term reliable supply
  chain and excellent documentation.  By contrast, smartphone users
  have much different motivations: they want the latest and greatest,
  but they honestly don't care about how the internals work.
  Therefore, there is a proliferation of incompatible, proprietary,
  non-standards SoCs.  Getting old SoCs to work with new software is a
  _de facto_ challenge.

----------

Other points are worth noting on peer-to-peer software updates for
Microsoft Windows.  "Why?" you ask.  Or, more specifically, you, a
technically inclined person, is asking "Why?"  Well, I think the
answer should have become obvious by nowadays, even though it wasn't
clear 15 years ago.  Because, your average consumer computing user
doesn't care to setup a dedicated home server.  They won't even think
about it as a possibility.  The closest you'll get to having a
dedicated home server in the home is the router found in the modern
Internet-connected home: matter of fact, that Internet router box was
the very first computer to be running Linux in the home that
successfully hit the mass market.  So, that's that with your home
server.  Now, the monetary motivations should also be obvious here.
Those router box computers are by far and large provisioned as
property owned by the user's Internet Service Provider (ISP), rented
out solely as a means to access the Internet.  It is by far in the
ISP's best interest to make those machines as cheap as possible, with
the eventual goal to save as much money as possible for the ISP, not
necessarily the user.  That being said, although a techie would point
out that a dedicated caching proxy server in the home would be just as
ideal as peer-to-peer, the storage host is now evidently the main
problem: router boxes have virtually no storage available within them.
Hence peer-to-peer on Windows for software updates.

In the future, those Linux router boxes may find more uses and smarter
uses, but for now they are relatively confined machines that are
highly focused on a narrow range of tasks: routing and firewalling.

Again, I reiterate, because this is important!  Finally, let's remind
ourselves that when a computer user does need the equivalent of a
dedicated server for application use, they don't go out and buy their
own machine.  Nope, the _de facto_ solution is to use somebody else's
computer: think Facebook.

> There is no cloud, it's just someone else's computer.  
> -- Chris Watterston

Yep, and that's a somebody who is somehow willing to pay for that
computer to host the content of people who don't want to pay for their
own computer.  Or, is it actually just for people who don't want to
maintain their own computer, but are still willing to pay someone else
to do that?  Well, anyways, let's refocus ourselves back on the
consumer use case.  Now it should become obvious, we can remind
ourselves that the consumer computer user doesn't want to maintain or
pay for the computer either, so somehow that money has to be sneakily
taken from elsewhere, and nowadays we know what elsewhere is very
obvious: fast-moving consumer packaged goods (CPGs).  The
manufacturers who produce fast-moving consumer-packaged goods levy a
tariff, a price hike, on the goods, which is then used to pay for
Facebook, YouTube, and Google hosting, in exchange for ads marketing
space on Facebook, YouTube, and Google websites.  So, in the end, we
surreptitiously force someone who uses something but is not willing to
pay for it to actually end up paying for it.  They are not
consciousoly aware of their purchases; literally, when they're
intending to pay for something else, some of that money is effectively
"stolen" to appropriate for use in paying Facebook, YouTube, and
Google.

You could argue that this avenue of surreptitious payment doesn't need
to happen through fast-moving consumer packaged goods.  It could
happen over one of a consumer's billing accounts instead, such as for
water or Internet access.  Now, that's a good point you've brought up
because I have to remind you that is in fact what's already happening:
Comcast, a major Internet Service Provider in the United States,
subsidizes funding for a news website called _The Verge_.  Comcast
users may not realize they are paying for it, and if Comcast customers
are prompted directly about this, they may say that they do not not
want to pay for it, but regardless of what they want to pay for,
that's where their money ends up going.

You know what?  This is what I say: do not define your customers to be
people who are not willing to pay for what you are doing.  If
something needs to be subsidized, you have reason to be leery that
your business idea could fail in the marketplace.
