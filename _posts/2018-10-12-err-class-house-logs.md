---
layout: post
title: Error measurements and classification in house logs
author: quorten
date: 2018-10-12 9:28 -0500
categories: [home-network, personal-finance]
tags: [home-network, personal-finance]
---

So, after working with "house logs for dummies" for a little while,
what became apparent is that I need to have a more advanced
understanding of data and sensors.  So, first of all, let's review
some of the very early sensor theory that was based off of early
military radar system reporting.  It's a chart with only four cells.

    +----------+----------+
    |  False   |  True    |
    | positive | positive |
    +----------+----------+
    |  False   |  True    |
    | negative | negative |
    +----------+----------+

As slick as this may seem, and as applicable as it is to radar
reporting, it is an over-simplified sensor model for house logs for
dummies.  First of all, let's describe some sensor phenomenon as
observed in the house logs for dummies system:

* Under-reporting is the norm.  If you're wondering why something
  apparently hasn't happened, it's probably due to under-reporting in
  the underlying system.

* Sometimes there will be a report, but the specific data details of
  the report are entered incorrectly by mistake.  In this case, the
  person who entered the incorrect data retains memory of what the
  correct action should be, and it is possible to prompt them at a
  later date for the correct data, provided that the date isn't too
  late.

* There is never a "false positive," i.e. a report of an event when
  nothing actually happened.  Indeed, this is perhaps the most
  significant difference from the radar system reporting.

<!-- more -->

So, a better sensor model with metrics that can be graphed can be
described as follows:

* Under-reporting/insensitivity intervals: Results in "false
  negatives."  The sensor failed to report data points on actual
  events.  With human sensors, this is usually characterized by
  discrete time intervals and can be automatically determined when
  combined with data on how stressed the human is.

* Inaccurate data point: There was a "true positive," but the details
  of the event were not correct.  In general, inaccurate data can be
  determined in two ways: (1) "triangulation" from multiple sensor
  data sources, (2) requests for error correction or data verification
  from the same sensor source.

* Error-correcting expiry: Requests for error correction cannot exceed
  this time bound, measured as a duration from the time the event
  occurred.  Less than this time bound, and error correction request
  can be made to obtain more accurate data.

* Self-detected error: .

* Self-corrected error: .

* "Triangulation" detected error: .

* "Triangulation" corrected error: .

Summary statistics on a specific sensor:

* Average underreporting

* Average "first-shot" accuracy

* Average self "eventual" accuracy, i.e. accuracy with final
  self-corrected errors.

* Average "triangulated" "eventual" accuracy, i.e. accuracy with
  "triangulation" corrected errors.

* Average expiry interval.

* Uncorrected errors due to expiry.

* Detected but uncorrectable errors via "triangulation."

TODO: A word on false positives.  Very very specific, not a
system-level measure.

TODO: A word on observational sensing.  Versus data that is logged
when an actor changes an environment.  No environmental changes.
Interval probing.

TODO: Measuring the accuracy that the current system state is known.
The probability that an event would have occurred with an associated
insensitivity interval.

Indeed, it's important to keep track of both sensing and actuation.
Reporting from the "controller" that performs the actuation, reporting
from an observer of the controller, or passive environmental state
sensing.

Then you have non-actuated events.  Divide this into two groups.
Un-reported events that were actuated by an actor, versus changes
caused by natural physical phenomenon.

Yes, indeed this is an issue in my current system that needs to be
resolved.  The difference between the reporter and the actor.

More terminology for false positives and reporting errors.  Among
humans, also termed "lying" under the guise that such an act was
intentional for the purpose of deception.

Also another facet.  If a request is made by a controller, and a human
is a "server," if that request does not get fulfilled.
