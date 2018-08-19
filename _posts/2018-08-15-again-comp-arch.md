---
layout: post
title: Computer architecture in a nutshell, again
author: quorten
date: 2018-08-15 18:58 -0500
categories: [tour-de-force, reiterate]
tags: [tour-de-force, reiterate]
---

Again, I reiterate, because this is important!

If I ask myself again, computer architecture in a nutshell, what will
I get from a quick writeup?

* Hardware
* Firmware
* Local Data
* Boot Loader
* Device Drivers
* Operating System Kernel
* Machine Code Libraries
* Machine Code Kernel/Daemon/System Processes
* Machine Code User Processes
* Interpreted/JIT Language User Processes
* Interpreted/JIT Language Libraries
* Networked Data
* Front-End Software/Data

<!-- more -->

Now this is somewhat inspired from those Linux architecture diagrams
on Wikipedia, where can I find some for reference?  Of course, the XCB
article is a good place to start.

20180815/https://en.wikipedia.org/wiki/XCB  
20180815/https://en.wikipedia.org/wiki/File:Linux_Graphics_Stack_2013.svg  
20180815/https://en.wikipedia.org/wiki/File:Free_and_open-source-software_display_servers_and_UI_toolkits.svg  
20180815/https://en.wikipedia.org/wiki/File:X11_display_server_protocol.svg

Okay, that was overly abstract in some ways.  What did I miss?
Basically, I was covering only _classes_ of libraries and such, not
the particular _implementation_ of specific applications categories
like graphics, sound, networking, and so on.  That's why my listed
hierarchy above looks so simple.  Indeed, it is still correct, just
that it under-estimates the full complexity of today's modern popular
computer systems.

For example, web programming?  It is all but subsumed as a
sub-category of networked data and runtime programming languages.  Yes
you can throw in more libraries in there for web programming, but that
goes without saying.  Suffice it to say, if you used the description
above as the guiding framework for the "blueprint" by which to build a
new computer system by, for sure you'd end up with a much simpler but
just as functional computer system compared to today's modern computer
systems.

Not to mention, for decades people have been mentioning simpler
software system architectures for networked computing that look more
like the following:

* Hardware
* Firmware
* Networked Data
* Network Boot Loader

The rest of the higher level stack is almost exactly the same:

* Device Drivers
* Operating System Kernel
* Machine Code Libraries
* Machine Code Kernel/Daemon/System Processes
* Machine Code User Processes
* Interpreted/JIT Language User Processes
* Interpreted/JIT Language Libraries
* Front-End Software/Data

In practice, a more rigorous locally installed operating system has
become much more popular on modern smartphones than an
ultra-minimalistic network booting one.  Perhaps this is largely due
to the fact that smartphones need to be able to go to sleep and wake
up quickly rather than be always-on like an office computer, so in
some sense an operating system that hosts a kernel and cache in RAM
and loads the rest from the network is impractical.

As for the lack of network boot for smartphones as a fallback?  With
wireless network security, and lack thereof trust and standardization,
network boot fallback for smartphones is much more difficult than it
is for desktops and laptops.  Network boot has only been well
established withing highly controlled on-premises networks of large
institutions like businesses and schools.  Cyber cafes, public Wi-Fi,
and homes by far and large do not attempt to provide any such
facility, historically largely because of software licensing costs.
