---
layout: post
title: Searching for methods to add a keypad to a Raspberry Pi
author: quorten
date: 2018-11-07 12:30 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, now I want to know how to reuse an old calculator keypad in an
electronics project.  Any info on the Internet?  Well, that's a tough
one.

I found this interesting article about calculator versus telephone
keypads on the Internet.

20181107/DuckDuckGo reuse old calculator keypad  
20181107/http://www.todayifoundout.com/index.php/2015/10/keypad-numbering-different-phones/

You can try buying a calculator keypad off of Alibaba.  No thanks,
that kind of defeats the purpose of being able to reuse.

20181107/https://www.alibaba.com/showroom/calculator-keypads.html

Here's an Arduino project on building a calculator using a calculator
keypad, an LCD screen, and an Arduino.

20181107/https://www.instructables.com/id/Arduino-Calculator/

Here's the keypad used, available on Digikey.

20181107/https://www.digikey.com/product-detail/en/96BB2-056-R/GH5011-ND/12622

The datasheet for the keypad.  Indeed, it is a simply matrix key scan
system.

20181107/https://media.digikey.com/pdf/Data%20Sheets/Grayhill%20PDFs/96%20Series.pdf

<!-- more -->

Now, I'm trying to understand key ghosting.  Why is diode isolation
required to prevent key ghosting?  It can be explained like this.
With just a matrix of wires, currents can flow in any direction.  In
the principle use case, you only want current to flow through one side
of the matrix, to a key, then flow to the other side of the matrix.
If only one or two keys are pressed, this is guaranteed to always be
the case when scanning the keyboard.  But if three or more keys are
pressed, then it is possible for current to travel a backwards path
through one of the keys, turn around at a second pressed key, then
flow to the other side, effectively registering a current path that
would be decoded as the ghost key.  To prevent ghost keys without
diode isolation, the keyboard controller can do "jamming" by signaling
an error instead of scan codes if more than two keys are
simultaneously pressed.  By contrast, if you want to simultaneously
detect more key presses are are willing to pay extra money to do so,
you can add in the diode isolation, which conversely simplifies the
controller as it does not need to check for key jamming.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2018-11-07-ghost_key.svg"
        width="250" height="250">
  Ghost key diagram...  Sorry, you need SVG support to see this.
  <!-- <img src="{{ site.baseurl }}/blog/images/2018-11-07-ghost_key.png"
       alt="Ghost key diagram"
       width="250" height="250" /> -->
</object>

The blue arrows in the diagram indicate the travel of electric current
from the GPIO output connected on the columns to the GPIO input
connected on the rows.  The green circles indicate the pressed keys.
The red circle indicates the ghost key.

20181107/https://en.wikipedia.org/wiki/Rollover_(key)#Ghosting  
20181107/https://en.wikipedia.org/wiki/Keyboard_matrix_circuit

Calculator LCD display = multiplexed display.

20181107/https://en.wikipedia.org/wiki/Rollover_(key)#Ghosting
https://en.wikipedia.org/wiki/Multiplexed_display#Character-oriented_displays

This is an interesting method to combine I/O pins for both scanning an
LCD display and scanning a keypad.

20181107/http://ww1.microchip.com/downloads/en/appnotes/00529e.pdf

So, you're wondering how to cut circuit traces on a printed circuit
board?  What is the best way to do this?  Here's how.  First, you use
a surgical knife, micro drill system, or razor blade to cut the trace.
Next, the best practice is to seal the gap between the cut trace using
epoxy.  Note, however, that you've also got to be sure that the traces
you desire to cut are not within an inner layer of the circuit board.
So long as the traces can be cut on one of the outer-most layers of
the circuit board, you're good.

Printed circuit boards are interesting in their strengths and
weaknesses.  One of their main weaknesses is that they are not easy to
modify.  On the other hand, one of their strengths is that they are
very easy and cheap to manufacture, so if you do need to make
modifications, simply print a new PCB.  But, in light of this, one of
printed circuit boards weaknesses is that their manufacturing process
is not very friendly to our planet and our living environments.  This
problem is compounded with the increased waste of manufacturing new
printed circuit boards and throwing away old ones every time changes
are made to a design, especially if we're talking about designed
commercialized in the consumer mass market.

20181107/modify printed circuit board  
20181107/http://circuits-central.com/pros-cons-printed-circuit-boards/

This is a really great site all about the subject of modifying
advanced electronics circuit boards and the like.  Indeed, it does
contain information on how to cut traces on a circuit board.

20181107/http://www.circuitrework.com/guides/guides.html  
20181107/http://www.circuitrework.com/guides/4-3-1.html
