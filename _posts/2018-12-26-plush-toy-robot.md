---
layout: post
title: Easily turn a plush toy into an electronic marionette
date: 2018-12-26 14:09 -0600
author: quorten
categories: [raspberry-pi, 3d-scanning, 3d-scanner]
tags: [raspberry-pi, 3d-scanning, 3d-scanner]
---

Playing with plush toys via direct hand manipulation is easy, fun, and
useful for telling some kinds of stories.  However, at some point, the
more advanced user is going to want some semblance of hands-free
animation.  So, that being said, let's revisit some more general
terms, that of "puppet," and review the more advanced form typically
controlled by remote strings, marionette.

20181226/https://en.wikipedia.org/wiki/Puppet  
20181226/https://en.wikipedia.org/wiki/Marionette  
20181226/https://en.wikipedia.org/wiki/Supermarionation

So, here's the deal.  If you want to use a plush toy unmodified for
hands-free animation, you must use some method which is more similar
to that of the marionette, where the strings attach on the outside.
There are some puppet forms where the strings attach on the inside and
are controlled from there, but of course that would require
modification of an existing plush toy.

So, now let's talk electronicifcation.  This is, of course, on the
subject of Raspberry Pi, so of course we must use a Raspberry Pi or
Arduino microcontroller of some sort.  Since these microcontrollers
are so cheap and tiny, why not embed the microcontroller as close to
the plush toy being controlled as possible?  This means the battery
pack must aso be carried close to the plush toy.  Also, since we are
talking mechanical movements, of course we will also be using motors
and rotational resolver sensors.  Finally, an important element of
having such close embedding to the plush toy means that we can't use
strings for control, but must rather use a rigid armature as an
_exoskeleton_.

<!-- more -->

So, now let's get into some more details of this design.  We have a
nice overall desgin of a rigid armature with joints that is easy to
copy movements off of to animate a virtual character.  What are the
joints that we must support for plush toy animation?  For most plush
toys, the joints are rather limited, so our description of the
requirements will go rather quick.  We will describe the animation
properties cumulatively, with each more advanced level including all
properties of the previous level.

All movable object animation:

* Location and orientation of the object, as a discrete movable
  object.

* Slightly advanced: for objects that are to be thrown into the air, a
  launcher mechanism that stays on the ground to launch the object.
  In practice, the launcher mechanism cannot travel with the object
  due to weight restrictions and the fact that it may undesirably
  alter the object's inertial characteristics.

Very basic plush toy animation:

* Ability to roll around on one's own.  This requires a
  counter-weights and levers mechanism to allow a plush toy to, for
  example, roll off its back to sit up.

* Rotation of the head.  All head rotation must be limited to not
  exceed bend and twist limits.

Basic plush toy animation:

* Movement of arms together as one unit.  Typically this is just
  rotating the arms up and down if the arms are pinned together.

Typical plush toy animation:

* Rotation of legs or feet.  A single segment without a knee joint is
  the norm.

* Rotation of arms.  A single segment without an elbow joint is
  the norm.

Somewhat advanced plush toy animation:

* Adjustment of an elbow joint at the arms.  Most notably, this allows
  the plush toy to fully adjust their arms to "pick up" objects in a
  more general manner.

* Separate rotation of top of legs from feet.  Typically, this may
  just be a single-axis joint similar to an elbow joint, but in more
  advanced models, it could also be a 3-axis joint.

* Claws at the end of the arms to pick up objects for real, similar to
  how it is done with fingers.

* Claws at the end of the feet to climb ladders, sticks, and so on.

* Pivoting of back, with bottom staying at stationary angle.  The more
  basic form of this animation is to simply rotate the entire body, or
  rotate the body and rotate the neck to achieve a similar effect.

* Twisting of the back, the primary purpose being to rotate the
  arms/shoulders with the bottom staying stationary.  The more basic
  form of this animation is to simply rotate the entire body.

So, given the above specifications, what is the maximum component
complexity required for an armature?

* Battery pack
* Microcontroller
* Accelerometer
* 3-axis magnetic compass
* Precise location determination beacon
* Wireless communications antenna
* Counter weights
* 6 x single-axis motors/resolvers for counter weight control
* 7 x 3-axis motors/resolvers
* 1 x 2-axis motors/resolvers
* 7 x single-axis motors/resolvers

Total single axis motors/resolvers: 36

For friction free motion recording, choose a resolver in preference to
a motor.  For live animation copying, choose a resolver.

----------

Once you've got this physical framework defined, it is pretty easy to
record motions as played out of physical models, copy motions on
physical models, and, most importantly, copy motions on phyical models
to virtual models.  Once the base motions in the virtual models are
properly animated, you can add special effects in any way you please.

One important special effect is lip sync.  Compared to more advanced
puppetry, notably missing from the previous specifications is mouth
movement control.  By all means, that is recognized to be one of the
major limitations of playing with plush toys, and this limitation is
imagined around in typical play.  Also, this is where transfer to
virtual models has the biggest advantage.  With correctly synced
character voice recording, lip syncing can be automatically generated
and mapped to the virtual model's mouth.

Another important effect of the digitized puppetry is telepresence.
I've thought long and hard about this for quite some time, and it
seems that the primary problem with video-game like control of virtual
characters for telepresence is that it is not immediately intuitive
for all users.  Although joysticks, keyboards, and mice certainly do
certainly help make controlling a robotic arm, issuing macro command
sequences, and pointing and shooting easier, these actions are not of
the typical nature of real-time puppet control.  Oh, and unlike
traditional 3D animation, where animation rigs are entered in key
frames not in real-time, moving rigs into place little by little at
one 3D view at a time, the animation must happen in real-time and be
manipulated from a single view in order to be intuitive to a simple
user, as ease of use is the emphasis of plush toy play over more
sophisticated puppet control.

Also, there are more considerations to making this user-friendly.
Some plush toys can be dressed to wear a shirt of some sort.  Being
able to fasten the armature into a piece of clothing is a great way to
hide it during play, and also to make putting it on a bit more
user-friendly, hopefully.  For leg control, this implies some sort of
pants may be needed.  For head control, wearing a head band or a
helmet of some sort will be needed.

Again, it's important to have some sort of physical conceptual base
before you can do higher-level operations really well.  Finally, you
can argue that it would be most convenient of all of the armature
measurement could be done analytically by remote cameras mounted
throughout a room.  Indeed, that would be ideal, but it requires quite
a bit of formal knowledge in advance in order to do easily and to do
well.  If you already have a 3D scan of the plush toy in question and
a formally designed armature by which to map motions too, mapping
motions from video cameras can be straightforward.  In this case,
having the plush toy wear a special shirt with symbolic markings can
help the camera system transfer the motion vectors to the virtual
armature.

In all of these cases, being able to quickly get an accurate 3D model
of the plush toy in question is dramatically useful to expediting the
process.
