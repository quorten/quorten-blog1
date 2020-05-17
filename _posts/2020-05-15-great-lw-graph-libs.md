---
layout: post
title: "Some great lightweight graphics libraries: CPU 2D rendering,
        JPEG+PNG loading"
date: 2020-05-15 17:39 -0500
author: quorten
categories: [media-prog, unlipic]
tags: [media-prog, unlipic]
---

Surely, I don't have to write my own C language 2D CPU graphics
library from scratch, do I?  Well... here's an interesting surprise
find.  Yeah, there are indeed other efforts out there, but still,
there's quite a unique number of things about my library that are
better than this one.

20200515/DuckDuckGo github c 2d cpu graphics drawing  
20200515/https://github.com/grz0zrg/fbg

But, here's the absolute best thing I've found.  There are
ultra-lightweight alternatives for decoding JPEG and PNG images.  Wow,
I've got to look more into those!  Yeah, libJPEG isn't too hard to
use, but libPNG, gosh that Zlib dependency sure made it a main.
`LodePNG` does not depend on Zlib.

20200515/http://keyj.emphy.de/nanojpeg/  
20200515/https://lodev.org/lodepng/
