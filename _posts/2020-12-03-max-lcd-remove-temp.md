---
layout: post
title: Maximum safe temperature for LCD electronics?
date: 2020-12-03 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

The printed circuit boards of modern electronics can stand up to quite
high temperatures.  They have to, because they need to survive the
heat of the reflow soldering oven.  Well... technically they only need
be designed to survive that heat two or three times for a few minutes
each time.  But still, usually they still are mostly functional even
when the sensitive components are pushed past those
manufacturer-specified limits.

So, you have a modern mobile electronic device that you want to repair
with heat?  Yes, remove all batteries, both the main power battery and
the CMOS clock battery, if present.  But what about the LCD screen?
We've been told many times that when it comes to working with heat and
LCD screens, you've got to be careful because too much heat can damage
the LCD screen.  So, how much is too much.

Never fear, I can consult the official manufacturer datasheet I found
for one of the LCD screens I use, found from this [previous blog
article]({{ site.baseurl }}/blog/2020/10/13/laptop-lcd-deep-dive).
Combined with other info I've found on the Internet, I have a verdict.

20201003/https://datasheet4u.com/datasheet-parts/LTN154X3-L06-datasheet.php?id=672537  
20201003/DuckDuckGo lcd hot glue temperature range  
20201003/https://www.ifixit.com/Answers/View/463364/What+is+the+suggested+temperature+of+a+heat+gun+to+remove+the+screen  
20201003/https://www.ifixit.com/Answers/View/251709/Which+Temperature+on+LCD+Separators+is+free+of+risks

<!-- more -->

* 60 degrees Celsius: Official manufacturer absolute maximum rating
  for long-term storage temperature, at maximum relative humidity of
  27.7%.

* 80 degrees Celsius: Hypothetical manufacturer accapted storage
  temperature provided that the relative humidity is extremely low.
  Low-range safe temperature for safely removing hot glue around a
  LCD assembly.

* 100 degrees Celsius: Hypothetical manufacturer accapted storage
  temperature provided that the relative humidity is zero.  Maximum
  temperature for safely removing hot glue around a LCD assembly.

The reason why the operating temperature is lower than the storage
temperature is because the electronics themselves generate heat while
in operation that needs to be dissipated, lest the temperature
permanently damage the liquid crystal material in a cook-off.  For the
particular display I've referenced, the maximum operating temperature
at the glass surface is specified at 50 degrees Celsius, 10 degrees
lower than the maximum storage temperature.  However, the heat
dissipation of the display in operation is not specified.

So, now a point in hand.  What is the reason why you are heating up an
LCD?  To remove water?  Then you must be extra cautious and use lower
temperatures, lestyou exceed the humidity-adjusted ratings.  But, by
contrast, if your LCD is dry to the regular air humidity levels, you
can take up the higher temperatures, in this case exclusively for the
purpose of softening hot glue.

----------

So, coming back to the broader point.  You want to bake off an
electronic device whole to repair it?  First important question: Does
it have an embedded LCD screen?  If so, your maximum temperature is
severely limited to that one component.  If you want to go higher, you
must separate the LCD screen from the rest of the components.  So,
let's build a temperature range chart for computer equipment.

* 060 C: Maximum safe temperature for wet/humid liquid crystal
  displays

* 080 C: Maximum safe temperature for dry liquid crystal displays

* 100 C: Boiling water, maximum safe temperature for extremely dry,
  zero relative humidity liquid crystal displays

* 140 C: Melting point of low-temperature hot glue., melting point of
  low-temperature heat seal connectors

* 200 C: Baking with browning effects, spontaneous combustion of paper
  and wood, melting point and glass transition temperature of most
  plastics (LDPE, HDPE, PP, PMMA, PLA, ABS, PC), melting point of high
  temperature hot glue, melting point of leaded solder

* 260 C: Lead-free reflow soldering oven, melting point of PS, PET,
  PVC plastic

That's what it looks like!  So, really a lot of the same chart details
as my classic [hot temperatures chart]({{ site.baseurl
}}/blog/2019/11/02/hot-temps-list), but with a bit more detail on the
low-end of the temperature range to indicate the temperature
sensitivity of LCD displays.  It makes sense that I have to use a
separate chart for this listing because the lower temperatures in this
scale don't quite so much classify as "hot" temperatures.
