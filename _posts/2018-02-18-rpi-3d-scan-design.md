---
layout: post
title: "3D scanner Raspberry Pi design, power supply, cost equations,
        the Zero Phone"
date: 2018-02-18 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner, raspberry-pi]
tags: [3d-scanning, 3d-scanner, raspberry-pi]
---

So. how will the Raspberry Pi user interface and hardware design look
like?  Here's what I've determined given my requirements.

* There will be a minimal number of hardware buttons for starters.
  These are connected to GPIO pins.

    * At least one button to advance to the next step.
      Alternatively/additionally, this one button controls "barcode
      command mode," wheree the device checks if it can read a QR
      barcode indicating a specific command.

    * At least one button to reset to "start" state to redo
      preliminary calibration steps, possibly by restarting the
      operating system.  This button can also be double-pressed to
      initiate a device shutdown.

    * Buying a pack of 5 or more buttons is recommended so that we
      have room for expansion on other projects such as single-handed
      typing, etc.

* A 1-bit piezoelectric speaker to communicate with the user.  This
  allows for very rich communication of basic state in a very small
  package: 12 notes on one octave, 132 notes with chords on an octave,
  and so on.  LEDs, by contrast, are much less permissive to rich
  communication, but they do offer persistent visibility, rather than
  intermittent signaling as is typical through audio.

<!-- more -->

* Power supply?  For sure, power over USB is supported.  Upon closer
  analysis, it's actually not that hard to add battery charging with
  Nickel Metal-Hydride battery chemistries.  When you plug in the USB
  power, power flows through the pins normally used to power the
  Raspberry Pi.  This power can then be fed into a battery charging
  control circuit, which can be very simple in the case of Nickel
  Metal-Hydride batteries.

    * So, what components would be required for this?

    * Hard toggle power switch

    * Buck/boost switched mode power supply rated for 5 V

    * Battery holder compartment (AA/AAA, 3 or 4 batteries, depending
      on your preferences)

    * 4 Nickel Metal-Hydride batteries recommended, though 3 might
      work too with the correct buck-boost switched mode power supply
      circuit

    * Diodes and resistors to isolate and regulate the current flow in
      the respective directions of charging/discharging.

    * (optional) Power management integrated circuit (LTC4412 IC) to
      switch off battery charging when the battery is full

        * LTC1579 can be used if the current draw is no more than 300
          mA, which will only be the case in a nearly bare-board
          design.

    * (optional) Capacitors as required for the power management
      integrated circuit

    * (optional) MOSFET to switch off battery power supply in software,
      so the device can turn itself off automatically

    * (optional) Button to trigger on MOSFET in the case of automatic
      powerdown support

* USB power supply, so that you don't have to share this with your
  smartphone.  This is especially important if you are not using
  (rechargeable) batteries.  Remember that USB has 2-5 meter rated max
  length, so if you want longer than this, you should use AC extension
  cords.  Yeah, I know, their weight and bulk is a nuisance, but this
  is the best practice since power USB cords will tend to transmit
  some signaling data too.

    * Okay, this is a pretty hard cost equation to solve... if you are
      using NiMH rechargeable batteries, of course you have a separate
      battery charger.  Building in a battery charger circuit would
      add to the cost and might not even be necessary for some users.

      Verdict: Battery power optional, if supplied there will be no
      support for battery charging.  Diodes will be used so that the
      user can plug into line power without risking the battery
      health.  Why does this make sense?  Typically, battery charging
      is done one cell at a time, whereas power supplies connect the
      batteries in series.

      Wait.  Is it actually still safe to remove the batteries without
      a switch to disconnect them?  Probably.

        * Again, I reiterate, because this is important!  NiCd and
          NiMh batteries _can_ be charged in series.  However, make
          sure you properly limit and regulate the voltage if you do
          this.  See my [previous blog article]({{ site.baseurl
          }}/blog/2018/03/05/clar-batt-chem-switch-psu) on the
          subject.  So, yes, it is actually rather easy to build NiMh
          **and** NiCd battery charging into a Raspberry Pi.

    * If you want outdoor use... expect to pay extra for battery
      circuits.  On the other hand, if you're traveling for outdoor
      use, you'll be spending much greater costs on transportation, so
      that is the other thing to consider.

    * If you do lots of traveling and don't want to lug around the
      external battery charger (they can actually be made pretty
      compact), then you will also likely be willing to pay extra for
      the battery charging circuit.

* Two motor-control integrated circuits (L293D), required for
  switching the IR filter, optionally controlling the laser drive
  motor, and controlling any other motor-like things you want.

* Long wires to connect the laser/motor to the Raspberry Pi, in case
  you want to run off of a single power supply.

* Removable plastic plugs for the laser/motor long wire connections.

    * How do we solder the wires in?  Oh, maybe the wires are in-built
      and we solder the connections on the outside.

* (optional) Display?  Use an additional device like a mini display,
  smartphone, etc.  Yes, this ties down to the interest of a
  cost-conscious device and enabling a specialized use case with
  minimal cost and the availability of cheap sharing with such more
  expensive devices.  That is my recommendation, use the Raspberry Pi
  to control the laser and motor.

----------

Wondering about the buck/boot switched mode power supply for
battery-powered Raspberry Pi?  Here it is.  It is a board designed by
Adafruit containing Texas Instruments integrated circuit parts.  Alas,
it costs about $10, and so does the AC wall adapter cost $10.  The AC
wall adapter is quite a bit bigger than the ones used on the latest
smartphones, what's the catch?  This adapter is specially designed to
work well with power-hungry single board computers such as Raspberry
Pi, Beagleboard, etc.

The power supply is 5V, correct?  Yes, that is the desired logic input
level.

20180224/https://www.raspberrypi.org/help/faqs/#introWhatIs  
20180224/DuckDuckGo raspberry pi switched mode power supply 5v  
20180224/https://www.raspberrypi.org/blog/power-supply-confirmed-as-5v-micro-usb/  
20180224/https://raspberrypi.stackexchange.com/questions/22352/using-a-generic-switching-power-supply  
20180224/https://raspberrypi.stackexchange.com/questions/7723/suitable-power-supply-for-dc-power-through-gpio?rq=1  
20180224/DuckDuckGo raspberry pi battery buck boot circuit

This rechargeable project only mentions lithium-ion battery sources.

20180224/http://www.instructables.com:80/id/Make-Your-Pi-Project-Rechargeable  
20180224/http://www.instructables.com:80/id/Raspberry-Pi-PowerHAT/

It turns out there are two power supply board choices.  The first one
is the preferred one because it is cheaper and it is also recommended
as best satisfying our intended use case.

* As it turns out, the lithium-ion battery equivalent is $5 more
  expensive.  On the other hand, the built-in battery charging circuit
  may prove more convenient than your options for a built-in battery
  charging circuit for NiMH rechargeable batteries.

    * Plus, the lithium-ion polymer battery only costs $8!  Yeah, but
      my NiMH batteries costed $12 and had more charge capacity too, I
      believe.

"VERTER 5V USB Buck-Boost - 500mA from 3V-5V / 1000ma from 5V-12V"

20180224/https://www.adafruit.com/products/2190

"PowerBoost 1000 Basic - 5V USB Boost @ 1000mA from 1.8V+"

20180224/https://www.adafruit.com/products/2030

"PowerBoost 500 Charger - Rechargeable 5V Lipo USB Boost @ 500mA+"

20180224/https://www.adafruit.com/product/1944

"5V 2.4A Switching Power Supply with 20AWG MicroUSB Cable"

20180224/https://www.adafruit.com/product/1995

"Lithium Ion Polymer Battery - 3.7v 500mAh"

20180224/https://www.adafruit.com/products/1578

This near-impossible idea.  Use capacitors to supply power for a
5-second powerdown.  If you go with supercapacitors, maybe.
Otherwise, go for batteries if you need this kind of use case.

20180224/https://raspberrypi.stackexchange.com/questions/5372/circuit-to-safely-power-down-pi

This is way too big to be practical to use with a Raspberry Pi Zero.
Also, it looks like it's too expensive too, despite the nice large
selection of features.

20180224/http://www.pimodulescart.com/shop/item.aspx?itemid=5

Important!  What are those tiny plastic connectors found on your IR
module?  JST connectors.  Good idea to try using that to plug in your
removable modules.

20180312/https://en.wikipedia.org/wiki/JST_connector

Hey!  Arduino has a voltage regulator built-in?  Yep.  It runs on 5 V
logic, and can accept anywhere from 3 V to 7 V.  Aww, bummer, the
Raspberry Pi would be really easy to run off of battery power if it
were designed likewise, but it's not.  For sure, Arduino is designed
for embedded hardware projects, but the Raspberry Pi is not so much.

----------

Okay, now for some conclusions for all my musing over the cost and
component count of this system.  Why can't you just use a smartphone?
Wouldn't that be wholistically easier and cheaper?  Actually, no.  You
can't get analog electronics motor control out of a smartphone, so
you'd end up needing to use some sort of auxiliary support circuitry,
and then that brings you back to Arduino or Raspberry Pi.  Those kinds
of devices are the most opportune for controlling analog electronics
by the use of wiring in additional support circuitry, plus they'd be
necessary to interface with a computer such as a smartphone, so you
might as well do all computation locally on a Raspberry Pi to make the
whole application cheaper.

Then again, if you do use the separate battery-powered motor and laser
module, the smartphone method would be viable through the use of a
smartphone tripod.  Again, you'd still need the tripod for the motor
and laser assembly too.

----------

Let's re-evaluate the cost equations.  Yes, we're including my real
$25 laser line module cost in here, not the ideal $2 one.

* $0 paper mache armature
* $25 laser diode line generator
* $3 battery holder (or other portable power device)
* $9 buck/boost 5V power supply regulator
* $12 4 x NiMH batteries
* $8 wall power supply
* $5 Raspberry Pi Zero
* $5 Raspberry Pi Zero FPC camera connector
* $11 32 GB MicroSD card
* $25 Raspberry Pi Camera

Subtotal: $103 dollars

* $3 NoIR filter
* $2 L293D motor controller
* ? Capacitors?

Total: $108 dollars.

Wow, expensive.  What are the biggest costs to be cut?

* $12 4 x NiMH batteries
* $9 buck/boost 5V power supply regulator
* $8 wall power supply

Subtotal: $29 dollars

* $25 Raspberry Pi Camera
* $11 32 GB MicroSD card

Subtotal: $65 dollars

Including the poorly selected laser line module.

* $25 laser diode line generator

Subtotal: $90 dollars

----------

More interesting documentation on using the L293D microcontroller.

20180224/DuckDuckGo L293D  
20180224/http://www.instructables.com:80/id/Control-your-motors-with-L293D-and-Arduino/

Lesson learned on batteries: Some batteries, i.e. Alkaline, actually
supply _less_ charge when used with high current.  This is the main
reason why cameras like to use Lithium batteries.

"Picking Batteries for your Robot"

20180224/http://letsmakerobots.com:80/node/3819

No!  No!!! Broken link.  And this is just the one I really wanted to
see the most.

"Once you've decided on batteries, how do you regulate the voltage"

broken/http://letsmakerobots.com/node/3880

So yeah.  Anyways, I was wondering if that analog control chip that I
spied on the old furnace control circuit was the L293D.  It looks like
that can't be the case, because that one chip controls like 4 relays,
and the L293D can control at most two motors.  By the way, the furnace
control circuit was replaced because the old one was broken.  However,
I believe it may only be the motor that is broken, or one of the
analog relays, but the digital logic should be okay for reuse.

----------

So how does the Zero Phone get so cheap at only $50?  Answer: the
components are purchased directly from Chinese resellers on Ebay, then
they are hand-soldered onto hobbyist-grade printed circuit boards.
However, the cost of doing this is that one has to verify that the
reseller is actually selling working components.  With the lower
prices and obscure names, one could just as well be buying from a
cheat and not know it until later testing.

20180224/DuckDuckGo zero phone raspberry  
20180224/https://hackaday.io/project/19035-zerophone-a-raspberry-pi-smartphone  
20180224/https://wiki.zerophone.org/index.php/Sourcing_ZeroPhone_parts

Important!  The site also lists some super-sites that list Raspberry
Pi Zero resellers.

Also, the site is good in its own right for listing lots of useful
components that you can use with the Raspberry Pi Zero like GPIO port
expanders.

So, anyways... continuing with my price discussion.  So, here's the
main question out of this.  It all boils down to this.  Who is your
target market?  If you truly do have a mass market target, then you
can go for the Chinese components to get your component prices down to
the levels that are used in typical commercial consumer mass market
electronics.  However, you do so with full knowledge of the fact that
you do have to do a bit more research to verify that your low-cost
components actually are real and functional.  Besides, it's actually
okay if the components turn out to be of low reliability: consumers
don't keep their electronics around for too long.  By contrast, what
if your true target market is the hobbyist market?  Then by all means,
you're going to want to give your customers a greater quality
assurance.  Yes, go for the American resellers.  The components will
cost 2-5 times as much money, but there will be a very strong
guarantee of reliability and longevity.  Yes, and hobbyists have much
different motivations.  Generally speaking, hobbyists want
high-quality electronics that are last long, are modular, are easy to
repair, and easy to upgrade.

Now, this needs to be discussed in greater detail.  The consumer
market is driven by an old mentality known as "keeping up with the
Joneses."  The idea, as aptly stated, is that if your next door
neighbor buys some fancy new gadgets, you've got to buy some fancy new
gadgets too to "keep up" with them and have a similarly high social
reputation that they've gained from their new purchases.  In the end,
this means that the consumer electronics market generates a lot of
waste as people keep throwing out their old electronics to buy new
ones.  Consequentially, consumer culture motivated by "keeping up with
the Joneses" also fuels the fastest growing waste stream, e-waste.

Hobbyists, by constrast, have much different motivations.  They do
things on their own agenda.  If their neighbor doesn't think that it's
cool, they don't care.  So long as the hobbyist personally thinks it's
cool, they'll do it.  As a result, there tends to be a much greater
emphasis on reliable, long-lasting, modular, well-designed electronics
rather than the cheap throw-away electronics espoused by the consumer
world.

20180303/https://en.wikipedia.org/wiki/Keeping_up_with_the_Joneses

Ah ha!  The Wikipedia article even agrees with me!  It mentions a
quote that consumerism in fact does divert useful resources from more
important commercial enterprises.

My Dad:

> People didn't do so much "keeping up with the Joneses" in the old
> days when they were farmers.  They just work work work work work
> work work work.  Don't care what they neighbors think, hardly even
> see the neighbors very often.  Hard working farmers were the kind of
> people who came to America.

My Dad has been asking this a lot in comparison to the 3D scanning and
Raspberry Pi project cost comparisons.  You also have to factor into
consideration your own cost and compare that to the cost of having
someone else do it for you.

So, my question.  How do you measure your own cost?  Now I have the
answer.  Don't concentrate too much on your own cost.  Instead,
compare total system costs.  How much does it cost for you to do it
yourself directly versus having you ask someone else to do it?  This
is the key.  When you ask someone else to do a task, you need to pay
for your own living expenses **and** those of the person doing the task
on your behalf.  So, in the end, it is always more expensive to ask
someone else to do something for you.  The question then, comes down
to this.  Is it more _economic_ to have someone else do the task for
you?  This is definitely the case if when you ask them to do the task
for you, while you're waiting for it to complete, you work on another
task simultaneously.  However, if you sit around waiting and doing
nothing during that time, then it is still equally economic to do it
yourself, even if doing so would take twice as much time as paying
someone else to do it for you.  Even if it is more economic to have
someone else do it for you, then this still comes down to the fact
that you are collectively getting more work done in less time, and it
is costing _you_ more too.  So then the question comes down to this.
Yes, I am getting more work done in less time, but is it worth my
money when I have to pay for the whole ordeal myself?

Now, this comes back to a really interesting observation about the
economy.  Generally speaking, monetary payouts are **not** balanced with
the amount of work that people accomplish: some people accomplish a
lot of valuable work and get paid very little for it, while others
accomplish very little valuable work and get paid a lot of it.  People
working in research are an example of the former category, and people
working in finance are an example of the latter category.  So, it goes
without saying that the finance equations are not balanced with the
work productivity equations.

* You might be funding a lot of people to get a lot of work done in a
  highly economically efficient manner, but in the end you could end
  up loosing money in doing so, simply because people aren't paying in
  more money to compensate for the increased productivity levels.

So, there's the answer.  In the end it comes down to the money supply
in the market segment that determines the maximum efficiency and
productivity levels that may happen in a professional discipline.  And
we know that the computer graphics discipline is always short-funded,
so it does not make sense to pursue grander, more economically
efficient visions.
