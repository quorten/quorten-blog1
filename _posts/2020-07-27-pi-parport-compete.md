---
layout: post
title: "Potential competitors to `pi-parport`?"
date: 2020-07-27 23:27 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

`pi-parport` can't be the only game in town for Raspberry Pi parallel
port interfaces, can it?  Well, actually it is almost the only game in
town, but not quite.  However, the "competitors" are all proprietary
developers, so they don't really count.  Here is yet another interface
HAT, but it also includes a serial port.  Adding a single serial port,
within limits, isn't too hard to do for `pi-parport`.  It's just that
we can't have software control over all the RS-232 pins due to a
finite number of GPIO pins.

20200727/DuckDuckGo raspberry pi parallel port  
20200727/http://shop.elesar.co.uk/index.php?route=product/product&product_id=76  
20200727/http://shop.elesar.co.uk/index.php?route=information/information&information_id=4

Now, here is a really tricky one.  Rather than attempting to be a
parallel port _host_, it is designed to be a parallel port
_peripheral_.  Looking carefully, `pi-parport` _is_ in fact almost
equipped to do just that, it just needs one more control output pin
broken out to the GPIO pin header, and then a simple control <->
status swapping "null modem" cable does the trick to complete the
hardware side.  Software-side, that is trickier due to the need to
manipulate 5 control pins rather than only 4, for which an
incompatible extension must be added to `pi-parport`.

When the extra control pin is not needed, it is simply initialized to
logic-level zero for ground, and then it appears as simply one of the
unused grounded pins on the parallel port.

<!-- more -->

20200727/https://www.retroprinter.com/  
20200727/https://retroprinter.com/wp-content/uploads/2015/07/IMG_0428.jpg  
20200727/https://www.retroprinter.com/about-us/

Surely, however, there must have been a trick used in PC parallel port
"null modem" cables to get one PC to appear to another like a printer,
right?  Like, just take one of the status pins and wire then to a
constant value like ground or positive voltage.  Could ACK and BUSY be
safely tied together and assumed to be one-in-the-same?  If not, there
really is no other way, you need access to all the signals to be a
true peripheral.

Unfortunately the Wikipedia site does not provide descriptions of the
pinout, but there are numerous other sites that do.  Here I reference
an Oracle docs site, via the Internet Archive Wayback Machine because
it's commercial and you know what their future fate is.  Oh, it came
from Sun, that's why it's on the Oracle website.

20200727/https://web.archive.org/web/20200728045424/https://docs.oracle.com/cd/E19088-01/220r.srvr/806-1081-11/z400027e1451238/index.html
