---
layout: post
title: "Servo motors, Raspberry Pi oscilloscope, and Raspberry Pi
        composite video input"
date: 2016-07-04 21:00 -0600
author: quorten
categories: [raspberry-pi, minolta-cam]
tags: [raspberry-pi, minolta-cam]
---

Servo motors?  How do you determine unknown pin-outs on a servo motor,
such as that on the inside of my old Minolta camera?  Well, I'm still
not exactly sure, but this is a helpful resource.

20160704/http://www.jameco.com/Jameco/workshop/howitworks/how-servo-motors-work.html

So, how about a Raspberry Pi oscilloscope?  That should help you
diagnose the connection.

Cool!  Raspberry Pi oscilloscope.  Well, this isn't actually
particular to the Raspberry Pi, but it works with the Raspberry Pi.
If you ask me, I'd go for the micro one.  I like the small size, and
it is fast enough for my purposes.

20160704/https://www.raspberrypi.org/blog/bitscope-micro/  
20160704/http://www.bitscope.com/pi/  
20160704/http://www.bitscope.com/  
20160704/http://www.bitscope.com/design/?p=machine  
20160704/http://www.bitscope.com/pi/  
20160704/http://www.bitscope.com/product/BS05/  
20160704/http://www.bitscope.com/product/BS10/

Oh, hey!  Let's revisit that other article referenced above on servo
motors.  It says the _standard_ time versus angle is represented in
the chart.  And, that's also what I've got from the other source I
found.  Well, that sounds pretty good then.  I've got reliable
references to work with.

<!-- more -->

20160704/http://www.societyofrobots.com/actuators_servos.shtml

Yes, in fact, it seems I've got a very reliable message emerging.
Here are the key points:

* **Standard timing** is as follows.

* The pulse period is 20 ms.

* 1 ms pulse moves the servo to zero degrees.

* 2 ms pulse moves the servo to 180 degrees.

* What if the pulse is shorter or longer than this?  Some servos will
  move to the respective min or max position, others will go out of
  order, and still others will do nothing.

* It seems the +V power pin is always in the center.

* If you mix up the ground and signal pins, this _may_ not cause any
  actual damage to the servo motor.  However, I've also seen another
  source that warns strongly against mixing up the red and black pins.
  Plus, my warning about about the behavior of nonstandard signals
  still applies.

Are there any servos that _don't_ use standard timing?  Apparently
these are very rare.  Very very rare.  So, the only thing left that I
need to do is find a way to generate the proper pulsed signal and find
out which pins are which.  Both such activities are greatly
facilitated with the help of an oscilloscope.

Oh, yeah, and that reminds me.  Composite video input for a Raspberry
Pi?  Record from a composite video source?  Well, as it turns out, I
haven't seen many recommendations for using the GPIO pins to do this
job.  Mostly they recommend using a USB 2.0 UVC-compliant frame
grabber.  Of course this does come with the problem of not being able
to sample enhanced bandwidth Apple II video signals.

20160704/https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=20159  
20160704/https://www.raspberrypi.org/forums/viewtopic.php?f=38&t=7748

Keep searching!

JJJ TODO LINK to my updated articles.
