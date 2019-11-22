---
layout: post
title: More information on IR and UV pass/cut filters
date: 2016-12-23 21:00 -0600
author: quorten
categories: [raspberry-pi, pentax-k-1-camera]
tags: [raspberry-pi, pentax-k-1-camera]
---

Okay, continue to search for filters.  This time, IR pass.  Guess
what, I was able to find the a good IR pass filter from the same
website.

20161223/http://www.pmoptics.com/filters.html  
20161223/http://www.pmoptics.com/ir_filters.html

Okay, but what about UV pass filters?  Judging from the text of the
website above, I should just search for "UV filters," apparently.

Oh wait, I should search for "UV pass filters."  Yeah, I think that
should provide for broader results in my specific category of search.

20161223/https://en.wikipedia.org/wiki/UV_filters

Oh, but interesting.  I've learned that sunscreens are a new class of
environmental pollutants.  One of the main problems is that wastewater
treatment facilities are (for the most part) not capable of filtering
out sunscreens from waste water.

20161223/http://www.globalspec.com/industrial-directory/uv_pass_filters

Those filters are too big.  And, despite the IEEE logo, I think the
selection of products is too limited.

20161223/http://www.naturfotograf.com/UV_IR_rev04.html

<!-- more -->

Oh hey!  Maybe I should search for "UV band-pass filters."  Or maybe
"UV band-pass filter."

20161223/UV band-pass filter

Okay, so you were asking this question, so I shall tell you the
answer.  Should I go for three different filters that subtract one of
the possible three undesired wavelength ranges?  Then, for viewing, I
would stack two of the three filters together.  Or, should I buy three
filters that subtract the other two wavelength ranges but pass the
desired range?  That way, I would only need to place one filter in
front of the camera.  It turns out that the method that subtracts
two-out-of-three is likely better, as I have seen the graph of the
filter efficiency, and the bounds are not "square."  Rather, the
filter strength fades off gradually as the wavelength changes.  So, it
is likely better to go with the ones that filter the larger ranges, as
we will likely get better quality with that method.

Wait, wait, upon further analysis of the URL above, from
naturfotograf.com, I've been told that you need a Quartz lens for good
ultraviolet photography.  So, now I'm wondering.  What's the UV light
performance of a plastic lens?

20161224/DuckDuckGo uv light plastic lenses

20161224/http://www.laramyk.com/resources/education/lens-options-and-materials/the-problem-with-uv-400-treatments/

Unfortunately, the results are somewhat dismal.  A plastic lens
absorbs 75% of ultraviolet light, and often times, there are UV
absorption additives put in the plastic lenses to prevent them from
yellowing from contact with ultraviolet light.  This is in addition to
the problem of there generally being only a very low level of UV light
in outdoor environments, further complicating the matter of UV
photography by requiring long exposures with even good lenses for UV.
So, in other words, although it may be possible to get some UV
photographs out of the Raspberry Pi NoIR camera, you really shouldn't
count on getting good quality photographs out of such a setup.  As a
matter of fact, as far as I am concerned, if I can't get _good_
photographs out of a certain spectrum, I might as well not try to take
any photographs at all in that spectrum.  So, that's the end of UV
photography with the Raspberry Pi NoIR camera.  If I'm going to end up
taking off the plastic lens and using my own lenses instead, I might
as well hold off until I can do so with a DSLR camera, which will give
me better results for an interchangable lens setup anyways.

So, I'm calling off the search for filters that block infrared and
visible light but not UV light.  However, this is where I last left
off.  I've found some interesting resources and the link below may
give me some more hints as to what keywords to type in to search for
the correct filters.

20161223/https://www.newport.com/f/bandpass-filters  
20161223/https://www.newport.com/f/visible-absorbing-bandpass-filters
