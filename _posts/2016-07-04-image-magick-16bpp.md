---
layout: post
title: ImageMagick 16 bits per channel
date: 2016-07-04 21:00 -0600
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Can ImageMagick work with 16 bits per channel?  This would be very
useful when doing gamma curve corrections.  It looks like it can, I
think.

* Yep, it definitely can.  Just make sure you use the `-depth 16`
  operator somewhere before you save as PNG and your PNGs will end up
  with a larger file size due to having 16 bits per channel.

* This Color Basics ImageMagick article is very useful.  In fact, it's
  so useful that it even includes a link to the excellent Gamma error
  in picture scaling article on 4p8.com that I include below and
  follow up with discussion.

** Important!  In ImageMagick versions before 6.7.5, there was a bug
   such that the meanings of RGB and sRGB were swapped.

20160704/http://www.imagemagick.org/Usage/color_basics/  
20160704/http://www.imagemagick.org/script/convert.php  
20160704/http://www.imagemagick.org/script/command-line-options.php#depth  
20160704/http://www.imagemagick.org/script/command-line-options.php#level

DuckDuckGo imagemagick 16 bits per channel
