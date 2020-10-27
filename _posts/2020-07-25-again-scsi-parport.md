---
layout: post
title: "SCSI over parallel port, revisited again"
date: 2020-07-25 06:02 -0500
author: quorten
categories: [mac-classic, raspberry-pi]
tags: [mac-classic, raspberry-pi]
---

I already beaten this topic down many times, but I must revisit it one
more time.  SCSI over parallel port?  Sure, I know, it's not possible
since parallel port communications doesn't have enough of the right
type of I/O bits to carry SCSI communications, though the physical
connector has enough pins.  Matter of fact, classic Macintosh
computers use a DB-25 connector for SCSI.

The interesting thing though is that some vendor hardware was designed
to be dual-mode, either parallel port or SCSI port mode.

20200724/DuckDuckGo scsi over parallel port  
20200724/https://retrocomputing.stackexchange.com/questions/15577/why-did-scsi-require-so-many-pins  
20200724/https://retrocomputing.stackexchange.com/questions/6589/connecting-iomega-zip-parallel-port-to-modern-pc  
20200724/DuckDuckGo db-25 scsi  
20200724/https://en.wikipedia.org/wiki/D-subminiature

UPDATE 2020-10-26: I wasn't entirely right by saying it wasn't
possible.  If you apply some restrictions on the SCSI protocol, you
can essentially carry SCSI communications over a parallel port.
Here's how.

Iniatiator control signals, max 4:

1. RST
2. SEL
3. ATN
4. ACK

<!-- more -->

Target status signals, max 5:

1. C/D
2. I/O
3. MSG
4. REQ
5. BSY

Bi-directional data: D0-D7

Excluded signals:

* DATA PARITY.  Note that this simply means the initiator (host) can
  never read data parity.  You could technically still wire your
  target (peripheral device) to still generate and send this signal.

* DIFFSNS is not needed because parallel port communications are
  always singled-ended, that means the signal is either positive or
  ground and second wires in signal pairs are always ground.  The
  alternative is differential signaling, where signal wire pairs are
  positive and negative rather than signal and ground.

* TERMPOWER is not provided as a separate signal because parallel port
  interfaces are almost exclusively point-to-point, so the target
  (peripheral) also includes its own internal termination, as does the
  initiator (host).

Protocol restrictions:

* The target (peripheral device) cannot use bus arbitration to
  (re)select an initiator or peripheral.  The initiator (host machine)
  must always initiate SCSI bus arbitration to select the peripheral
  device.

So long as those two restrictions are met, it will work fine.
Otherwise, you need bi-directional bus transceivers on the control and
status lines, which means you can no longer use a PC parallel port
interface.
