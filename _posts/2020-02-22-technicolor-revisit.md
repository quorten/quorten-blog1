---
layout: post
title: Technicolor revisited
date: 2020-02-22 16:39 -0600
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Two-strip Technicolor... how exactly does that work?  How were those
films able to get the range of whites and blacks that they did with
only two colors?  The answer is a tricky one.  Ultimately,
experimentation was used to pick the particular color primary values
that would get pretty good results given the limitations of using only
two primary colors.

First of all, let's evaluate the bare minimal extreme where only the
lowest quality is achieved.  Additive color with only red and green
will only give you a range of colors from black, red, yellow, and
green.  You will not be able to achieve pure white because of the lack
of a blue component.  Thus, all images will generally be tinted
yellow.

Again, **please note** that I am generating these color displays in a
gamma-correct fashion, using gamma = 2.2 rather than full sRGB for
simplicity.

<!-- more -->

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2020-02-22-tc_colors_1.svg"
        width="400" height="200">
  <img src="{{ site.baseurl }}/blog/images/2020-02-22-tc_colors_1.png"
       alt="Additive Technicolor colors diagram"
       width="400" height="200" />
</object>

Let's review some very basic information on film processing.
Typically, film is "negative film": When it is exposed to intense
light, it becomes dark (opaque), but when it is not exposed to light,
it remains light (transparent).  This is referred to as a "negative
image," of course.  Negative images are typically not useful for
viewing, so they must be negated again to generate a "positive image."
Less common is "reversal film" which, after development goes straight
to a "positive image" and does not need further processing to be
viewable.  In the case of taking black and white film and toning it,
the transparent area remains transparent, and the dark/opaque area is
replaced with the asserted color tone.  Color tones are described by
the color of light that remains after filtering, not the color of
light that has been subtracted, i.e. CMYK (cyan, magenta, yellow,
black) printing tones.

In the case of Technicolor filming, we produce a red source strip by
filming behind a red filer and a green source strip by filming behind
a green filter.  The film stock itself is panchromatic black-and-white
negative film.  Interestingly, the question of additive versus
subtractive color affects only the presentation of a film; the capture
process is the same in either case.

Now, let's try the very basics of subtractive color.  With subtractive
color, you start with white light, then you can subtract light to
control the display of red and green.  But, here's the key.  If you
only subtract away red and green (toned cyan and magenta), you'd be
left with blue as "pitch black" rather than pure pitch black.  So, the
trick that you play to get pitch black is that when you subtract
either red or green, you will also subtract an equal amount of blue.
Essentially, this means that we process the red and green source
strips so that the positive red strip is toned green (subtract red &
blue) rather than cyan (subtract red) and the positive green strip is
toned red (subtract green & blue) rather than magenta (subtract
green).  Unfortunately, when we layer two such strips together and are
displaying shades of gray, we "subtract" equal amounts of the blue
channel twice.  Also, we sacrifice the ability to display pure yellows
for the ability to display grays.

Please note that when we layer two filters together, we do not add the
amount of light they subtract, but rather we multiply the percent of
light that each filter transmits.  These are, after all, filters that
will allow, say, 50% of light to pass.  So 50% times 50% is 25% light
transmitted, for example.  Because of this, pure shades of gray will
end up being tinted yellow with this kind of subtractive color.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2020-02-22-tc_colors_2.svg"
        width="400" height="310">
  <img src="{{ site.baseurl }}/blog/images/2020-02-22-tc_colors_2.png"
       alt="Basic subtractive Technicolor colors diagram"
       width="400" height="310" />
</object>

Compare that to this pure gray strip.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2020-02-22-tc_colors_3.svg"
        width="400" height="64">
  <img src="{{ site.baseurl }}/blog/images/2020-02-22-tc_colors_3.png"
       alt="Pure grays diagram"
       width="400" height="64" />
</object>

But, here's the key that we can use to our advantage.  Because we
multiply filters when layering two of them together, we can adjust the
blue light filtering so that rather than subtracting 100% of blue
light at full intensity, we can only subtract up to 90% of blue light.
When we want to display pitch black, we will get the product of 90%
times 90% filtered, or only 1% of light will be passed through.  This
allows us to still be able to display pretty convincing blacks, while
at the same time getting more pure grays with the filters.  And, we
minimize the amount we compromise on being able to display bright red
and green hues.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2020-02-22-tc_colors_4.svg"
        width="400" height="310">
  <img src="{{ site.baseurl }}/blog/images/2020-02-22-tc_colors_4.png"
       alt="Improved subtractive Technicolor colors diagram"
       width="400" height="310" />
</object>

Okay, so how does two-strip Technicolor really filter the light?  For
the red source strip, my technique and theirs agree head-on by toning
cyan-green.  But for instead of using magenta-red for the green source
strip, they use orange-red.

20200222/https://en.wikipedia.org/wiki/Technicolor#Two-color_Technicolor

The best way to understand two-strip Technicolor is to watch one of
the actual historical movies that used the technique.  How about the
oldest such movie, _The Toll of the Sea_?  For a long while, it was
thought to be lost, but in the past few years, it looks like the
Wikipedia article on the movie has been updated to say that it has
been found and restored in the 1980s.  Now that it is over 90 years
old and in the public domain, a copy of the movie has been uploaded to
Wikipedia.  All of the actors depicted are long gone, of course.

20200222/https://en.wikipedia.org/wiki/The_Toll_of_the_Sea  
20200222/https://en.wikipedia.org/wiki/Anna_May_Wong  
20200222/https://en.wikipedia.org/wiki/Kenneth_Harlan  
20200222/https://en.wikipedia.org/wiki/Priscilla_Moran

These filter choices explain why I sometimes saw weird purple hues in
_The Toll of the Sea_ movie.  Because the cyan-green tone choice for
green strip did not subtract out 100% of the available blue light,
this made it possible for purple hues to be displayed under some
circumstances where there was bright reddish light.

What would explain the choice of orange-red toning for the red strip?
I imagine this may have been chosen to optimize the display of skin
tones, and maybe it also helps compensate for the fact that we can no
longer display yellow as in red-green additive colors.  It also
completely eliminates the possibility of displaying cyan colors at
all, which I did notice that all blues of any sort were conspicuously
absent from the movie, being substituted with a variety of green
colors.  You can only see so much green before you start feeling tired
and "green" about it.  Also, in regards to over-subtracting for the
blue channel... even though we have one channel that subtracts 100%
blue, the fact that we still multiply the filters and have reduced the
strength of blue subtraction on the other channel means that we still
do get closer to displaying more ideal grays.  Also, the scene where
there Lotus Flower was looking at the black and white photograph of
Allen Carver, the photograph was generally slightly tinted green, with
the very darkest areas tending toward more of a yellow tint.  The
additional green tint in particular is probably due to the orange-red
toning adding in a bit of extra green light.
