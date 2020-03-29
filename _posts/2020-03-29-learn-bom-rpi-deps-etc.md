---
layout: post
title: "Lessons learned on designing physical electronics projects, 3D
        scanner, page counting device, software dependencies, and bill
        of materials"
date: 2020-03-29 10:49 -0500
author: quorten
categories: [raspberry-pi, media-prog, pentax-k-1-camera]
tags: [raspberry-pi, media-prog, pentax-k-1-camera]
---

Electronics projects.  One thing about building electronics as a hobby
is that people tend to get excited about it because it produces these
cool electronic gadget toys.  Cool, yes indeed it may be, but coolness
aside, there are many practical factors that need to be considered.
Over the course of my recent endeavors working with electronics hobby
projects, I have found it necessary to summarize some important
lessons that I learned, which are certain to be valuable for anyone
else to know in advance should they consider picking up such a hobby.

----------

### First Question: What is the purpose of your electronics hobby?

First of all, answer this question.  What is the purpose you are doing
this electronics project for?  Many simple electronics projects don't
strictly need to be done with a physical electronics project hardware
element.  Like any hobby project that requires buying raw materials,
the associated costs can quickly spiral out of control if you just
want to buy anything that's fun to play with.  But, furthermore, you
may find out that electronics is not as fun as you thought it would be
if you just buy and build anything you can think of with electronics.

So, it is crucial that before beginning, you present to yourself and
answer the question up front: Why _can't_ this be done purely with
software alone?  Why is a electronics hardware element actually
required?

<!-- more -->

Often times, as I've found out, the answer to this can often times be
phrased in a quite clear and concise manner.  The reason why you
_must_ have an electronics hardware gadget is because you _must_ have
an **additional** means to interact with the physical world that
existing computer equipment on the commercial mass market does not
provide.  For example, the following points are some of my legitimate
justifications for myself to get involved in electronics hobby
projects:

* You have an existing computer that works just fine on its own,
  except that you want to make some minor improvements or repairs to
  it.  The commercial market fails to offer a product that suits your
  needs because (1) they only offer totally newly manufactured
  computers for sale, none of which suit your tastes for computer
  hardware, (2) although they do offer repair services, they are too
  expensive for you to personally afford, (3) for your own
  convenience, you want an "extra" working computer at no additional
  cost, or (4) you need to perform an advanced computer repair which
  is not commercially available in your country since it requires
  manufacturing-style skills that are only prevalent in Asia.

* You have a "legacy computer" with specialized computer I/O
  interfaces that you must have access to, and no current hardware is
  in commercial production that supplies those interfaces.  Therefore,
  you must be able to perform your own advanced electronics
  maintenance and repair on the equipment you own in order to keep it
  running to satsify your needs.

* You already have all the electronics hardware parts that you need to
  build a 3D printer device that you want from old 2D scanners and 2D
  printers, but the commercial market does not provide you with market
  options to directly recycle that old equipment into your
  specifically desired new products.  You may also want to make tweaks
  to your 3D printer so that it can also double as a "robotic pick and
  place" machine for surface-mount components.

* You need additional sensors to gather data and make it available on
  your computer network, and your sensor needs are so specialized and
  specific that there is not suitable commercial device that satisfies
  your needs.

* You need to make improvements to existing commercial sensor designs,
  i.e. 3D scanners, but since they are proprietary, you must more
  wholly build your own device instead.

* For the sake of your specific computer uses, you want to better
  control the overcomplexity of computers compared to the commercial
  market's approach.

* You have worked with commercial computer hardware maintenance and
  repair in the past, and you were upset with the lackluster effort
  put into modularity, repairability, and the ability to repurpose the
  hardware to future uses.  Therefore, you need something more custom
  than what the commercial market has to offer.

* You are anticipating wanting to perform specialized and advanced
  operations on computer hardware, and you therefore need to have Open
  Hardware to work with.  In the event it doesn't exist on the
  commercial market, you need to build your own.

Nowhere included in here is the idea of getting involved in
electronics hobby projects just for the sake of having fun and playing
with electronics toys.  Of course not.  "Hardware is hard, software is
easy."  The day-to-day reality of working with electronics projects is
far from fun when you consider the equipment costs involved.  The
fixed startup costs for electronics projects are quite high compared
to the fixed startup costs for osftware projects.  You need to invest
in both tools and materials before you can even get to your day one
electronics prototyping breadboard where you simply start out testing
circuits, creating test circuits, and almost just generally playing
around seemingly without working toward a real project goal.

But, here's the key.  If you do have a clear answer to the first
question and can clearly define a purpose as to why you are getting
involved in electronics hobby projects, you'll be able to tackle the
associated costs much more diligently.  And, ultimately, minimize them
as much as possible.  Buying individual electronics components not
only has increased costs in terms of per component costs compared to
their cost when embedded in a commercial mass market product, but it
also has additional complexities and responsibilities when it comes to
organizing hundreds of different types parts that you'll need to have
on hand, each with very specific requirements.  If you know what goal
you are working toward, at the end of the year, you'll be able to
tally up all of the time and resources you've spent on the "play"
aspects of electronics hobby projects and make it count toward a
specific final product that you'll be able to use and see the value in
for a long time to come.

Let's take another example to run this thought process through its
paces.

* Temptation: Hey, it'd be nice to create a cool electronics gadget
  that plays different sounds when you push different buttons.

* Enlightenment: Well, if all I want to do is create some toy that
  makes sounds when _I_ myself push buttons, I can do that in
  software.  Just create a GUI with push buttons and use the operating
  system routines or a library to play sounds.  If I need it
  hand-held, I can run the software on a smartphone.  After I'm done
  playing with it, the cleanup is easy with software if it turns out
  to be an idea that doesn't really scale beyond my own entertainment.
  But, were I do to it with hardware, I could just as easily end up
  with some hardware toy that just collects dust once I am no longer
  interested in playing with it.  And if I kept that habit up, I'd end
  up with a much bigger problem at the end than the alternative would
  present me.

* Problem: I need to use a Serial In, Parallel Out (SIPO) shift
  register inside a large and complex electronics project, how am I
  ever going to get it to work correctly?  When the large and complex
  circuit as a whole isn't working correctly, how am I going to know
  what's going wrong?

* Solution: This is where the value of play can pay dividends, if done
  as a sub-component of a larger project at steak.  Rather than
  focusing so heavily on building only the final project in an
  instantly finished form, you can break down the development process
  into sub-steps.  Hey, why don't I try creating a simple debug board
  with tactile switches so that I can control the shift register
  directly with my own fingers?  Not only will I be able to verify
  that the shift register is working, but when I wire it up into a
  more complicated circuit, I'll be able to reuse by device to test
  that the larger circuit is also working correctly by probing on my
  debug device onto the more distance wire connections.

----------

### The laborious journey through learning electronics

And once, and only if, do you have the key premise question answered,
then you can proceed to setup elwctronics prototyping.  It will take
you longer because "no one" has done this kind of stuff in like 50
years, so chances are you will not have a working memory, heck you may
have never had any experience with electronics in your past life.  And
neither will any of your teachers, parents, family, or friends know
how it works either.

So, you will have to embark on a journey that seems unnecessarily
complicated.  Surely there are professionals who are skilled in all of
this?  Well, there _were_ professionals that were skilled in all of
this, of course they all moved to Software Land since that's where all
the paying jobs are.  I mean, yeah they have the skills, but they know
they won't get paid to use them, so why bother put them up on a
pedestal and advertise and market that they have those skills?

Nevertheless, although good help will be hard to find, you will find
enough hints of a trail of breadcrumbs by web searching via the
Internet.  Slowly you will learn little by little in a random and
chaotic order guided by carefully learning and taking notes on
whatever random information comes up to you on the Internet.  At this
point in the process, you must be careful to document your research
and thoughtful about your learnings and findings.  There will be many
times when you are told true facts about practical circuit design but
you won't be able to comprehend the big picture.  Then, only after
deeper thought will the theory behind the facts become obvious.  You
can look at some of my own blog notes on motors, motor protective
circuits, inductors, and capacitors for reference, for example.

----------

### Hardware is hard, software is easy

Construction complexity and cost equations will loom imminently before
you.  It's true that surface-mount devices are the commercial mass
market industry standard in electronics, but they are quite
challenging for novices to work with, and even in general, they are
markedly more difficult and expensive to prototype with, even though
the raw cost of these devices are cheaper than their through hole
equivalents.  Through hole devices, by virtue of being larger at 1/10
of an inch pin spacing, are easier to work with in general, and
especially easier for novices to prototype with, but because the
market is so small for them, there is a lesser diversity of through
hole devices available than surface mount, not to mention they're more
expensive.  The increased complexity of searching for through hole
devices and the increased cost alone, in addition to the increased
cost of buying in small volumes, is enough to scare all but the most
essential electronics hobby project ideas away.

But, here's a tip: as [I've noted previously]({{ site.baseurl
}}/blog/2019/11/11/smd-dip-adapters), there are adapters you can use
to mount surface-mount components to through-hole perfboards, but the
most common type require surface-mount soldering, and although that's
something you can do [with your home kitchen's oven]({{ site.baseurl
}}/blog/2019/01/01/discuss-smt-solder), the fact that these are
separate discussion points is enough to scare novices away from using
surface-mount components in their very first major electronics
project.

And, that's not all.  Sure, you may have guided your strategy in light
of these realizations.  Due to the challenge of finding suitable
parts, I must make that be one of the first steps in my design
process.  First I will just vaugely sketch out and write out
brainstorm ideas of the functional requirements, then with my vague
plan of what discrete and integrated components are required, I will
search for those and build a bill of materials, maximizing the number
of through hole components I can get and buying adapters for the parts
I cannot get in through-hole form factor.  Once I have my bill of
materials, I can determine how much board area I need by drawing out
the design with accurate part footprints in some electronics design
automation (EDA) software like KiCAD.  Then I'll be able to buy a
perfboard of the required side.

So, finally, you're at the final step of the process.  Your designs
are all drafted out checked over three times, you have a clear bill of
materials, and you're ready to place your purchase.  But then, reality
strikes.  Hardware is hard, software is easy.  Just as you are placing
your order, you notice that some of your previously in-stock parts are
not out of stock and on backorder!

And that's still just scratching the surface of all that you can do
with electronics and what you actually wanted to do.  You probably
actually wanted to reuse some existing electronics parts you've had,
but to your disappointment, they were all surface-mount and therefore
above your novice electronics skill level.  Or maybe they were missing
some modular connectors your design called for and you didn't want to
start clipping wires so early.  Or, maybe you did actually find some
parts that you wanted, but not enough, not enough of the same type to
use together in one single logical project.  There are just so many
more variables that although you can account for them when working
with hardware, many more of them are beyond your control and you are
powerless to do anything about compared to software.

Any bill of materials will be harder than any software dependency
problem.  No matter how unnecessarily difficult you think the software
dependencies problem is, I can assure you, the bill of materials
problem with electronics hardware will always be harder.

Why?  Because with an electronics bill of materials, not only do you
have to check for compatibility of the components per se and whether
they are still supported by the manufacturer, but you must also check
for the quantity in stock, manufacturer lead time, and the quantity
that you are ordering in comparison.  There will be shortages some of
the time, and you will be forced to wait for new factory manufacturing
and additional freight-class shipping delays to complete.

----------

### Some of my big lessons I have learned working with electronics

The challenge will always continue when working with electronics
projects, far more than is the case with software projects.  Over the
course of working with electronics projects, I've learned a few
notable lessons that are worth summarizing here.

3D scanners and printers: Stepper motors DC motors?  Stepper motors
are quite popular here, but surely they are not necessary are they?
Old 2D printers and scanners previously used stepper motors, but the
newer ones have since done away with them for cheaper, faster, and
more powerful DC motors.  And they do produce pretty accurate results,
don't they?

Not so fast.  For one particular project, I was printing measurement
grids with one of those modern 2D printers with a DC motor, and I
noticed the lines were all messed up.  Looking at it carefully, surely
it was caused due to issues with the position tracking of the DC
motor!  Awww, dang, indeed DC motors are _not_ sufficiently
dimensionally accurate for even 2D printing and scanning, so how do
you ever expect those kinds of motors to perform when you need
dimensionally accurate 3D printed electronics cases?

Second lesson learned: Designing a page counting device for
photographic paper scanning without skipping.  It sounds like a simple
target application, but what kind of actual sensors would you use to
solve this particular problem?  Weighing is one idea that comes to
mind, but that is subject to noise, not to mention I originally wasn't
even sure if there was a sufficiently accurate weight sensor to
perform my job.  So for a moment, I entertained the idea of height
measurement, but even that can be uncertain with papers as they tend
to have curl that causes them to stick up unless forced down flat with
sufficient weight.  Finally, after turning around in many circles, I
was able to find a suitable weight sensor that could give me the
accuracy I needed, and it allowed mounting inside a custom enclosure
so that I could build a page-sized weighing platform.  Previously
another problme was that the high precision scales only had a small
weighing platform and were therefore unsuitable for weighing papers.

However, designing the platform was yet another problem to be solved.
What material do I build it out of?  How do I mount it to the sensor?
One of the main things to beware of when designing weighing platforms
is _deflection_: if the platform itself bends when under load, the
force causing the platform to bend is absorbed into potential energy
in the platform itself, like stretching or compressing a spring.  This
also means that energy is **not** transferred through to the other
side of the platform, so this causes your weight measurement to sag in
comparison to the actual weight.  If you want an ideal weighing
platform, you want one that remains relatively rigid and stiff when
the load is placed on top of it.  This means you can't use a thin
pressed cardboard platform, but a corrugated cardboard platform may be
adequate.

Likewise, thin aluminum and copper sheets may be too flexible, but is
there a good metal you can use for the platform?  Steel may work well.
Brass is also very likely to work well... it is the stiff metal used
in pin headers that are designed not to bend very much, unlike the
copper wires you attach.

----------

### Conclusion

As you can see, electronics hobby projects are not for the faint of
heart.  The journey will continue for a long time, and the challenges
are many.
