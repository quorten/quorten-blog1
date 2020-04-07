---
layout: post
title: "Simple serial communications, and methods to progressively
        reduce the pin count requirements"
date: 2020-04-06 21:24 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Here is a quick summary of various means for serial communications and
the resulting pin counts.

Different variations of serial communications connectors.

1. SPI is the simplest type because it can connect straight to a shift
   register.  How many pins?  Typically 7 to 8: Ground, 3.3 V, 5 V
   (optional), RESET, Slave Select, CLOCK, MOSI, MISO.

   If we omit RESET and use power-cycling for RESET instead, assuming
   the receiver has a power-on-reset circuit, then we can go with only
   6 pins.

2. Asynchronous serial communications.  Eliminating the separate clock
   signal allows for only 5 pins: Ground, Power, Data Terminal Ready
   (DTE), Transmit, Receive.

   To get to 4 pins, DTE can be eliminated by assuming a bus protocol
   that transmits that information "in-band," i.e. software flow
   control rather than hardware flow control.

3. Asynchronous serial communications, half-duplex.  3-state logic and
   state tracking is used to perform transmit and receive on the same
   conductor.  3 pins.

4. Multiplexed power and data transmission, "powerline
   communications."  Data transmission is modulated on the power line.
   2 pins.

<!-- more -->

5. Single-wire earth return, half-duplex powerline communications.
   This is technically not feasible in portable hand-held electronics
   since they are low-voltage and may have no earth return path,
   especially when they are airbourne.
