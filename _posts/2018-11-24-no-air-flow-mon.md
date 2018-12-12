---
layout: post
title: "Measure the air flow through a room continuously?  No, it's
        tough."
author: quorten
date: 2018-11-24 12:41 -0600
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, you're wondering.  How do you measure the air flow through a room?
Well, I have a variety of ideas that I can list here.

* Use a video camera to monitor the flow of dust through the air, or
  inject some kind of known smoke tracer that you cana optically
  analyze the flow using a video camera.  Easiest intuitively but most
  complicated/expensive to implement.

* Use at least two air pressure sensors in a room.  Intuitively, this
  should work similar to measuring temperature gradients by using two
  temperature sensors in a room: the difference in reading and their
  locations tells you the air flow speed.  Unfortunately, the main
  problem this suffers from is that the air pressure sensors likely
  aren't precise enough to get any viable air flow data.

Okay, so let's see what other ideas are out there on the Internet.  In
general, there aren't really great options for this, so it seems.
Real-time continuous air-flow monitoring seems elusive.  There, there
are lots of ways to design a point-in-time air flow measuring device,
but not much in the way of running such a setup 24 hours a day.

Also, for measuring air pressure difference between rooms.  There is
no easy way to do this.  Again, the air pressure sensors aren't
precise enough for this particular measurement.  What you have to end
up doing is building a tube to connect the air in the two rooms and
adding special sensor instrumentation in between.  Yeah, way too
complicated unless it is absolutely necessary to regulate that
quantity as may be the case in industrial and medical environments.

20181124/DuckDuckGo sensors measure air flow through a room  
20181124/https://www.sensorsone.com/how-to-measure-delta-change-in-pressure/
