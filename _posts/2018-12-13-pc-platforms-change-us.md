---
layout: post
title: "The few computing platforms that have changed our lives the
        most from a software developer's standpoint"
date: 2018-12-13 12:25 -0600
author: quorten
categories: [tour-de-force]
tags: [tour-de-force]
---

I was reading about the Cinnamon desktop environment recently,
thinking more about the GNOME 3 controversy, and that reminded me of
something.  Despite the large number of computing platforms ever
created, there are only very few that have really moved most of us as
software developers.  So few, that they can be counted on the fingers
of one hand.  So, let's rehash what those are.

* Early PC microcomputers, early 1980s.  These are of the likes of the
  Apple II, Commodore 64, IBM PC, and so on.  The key feature of these
  systems was to introduce BASIC and assembly language programming to
  people far and wide, essentially spawning a new generation of
  software developers on a much more massive scale never seen before.
  Most early PC microcomputers shared no software compatibility in
  common.

* The Macintosh computer, late 1980s.  Being the earliest, cheapest,
  and most mass marketed computer to sport a graphical user interface,
  it was instrumental in introducing the concept of graphical user
  interfaces early on to many programmers far and wide.

  The printing interface introduced with the Macintosh computer was a
  major landmark.  Using a graphical user interface dialog to prepare
  for printing, driver support for multiple different printer
  backends, and access to network-attached printers set the standard
  of computer printing forever.

  In terms of software compatibility, there generally was still no
  such thing at this time.  Similar systems for other mass market
  computer hardware that have been introduced later, such as Windows
  and OS/2, were mutually incompatible with each other, though Windows
  had many technical features that were came directly from the
  Macintosh due to a short-term partnership.

<!-- more -->

* Windows 9x (95/98/98SE), late 1990s.  Windows 95 was the first
  biggest to bring many things together all at once.  It was developed
  after the end of the culmination of the late 1980s' rapid innovation
  in computer hardware, when the IBM PC compatible system became the
  first to introduce powerful computer hardware to the mass market.
  Windows 95 was the biggest first to bring a device driver model with
  thousands of available device drivers to the IBM PC compatible
  system.  Windows 95 was the biggest first to bring an elegantly
  designed user interface to this generation of powerful computer
  hardware.  And, by running on powerful computer hardware, Windows 95
  was capable of hosting sophisticated computer software.  Also,
  unlike Mac OS Classic, support for a text terminal/console was
  built-in by default, as required for compatibility with MS-DOS
  software.  As a consequence, support for GNU Unix-like software
  development tools on Windows grew quickly, and Unix-born software
  like Web browsers got ported to Windows quickly.  Not too long
  later, Windows 98 featured powerful modern Internet support built-in
  to the operating system installation by default.

  The particularly unusual about thing about Windows 9x at the time,
  which is still considered unusual today, was the iron-heart
  commitment to backwards compatibility that has been placed within
  Windows 9x.  This had been slowly developing in earlier versions of
  Windows that came before Windows 9x, but came to be almost an
  unstated expectation by the time of Windows 9x customers.
  Therefore, the return to less compatible means of software
  development struck many customers as a surprise when they upgraded
  to Windows XP.

  Windows 98 also made connecting to the Internet super-easy
  out-of-the-box, a far cry from the technical rigor needed in the
  past days of early PC microcomputers and bulletin board systems.
  For this reason, many people have not connected to the Internet from
  home until the advent of Windows 98, which included Internet
  Explorer 4.01 in the installation.  Connection was via dialup as it
  was easiest to setup, since Windows 98 home PCs shipped with a
  built-in modem.  Hence, Windows 98 marks the beginning of many
  facets of web development which are still quite similar today as
  they were at the turn of 1998.

  Almost overnight, many startup companies raced to build the dot com
  boom, starting in 1995.  Alas, on the user side of affairs, suffice
  it to say that most people were still learning how to use the
  Internet in _1998_.  1995 is barely worth considering except for the
  more technically involved early adopters willing install Internet
  Explorer manually, setup dialup Internet through more complicated
  means, and so forth.  Not to mention that the Internet/Web wasn't
  clearly technologically superior for many things, hence the dot com
  crash came fairly quickly thereafter.

  In wasn't until the year 2010, due to the advent of smartphones,
  that a "dot com boom" really started to take off.  Although there
  were many people who were still learning, there was a much stronger
  existing knowledgeable community to get things started.  With
  serendipity, this happened just as the U.S. economy and global
  economy were recovering from a recession.

  But, despite what I said about the dot com bubble, I cannot rival
  this quote from a book written by a venture capitalist.

  > "A friend of mine has a great line. He says 'Nothing important has
  > ever been built without irrational exuberance'. Meaning that you
  > need some of this mania to cause investors to open up their
  > pocketbooks and finance the building of the railroads or the
  > automobile or aerospace industry or whatever. And in this case,
  > much of the capital invested was lost, but also much of it was
  > invested in a very high throughput backbone for the Internet, and
  > lots of software that works, and databases and server
  > structure. All that stuff has allowed what we have today, which
  > has changed all our lives... that's what all this speculative
  > mania built".[49]

  20181217/https://en.wikipedia.org/wiki/Dot-com_bubble

  So, to be honest, that being said, we have a torn picture of web
  development among software developers at this time.  Some people
  jumped right in knowing it would be the way of the future, even if
  that overly enthusiastic prediction might need to experience a crash
  in the intermin.  Others who knew it was too early decided to wait a
  few years before learning web development.  However, those that did
  wait a few years before learning will admit that many simple web
  applications can easily be implemented to work just as well in the
  browsers from 1998.

  What matters, ultimately, is that we have a large number of
  programmers on both sides of this affair, without any "mass
  majority" waiting toward one side or the other.

* "Second generation Linux," early 2000s, continuing to the present
  day of 2018 and going beyond into the undetermined future.  Starting
  5 years after the late 1980s' rapid innovation in computer hardware,
  standardization on the physical hardware interfaces had begun.  Once
  the standardization was complete and being commercialized in the
  early 2000s, it was no longer necessary for an operating system to
  have a slew of different device drivers to run on the powerful
  hardware of a modern personal computer.  This was a considerable
  boon to Linux adoption on PCs, that was previously few and far
  between before this change in underlying PC technology.  Familiar
  GNU software tools that could be installed on Windows 9x computers
  are considered part of the system core on Linux-based system, hence
  the name GNU/Linux.  Likewise, this accelerated the popularity of
  GNU/Linux on dedicated server computers, which was already pretty
  popular in the late 1990s.

  Additionally, starting in the early 2000s, Linux became a wildly
  popular platform for embedded systems and hardware manufacturers of
  totally new CPU architectures to port to their hardware, thanks to
  its free, libre, open-source nature making community assistance and
  customizations easy.  One of the big mass market applications was
  high-speed Internet DSL/cable modem-routers.  This further
  culminated with the development of system on a chip (SoC), and Linux
  was the most popular OS to host on these.  The development of
  smartphones, their use of a system on a chip, and their mass market
  adoption worked to greatly accelerate overall Linux adoption and
  market penetration.

  By the year 2015, Linux had become firmly established in the
  foothold of modern mass market computing because of these reasons.
  In fact, the typical computer user might only ever user computers
  that run Linux over the course of their activities: from their
  smartphone, to their Wi-Fi hotspot, to the ISP's switching
  equipment, to the destination datacenter's switching equipment, to
  the application server.

  On the other side of affairs, Microsoft Windows still has a stable,
  but limited, market share: office PCs/laptops.  Windows grew to
  dominate office PCs/laptops, it failed to grow past office
  PCs/laptops, but in the domain of office PCs/laptops, nothing has
  really succeeded in eclipsing Microsoft's incumbent market share.

  Speaking of backwards compatibility, Linux systems have a rather
  unique set of affairs.  The Linux kernel itself maintains strict
  compatibility with its system interfaces that are designed for
  user-mode software to use.  However, the internal kernel interfaces
  for driver software have been traditionally unstable.  Also, the
  kernel alone is not a complete operating system distribution: many
  standard libraries and user-mode services are required to obtain a
  typical Unix-like operating environment.  Although some traditional
  Unix-like components like the standard C library remain stable, many
  important components for interactive computing like the display
  server and desktop environment are inherently unstable.  The
  consensus solution to build stable systems out of unstable
  components is through the means of _distribution developers_.  The
  distribution developers will customize the software components to
  impedance-match them together, then distribute the components
  together as a whole system.

  The result of these conditions is that only the most traditional of
  Unix-like software can be expected to run on future Linux-based
  systems without modifications.  For all other software, a
  distribution development approach is expected: to port an old
  application to a new system, the application must be customized to
  fit in the new system distribution.  To port newer versions of
  software components existing on an older distribution, either the
  newer software component or other software in the older distribution
  must be customized.

  These technical facts are not very friendly to sloppy, disorganized,
  and/or lazy software developers, especially if the software
  developed is being used by change-averse enterprise users.  As a
  consequence, virtualization very popular to use with Linux-based
  systems, so that one can keep running an old application on an old
  distribution without needing to upgrade anything.  Furthermore, the
  stability of the kernel interface has caused _containerization_ to
  become popular as a more efficient means of virtualization of old
  Linux distributions.  _Docker_ became a highly popular front-end
  interface to use for containerization.

These are some honorable mentions, but I must exclude them for my
previous list for the stated reasons.

* Windows Phone.  Arguably, Windows Phone failed for many of the same
  reasons that Windows CE failed: "shrinkwrapped" proprietary
  operating systems and embedded systems don't mix.  By the time that
  Microsoft bought Nokia, principally a hardware company, they were
  essentially too late.  That being said, retiring Nokia's platform
  was a bad idea.

* iOS. iOS was not covered because it's not as mass market as
  Linux-based Android.  Nevertheless, iOS is notable and unusual in
  many aspects.  Basically, iOS is the only proprietary smart device
  operating system still existing on the modern market place.  This is
  mainly due to the fact that Apple got itself moved into a key
  strategic position very early on, so they could muster the time and
  development resources required to create a complex modern smart
  device operating system totally in-house.  Additionally, due to poor
  business decisions, all of the other proprietary operating system
  smart device developers who did get started early on have since
  fallen out of business, effectively destroying their proprietary
  smart device code base.  For everyone else that is newer into this
  field, the only way to rival Apple is to build off of Linux by
  customizing it to their specific hardware, and sharing their
  knowledge and customizations with the broader community.

* Windows XP, early 2000s.  Despite the fact that most of us, as
  computer users, remember Windows XP in contrast to Windows 9x as
  bringing a reliable operating system and a reliable computer to the
  table, in so far that freezing and crashing almost never happened on
  a day-to-day basis, honestly from a software developer's standpoint,
  not much has changed from Windows 9x to Windows XP.  Sure, there
  were some important new features and API functions added to Windows
  XP, but almost all of them were also brought to Windows 9x through
  the inclusion of redistributable dynamic link libraries.  Honestly,
  from a software developer's standpoint, the main reason for Windows
  XP was to get a version of Windows that worked on newer computer
  hardware.  Software developers mainly focused on the fact that
  average computer hardware had a faster CPU, more RAM, better
  graphics, more disk space, and so on.

* Mac OS X.  Mac OS X was instrumental in bringing the Mac computer
  platform back to a larger market relevance.  However, it still has a
  fringe existence on the mass market.  For example, I have used many
  modern Macs myself at school and at work, but I have not personally
  owned a modern Mac.  The problem is that Mac OS X only runs on Mac
  hardware, and Mac hardware is rare and expensive.  Modern schools
  and businesses tend to send off the hardware to recycling facilities
  that effectively destroy the hardware, and upper class personal
  users (i.e. the majority of personal users of Macs) typically do
  likewise, rather than reselling the hardware.

* Windows CE.  Windows CE failed largely because it was meant to be
  sold as a software product to the embedded world.  In the embedded
  world, hardware sells, not software.  Also, the embedded world
  relies heavily on customization to get low-level software like
  operating systems running on the hardware.  A proprietary software
  project can't really do well in this kind of environment, unless
  there already exists a operating system software platform built on
  top of the base hardware.

* Mac OS 8/9.  Despite still being somewhat popular in schools at the
  time and having modern features compariable to Windows 9x, the
  general market share of Macs at the time has decimated so much as to
  make them irrelevant from a braoder, more mass market standpoint.
  Additionally, a lot of software available for Mac OS 9 was
  codeveloped to also be available for Windows 9x at the time.

* Windows 1-2, 3.1x.  From a programmer's standpoint, these early
  versions of Windows honestly weren't that much different than what
  we observed with the early Macintosh, other than the fact that
  Windows could run on mass market IBM PC compatible clone hardware.
  Perhaps the main alteration was the preference for the C programming
  language as the high-level language of choice, rather than Pascal.
  Another big thing about early versions of Windows was the
  relationship with MS-DOS, effectively making a text terminal/console
  included in the operating system by default.

* Mac OS 2-7.  These versions of Mac OS were basically simple
  alterations to take advantage of better computer hardware, like
  color graphics.  Hierarchical file systems, designed in light of
  large internal hard disks, is perhaps the most notable software
  feature improvement.  Other features added beyond this were
  relatively minor.

* FreeBSD, OpenBSD, NetBSD.  These began before GNU/Linux and were
  runner-ups in many of the previously mentioned fields.  However,
  Linux exceeded the popularity of these other systems, primarily due
  to having a stronger collaborative community.  Linux started out
  with an extreme technical disadvantage compared to these more
  established Unix systems.  Additionally, even though the *BSDs had
  huge communities of users porting them to embedded systems, most of
  these systems were proprietary and the system builders effectively
  never shared their enhancements with each other.  Over time, the
  weaker community interactions ultimately led to the demise of these
  systems from mainstream relevance, especially as market pressures
  for more powerful and complex embedded systems increased.

* Timesharing with terminals on mainframe computers.  Despite helping
  give more people access to interactive computing, hardly anyone ever
  had access to these systems.

20181213/https://en.wikipedia.org/wiki/Cinnamon_(software)
