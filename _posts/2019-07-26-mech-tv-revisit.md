---
layout: post
title: Mechanical television revisited
date: 2019-07-26 08:43 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

As you may know, in the very earliest days of television in the early
1900s, inventors were experimenting with mechanical means of
generating a raster scan, but apparently, "all" of them failed to
produce sufficient resolution to gain popularity with the public.
Later, when electronic raster scanning came along through cathode ray
tubes in the 1920s, the resolution was greatly improved, thus started
the adoption of television by the public at large.  Then, when LCD
monitors came to market in the late 1990s, businesses at large
switched to the space-saving, and energy-saving technology.  Never
again would anyone want to use the old CRT monitors because they
contained so many hazardous materials, unlike the modern flat-panel
display technology, and pretty soon, in the late 2000s, it was a race
among companies to get rid of CRT monitors as quickly as possible.
CRT manufacturing was pulled to a halt, and old stock CRTs were sold
at considerable discounts to deplete the inventory as quickly as
possible.

Well, this isn't the full story, as it must turn out.  Although it is
an accurate reflection of the public consciousness, it is wrought with
many misconceptions.  Worst of all, if you take this viewpoint to
heart, it stifles your ability to build useful Raspberry Pi
electronics projects in the modern era.

So, let's retrace our steps to the beginning, review how each such
earlier technology is still being used in the present, and ultimately,
present a viable "modernized" design for building a raster-scan
display.

<!-- more -->

First, there was the _mirror galvanometer_, generally commercialized
sometime in the late 1800s.  Yes, this is a pretty old technology.
The main design intent and improvement over the traditional needle
display galvanometer was to allow viewing the voltage properties on a
finer scale.  The mechanism was to attach a galvanometer to a mirror
and shine a beam of light at the mirror; changes in voltage would
deflect the light at a different angle.  Ah, now you're talking, just
about all the properties you would need to build a "high resolution"
television display, using relatively primitive opto-mechanics, free of
hazardous chemicals.  In fact, high-speed mirror galvanometers are
used in modern laser light show graphics displays to drive deflection
of the laser beams to draw graphics.

Indeed, from this point followed a few parallel paths of development.
Up and coming was the galvanometer's more sophisticated cousin, the
oscilloscope.  Early implementations built off of the mirror
galvanometer.  For example, one particular design used photographic
film to record the path that the light beam took.  The other parallel
path of development was cathode ray tube oscilloscopes.

From these two branches, cathode ray tubes were primarily used for
oscilioscopes for quite a while, but mechanical television research,
design, and development picked up quickly from rotating apertures and
mirror galvanometers.  It wasn't until quite a while later that
cathode ray tubes were improved enough to be practically usable
outside the lab, so during the early 1900s, mechanical television had
an edge.  But then, as times must have turned out, World War II came
around in the 1930s, and this radically changed engineering priorities
across the world.  The end result was that at the time, since cathode
ray tubes had a clear use as radar screens, they were viewed as much
more valuable for the war effort, and although there were some quite
impressive mechanical television projects out and about, they
basically got pulled to a standstill.  Then, after the war was over,
it was pretty much unanimous that only CRT televisions could be
considered ready for prime-time viewing.

One of the most interesting mechanical television project that made it
pretty far along in development until getting canceled because of
World War II was the Scophony.  This was a mechanical television
projector device that used rotating mirrors to scan out a television
frame.  The highest speed rotating mirror motor operated around 30,000
PRM.  That's totally doable with modern DC micro-motors, although the
vintage design used an AC motor, probably because brushless DC motors
were not practical at the time.  The high-speed motor-mirror was used
for horizontal scan, and a lower speed motor-mirro was used for
vertical scan.

Interestingly, beam focusing was done using two cylindrical lenses
rather than one spherical lens.  The light beam was generated from a
halogen lamp.  As for modulating the light signal, this system used an
interesting technique.  Rather than modulating the current to the
lamp, which could risk making it burn out faster, a chamber of water
is acoustically vibrated at varying frequencies to change its index of
refraction.  These changes can range from passing the light beam
clearly to scattering it off in a different direction.  This was
called a "Jeffree cell."

As you can see, these are all relatively primitive technologies
involved in this projection television display that can be built by
hand or by primitive machine tooling without the assistance of an
already-invented computer.

20190726/https://en.wikipedia.org/wiki/Mechanical_television  
20190726/https://en.wikipedia.org/wiki/Scophony  
20190726/https://en.wikipedia.org/wiki/Jeffree_cell  
20190726/https://web.archive.org/web/20071015191810/http://nightlase.com.au/lasermame/  
20190726/https://en.wikipedia.org/wiki/Radar_display  
20190726/https://en.wikipedia.org/wiki/Oscilloscope  
20190726/https://en.wikipedia.org/wiki/Oscilloscope_history  
20190726/https://en.wikipedia.org/wiki/Mirror_galvanometer

So, that is the history behind television.  One of the big reasons why
CRT monitors caught on in the mainstream was because of a fortunate
turn of events, but one might still argue that they still would have
gone mainstream simply due to their technical advantages over the
mechanical systems even if it weren't for the war.  But, one thing is
clear, that if you want to reinvent a raster scan display that is
worthy of use with modern electronics hobby projects, building your
own CRT monitor is a no-go in the modern era.  Yeah, people of times
past did it, but that is just too culturally obsolete to be repeated,
not to mention the need for controlled hazardous chemicals that are
harder to come by in the modern era.

Also, with the lack of vector CRTs in the modern era, some retro
gaming users have turned to laser light displays as a viable
replacement for a true vector CRT.  It certainly does give a more
authentic look than primitive emulated rasterization may give.

----------

So, let me detail and propose my design that works well with Raspberry
Pi.

You have two rotating triangular prism mirrors.  These are designed to
be like "long bars" rather than short prisms, and this is necessary so
that beam deflection in two dimensions can be done with ease.  These
are controlled by (brushless) DC motors.  The fastest motor, for
horizontal scan, rotates at 30,000 rpm.  Additionally, the motors have
some sort of "resolver" or rotation sensor that can effectively
determine the timing of the "start" of a cycle.  For your light
source, you have an LED that can have its power modulated by the
Raspberry Pi.  There is a focusing lens and maybe also an aperture to
concentrate the light to be more beam-like.  The other alternative
would be to use laser light directly, and although that is cheap to
do, that makes the project feel a lot less hand-made, plus it is
somewhat more risky with more safety implications.

The main caveats of this system:

* Horizontal and vertical sync signals are not controlled by the video
  card, but rather entirely by the display device.  The video card
  must adjust its display properties to the synchronization pulses
  generated by the raster scan motors.

* The projection display itself is necessarily going to be somewhat
  small and dim.  A narrow projection angle, which results in very
  little magnification with increasing distance, is a necessary
  artifact of the deflection mirror design, and the use of triangular
  prism mirrors rather than octagonal prism mirrors is a means of
  compensating for this, albeit with a great susceptibility to
  distortion.  The brightness of the display, of course, is limited by
  the brightness and focusing power of the LED light system, and it
  decreases with increasing projection distance.

* Because the system is mechanically controlled by motors, and a
  rather fast one for the horizontal sync, it is going to be rather
  noisy compared to pure electronic displays.

* The resolution is going to be somewhat low, of course.  No more than
  320 X 240 is my recommended expectation, but you might be able to
  get up to 640 X 480 resolution.  The horizontal resolution is also
  limited by the rate that the Raspberry Pi can toggle the GPIO pins,
  though some trickery with the UART or PWM can be used to effect a
  higher resolution.
