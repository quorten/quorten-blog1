---
layout: post
title: Document scanning with a DSLR camera
author: quorten
date: 2018-05-20
categories: [pentax-k-1-camera]
tags: [inven-sys, pentax-k-1-camera]
---

So, using a DSLR camera, my Pentax K-1 DSLR body and 1980s 50mm SMC
Pentax prime lens to be specific, has been an interesting journey.
First of all, I've been impressed with the volume of photos I"ve been
able to take.  I've quickly reached over a thousand photos of my
documents.  Now I want to flip through those pages on a larger
computer screen to look at what I have.

<!-- more -->

Unfortunately, that's where the first problem comes into play.
Although flipping through the 8K Ultra High Definition photos on my
DSLR camera works perfectly fine, I've noticed problems with my Ubuntu
photo viewers responding a bit slowly.  Sluggish.  So, what is the
cause of this problem.

After some more in-depth analysis, I've identified and timed these key
steps in processing required for photo viewing:

1. The time duration to load the data from disk.

2. The time duration to decompress the JPEG image, or to demosaic the
   RAW image.

3. The time duration to pan and zoom the loaded image.

I've found out that steps #1 and #3 are reasonably performant.  Since
I already knew in advance that I wanted to page through many photos
quickly and didn't need high color tonality for predominantly
black-and-white documents, I've only saved directly to JPEG, not using
a RAW development workflow.  So, #2 was my performance bottleneck:
decompressing 8K UHD JPEG images.

There surely are solutions to this by the way of GPU functions:
hardware accelerated video decode APIs and GPGPU programming are two
such potential solutions.  Another possibility is better optimized CPU
decoders.  I'm going to have to look into this further and provide
updates on what I find.

In the meantime, I've been looking toward improving other aspects of
my document scanning workflow.

----------

I believe this is the first time I wrote this, so I'm not going to
claim I'm reiterating something that I didn't already write before.
However, I may have noted this one earlier: having properly sleeved
film negatives makes a big difference in how quickly and efficiently
you can scan film negatives.  With paper documents, this fact is much
more extreme.  For film negatives, the worst condition they may be in
is that they were left in the original developing envelopes that came
back from the commercial film developing shop.  On the other hand, the
worst condition for paper can get far worse: It's not uncommon for
papers to be poorly preserved to the extent that they are bent out of
a flap shape, or even creased and crinkled.

So, the same advice to expedited film scanning applies to paper, but
in a much more extreme sense: items that are properly packaged for
scanning pays off with dramatic time savings and increased efficiency
for the person doing the scan operations, ScanOps.

For film negatives, the ideal packaging is as two-fold:

1. The developed film strips should be placed within high-quality,
   non-adhesive negative sleeves.  Removing a film negative should be
   as easy as gently slipping it out the side.

2. The negative sleeves should be inside a _box binder_.  This is a
   special type of 3-ring (or n-ring) binder that closes such that all
   the edges are sealed tight from elements of the weather such as
   dust, rain, and light.  Both the "box" and the "binder" elements
   are important: the box, of course, for weather sealing, and the
   binder so that the scanner operator can quickly page toward any
   negative sleeve to select for scanning.

For paper documents, the ideal packaging situation is a little bit
more curious to the uninitiated.  The actual ideal packaging situation
is exactly as you find reams of new printer paper packaged:

* All papers of the same size are precisely stacked up into a ream of
  500 sheets.

* An easily removable sleeve surrounds the whole stack of papers.

* The reams are stored horizontally, just as you find multiple reams
  of new printer paper stored in an office.  (Well, maybe only a
  typical one.)  Incidentally, this is also an archival best practice
  to avoid weird page curl-ups and other physical aberrations that can
  happen from vertical storage.

So, why are these recommendations in place?  First of all, there is
the obvious physical reason to prevent the documents from succumbing
to the fate of poorly preserved ones: bent, curled, creased, and
crinkled sheets of paper that require extensive restoration work to
bring back to a reasonable condition.  Second, by packaging the papers
into the same form factors used by standard office printers when
possible, the same paper feed mechanisms that are used in those
high-volume office printers can also be used in a high-volume document
scanner: an automatic document feed (ADF).  Bingo, you've just
eliminated the toughest part of the scanning job.

However, there are still plenty of other paper-like articles left to
be scanned that do not fit into such a nice "digital library" mindest.
For bound books, yeah we have automatic page turning robots, but that
tight crease in the center still poses a problem for scan quality and
speed.  A 3D scanning intermediary step can be used to compensate for
page curl, but that slows down the overall scanning process.
Conversely, the spine can be sheared off a book and the pages run
through an automatic document feed, but that effectively destroys the
original book.  Finally, there are still many more oddball-sized
sheets of loose leaf paper left.  These generally do not fit through
an automatic document feed with any amount of ease.

----------

So, what is your last resort for scanning paper documents that works
in all of these situations?  Yep, that's right: turn those pages by
hand.  After all, that is how you read the documents and books the
first time, right?  Naturally, all of those paper-based media formats
support this mode of reading by design.

The practical limit on turning pages by hand is about one page per
second.  Faster than this, your hands might reach dangerously fast
speeds that can damage the documents you're trying to preserve.  Plus,
even at one page per second, the human vision system isn't fast enough
to keep up with what's going on: you're hands are often times just a
blur to your eyes.  In any case, at the end of the day, you realize
that scan speeds of 1000 pages per hour or faster make your DSLR
camera a real workhorse compared to that old flatbed scanner where you
can only scan 6 pages per hour.

The practical limit for scanning film negatives by hand paging is
about 100 negatives per hour on average, or about 2 negatives per
minute.  Again, delicacy is paramount to preservation, so this often
times forms your natural speed limit that prevents you from scanning
much faster than this.

Finally, remember to factor in the bandwidth limits of your DSLR
camera into consideration.  Even though you might have the tools and
technologies to scan faster, if your camera can't keep up, you're
going to have to slow the rest of your system down to work with what
you have, or else shell out thousands of dollars to get a faster DSLR
camera.  With today's (2018) DSLR cameras, the practical speed limit
is not the optical systems, but the digital systems: the digital data
buses that complete the circuit of writing the data out to storage or
an external bus simply can't write out data any faster.  Incidentally,
this is also one of the main reasons why DSLR cameras can have nearly
identical optical systems, but differ in price by a factor of 10.

That being said, archival photography is generally not a lucrative
area, so even if your main interest is in archival photography, you're
better off settling with a DSLR camera where the digital buses are
fast enough for typical daily use, even though this may leave room to
be desired for archival photography.

For my DSLR camera, the Pentax K-1 camera, the practical limit on SD
card write speed is 26 MB/s.  Peak write speeds can be up to 32 MB/s
under special circumstances.  With 20 MB JPEG photos, this means that
1 photo per second is the practical limit.  Therefore, there is no
speed advantage for me to use an ADF system: hand page turning is just
as fast, plus it is more versatile than the ADF that only works under
special circumstances.

----------

What does it take to reach a page turning rate of 1 page per second?
There are a few practical physical layout requirements to optimize to
this speed.

* Pages should be turned _book-style_: papers should be stacked up in
  two piles, and pages should be photographed two at a time.

* In order to be compatible with loose leaf paper, the stacks must lay
  horizontal.  You can't place them on an angled or vertical surface,
  even though this would make setting the camera up more convenient.

    * Consequentially, this means that your camera must either be
      operated hand-held or supported on a tripod that allows it to
      look directly down at the floor.  Tripod mounting is ideal for
      speed as it allows your hands and visual concentration to be
      fully focused on turning the pages quickly.

* The tops of the stacks should be close to each other in height, so
  that they are within your lens' depth of field.  For loose leaf
  papers, this means picking up the papers in smaller packets at a
  time, and paging through the packet in a book-style manner.

* Finally, my own self experience.  It feels like I'm "in the pit"
  when I'm working on the scanning stuff: It's actually physically
  strenuous to turn pages quickly purely for the sake of photographing
  them.

----------

So, let's discuss better tripods.  I started out with an
ultra-portable lightweight travel tripod that cannot look directly
down at the floor.  Plus, my DSLR's camera is just below the weight
limit of the tripod.  Obviously I need something better for archival
photography, and by any means I need the better tripod simply for a
higher weight capacity.

So, what's in stock for this?

* Professional tripods are purchased separately in two parts: the legs
  and the ball head.

* The professional ball heads are serious business: they do not limit
  your degrees of freedom like the ultra portable cheap ones do and
  they lock very tightly.

* The professional tripods have center columns that can swing out so
  that you can orient your camera directly downward.  Also, they have
  mount points so that you can place counter-weights on the opposite
  end of the swung-out center column.

* Expect higher prices for this higher-end equipment.  However, if you
  plan to shoot thousands of photos for many hours in any case, "your
  back will thank you" for getting the right equipment.

* An L-plate is great complement to a professional tripod: it allows
  you to mount your DSLR camera in either portrait or landscape mode.
  Make sure you get one designed specifically for your camera, _not_ a
  "universal" one, and do not be fooled by excessively expensive
  L-plates either, as this is still just a piece of metal.

20180520/DuckDuckGo tripod look directly down
20180520/https://photo.stackexchange.com/questions/13003/how-can-i-take-horizontal-photos-where-the-object-is-lying-flat-on-the-floor
20180520/https://photo.stackexchange.com/questions/7419/what-should-i-look-for-in-a-camera-tripod-for-photographing-microfilm-machines-a
20180520/http://learnmyshot.com/photography-tips-for-shooting-overhead/

This is a great resource.

20180520/https://improvephotography.com/12062/tripods-ball-heads/
20180520/DuckDuckGo tripod gear site:improvephotography.com
20180520/https://improvephotography.com/gear/tripods/
20180520/https://improvephotography.com/42411/l-plate/

----------

I do realize that as the photo subject section in my blog is taking
off, I've ought to add some of my photos I've shot into the posts I
write.  Alas, I've yet to figure out a hosting solution that I'll like
for the photos.  Ideally the service would be a "storage-only" one
that focuses around making the images accessible through a URL.
