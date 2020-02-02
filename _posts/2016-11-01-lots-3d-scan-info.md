---
layout: post
title: 3D scanner equipment setup, computations, and more
date: 2016-11-01 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---


3D scanner notes.  3D scanning notes.

Okay, now here's the low-down on the design of the system.  I think
I've got it entirely thought through.  Here, I'll mostly describe the
technique by which the system is supposed to operate.

First of all, let's describe the equipment setup simply.  You have
some sort of digital imaging device setup on a tripod that can take
images spaced equal time intervals apart.  Essentially, either one of
a rapid-fire still camera or a video camera.  Whichever is the case,
it is preferred that your camera records a series of uncompressed
frames for maximum quality, but individually compressed and
video-compressed frames will still be workable.

<!-- more -->

Set some distance away from your camera, you have your laser line
generator mounted on some sort of angular sweeping mount that is
driven by a high-precision motor.  The offset distance is necessary
for accurate triangulation.  In fact, you should measure this distance
as best as you can and determine relative XYZ coordinates of both the
camera and the laser.  (We'll show later that it's possible to
automatically determine this position with precision.)  The motor can
be a simple DC motor with constant supply current followed by a Lego
gear train to reduce the motion down to finer movements, followed by a
rod mount that holds the laser to get rotated.  When properly built
(TODO upload Lego design), you should have a reasonable sturdy system.
Something to watch out for if you don't quite build the system
correctly is vibration noise that could throw off the fine precision
movement of the laser.  You may need to use a combination of flat
mounting surfaces, weights, and dampers to minimize these effects.

Finally, an important aspect to discuss, the environmental lighting.
Since you will be recording images continuously, you cannot use flash
lighting.  Some sort of consistent ambient light above pitch black is
recommended to minimize the noise on the camera sensor if it cannot be
configured manually.  Also, it helps wash out secondary reflection
from the laser light.  For triangulation, you need not worry about
provisioning particularly bright or pure light sources to illuminate
the subject, but these will be useful when taking the color map scans,
along with some white paperboard props for setting good up bounce
lighting.  360 degree ambient lighting will help in recording the
pigments on the objects rather than arbitrary shadow details from your
particular scene lighting setup.

Also, it is helpful to setup some markings on your paperboard props
and measure their positions and dimensions.  This will allow software
to automatically compute the position of the camera in the scanner
environment by optically analyzing these markings.  In fact, I'll TODO
have a software mechanism for generating these markings for printing.
Also, before the scan, verify that you've used the software methods to
calibrate your camera using the printed calibration sheet and
measuring the distance from the sheet to determine your camera's field
of view.  This "real-world" measurement information will be used in
addition to the EXIF/RAW metadata largely as a reality check, or as
the sole unit in the case that no such metadata is available for your
camera.

Oh yeah, now you may be nagging.  What about automatically determining
the position of the laser?  Okay, here's how it works, but I'm telling
it now only for the sake of the impatient.  For practical reasons, the
full data necessary to make this computation will only be available
after the scan has completed.  First, you already know the position of
the camera from the optical markings.  (Also note that your manual
measurements serve as a good reality check for the precision of the
automatic algorithm.)  Also, you know that some parts of your known
scanner environment are at different depths relative to the laser.  If
you look at the laser line at its min and max angles, what you'll get
is two planes that intersect to form a line.  Now, the laser module
must be located somwhere along that line, but where?  Also remember
that we can obtain detailed profile images of how the laser light
intensity of the generated line varies based off of how far off center
the point we're looking at is.  So, we can use this to narrow in on
which point of that line must be the center, and wallah!  We know not
only the point where the laser line module is located, but also its
angular orientation.  Again, you may realize that there are conditions
where these automatics don't work very well, and that's what your
manual measurements are for to backup.  Also, as we'll discuss later,
you can tweak very many parameters post-process whose measurements
might have been a little off during the original scan, without having
to go back and do the entire scan all over again.

Okay, now time for the equipment record procedure.  First photograph
the scene without the laser light, but with the ambient light.  This
photograph is used for the difference thresholding needed to compute
which pixels of subsequent images contain our laser light of interest.
Yep, just a simple thresholding function is used for laser light
detection, nothing fancy to account for the dimmer and dashed edges of
our cheap laser line.  (We may have to revisit this design decision
with how to best utilize cheap laser line generator modules.)

Next, you can commence with the "scanning loop."  To start, first turn
on the DC motor and laser.  We want any backlash and slack in the
reduction gear train to be taken care of before we start recording
frames.  Next, record the image frames in sequence.  At this point,
the rest of the data is either buffered up or streamed directly to our
software for processing, until our laser has sweeped the required
distance across our object from the chosen viewpoint.

If we must be buffering up all of the images in our camera device, it
could just as well turn out that we run out of storage space before
the scan is complete.  If this happens, you'll need to stop the motor
mechanism and rewind it a bit before your next scan, again in order to
avoid issues of gear train backlash.

Okay, cool!  That sounds easy.  Superficially easy for a 3D scan.  Now
let's discuss in more detail how the software works.

----------

First, the software calls for calibration and a scanning environment
from the user.  For this, a calibration sheet is printed out and
photographed straight-on at a measured distance.  This is used to
calibrate both the field of view and perspective distortion of the
camera.  The scanning environment likewise comes from generated
pattern sheets that the user must print out.  Then, they must lay
these across flat cardboard pieces and stand up the scanning
environment walls.  This I have not fully decided on how this will
work where you can setup the walls and both get reasonably good
viewpoints for the camera to look into the construction for the sake
of scanning.  Maybe this will come from the instrumental use of
windows in the structure for the camera to peer through.  Hey,
actually I like that.  Let's try to create more of a wire-frame that
can be recognized, but still allow the camera to look through into the
scene, and same with the position of the laser line module.

Now, you also need to calibrate the laser profile.  If your laser has
a detectably non-uniform profile, then that can be used to determine
what kind of intensity patterns indicate the center versus the edges
of the laser light.  So, this is calibrated by shining the laser as
directly as possible at a white (er, grey?) sheet of paper and
photographing the result.  Again, here we must be diligent to record
the positions of the laser and the camera so that the software can
properly calibrate the properties of the laser.  This also allows the
software to calibrate the delta threshold used for detecting the laser
light, or perhaps I should say this is where the user selects their
desired default parameterization for this kind of recognition.

Okay, note that I've already covered previously how to calibrate the
camera position and the laser position at the scanning scene when
you're about to scan an object.  First you calibrate the camera
position by optically analyzing the wire-frame pattern markings.  But
then, you can't calculate the position and angle of the laser until
it's swept both the max and min position of its scan, provided that
you get at least some illumination of the built scanner environment.

----------

Okay, now time for the actual scanning loop software design.  At the
beginning, you take in an ambient light photograph used for laser
light threshold detection.  This ambient light reference does not have
to be held constant by the software for the full scan; it can in fact
be updated constantly as the laser sweeps across the object and
reveals areas no longer covered by the laser.  The main reason for why
we might want to do this is if we are taking really long scans such
that the ambient lighting at the end of the scan changes noticeably
compared to that at the start.  This is likely to happen if a scan
takes several hours.  However, it can even happen over just a few
minutes if a considerable amount of the ambient light is coming from
outdoor natural light, due to moving clouds intermittently covering
the sun, only to be uncovered just a few minutes later.  Also, there
is a down-side to the sliding ambient light window method.  One could
be thrown off a little bit in terms of ambient light if the laser
light noticeably scatters and bounces of the object elsewhere a second
time, a considerable distance from the direct line light.

Anyways, from here things are pretty much downhill simple software
algorithms.  For each frame, one subtracts the ambient light reference
frame from the current frame (clamping to zero in case of underflow),
then applies the calibrated threshold parameterization to recognize
which pixels contain "laser line light."  We now have a "monochrome"
image composed of only pixels that are either "laser light" or
"ambient light."  We convert this image to a 16-bits-per-pixel image
with the laser light as the frame number and the ambient light as
"zero."  In this case, the frame number must be greater than or equal
to one.  Finally, we accumulate this to our cumulative laser light
buffer image.  Effectively, this is an alpha-over compose where
ambient light is considered transparent and laser light is considered
opaque.  The fact that I can say this and phrase it up as simple 2D
image manipulation operations suggests that it is very easy to program
graphics hardware acceleration into this workflow, or even design
these steps into hardware piggy-backed directly a camera image sensor.

The fact that we use a 16-bit laser light frame buffer means that,
under the current software design, a 3D scan from a single viewpoint
cannot contain more than 65,535 "scan lines" (of course I'm talking
about "scan line" in a different sense from that of computer graphics
literature).  For all but the highest resolution imaging technology
available today, this will not be a problem.  What would otherwise be
a problem would be complicating the design of potential near-present
hardware by specifying an unnecessarily-wide depth for the laser light
buffer.

Note that the overlapping of pixels may cause a problem, so you may
think, in the case that the laser line is more than one pixel thick.
At the same time, this is a little bit of a non-issue for reasons
discussed previously that I shall not repeat.  Basically, when we
detect such fatter lines in image, what we can do is generate a
"thickness map" in which each pixel in an image represents the size of
a circle that could be drawn to maximize the reachable continuous
neighbors including a point from a single scan time frame.  If you
don't quite get that, well, that's what designing the actual software
is for, so I can demonstrate to you more concretely.  For now, take
these as being primarily notes to myself.  Then that can be all kinds
of useful and joyful data for even better applying the so-called
"phase-shift method" algorithm which I can easily explain to you with
overlapping brushes in a paint program to achieve lines that are
thinner than the brushes themselves.  Oh yeah, and basically, the
search algorithm, as done in parallel, is initiated on each laser
pixel individually, expanding a circle until you can no longer expand
it, then tagging the circle radius on center pixel itself in question.
Finally, you do a post-processing operation whereby you walk down
max-sized circles in order and update all pixels included in the
circle with the max size, this process being done to illustrate the
overall uncertainty in measurement in all of the pixels that were part
of that fat line.  Then, this map is maintained similar to the laser
light accumulation map.  Existing points can get overwritten by new
points.

* Okay, come on, that's terribly inefficient, especially under serial
  processing.  Let's try something better.  Yeah, like your thick line
  scanning ideas.  Okay, so you choose an edge pixel, then try to walk
  to reach the other edge.  Next you want to trace along the edges as
  best as you can to determine the centerpoint.  Now, you can easily
  compute the circle size in question, then tag all included pixels
  with the correct size.  Wow, that is a lot easier once you recognize
  the edges of your pixel regions and start computing on them.  I have
  to say, even in parallel, it seems to involve less work!

At the end of your scan, the principle image your software gives you a
single "time-of-flight" image.  If you're interested in the fatness of
individual scan lines as discussed above, then you can also opt-in to
generate the corresponding thickness map image, but it comes with an
additional computational cost.  Also, you have the ambient light image
from the start of the scan.  This can be used for rudimentary
colorization of the scanned model, though you may want to do a
separate bright-light exposure photograph specifically for this
purpose.  It will give you better results than trying to do both at
the same time.  It also turns out that this technique renders you
fortunate to be able to use flash photography rather than constant
light sources when taking the bright light exposures, further
simplifying your workflow and process.  Finally, as discussed
previously, the scanner software may need to save individual first and
last frames to automatically compute the position of the laser.

Now, you might realize, this is most interesting because it opens up a
whole host of post-processing operations at this point.  What if the
camera position wasn't correctly computed?  Don't wory, you can tweak
that value.  What about the position and angle of the laser?  Same
deal, just tweak.  What about the speed of the laser?  Tweak.  With a
known laser position, start angle, end angle, and motion vector, all
of the angles of the laser can be computed and thus subsequently
combined with the time frames to triangulate the positions of the
corresponding pixels (using the perspective map to determine the
appropriate angles).  Furthermore, in the case of fat lasers, as
discussed in more detail above, phase shifting can be applied to get a
precise, high-resolution point for every pixel in the scan except for
those at the beginning and end of the sweep.  In the case that a
measurement error is spotted due to poor calibration, it is
exceedingly likely that one can just tweak many of the aforementioned
parameters and recompute at a higher degree of precision.  And, most
of this is possible without needing to incur the expensive overhead of
storing all of the original image frames.  One just needs to be
confident that their thresholding functions are working as intended.

Now, it's one thing to be able to compute a list of points in 3D, but
you can't really go very far in visualizing whether this is what you
want or not unless you build a mesh on those points.  So, here's how
we do that.  Very simply in fact with our scanner design.  We just
connect the nearest neighbors as seen in 2D, unless their depth
exceeds a certain threshold.  If the depth does exceed a certain
threshold, we define this to be a "crease."  Again, this is yet
another area that can be tweaked and user-adjustable, but it is often
times good to create good automatics so that users need only tweak
when they see there is a need for additional quality.  The general
rule of thumb is that the threshold distance should be on the same
order of magnitude as the proportional distance of one pixel up, down,
left, or right from the position as seen on the camera frame, but
adjusted to the actual depth of our point.  So, closer points will
have smaller thresholds, whereas farther points will have larger
thresholds.  When two points that are visually adjacent in 2D do not
get connected, we call that a "crease."  Now, these creases can easily
be drawn as lines in 2D on the original image.  And again, here is
where the professional artist-user has the opportunity to tweak
whether they actually want that crease line or not.  They can erase
the crease lines that they do not want, and they can even draw in
crease lines that appear to be missing!  Oh, and that being said, I
might as well allow them to select regions to run the crease algorithm
on with custom settings.  Hey, this could turn into a useful general
geometry editor.

Cool, so with these crease lines computed, you can connect the
remaining non-creased neighbors and then render your mesh in 3D for
previewing.  If you don't like what you see, you can change it!  And,
the best thing about this workflow up to this point is that
practically all stated manipulations above can be done independent of
each other, so you can go back, make corrections, and then all your
later work will still be intact.

----------

Now, that's cool.  You can get a series of individual 2D photographs
augmented with depth maps and crease maps through this procedure, in
effect being able to easily turn them into 3D model segments.  Now the
next question is how to stich all these segments together such that we
can get a single continuous, composite, full-round 3D model.  Well,
you know how we collected all of that camera position information
earlier?  This makes things real easy to just paste in all those
individual 3D models into a common space.  Now the only challenge that
remains is stitching the pieces together.  So how do we do this?

First of all, I want to note that my algorithms will be using sanity
checking.  Since we know all of the position of the camera, the
position of the laser, and the position of the scanned points for one
image, along with direct rays that connect the camera to the point and
the point to the laser, we know that there must be a straight-line
clearance in that area.  In fact, when we extend that across multiple
lines that are packed one next to the other, we trace out volumes of
space that must be held clear.  We will use this constraint in the
compositing operation to verify that we don't get "ghost layer" points
where we have an invisible mesh layer hidden underneath another.
Also, at the same time, we can compute explicit "shadow volumes" that
are spaces we know to be unmapped due to existing occlusions.  These
shadow volumes most often would otherwise tend to be infinite, unless
we bound them to the space of the scanner area.  In fact, we must
bound the space of the scanner area so that we have a space with
deterministic precision properties.  It's hard to compute with
infinity when you are not allowed an infinite number of bits to do it.

Okay, so here, we'll assume we'll often have overlapping points that
we need to tie-break.  We'll use a "scanner quality" metric as the
principle tie-breaker, based off of the angle of the light and the
camera.  The idea is to setup the triangulation where we get maximum
quality measurement.  No, we'll shy away from blending this time,
assuming that we want to choose only the highest quality points, no
questions asked.  Anyways, that will help us dramatically reduce the
points we have that overlap, but then we'll be left with remainders.

How will we deal with the remaining inconsistencies?  Tweak it!  Here,
our automatic algorithms will try to delete remaining conflicting
points until we get regions that are not conflicting but close enough
to stitch together, then we can show the user the final "mask
regions," areas of the individual scans that are included versus
excluded, along with the "stitch lines."  The user can repaint the
stitch lines simply by drawing and erasing with brushes.

* Okay, this can be rather challenging with certain mesh topologies.
  Maybe for algorithmic simplicity, we want the user to help do some
  masking to simplify the point-pair stitching algorithms that come
  later.  One that is taken care of, topology is dramatically simpler
  to manage, adjust, or most importantly as you'd say, tweak.

----------

So now you have your spatial 3D model.  The last step is to give it
color texture.  This is done rather simply with 2D photographs.  You
move the camera around, taking pictures at your angles of choice, the
camera positions are computed automatically, colors are projected to
points, and then, oh, tie-breaking... that's a little bit more
complicated here.  Here, we want to break up diffuse and specular
light properties and consider the two separately.  For sure, when you
average photographs from many different angles but with the light
sources held at constant positions, the average color will be closer
to the diffuse color than any specular reflection.  Furthermore,
points containing specular reflections are strictly brighter than the
diffuse color.  So you can use this knowledge to try to filter away
the specular color and just get the average diffuse color, along with
a ranking of how specular an area of the object is.  Cool, now you
have not only a diffuse color map, but a map that ranks the
"shininess" of different parts of the object.

Yeah, I know, what I discussed above was actually rather really basic.
You know, there's The Matrix movie that used this full light stage
technique to get full BSDF information across the surface of actor's
faces for highly realistic rendering, but hey!  Also discussed in the
related Wikipedia articles is the issue of storage space, which I'll
advise you, for mass 3D scanning and long-term archival, you want to
keep your storage space requirements to a minimum.  So, that also
means that the amount of data you encode for your models must also be
minimized, which means that you will in fact have to pass up on some
nice to have, highly detailed, highly realistic models, simply for the
sake of economizing on available storage space.

----------

Okay, yes, fine, I guess that leaves a clear gap in my work where
there is future work available to do.  Extend my software and
procedures to also capture BSDF data so that the same technique can be
used for rendering models in photorealistic movies.  But that is for
another time and possibly another person to do.
