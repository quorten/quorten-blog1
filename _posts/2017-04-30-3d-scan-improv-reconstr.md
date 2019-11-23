---
layout: post
title: "3D scanner improvements, explaining \"reconstruction\" from
        Stanford 3D scanner papers"
date: 2017-04-30 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

First of all, I'd like to read more about "well-known" techniques for
reducing laser speckle.  But, I'm not sure that I can get to those
references from the Stanford space-time research paper.  No problem, I
can search the Internet instead.  I've found some very good sources,
the first one in particular is the best.  The second one describes
using a colloidal solution to disperse a laser to reduce speckle.  Not
particularly interesting for my use cases.

But the second paper does bring up an interesting point.  In order to
achieve _good_ speckle-free results, 600 different speckle patterns
need to be averaged together.  So, simply shifting a laser to two
different positions does not sufficiently achieve this requirement.

20170430/DuckDuckGo laser speckle reduction techniques  
20170430/http://www.siliconlight.com/wp-content/themes/siliconlight/pdf/speckle-spie.pdf  
20170430/https://arxiv.org/pdf/1212.5176

There is certainly no shortage of published research papers on lasers,
but I think I've seen enough to get the idea.

<!-- more -->

Second note.  I can re-design the "crane" in my 3D scanning place mat
to be a fold-up system.  It could be like the legs on our fold up
tables or it could have the diagonal be a sliding component with both
edges latched in.  Here is a good example design of a fold-up crane,
the Western Mule Fold-A-Way Bumper Crane.

20170430/DuckDuckGo western mule fold-up bumper crane  
20170430/http://westernmule.com/bumper_cranes.html

Third note.  See `2017-04-30-interpol-funcs.png` for a quick visual
display of using no interpolation, bi-linear interpolation, bi-cubic
interpolation, and Lanczos 3-lobe interpolation.

<img width="608" height="260"
     alt="Interpolation functions visualization"
     href="{{ site.baseurl }}/blog/images/2017-04-30-interpol-funcs.png" />

These scalings were done in the GIMP.  Note that the source image is
solely black and white, so you need not worry about gamma here when
comparing the interpolation functions.  Yeah the target gamma in the
scale-up isn't correct, but the shades are mainly there to help you
visualize the interpolated values, so it works out alright in this use
case.

So my verdict?  Well, it turns out that bi-linear interpolation yields
worse results than I anticipated for smoothing out diagonal lines.
Somehow I thought the results for 3D scanning might be a little bit
better than is the case with 2D images, but I should have known
better.  Bi-cubic interpolation actually gives worse results than
bi-linear interpolation.  The Lanczos filter gave rather good results
for smoothing out the diagonal line, but it came with the problem of
generating a "ringing" a certain distance away from the edge.

I believe it should be possible to tune the Lanczos filter to only use
adjacent neighbors, though.  Is it?  No.  In that case, it would just
degenerate to a simple bi-linear interpolation.

Definitely, actually, it looks like they used a more sophisticated
interpolation algorithm than bi-linear in the Stanford space-time
paper.  Lanczos interpolation is my best guess, but who knows.  They
might have used a spline technique, but it definitely looks like they
did not use bi-cubic or bi-linear interpolation.

But hey, let's do another web search just to be sure they're not using
something better when they say "reconstruction."

20170430/DuckDuckGo reconstruct a continuous function from sampled data

This is a pretty good resource that covers most of what you are
looking for in the same computer graphics subject category.

20170430/http://www-cs.ccny.cuny.edu/~wolberg/pub/crc04.pdf

It turns out that Wikipedia has some pretty good information too.
Well, it's very condensed and the gamma issue is not as dramatically
stated as in the other resource I referenced.  Also, it hasn't really
covered anything new in regard to good filtering algorithms.  Kaiser
window is another good option to consider in addition to Lanczos
window.

20170430/https://en.wikipedia.org/wiki/Reconstruction_filter  
20170430/https://en.wikipedia.org/wiki/Reconstruction_filter#Image_processing

Medical imaging is referenced multiple times in the reconstruction
filter article.  Surely, there has ought to be more useful information
in the medical imaging article on Wikipedia if the profession has
produced so much useful knowledge on image processing.  Actually, I
didn't learn anything new and useful to my pertinent search from
reading that article.

20170430/https://en.wikipedia.org/wiki/Medical_imaging

* Yeah, seriously I have to admit.  Overall for the subject matter of
  3D scanning and related image processing steps, Wikipedia's
  information is pretty hard to navigate and pretty hard to read.  The
  searchability of the content is severely hampered due to poor
  authorship and maintenance of the article information.  This for
  sure looks like a low-quality area in Wikipedia compared to external
  resources.

20170430/https://en.wikipedia.org/wiki/Signal_reconstruction
