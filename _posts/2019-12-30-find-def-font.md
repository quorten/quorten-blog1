---
layout: post
title: "Find which font is used for the default `sans-serif` on
        Ubuntu"
date: 2019-12-30 18:59 -0600
author: quorten
categories: [media-prog, unix]
tags: [media-prog, unix]
---

Suppose you create a graphics design on a Debian or Ubuntu based
operating system and point the fonts used to generic names like
`sans-serif`.  How do you know which corresponding system font was
used?  Easy, run this command:

```
fc-match -s sans-serif
```

And pick the first "branded" font name from the list.  It should match
the metrics of the font you used in your graphic design.  Better yet,
prefer to point your graphics design sources only to branded fonts so
that it is easier to reproduce the original from the sources in the
future.  And, of course, always use only libre fonts or fonts of your
own design.

20191230/DuckDuckGo ubuntu find which font is used for sans-serif  
20191230/https://askubuntu.com/questions/61112/whats-the-default-serif-font-in-firefox
