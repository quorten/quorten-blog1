---
layout: post
title: "3D scanning spectral analysis, and Raspberry Pi NoIR"
date: 2016-12-10 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

Interesting, but of course, their approach doesn't nearly meet my
demands because it is low-resolution.  But, that's just to show that
there is indeed a lot of variation in the sensor requirements.

20161210/https://www.technologyreview.com/s/529986/turning-a-regular-smartphone-camera-into-a-3-d-one/

Okay, cool, I can put these words up another way.  If you need
resolution, you really only have two choices: visible light and
ultrasound.  You might have a remote third choice, infrared light, but
of course the wavelength has to be relatively short.  And that's the
point.  You need a short wavelength sound or light source in order to
be able to even think about scanning small feature details at high
resolution.

* There are also other practical considerations like the atmospheric
  absorption of the waves.  Ultraviolet light is quickly absorbed by
  the Earth's atmosphere, and although low-frequency sound can travel
  long distances through air, high frequency sounds tend to be quickly
  attenuated over short distances.  So, that's another limitation with
  ultrasound.  On the other hand, ultrasound travels through fluids
  quite well.

  Likewise, there is a similar problem with some microwave frequencies
  such as 60 GHz waves.  These waves also get readily absorbed by the
  atmosphere.

<!-- more -->

** The most key difference between sound waves and electromagnetic
   waves is that sound waves require a physical medium to travel
   through, one that can transfer mechanical motion waves.  On the
   other hand, electromagnetic waves can travel through a vacuum.
   Even so, in the case of imaging the interiors of materials like
   medical imaging of the interior of the human body, ultrasound can
   often times turn out to be a more convenient imaging technique than
   the imaging techniques that rely on electromagnetic radiation.

So anyways, now for the cost analysis.  Visible light image sensors
are obviously cheap and abundant, but sufficient ultrasound equipment
is considerably more expensive.  So, visible light it shall be,
possibly with some exploration into infrared light.

Oh yeah, X-ray photography is one last option, but again, cost.  Cost
is the issue with X-ray equipment.  There are also more severe safety
implications while working with X-rays.

Obviously, for different applications, you'll have different
requirements.  Maybe you need to be able to acquire 3D data fast but
not at a high resolution.  For that, Microsoft's research into depth
cameras as used by the Kinect and the project mentioned above are a
good reference on how to build such a sensor.  Time-of-flight LIDAR
sensors are similarly useful for this purpose, when 1-centimeter
feature size limits are not an impediment.

For larger scale scanning, such as for 3D scanning mountains, none of
the conventional solutions that use visible light triangulation or
ultrasound will be adequate.  For such a scale, photogrammetry or
radar techniques are necessary.  Yes, radar, due to its long
wavelength, is not appropriate for scanning small objects.

Yes, and of course I have to reiterate this.  The main disadvantage of
photogrammetry is that it only works well for making 3D scans of
objects with textured surfaces.  It's main advantage is that it can
easily be scaled up for making 3D scans of mountains, provided that
the photographed mountain has sufficient texture and that you take the
photographs from a fast-moving vehicle like an airplane.

One thing we do know from small, hand-held objects is that it is very
frequent for such objects to either have texture grain that is too
small to be seen clearly by a camera or not enough texture grain for
photogrammetry to be a viable technique.  Another obvious problem with
photogrammetry is that required feature-detection and matching steps
are computationally intensive, whereas triangulation of small objects
is simple and computationally cheap.  Thus, laser triangulation can be
executed on low-end, low-power, low-cost computers such as directly
native to a smartphone.

Oh yeah, further discussion.  Visible light or infrared?  This has its
relative advantages and disadvantages.  Visible light is safer to work
with, as the eye has a blink reflex if any bright light inadvertently
enters the eye, but the same is not true with infrared light, of which
intense such light can cause eye damage.  On the other hand, if one
takes reasonable safe-guards to prevent strong infrared light from
entering one's eyes, then infrared light can be less intrusive when
scanning the landscape of public parks or buildings that one does not
own.  Yeah, something to think about.

Oh yeah, on infrared.  Another disadvantage.  Remember, the infrared
spectrum is much wider than the visible light spectrum, so it turns
out that it is generally harder to get light sources and cameras that
match on the infrared spectrum than it is on the visible light
spectrum, as evidenced in this article on one person's experience
using the Raspberry Pi NoIR module with an infrared flood lamp source.
The Raspberry Pi NoIR camera wants an 880nm wavelength infrared light
source, but the IR illuminator used was 850nm.

20161210/https://www.linux.com/learn/give-your-raspberry-pi-night-vision-pinoir-camera

Okay, let's compare that to the various wavelengths used for red laser
light.  635nm-670nm.  Okay, actually that's a similar range for being
off on the wavelength.  So, it seems being off by 30nm is okay, but
much more than 30nm is probably not okay.

20161210/https://en.wikipedia.org/wiki/Laser_diode#Common_wavelengths

Oh yeah, don't forget, you might also be able to use a laser mouse as
an infrared laser light source.  Yeah, that's totally being creative.
Seriously.

Okay, so you know what?  I was wondering about the feasibility of
getting an infrared laser of the right wavelength, so I looked at my
Quarton laser product data sheets for the available products, and
indeed, I am in luck, there is an 850nm infrared dot laser module.
Unfortunately, I am also out of luck for the reason that there are no
infrared laser line generators available, so as far as this one
manufacturer is concerned, I'm toast for infrared 3D scanning.

Also, yes, it turned out to be harder to find information on using the
Raspberry Pi NoIR camera for dual visible and infrared light than I
thought.  There turned out to be far less information available on the
Internet than I was hoping for.  But, I am in partial luck.  I've
found but one how-to article that includes a link to a potentially
useful device available on Ebay.

20161211/http://nestboxtech.blogspot.com/2014/10/how-to-make-your-own-raspberry-pi-trail.html  
untested/http://www.ebay.co.uk/itm/New-M12x0-5-IR-CUT-Day-Night-Filter-Switcher-CCTV-CMOS-Board-Camera-/231339792798?pt=LH_DefaultDomain_3&hash=item35dced199e

And, continuing on the subject of Raspberty Pi NoIR.  Yes, it's also
possible to do some IR filtering in software simply by setting the
white balance.  You won't get good results for photographing plants,
but for photographing inanimate objects, you'll get some sort of
believable natural color results.

Also note that on the Raspberry Pi NoIR camera, the mass majority of
infrared light is picked up on the blue channel.  Why is that?  This
is because the blue light wavelength is harmonic with the infrared
light wavelength, which causes the blue channel to pick up most
infrared light.  So there you go, Rebecca G. Bettencourt.  The
wavelength harmonics actually do have a meaning, just not with human
eyes.  But with machine sensor electronics, this is something worth
considering, within the wavelength sensitivity limits of a device,
that is.

20161210/https://www.raspberrypi.org/forums/viewtopic.php?f=43&t=59683

Do we have any recommendations on good IR and visible light filters to
use with the Raspberry Pi NoIR camera?  Well, that's a tough question,
but along the way, we've mentioned that the reason why color filters
and photographic film are transparent to infrared light was to prevent
build-up of heat inside the projectors of older equipment that used
incandescent bulbs.  So putting these filters in front of a Raspberry
Pi camera serves as an effective visible light filter.

Also, you know the blue gel filter that is included with the Raspberry
Pi NoIR camera?  That filter technically filters out red and green
light, but lets blue light pass through.  So that's what the magical
"hyperspectral imaging" is really about.

20161210/https://www.raspberrypi.org/forums/viewtopic.php?f=43&t=137403

Unforutnately, after all that searching and reading for information on
using a Raspberry Pi NoIR camera as a dual visible light and infrared
camera, I gained no insight.  There just doesn't seem to be enough
information out there, I've got to instead ogo through some
turmoltulous process of trail and error of searching on sales
websites.  And yeah, I don't like doing that.
