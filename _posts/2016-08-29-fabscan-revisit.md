---
layout: post
title: "FabScan thesis papers revisited, more 3D scanner analysis,
        MakerScanner"
date: 2016-08-29 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner, raspberry-pi]
tags: [3d-scanning, 3d-scanner, raspberry-pi]
---

Okay, so I went back and read that Fabscan bachelor's thesis paper,
and I was impressed.  I'm glad I did read it.  It had a lot of useful
general information on most modern related 3D scanning solutions, and
it even included some new information on open-source 3D processing
software that I didn't know about.  Specifically, the Powercrust 3D
reconstruction algorithm provides for a much more elegant way to
reconstruct meshes than the other more-laborious techniques I've been
using in Meshlab.  Also, the paper put a great deal of emphasis on the
fact that the resolution of the 3D scanner is limited by the
resolution of the stepper motors to advance the turntable and laser.
This is important because up until this point, that was a complete
oversight on my part on building high-resolution 3D scanners.  I just
thought that moving the laser by hand would be easy enough, but seeing
what a problem it is even for motorized equipment, perhaps I should
think again.

Does the Fabscan use any special techniques for higher resolution on
the laser line generator?  Actually, no, it doesn't.  Furthermore, it
even goes to assume the laser line is a perfectly straight line, when
in reality it isn't.

One important point that the paper notes is that OpenCV has a camera
calibration routine in it.  Thus, there is no need for me to write my
own camera calibration routine, unless I want to create a working
solution with an absolute minimum code complexity.

* FabScan research papers.

<!-- more -->

20160829/http://hci.rwth-aachen.de/materials/publications/engelmann2011a.pdf

* And that was back in 2011?  And what didn't I know about 3D scanning
  at the time?  Well, there you go.  When all kinds of things happen
  at past times and I am not aware of them, even though I wish I were.
  And then there's the flip-side, things that happen that I'm not
  aware and I'm glad I wasn't aware, and things that happen that I am
  aware but I wish I wouldn't have had my time wasted.

    * Well, I **did** know about 3D scanning in 2011, it's just that I
      didn't know that there were libre efforts to do 3D scanning
      already underway.

      I thought it was late 2006 when I first heard of laser image
      capture from that ATI Radeon real-time rendered video of the
      Parthenon.

* So that's why the Fabscan's scans are not as sharp and crisp as I
  would have expected them to be.  They are designed with far less
  precision and resolution than I was thinking they should be designed
  with, especially in regard to the precision of the laser line.  For
  simplicity, the line is assumed to be perfectly straight and create
  a plane.

* I also want to note.  They use a different laser line generator
  part, and searching for the term "line laser" may also be helpful in
  finding different kinds of such parts.  No, it does not come with
  tech specs that tell you the angle or any of that stuff like your
  laser came with, yes is it like the other cheap laser modules in
  this respect.  And, it is even cheaper than $5, costing instead
  $3.99.  Also, it has a higher maximum operating voltage, up to 5V.
  Maybe that's why it looks brighter in the pictures you were looking
  at, maybe because it is matter of fact brighter.  Perhaps too
  bright?  Ah, maybe that's why they were having scanning illumination
  problems.  My laser line generator is already "too bright" at just
  3V.

20160830/http://www.lightinthebox.com/nl/rode-laser-module---gerichte-lijn--3-5V---4-5V-16mm-5-MW-_p77253.html

20160829/http://hci.rwth-aachen.de/materials/publications/lukas2015a.pdf

Oh, but even better is the newer thesis.  What I like most about it is
that it surveys the current market of 3D scanners.  Certainly the
market has grown considerably in recent years.  Perhaps a good thing
about academic research papers is that they cite "related work," which
in the practice of this paper actually provides a wide survey of the
competing available products on the market, a plus when searching in a
highly specialized market is not easy for me.  Either that, or I am
just bad when it comes to searching.  Unfortunately, it is on a bit of
a regression in terms of the type of algorithm that is used to build
the mesh.  It uses Poisson reconstruction rather than Powercrust.

Oh yeah, and the FabScan also has an independent website (actually a
Github site) where the actual software is located.

20160830/http://mariolukas.github.io/FabScanPi-Server/

KiCad is proprietary, right?  No, it's libre!  JJJ TODO Go get this!
Maybe I already have it?  Well, now you ask.  How does this compare to
geda?  Well, if you get the very latest version, you'll get
enhancements sponsored by CERN to help try to make KiCad more on-par
with commercial EDA software.  So, there you go.

20160830/https://en.wikipedia.org/wiki/KiCad  
20160830/https://en.wikipedia.org/wiki/Gerber_format  
20160830/https://en.wikipedia.org/wiki/Binary_image  
20160830/https://en.wikipedia.org/wiki/Excellon_format  
20160830/https://en.wikipedia.org/wiki/Netlist

Note: RS-274-D = G-code

----------

Furthermore, I've re-analyzed my own photographs of my test laser
session, and I've found out something very important.  When I
threshold the laser light, I can get a very thin central line,
sometimes only one pixel thick.  So, you know what you were saying
about analyze both edges of the line and look for the most intense
center?  I think it is safe to say that under practical
considerations, the only points that are going to be most intense are
those at the center of the laser line, and any points further away
from the center are bound to be less intense.  Although, on the flip
side, it may also be the case that some points at the center may not
be at their full intensity due to their angle.  Yes, I was wondering
very much about the practical light dynamics on this issue and whether
you could really trust the "most intense point" to be the centerpoint
and not some reflected angle.  Now I am confident that this is very
likely going to be correct.

Also, I have to note that over many parts of the laser light, the
camera was in fact overexposed at the pixel values of the laser, and
at the overexposure points, it seemed it could be possible to extract
a thinner line at the center if only the image wasn't overexposed.
Hey, now I'm starting to understand why the Nikon professional 3D
scanner used adaptive exposure.  It's how you get a really narrow and
fine laser line for really high precision 3D scanning.

* Wait, I have to make this statement.  In fact, your concerns over
  specular reflection are correct.  However, note that this not a
  problem when the laser and camera angles are close to each other.
  Also note, because the laser light source is small and the line is
  large, it is unlikely that there are going to be very many
  problematic points.  Yes, this is the key.  Remember that specular
  reflections only take up a small amount of an object's surface, and
  they are not visible from other angles, even at the same point.  So
  if you can identify that reflection intensity properties are
  intermittent, then you've identified a specular reflection point
  that can be deleted.

* What were you saying?  You were planning on also using the phase
  shift method?  Come on!  You're already down to one pixel with just
  thresholding and selecting the maximum intensity points, and that
  already gives you 0.1mm resolution.  Were you to go even higher than
  that with the phase shift method, you would end up with 0.01mm
  resolution.  That's a resolution so high that you can't even scan at
  that resolution without the help of a DSLR camera with specialized
  macro lenses.

    * Okay, I guess you're right.  Given all these definitions in full
      detail here, I guess it's not really necessary after all to use
      the phase shift method.  I just need to make sure I have
      adequate manual control over the camera that I am using for the
      photographing, and the related lighting conditions.
      Specifically, I want as little ambient light as possible for the
      laser scan, but in the photographing step, I want full
      omnidirectional ambient lighting of the model.  Yes, that means
      bounce lighting in a white environment and multiple directional
      direct lighting.  Yes, both at the same time actually.  Flashes
      would make for the easiest lighting setup.

Okay, this is important.  How do you combine scans from different
angles and mesh at the same time.  Here's the key rule to remember.
When you mesh points from a viewpoint, _surface area_ that you see
from that particular view is always correct.  BUT, there may be
surface area that you cannot see from that view.  Obviously, when
meshing the points, you want to determine whether it would be feasible
to see a certain surface directly, and if it isn't, then you must mark
that part of the picture as a discontinuity.  A scan from a different
angle will be able to fill in geometry in the gap.

What if you mesh over points that are close and the angles are low and
the gap is small and all seems reasonable, but then you view from a
different angle and you need to splice in geometry into that gap?
What do you do?  How do you mitigate?  Remember the rule that I've
just mentioned.  The _surface area_ that you do see is always correct.
In this particular case, you have to be able to prove that you don't
change the essential surface area that was visible from the original
camera view, but instead are just splicing in new geometry that does
not affect anything visible from the existing camera view.  If you can
find a way to do this, you are good.  And if not?  Well, then I would
like to say that you must simply discard the points and faces if you
cannot prove that they are of higher quality than the existing points
that they conflict with.

* What if you have some mesh scan points that cause a newly-scanned
  surface to poke through an existing surface?  Again, this is another
  case of a scanner error.  Either the new points must be discarded as
  invalid or the old points must be discarded as invalid.  If the
  points are close enough to each other, within a margin of error
  distance, then this discarding/fixing can be done silently and
  automatically.  Otherwise, this needs to be flagged as a fatal
  scanner error in which the user must do manual fixup to resolve the
  error.

Remember, the key here is that _concave_ details are not visible from
all angles because they are likely to be occluded.  _Convex_ details,
on the other hand, are only invisible from some angles because they
are on the back side of the geometry in question.

* Furthermore, if data from a new scan is added such that it would
  occlude points that were visible from a previous angle, unless the
  quality of the new points are higher, they must be rejected.
  Otherwise, the new points must be spliced into the surface and
  replace the existing points of lower quality.

* But, then again, these rules only apply for inanimate objects.  For
  scanning softbody and animated geometry, you have to take into
  account the time base of your scan, and different scans from
  different time bases don't necessarily match up.  You might need to
  tag the scans from different time bases with standard known "poses"
  so that the software can figure out how to reverse the
  transformation or bin it into a pose of a certain time base.  Then,
  you might need to capture over longer periods of time so that you
  can capture the geometry of all time bases, sort them into their
  proper pose bins, and get every single animated key frame.  Wow,
  interesting, but yes, complicated.  A much more complicated means of
  3D reconstruction for animated objects.

One thing that I must emphasize in particular at this point.  The fact
that we are connecting only points that are visible from one camera
angle is of a great advantage to us as we do not need to worry about
making accidental connections with "back-side" points.  Physics is on
our side in this kind of 3D reconstruction, which is not so much the
case when we are building from a point cloud.  Why is that?
Essentially, when you build meshes from a point cloud, you have in
effect already lost some important, key, and essential information for
the 3D reconstruction.  So, there you go.  There certainly are better
ways to do things than to just "build a point cloud" and then "recover
the mesh later."

----------

Oh, yes, there's no shortage of open-source turntable 3D scanners.
That certainly wasn't true 10 years ago when all the software was
proprietary and all the hardware costed tens of thousands of dollars.

FabScan's closest competitor, Atlas 3D and OpenLSS.

20160829/http://freelss.org/

Alas, it appears that maybe the resolution of FreeLSS is lower than
that of the FabScan Pi.

Honestly, I want to put things this way.  The reason why open-source
software came to the web first is because it is much more lucrative
and profitable, thus where the new development methodology took off.
Beyond the other technicalities faster telecommunications decreases
the entry barrier to standardization of complex technological systems.
But I think we can heartily agree that the reason why manufacturing.
In fact, those in the field feel ashamed that they failed to take
advantage of new open-source development methodologies at the same
pace that it was adopted for 99.999% of the rest of information
technology.  Sometimes the "Information Age" is touted as
"post-industrial society," so there you go with the rift in
manufacturing.

----------

Here, I must absolutely comment on the implementation technology
question.  What's wrong with Qt?  It requires too much technical
knowledge to setup on different operating systems.  A web browser
interface would be much simpler to setup.  Why is that?

Okay, let's review some history.  You know how you were talking about
coordination cost?  Yes, when communications costs are high, and
innovation is fast, rather than humans actually slowing down and
putting a cease-innovation on their technological advancements, they
go ahead and make their own solutions independently, which as you must
know, being humans, they have no special biological communication code
to guide them into making exactly identical symbolic decisions, so
what we end up having is a collusion of incompatible and nonstandard
systems.

So, what were you saying about the Internet?  Enter the Internet.
With the Internet, people can communicate by much richer means in much
faster ways than ever before.  So what logically follows this
development?  Well, since coordination costs are lower, people are
more likely to coordinate, and we end up having much more exact and
universal standards emerge.  And, remember this clearly, it would have
never happened had the coordination and communications costs been
higher.  Never.  It would have been an economic infeasibility.  Either
people would have to limit the maximum sophistication of their
technologies or they would have to go ahead creating sophisticated but
nonstandard technologies.  Those are the only two options.

So, on with what you were saying about the web.  The only reason why
we have so much convenience behind Web UI but not the other options is
because it is based off of this new platform methodology.  You can't
have innovative standards and slow communications at the same time.
With slow communications, either you have to sacrifice innovation or
you have to sacrifice standards.  It's one or the other, but not both.

So why Web API?  Is it really the solution?  Personally, I have to put
my piece in.  It would be a lot faster if only people would be willing
to integrate it at the operating system level, but... that's a
coordination problem due to legacy systems, inertia, and the fact that
the present-day systems seem to be working alright, so why pay for the
extra effort to improve them?

----------

Oh yeah, what about MakerScanner?  It is actually a much older project
than Fabscan, yet it appeared much higher in my search engine results
earlier on.  Well, I guess the _age_ of the project is the reason for
its popularity in search engines, as it has already established a
large number of backlinks.  Anyways, the biggest giveaway to the age
of the project is its Blender UI is from Blender 2.4.

Hey, and you know what!  Here you go, right here!  A guide on how to
use Meshlab to reconstruct meshes from point clouds.  Alas, the
software doesn't tell you to explore all possibilities for
reconstruction algorithms.  Maybe the author's experience on learning
how to use Meshlab turned out to be the same as mine, one of
frustration on how to learn how to use the software via exploration,
trial, and error.

20160829/http://www.makerscanner.com/  
20160829/http://abarry.org/makerscanner/2-makerscanner-building.html  
20160829/http://abarry.org/makerscanner/3-makerscanner-software.html  
20160829/http://abarry.org/makerscanner/4-makerscanner-post-processing.html  
20160829/http://abarry.org/makerscanner/5-makerscanner-meshing.html  
20160829/http://abarry.org/makerscanner/6-makerscanner-editing-with-blender.html

This one is interesting.  It basically uses your idea of a still
raster image, followed by having the laser and the camera mounted in
the same construction, but adds angular mobility to the laser.  Well,
there you go, come see the end of what your project would be were you
to go on that tangent.

Alas, it seems that none of the popular solutions to 3D scanning meet
my demands and requirements.

One evident problem that I want to emphasize with the MakerScanner's
design is that you have to sweep the laser back and forth across the
object many times in order to get a good result.  The problem here is
that manual laser sweeping leaves considerable gaps in the object that
you are trying to scan, so you have to backtrack and go over the same
path again.
