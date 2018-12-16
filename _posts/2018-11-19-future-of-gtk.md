---
layout: post
title: The future of GTK+
author: quorten
date: 2018-11-19 17:47 -0600
categories: [random-software]
tags: [random-software]
---

Alright, so we're wondering about the current status of GTK+.  With
the whole GTK+3 fiasco, how is it holding up?  Well, it appears there
is some good news for the future.  GTK+4 will settle down and become
more compatible.  But, it appears that the general consensus is clear.
People are switching away from GTK+ in preference of Qt.

But, if you ask me for my preference and pick.  If I can't use a C
windowing toolkit like GTK+, I'd rather use WxWidgets over Qt.
WxWidgets is pretty stable and well-liked by its existing user base,
isn't it?  Well, indeed it is.

Speaking about high DPI displays.  GTK+ 3 has been switched over so
that all widgets are rendered via Cairo.  In late versions of GTK+ 2,
most widgets were being rendered via Cairo as part of a long-term
switchover.  Indeed, if you want to render user interfaces on high DPI
displays, Cairo is a must, and no longer will you be able to talk
about pixel-pushing in the realm of user interfaces.  In high-res,
pixel-pushing is a relic only of image processing and the like.

<!-- more -->

Yes, also FOX is still around and under active development.  There was
a fork of FOX called TnFOX, but it is no longer being developed or
maintained.  By far and large, this is due to the original author's
current employment settling around Internet, cloud, and web.

In light of that, indeed there is an HTML 5 backend for GTK+ named
_Broadway_.

And yes, GIMP is still out and about as I knew it when I first learned
it.  Yeah, about being one of the inspirations for me to learn GTK+,
along with Inkscape and GTKRadiant.  It was the original namesake of
GTK+!

20181119/https://en.wikipedia.org/wiki/GIMP  
20181119/https://en.wikipedia.org/wiki/GTK%2B  
20181119/https://en.wikipedia.org/wiki/WxWidgets  
20181119/https://en.wikipedia.org/wiki/Fox_toolkit  
20181119/https://en.wikipedia.org/wiki/Xfe  
20181119/https://en.wikipedia.org/wiki/TnFOX  
20181119/http://www.nedprod.com/TnFOX/#comment-465689583
