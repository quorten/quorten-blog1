---
layout: post
title: "Path of action for repairing a CRT with jittery vertical
        deflection"
date: 2020-02-26 17:53 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, I have a CRT monitor that has jittery vertical deflection.  How
would I go about diagnosing and repairing this?  Is the flyback
transformer at fault?  Nope, the flyback transformer strictly controls
horizontal deflection and high voltage generation.  It's also good to
know the flyback transformer functions as a failsafe to prevent screen
burn if horizontal deflection fails.

20200226/https://en.wikipedia.org/wiki/Flyback_transformer  
20200226/DuckDuckGo crt vertical deflection jittery  
20200226/https://www.repairfaq.org/sam/deflfaq.htm

Oh, so now this good CRT repair FAQ that I found indicates that
indeed, the flyback transformer and other complexities are primarily
elements of horizontal deflection.  But, if vertical deflection is at
issue, that is not nearly as much of a problem to diagnose because the
frequencies are lower, and therefore the circuitry is simpler.  Often
times in newer CRT sets, almost all vertical deflection circuitry is
handled by a single integrated circuit.  That's great to know!
Because...  as is often the case with such integrated circuits, all of
the required circuitry **except** for capacitors are included in the
integrated circuit.  And with chips, it's typically either all or
nothing.

<!-- more -->

So, the answer is simple.  I'm having trouble with vertical deflection
being jittery, therefore I should look toward diagnosing the vertical
deflection circuitry.  But the vertical deflection circuitry still
works most of the time, and we know it's likely all contained in a
chip, so that narrows down the problem to the few supporting discrete
components that are outside the chip, and those are sure to include
capacitors, and maybe a few inductors.
