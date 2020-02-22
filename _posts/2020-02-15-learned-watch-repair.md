---
layout: post
title: Lessons learned on repairing my digital wristwatch
date: 2020-02-15 22:11 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Near the end of last year, my digital wristwatch stopped working.  The
display no longer had any digits on it, like the battery ran out.
Well, I've been using it for quite a while, over 10 years since I've
last changed the battery, so maybe now is the time for a new battery
change?  Not quite.

But in any case, first I tried buying a new battery and replacing the
battery.  No dice.  But, here's the interesting thing.  With the new
battery in and playing around pushing the buttons to see if I need to
enter some magic reset code to switch the watch on, I found out that
pressing the LED backlight illumination button causes not only the
display to light up, but the watch to also start ticking like normal.
Hmm, interesting.  Then, looking around and playing around with my
watch a little more, I noticed that rotating and shaking it around
causes the watch to intermittently work for a short period of time
_without_ backlight illumination, before freezing like it lost power.
Interestingly, after pushing the backlight illumination button, the
watch would continue from where it left off, like it preserved memory
but did not advance the oscillator ticking.

Okay, okay, so thinking about this, it sounds like the problem is a
loose solder joint.  You rotate it around, and then the watch works
because the loose joint makes contact.  But then you rotate it again,
and the loose joint looses contact, causing the watch to no longer
work.

<!-- more -->

Okay, so now I had to get to work at a more complex disassembly.  This
was met with delays because I thought I had to remove the push buttons
from the sides before I could completely remove the circuit board.  I
did remember that I was able to pop the buttons out once before, and
surely they would be protruding inward to an extent where they would
touch the circuit board but also prevent the circuit board from being
removed.  But, then I thought things through, and tried to be more
optimistic.  Well, maybe I can pull the circuit board straight out
without removing the push buttons.  So then I tried that, and it
worked.  Hooray!

Turning the circuit board over and looking at the front side, I saw
the problem sure enough.  Holy smokes!  A capacitor is dangling by
only one leg.  Okay, okay, I definitely got to get this soldered back
down.  But... upon further inspection, the problem is more gruesome
than I originally thought.  The solder joints were **intact**, the leg
actually became detached from the **inside** of the capacitor.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2020-02-15-capacitor.svg"
        width="250" height="150">
  <img src="{{ site.baseurl }}/blog/images/2020-02-15-capacitor.png"
       alt="Dangling capacitor diagram"
       width="250" height="150" />
</object>

Okay, so now I'm going to need to be careful about this.  Better not
slap a soldering iron straight on the capacitor, else things can go
awry really quickly.  How do you repair a capacitor where one leg got
pulled out of the capacitor itself?  Surely, a web search would turn
up results, right?  Nope.

Failed search.

20200215/DuckDuckGo capacitor lead pulled out  
20200215/DuckDuckGo capacitor lead disconnected  

I end up looking at the general information about capacitor
manufacture on the Wikipedia page.  So, indeed it looks like the legs
are not attached to the interior of a capacitor via soldering, but
instead are attached via "bonding."  I assume this involves techniques
using epoxy or resin to fasten the capacitor leg down to the interior
of the capacitor.  And, of course, the electrolyte inside the
capacitor itself is sensitive to heat, please keep your soldering iron
away from the body of the capacitor and only the legs, else you risk
exploding your capacitor.

20200215/https://en.wikipedia.org/wiki/Capacitor

Okay, let's go searching around for the capacitor part number in
particular, I could read it off as "6971."

20200215/DuckDuckGo 6971 capacitor

Okay, so I found this product info page, but it doesn't look to be
useful... not quite the part I am actually using.  I thought for sure
there is a metal body on the capacitor I'm looking at, but maybe it is
just shiny gray plastic?  The dimensions are somewhat similar, I
guess.

20200215/https://www.csgparts.com/capacitors-fsc-5910/page/2705  
20200215/https://www.csgparts.com/NSN/5910-01-090-6971_5910010906971.html

At the end of the day, I simply used a dab of Elmer's glue to help
hold the capacitor in a position where the legs would make proper
contact with the interior of the capacitor.  Unfortunately, the leg is
still unbonded from the interior and merely in electrical contact.  My
hope is that this will buy me enough time to research a proper
solution.  It works, but I'm not sure how long the Elmer's glue will
hold.  And, worst of all, this solution risks doing more damage in the
meantime.  Elmer's Washable School Glue has a pH = 4.7.  "NOTE: Not
for bare metal" says the label.

But for the time being, it indeed works quite well.  In order to truly
be confident in the hardiness of this repair, I try deliberately
dropping the watch 3 feet onto hardwood floor.  QA PASSED - 3 ft drop
test.  Well, I guess I'll keep the Elmer's glue solution in place for
quite some time.

----------

In the midst of this, there's a bigger lesson to be learned.  Why did
I have a broken capacitor leg connection to begin with?  Well, I can
answer that question with a bit of personal history.  For much of the
time that I have owned this digital wristwatch, I was under the
impression that it is quite durable.  It's water-resistant up to 30
meters depth, and it feels quite solid in my hand.  When I
accidentally dropped it onto the ground the first few times, it
sounded pretty solid when it hit the ground, and picking it up, it has
always kept working for me.  After the first few times, I've become
accustomed to the assumption that "it's durable," so there's no need
to be extra cautious about dropping it, right?  Wrong.

Presumably all those drops were slowly doing damage to it, it just
wasn't apparent until it stopped working.  That capacitor?  The way it
is attached to the motherboard is by those two solder joints on the
legs attached to one end of the "tin can."  The other end is left
dangling.  That allows for high frequency vibrations, such as those
that might occur during a drop, to travel down the length of the
capacitor.  Depending on the specific conditions of the drop, those
vibrations might be so intense that they snap connections apart.
Matter of fact, even holding the bare circuit board in my hand and
tapping on it made this quite obvious and evident, there was
considerable vibration within the capacitor even from the slightest of
taps.

Looking at other components on the circuit board, I noticed that some
had hot glue to hold them down with extra security.  The capacitor, in
particular, had no additional hot glue to hold it in place.  But,
after I added my tiny dab of Elmer's glue to it to help hold it in
place, I did notice that tapping on the side of the circuit board
seemed to pretty much have no effect on sending damaging vibrations
through the capacitor.  Indeed, that's something that should have also
been hot glued down during manufacture.  Notably, there were two test
points right next to the capacitor.

Alas, another thing I must admit is that the alarm speaker no longer
works.  It broke long ago.  I blame the persistent dropping on the
cause of its failure, of course.  Looking inside, there is another
component that looks out of whack, an inductor or transformer of a
sort.  Surely that is being used in the speaker path?  I noticed that
it did have a dab of hot glue on one side, but of course, the side
opposite of the hot glue was the side that was unraveled.

So, the bigger lesson to be learned?  Don't be overly optimistic in
assuming electronics are "durable" when they do not say so
specifically.  Chances are, even though they may be of a mostly
durable design, they will have some simple design errors that
effectively render them to be non-durable electronics.
