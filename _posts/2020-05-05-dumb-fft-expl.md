---
layout: post
title: "\"Dumb\" Fourier transform, a simple explanation for frequency
        analysis"
date: 2020-05-05 11:53 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Fast Fourier transforms... ah yes, very important in modern multimedia
computing, but very few common people understand it.  For many seeking
to learn more about it, they find themselves deep in the water of
complex math that they haven't yet been educated in when they try to
study the subject.  Although I have a fairly good conceptual
understanding of it, I have not been ableto phrase it up in simple
terms, until now.  Here, I present a simplified frequency analysis
technique that I've been dubbing "dumb Fourier transform" while my
ideas were in development.

So, what is the simplest frequency analyzer you can design?  One that
uses basic math that is easy to explain and understand?  The simplest
frequency analyzer is this: define a window around each point on your
time-series where you average together all samples.  This is known as
a _moving weighted average_.  Or, in other words, a moving
product-sum.

For example:

<!-- more -->

```
data = [ a, b, c, d, e, f, g ]

filtered[1] == (a + b + c) / 3
filtered[2] == (b + c + d) / 3
filtered[3] == (c + d + e) / 3
filtered[4] == (d + e + f) / 3
filtered[5] == (e + f + g) / 3
```

So, as you can see, you take a data input waveform, and you define the
filtered waveform by averaging together samples before and after the
current index.  What do you do at the ends where you can't retrieve
any samples before or after?  You simply copy the endpoint multiple
times to fill the missing slots when computing the moving weighted
average.

Now, the given example is just a moving average since it doesn't
assign any weights to the data points.  A moving weighted average is
of course more useful because you can attenuate the effect of the data
points far away from the current point.

Applying a moving weighted average effectively filters out higher
frequencies because the high frequency data gets all averaged
together.  Hence, it is in effect a _low-pass filter_.  If you
subtract the result of a moving weighted average from the original
data, effectively you subtract out all the low frequencies, so you've
got yourself a _high-pass filter_.  Combining a low-pass and a
high-pass filter, you can tune into a defined frequency band.  And,
doing that repeatedly for different filter window values, you can get
a sort of rudimentary frequency spectrum analysis.

Because you can only tune to frequency bands, you get buckets of
frequencies in your analysis, not individual frequencies.  Also, the
frequency bands generally will not have sharp cut-off frequencies, but
rather roll-off frequencies, where higher and lower frequencies get
attenuated with increasing intensity.

In essence, the effect of an resistor-capacitor (RC) filter is
essentially that of a moving weighted average: the exponential decay
charging and discharging response of a capacitor is in effect the
application of a moving weighted average, with weights configured as
per the exponential response waveform of a capacitor.

However, one thing you'll note is that the exponential response of a
capacitor depends on its current voltage and the voltage of the
applied signal.  A simple moving weighted average doesn't do justice
to effectively model the response curve of an RC filter.

Nevertheless, there are still more clever things you can do with a
moving weighted average.  If you define a moving weighted average
where the weights follow a sine wave with distance decay, you've
defined a moving weighted average that essentially emulates the same
behavior as a resonator.  As a waveform continues to repeat at the
same frequency, the resonator's signal response increases, until it
reaches an equilibrium maximum defined by its natural damping decay
rate and the new energy being imparted into it.  A resonator, unlike a
simple cut-off filter, can tune more narrowly to a specific frequency.

Okay, susre, the cut-off filters are easy to apply directly to data
and get some meaningful results, but how do you use this resonator
defined by a moving weighted average?  Fundamentally, if you apply the
resonator moving weighted average, you will get a waveform that
defines the response waveform of the resonator.  Typically, you don't
just want to generate a resonator response waveform, but you want to
know if there is a signal at that frequency or not after integrating
over a period of time.  So, that is the key.  After generating your
resonator waveform, you compute the root-mean-square (RMS) amplitude
over your desired monitoring period, and that is your value to use for
analyzing the intensity of that particular frequency at that time.
Alternatively, you can monitor the resonator waveform and detect
whether it exceeds a certain amplitude threshold.  When it does,
you've reliably detected that frequency, since it must have been
repeated multiple times to resonate up to that level.

One key to understanding about resonators is that the attenuation
curve and duration of analysis defines how sharp your frequency tuning
is.  If you have a high falloff and short duration of analysis,
i.e. you don't resontate for very many cycles over your duration of
analysis, your resonator will have a rather dull frequency tuning.
But, if you analyze over many resonated cycles and have a low
attenuation falloff, then you will only get a strong response for a
waveform very specifically tuned to that frequency of the resonator.

Okay, so this is a nice concept for understanding how to build a
software resonator using a moving weighted average, but as defined, it
is not very efficient to compute.  What is a more efficient way to
compute this?  Simple, you just keep track of the result of the past
computed moving weighted average and the current phase.  Using the
current phase, you know what you need to multiply the new sample by,
then you add it to the existing moving weighted average.  And the
entire average thus far, you continuously attenuate by subtracting a
constant damping quantity, or by using eponential decay.  In the event
of linear subtraction and a very low remaining value, you might reduce
the amount you subtract so that you consistently subtract the same
quantity from the fewer remaining number of old samples still
contributing to the current moving weighted average.  This is why you
might just want to use exponential decay instead of a linear decay.

Another word of advice for good performance when using this tuned
resonator.  This tuned resonator works best when there is not a DC
offset, i.e. the target resonator waveform is centered around the
baseline.  It will still work a little bit if there is a DC offset,
but the resonator effect will be greatly diminished.  Therefore, if
you expect there to be much lower frequencies than the target
frequency present, you must apply a high-pass filter first.  Higher
frequencies are gracefully ignored as simple noise on the input.

Hey, but wait.  A key question was not answered?  How do you determine
the starting phase angle in the more efficient resonator model?  And,
Oh, dang, another complication, but the good news, the solution allows
us to gracefully deal with angular drift, unlike the earliest
definition.  First of all, entertain this statement of fact: a
resonant object can sustain multiple waves of the same frequency
simultaneously at different phase angles.  If you add together two
waves of the same frequency but at different phase angles, the result
will always be a single wave of the same frequency, but at a different
phase angle and a different amplitude, except in the case where they
sum to zero.  Therefore, all such possible waves at different phase
angles are gracefully summed together to create a single wave at a
defined phase angle.  When this happens, it also allows us to
gracefully shift and drift the phase angle of a wave slowly by a small
margin, without having to loose all our resonator's stored energy.

----------

So, the question is, how do we phrase our calculations to enable this
to happen?  Rather than asserting a specific phase angle, we must
dynamically calculate it.  To do this, we have to entertain a more
physical model.  Our resonator is actually a mass attached to a spring
to hold it down to the baseline center position.  Sound waves are
sound pressure variations, and pressure is a force.  So, a non-zero
sound baseline imparts a force on our weight which causes it to move
away from the baseline.  But, as it moves away from the baseline, the
centering spring stretches and imparts an increasing force to come
back to the baseline.  The principal acceleration of the mass is
determined by the mass of the block itself (of course) and the
pressure force applied to it.  The centering spring force is simply
determined from the offset from the baseline, because we assume a
Hooke's Law spring.

So, the key here is to adjust the phase angle and amplitude based off
of kinetic and potential energy.  Assuming no external forces acting
on the resonator, determining the next state of phase angle and
amplitude is easy.  But, when we have a force acting on the system, we
need to break down into the two components.

```
amp. = amplitude
k.e. = 1/2 * mass * (amp. * cos(theta))^2
p.e. = 1/2 * mass * (amp. * sin(theta))^2
k.e. + p.e. = 1/2 * mass * amp.^2
s.f. = spring force = s.k. * amp. * sin(theta)
s.k. = spring constant
```

Next we need to compute the total forces acting on the mass.

```
s.p.f. = sound pressure force
t.f. = total force = s.f. + s.p.f.
```

These total forces will cause an acceleration that either increases or
decreases the kinetic energy of the mass.  Integrate (or simply
approximately multiply) by delta time to determine the acceleration,
divide by mass to get the change in velocity, and add that to the
total kinetic energy.

```
new k.e. = k.e. + 1/2 * mass (t.f. * delta_t / mass)^2
```

Now you need to compute the new position.  Simply multiply the
velocity (computed from new k.e.) by delta time.

```
v = sqrt(new k.e. * 2 / mass)
new pos. = amp. * sin(theta) + v * delta_t
```

The new position is, quite readily, the new spring force and new
potential energy.  With both k.e. and p.e., we compute the total
energy, that is the new amplitude.  And finally, we can solve for the
phase angle.

```
new amp. = sqrt((new k.e. + new p.e.) * 2 / mass)
new theta = atan2(sqrt(new k.e. * 2 / mass),
                  sqrt(new p.e. * 2 / mass))
```

Gosh, those mathematicas are way too complicated!  Just to implement a
digital resonator that can sync the starting phase angle and adapt to
small frequency drifts?  I really have to rethink a simpler way to do
this, one with less square roots.  Basically, my only recommendation
is to compute both "momentum" and energy so that you don't have to use
the square root so often, but you still must use it to get the updated
amplitude since you need to combine the total system energy.
Otherwise my previous recommendation of the weighted moving average is
pretty much the best thing, and if you want to match with more cycles
and inertia, then you use the first method to get the starting phase
angle, and you use the simple method to continue the accumulation
until the go/no-go threshold condition is reached.

----------

The exponential decay method is somewhat similar to the Goertzel
algorithm for a discrete Fourier transform on specific selectable
frequencies.  However, the Goertzel algorithm appears to use a few
more tricks to simplify computations, but not many due to its
simplicity.

20200505/https://en.wikipedia.org/wiki/Goertzel_algorithm

Okay, and after going through that explanation of how to design an
adaptive-syncing resonator, now I sort of understand what the whole
discrete Fourier Transform complex conjugates computation is all
about.
