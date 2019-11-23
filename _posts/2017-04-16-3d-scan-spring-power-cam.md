---
layout: post
title: "Raspberry Pi camera stream processing, HTML 5 webcam, 3D
        scanning armature, windup springs, motors as generators, power
        supplies sharing motors and logic"
date: 2017-04-16 21:30 -0600
author: quorten
categories: [raspberry-pi, 3d-scanning, 3d-scanner]
tags: [raspberry-pi, 3d-scanning, 3d-scanner]
---

You know what, it would be really interesting if I could stream data
from the Raspberry Pi camera and process it in real time.  It would
also be interesting if I could do likewise with HTML 5 Web API.  Guess
what?  You're in good luck.  On the Raspberry Pi, you can get live
streams via Video4Linux2.  Also, SimpleCV/OpenCV provides a wrapper to
process live streams from web cams.  Yes, so OpenCV is a good
framework for you to work with, it just doesn't provide the direct
implementation of your needed algorithm.  As for the HTML 5 Web API,
it looks like you can only fetch a video in bulk, not process a live
stream in real time.  Anyways, that's what that new media buffer thing
is about in Web APIs, it's to enable that kind of class of
applications.  Yeah, like a YouTube web page that makes it super easy
to upload smartphone videos to YouTube.

20170416/DuckDuckGo raspberry pi process live video data  
20170416/https://raspberrypi.stackexchange.com/questions/23182/how-to-stream-video-from-raspberry-pi-camera-and-watch-it-live

* Also covered were some fast and efficient means to stream video over
  the Internet.  Use VLC client with V4L2.

20170416/DuckDuckGo mdn webcam api html 5  
20170416/https://www.webcodegeeks.com/html5/html5-web-camera-example/

<!-- more -->

* Also, there were a lot of very good questions asked in the comments
  of this artcle.  Like building a mobile app, using multiple web
  cams, etc.

* Note: Truth in advertising.  I didn't get to that web search result
  so easily.  Nope, it took a few tries.  These are the earlier
  attempts.

  20170416/DuckDuckGo mdn webcam  
  20170416/DuckDuckGo mdn webcam api

Also, here are more details on the Raspberry Pi camera hardware and
software.  Yes, it looks like it is possible to get manual control
over the camera settings as you will need for the 3D scanning job.
Well, hopefully, because that was one of the problems with the
FabScan, that they couldn't get manual control and fix the parameters.

20170416/https://www.raspberrypi.org/learning/getting-started-with-picamera/  
20170416/https://www.raspberrypi.org/documentation/usage/camera/raspicam/raspivid.md  
20170416/https://www.raspberrypi.org/documentation/hardware/camera/README.md

----------

So, about the 3D scanner place mat design.  Yeah, the crane.  I'm
probably going to have to build it out of wood in order to get good
structural strength for the range of objects that I might consider
hanging.  Given the amount of space the crane and back board allows
for, some objects that fit in that space might be somewhat heavy and
not free-standing.

So, yes, I can build the setup myself, but can I find a setup that is
already commercially manufactured?  Yeah, like a "desktop crane."
Well, er, the results were hard to find, and oh no!  I don't want a
$5000 crane truck!  Okay, so changing my search terms to "toy crane,"
but then I fear that it appears that many designs are
over-complicated, designed more for the sake of intellectual curiosity
and entertainment than for practical use.

Okay, fine, so that means that I'll be building my own in order to get
a reasonably simple setup.

20170416/DuckDuckGo small crane armature  
20170416/DuckDuckGo small desktop crane armature  
20170416/DuckDuckGo desktop mini crane  
20170416/https://www.alibaba.com/product-detail/Desktop-Crane_100305812.html  
20170416/DuckDuckGo toy crane  
20170416/http://www.instructables.com/id/Kid-Crane-Riding-Toy/

----------

3D scanning notes.  3D scanner notes.

* Okay, so I have a new 3D scanner design idea.  "Laptop and compass
  design."  It is a fold-up two-paneled paper with a compass turntable
  on the bottom panel.  It takes the least amount of space to operate.
  Of course, it comes with many disadvantages, namely that you must
  move the object to scan it from different angles and that it does
  not provide an armature to support non-free-standing objects.
  Hence, it is not truly a "non-contact" 3D scanning system.  Suffice
  it to say, it cannot be used to make 3D scans of as large of a range
  of objects.  On the other hand, this design has superior portability
  for picking up and moving to distant locations.

    * The design idea borrows from that of my toy compass design.
      Well, why not use that to measure actual angles that you rotate
      an object to on a platform?  As a matter of fact, that is a
      pretty good design idea for a 3D scanner.  Certainly it is a
      much lower cost and more compact design compared to the similar
      commercial turn-table portable 3D scanner design that I saw
      presented in the FabScan research paper.

      The only problem is that the angle readings must be performed
      manually.  Not if you mark up the compass construction with
      machine-readable barcodes?  Sure, that can work, but the design
      of the barcode reader will have to be a little more complex to
      account for the precise rotation of a small number of barcodes.
      Well, that's not too much of a problem if I implement the
      barcode recognition logic in full for my larger place mat
      design.

* Important!  Remember to account for ramp-up time when starting the
  motor.  Make sure you include this in your instructions to the user.

* Use a wind-up spring instead of a motor to rotate the laser at
  constant angular velocity?  Would it be better and cheaper?  Cheaper
  if you use a cheap winding and spring mechanism, but the high
  quality springs can get rather expensive.

20170418/https://en.wikipedia.org/wiki/Mainspring  
20170419/https://en.wikipedia.org/wiki/Clockwork_radio  
20170419/https://en.wikipedia.org/wiki/Human_power

It's interesting that they have an article named "Human power."

Off topic, but useful general knowledge:

20170418/https://en.wikipedia.org/wiki/Leaf_spring

----------

Wind-up notes.  Yeah, there's the clockwork radio.  So is there a such
a thing as a wind-up flashlight?

20170419/DuckDuckGo wind up spring flashlight  
20170419/http://ask.metafilter.com/104007/Windup-light-that-does-not-use-a-battery-to-store-power  
20170419/https://en.wikipedia.org/wiki/Human_power

Yes it does look rather challenging to do well.

20170419/DuckDuckGo micro electric generator  
20170419/DuckDuckGo raspberry pi wind up  
20170419/https://www.raspberrypi.org/forums/viewtopic.php?f=2&t=4122

Okay, so these MEMs devices are a little bit smaller than my target
size.

20170419/https://en.wikipedia.org/wiki/Microelectromechanical_systems

Okay, this is a very good article.

20170419/DuckDuckGo clockwork electric generator module  
20170419/http://www.trevorbaylisbrands.com/tbbnew/technology/winduppower.asp

So, the conclusion.  Want to power a small hand-held electronic using
wind-up power?  You're definitely in good shape for your particular
use case.  Even though clockwork springs are heavier and store less
energy than AA batteries, it turns out that I don't need nearly the
full energy of a AA battery for my application, so the spring energy
storage will work just fine.

Never fear, you can turn a DC motor into a generator with ease.  So
you can go both ways, no need to make up your mind before you get
started.

20170419/DuckDuckGo can you use a dc motor module as a generator  
20170419/http://www.instructables.com/id/DC-motor-as-a-generator/

----------

Okay, looking for motors that I can wind in reverse to make an
electric generator.

Oh, this is a really nice document.  Wow, it totally compensates for
the lack of information available on Wikipedia in this subject of
mechanical engineering.  And, the document design is really gaudy.  If
you look closely, there is a screenshot of a web browser that appears
to be Internet Explorer 5.5 running on Microsoft Windows 98.
Interesting that they could make such a nice looking document way back
then.  Then again, mechanical engineering is a pretty old and
established engineering profession, so it's no wonder that there were
highly knowledgeable people in the profession.  And, being that they
were engineers, of course they had access to one of the more powerful
Windows 98 computers.

20170419/DuckDuckGo milliwatt motor  
20170419/http://www.farnell.com/datasheets/89672.pdf

Okay, so I've learned quite some new things from reading this
document.  First of all, DC motors are designed to have a range of
speeds at which they work optimally at.  Below those speeds they don't
work so well.  Usually, the default speed of the motor is too fast for
most applications, so gearing must be used to slow down the motor.
But then the motor outputs more torque!  Also, what is the minimum
energy output of the motor?  12 V input, 3 W output.  Oh, yeah, the
disadvantages of the system.

So, it looks like the disadvantage of even a DC motor generator is
that it may require quite some energy input to get even any energy
output.

Here are some more useful resources on DC motors.

20170422/DuckDuckGo low current dc motor  
20170422/http://www.designworldonline.com/Selecting-Small-DC-Motors-for-Low-power-Applications/  
20170422/https://en.wikipedia.org/wiki/DC_motor

Okay, I think I get the idea.  The number of windings determines how
much energy you get out of the motor for a particular voltage.  As my
experiments below show, it's okay to feed the motor less voltage than
the specification indicates.  I believe the indicated voltage is the
maximum voltage for continuous operation under the specified
environmental conditions.  So we're okay, no need for more searching.

----------

Next question.

20170420/DuckDuckGo is it safe to connect an led and a motor to the
  same power supply

Okay, now I couldn't really find a real answer, but I guess that it is
safe when you think about it.  If you can connect a relay and a LED in
parallel, then it must be just as safe to do so with a motor, and I'm
pretty sure I've done that before with the 200 in 1 electronics kit.

"Yes" is the answer.  Indeed, I have done an experiment where I power
both an LED and turn a motor on and off from the same 3 V power source
and I have not had issues.  Thus such a mechanism must work just as
well in the case of using the laser diode.

So, to put things this way, the inductive spiking problem is only a
problem when you need to interface CMOS electronics with motors.
Otherwise, you wouldn't normally expect it to be a problem with most
electronics.  LEDs and TTL circuitry are okay.

----------

Next question.

About DC motor voltages and power generation.  Can a DC motor generate
3 volts with ease?  Well, let's do an experiment.  Take that small
Lego motor and wire it up to the 200 in 1 electronics kit to 3 volts.
Does it work?  Yes it does.  Now let's check if we turn it and connect
it to our digital multimeter.  What voltage do we get?  We can easily
sustain 3 volts by rotating the motor at a decent speed, but greater
voltages can be generated by rotating the motor faster.

Thus, in order for this to work well with our laser, we need current
smoothing and voltage regulation circuitry on the output.  Perhaps a
simple integrated bridge rectifier with a built-in voltage regulator
would do the trick.

Yes, now for the question on voltage regulation.  Does a switched-mode
power supply generate electromagnetic noise?  Does a voltage regulator
generate less EMF noise than a switched-mode power supply?

Let's go check Wikipedia.  And the answer?  Yes, indeed a simple
linear voltage regulator generates less EMF noise than a switched-mode
power supply.  Actually, in fact, for very low voltage applications,
the linear voltage regulator can be preferred not just due to
implementation simplicity, but also due to superior performance under
some circumstances.

20170422/https://en.wikipedia.org/wiki/Voltage_regulator  
20170422/https://en.wikipedia.org/wiki/Voltage_regulator#Comparing_linear_versus_switching_regulators  
20170422/https://en.wikipedia.org/wiki/Constant_current_regulator

Off topic.  Ah, so this is the Wikipedia article on the related
computer component.

20170422/https://en.wikipedia.org/wiki/Voltage_regulator_module

----------

Next question.

Where do we buy the wind-up spring module?

20170422/DuckDuckGo wind up gearbox mechanism do it yourself instructables  
20170422/http://www.instructables.com/id/Creating-3D-printed-wind-up-no-assembly-required-g/

Interesting, but not what we want.  No, we want professional
metallurgy in the spring mechanism, not just flexible plastic.  But,
remember that you can 3D print plastic gears if you don't think you
can get what you need as already manufactured parts.

20170422/DuckDuckGo wind up mainspring module  
20170422/DuckDuckGo wind up spring

Ah, yes, looks like we're making progress.

20170422/http://www.globalspec.com/Industrial-Directory/wind_up_spring

Okay, no, that's not good enough.

20170422/DuckDuckGo wind up spring supplier

Here is a listing of mostly just bare springs that need to be
integrated with additional mechanisms to make a useful spring motor.

20170422/https://www.alibaba.com/showroom/wind-up-spring.html  
20170422/https://www.alibaba.com/product-detail/Stainless-steel-wind-up-spring-rewind_60631166549.html?s=p  
20170422/DuckDuckGo how to build a wind up toy

This page contains useful information on the internals of wind-up
mechanisms.

20170422/http://re.trotoys.com/article/wind-up-mechanics/  
20170422/DuckDuckGo spring-powered motor  
20170422/https://www.alibaba.com/showroom/spring-powered-motor.html

These are some useful information pages on the different kinds of
springs.  Unfortunately, these company websites center around custom
manufacturing for engineer requests.  Yeah, too expensive for my
taste.  Looking at these, I think it is clear that I just want a
conventional power spring made of stainless steel.

* Yes, but I want it built into a packaged enclosure!

20170422/http://www.springcompany.com/products/power-springs  
20170422/http://www.hunterspringandreel.com/products/springs  
20170422/http://www.hunterspringandreel.com/products/springs/power-spring-clock-spring  
20170422/http://www.hunterspringandreel.com/products/springs/power-spring-clock-spring/conventional-power-spring  
20170422/http://www.hunterspringandreel.com/products/springs/power-spring-clock-spring/prestressed-power-spring-spirator  
20170422/http://www.hunterspringandreel.com/products/springs/constant-force-spring-negator  
20170422/alibaba spring powered wind-up motor  
20170422/https://www.alibaba.com/showroom/wind-up-spring-motor.html

Lots of good results on Alibaba, but I need to go revisit the pages
with a better browser.  They might have what I need, but some assembly
may be required, unfortunately.  Unfortunately it seems that I can't
just get a metal box containing everything I need.

Anyways, about the spring speed.  Maybe you don't need to spin the
motor at the full 3 volts speed.  Perhaps the "joule thief" circuit
can somehow be used to deliver the correct voltage even when the motor
spins at a slower speed.  This will allow me to use less powerful
springs, and it will make the entire system more energy efficient.
