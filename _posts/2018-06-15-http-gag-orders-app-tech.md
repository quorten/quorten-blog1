---
layout: post
title: Interesting HTTP status codes, gag orders, appropriate technology
date: 2018-06-15 4:40 -0500
categories: [random-software, raspberry-pi, legal, misc]
tags: [random-software, raspberry-pi, legal, misc]
---

About a multi-machine server.  The idea is that you have a small,
low-powered, always-on computer to process requests.  If a request
requires a larger resource, it will be forwarded to the larger
computer.  If the larger computer is powered off or sleeping, it will
be woken or powered on.  And then what?  How to handle the request
when it cannot be responded to immediately?

I thought HTTP had a status code for "resource temporarily
unavailable."  Indeed, it does.  So we have that response right there,
and we can serve a custom error page that will automatically refresh
after a timer, and tell the user the machine is powering on.

<!-- more -->

503 Service Unavailable

20180618/DuckDuckGo resource temporarily unavailable  
20180618/DuckDuckGo http request resource temporarily unavailable  
20180618/https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_error

This is an interesting status code.  Also touted as useful whenever
any Internet blocking is implemented.

HTTP 451 Unavailable For Legal Reasons

Other interesting technical and legal Wikipedia pages that are
related.  Gag orders are not a good idea, as they make the media more
susceptable to circulating false information.

20180618/https://en.wikipedia.org/wiki/Evil_bit  
20180618/https://en.wikipedia.org/wiki/Technological_fix

So what about reflecting mirrors to concentrate solar energy?  In more
temperate regions, the high temperatures were found to be killing
birds.  Of course, this is not much of a problem if you setup such
arrays in the middle of a desert.  Of course desert birds need to
beware of very hot surfaces.

20180618/https://en.wikipedia.org/wiki/Technological_fix#cite_note-10  
20180618/https://en.wikipedia.org/wiki/Gag_order  
20180618/https://en.wikipedia.org/wiki/Injunction#UK_super-injunctions  
20180618/https://en.wikipedia.org/wiki/Unintended_consequences

Great concept here, yes, one that I think more people should practice.
Building your own technology using cheap but local resources.  The
touted reason here is that such a concept is not "appropriate" in more
developed nations.  Lots of great technology mentioned in this
article.

20180618/https://en.wikipedia.org/wiki/Appropriate_technology  
20180618/https://en.wikipedia.org/wiki/Natural_ventilation  
20180618/https://en.wikipedia.org/wiki/File:Earthship-ventilation-cooling-tube-schematic.svg
