---
layout: post
title: How to strip wires with only a pair of scissors
date: 2018-12-31 19:51 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, you want to do an electronics project on the cheap, with minimal
tooling.  "Do I _really_ need to buy a pair of wire strippers?"  Of
course not, you can use alternate tools to achieve the same thing.
But can you really get the same quality and speed that you can with a
dedicated wire stripper tool?  Under some circumstances, yes.

I'll focus on a very specific use case that is pertinent to me:
stripping old 6P4C telephone "patch cable" wires.  These particular
wires are stranded copper wires, as they are meant to be able to bend
and flex without breaking.  I chose these wires specifically because I
wanted to recycle and reuse unused old equipment as much as possible
for my electronics projects, of which these were a candidate.
However, there is something specific about these wires that makes them
perhaps a little bit different from your typical electronics project
stranded wires: the strands are not twisted together.  This actually
_creates_ a particular problem that makes them more difficult to strip
using a conventional wire stripping technique: after you have cut the
insulation and are pulling off the bit of insulation, the insulation
tends to stick to some or all of the individual strands of wire.
Thus, when you pull the insulation off, you end up pulling large
parts, or even entire strands, out of the remainder of the wire's
insulation.  So, how do you mitigate this problem?  As it turns out,
the easiest methods to mitigate this problem come naturally when you
are using a pair of scissors to strip the wire.

<!-- more -->

So, let's outline the most important steps of the scissors wire
stripping technique.  The first important part of the technique is
practice.  You're going end up getting it wrong many times before you
can get it right consistently.  With that mention out of the way, here
are the steps.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2018-12-31-wire_strip.svg"
        width="425" height="535">
  <img src="{{ site.baseurl }}/blog/images/2018-12-31-wire_strip.png"
       alt="Wire stripping steps in diagrams"
       width="425" height="535" />
</object>

1. Get your pair of scissors and wire ready.  I recommend using a
   short pair of school scissors that are somewhat dull for better
   ease of fine control.

2. Take your pair of scissors and very gently and slowly clasp down on
   the wire with the scissors blades.  The idea of this step is a
   rather subtle one.  Your goal isn't to directly cut through the
   insulation, but rather indirectly cut the insulation by causing the
   wire to undergo a very sharp bend in angle over a small area.

   It's important that you be really careful at this step, as once
   part of the wire is cut through, it takes less force to cut through
   the rest of the wire.  If you're not careful, your scissors blades
   will slip to a higher velocity and you would have ended up cutting
   through the whole wire.

3. Take a look at the several diagrams I've included here.  As your
   scissors cuts down on the wire, what happens is that the two blades
   of your scissors contacts the wire at different portions.  One
   blade pushes one piece of the wire up, and the other blade pushes
   the other piece of the wire down.  As you press the blades down
   further, this causes the angle of that bend to increase.
   Eventually, you'll reach a sharp enough bend angle over a small
   enough area that surely, the half of the wire insulation that
   traverses the longer edge would have had to stretch so far that it
   probably got broken right through.

4. Once you believe the longer half of the insulation has been cut
   through, open up the blades of the scissors.  You should be able to
   look at the side of the wire that stretched the longer path and
   notice that you can see the shiny copper through that edge.  That's
   how you know you've made it through one side of the insulation.

5. Now, this last step is the most interesting and important. First,
   grab the bit of insulation at the end and twist it around one time.
   Do not twist it around too much or else your entire wire will
   break.  The twist is important so that you can get some of the
   exposed end of the wire to be twisted together, which will make
   mounting and soldering into your electronics project easier.

6. Now, the last trick is to tightly grip the wire insulation on each
   side of the partial cut and shear it off at a sharp angle by
   pulling _perpendicular_ to the wire, not parallel.  This technique
   will minimize the risk of pulling strands of wire out from your
   untwisted, stranded wire.  Look carefully at the diagrams I've
   provided for details.  Note that when I was doing this last step, I
   used the ends of my fingernails to help get a small, tight grip.
   If you are unable to do this and gripping with your fingers won't
   do, you may need to use two pairs of tweezers to get the right grip
   on the wire for this last step.

7. Once you have successfully pulled off the bit of insulation, you
   should see the shiny exposed copper of the wire is bent off at the
   same angle you were shearing, but is otherwise intact.  You can now
   bend the exposed copper back to the same angle as the rest of the
   wire.

JJJ TODO: Add diagram.
