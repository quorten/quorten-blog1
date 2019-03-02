---
layout: post
title: 3D scanner motor vibrations control
date: 2018-12-15 19:31 -0600
author: quorten
categories: [raspberry-pi, 3d-scanning, 3d-scanner]
tags: [raspberry-pi, 3d-scanning, 3d-scanner]
---

One important design consideration of my 3D scanner design that I
didn't consider is motor vibration control.  Particularly, in the case
of using cheap DC motors, you're going to get vibrations traveling
away from the motor due to not being perfectly weight balanced,
imperfections in the design of the motor, a shaft that is not
perfectly aligned, different force responses based off of the relative
positions of the rotor and stator, and so on.  Most importantly, these
are qualities endemic to the motor, independent of the rest of your
setup.  But, when those spurious vibrations travel from the motor to
the rest of your setup for rotating the laser module, those extra
vibrations in your laser module effectively limit the maximum
resolution that you can scan at, potentially even more so than the
width of your laser.

So, what can you do about this?  It could just as well be the case
that using your average stepper motor in place of your average DC
motor could solve your motor vibration woes.  Especially considering
some of the design specifications and measurements made for the
FabScan 3D scanner, indeed a stepper motor can get you pretty good
accuracy and minimal spurious vibration out-of-the-box.

<!-- more -->

Otherwise, if you really want to go with cheap DC motors due to their
tremendous abundance, your main mitigation is to find ways to (1)
isolate and (2) stabilize your setup against the motor vibrations.  To
isolate your setup from the vibrations of the motor, try to use
relatively loose fitting gears in your reduction gear train, and try
using a long shaft connecting the motor to its first gear.  I've found
that using a tight fitting setup, though intuitively more mechanically
sound, actually causes more spurious vibrations to travel through your
system supporting your laser module.  Second, adding stationary mass
and placing your setup on a hard, flat surface works well to stabilize
your setup against the residual vibrations that will still travel
through it.  If you run your setup on a soft, carpeted surface with
very little mass, the setup seems very prone to "jumping up and down"
as the motor rotates.

Third, this one almost goes without saying, but due to some curious
observations, I must state a few words on this.  Running your motor at
lower speeds causes less vibrations to travel through your setup.
However, I've found out from experimental evidence, if you succeed in
doing a pretty good job at isolating and stabilizing your setup
against spurious DC motor vibrations, even running the motor at faster
speeds appears not to have too much of a vibration issue.  However, if
you don't have a high-speed camera and are already using a reduction
gear train, you probably want to run your motor at the lowest speed
anyways to minimize the need for a reduction gear train as much as
possible.  Even running my 9 V Lego Mindstorms DC motor at 1.5 volts,
I still find it necessary to use an approximately 1000:1 reduction
gear train to get a good 25-30 samples per line width per second.  At
2K UHD resolution, a digital camera I tested registered the laser line
width at approximately 10 pixels, so that's 256 seconds ~= 4.3 minutes
at 30 frames per second.  Yeah, it's slow, but if you want the best
quality with low-cost equipment, that's what you've got to aim for.

All of this being said about motor vibration isolation and
stabilization, it could just as well be the case that due to the
rigidity of planetary gearing, planetary gearing may actually not be
the best solution to use in conjunction with cheap DC motors.

Finally, some last words on the idea of using a motor to rotate a
laser.  Originally, I chose this design upon the belief that it is
easier to simply add more mechanically precise control to a laser
sweep module if you want to get better resolution, up to the limits of
your chosen camera.  Now, simply due to the inaccuracies caused by DC
motor vibrations, I'm thinking otherwise.  Under these considerations,
even a low resolution video projector could prove to be an easier and
faster setup if you want to get a 3D scanner of reasonable accuracy.

* Footnote: There are interesting similarities between motor vibration
  control and thermal control.  Insulation versus thermal mass.
  Isolation versus stabilization.  Shock absorption versus increasing
  mass.
