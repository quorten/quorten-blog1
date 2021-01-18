---
layout: post
title: Dirt cheap lossless video editing
date: 2021-01-09 13:21 -0600
author: quorten
categories: [media-prog]
tags: [media-prog]
---

What is the simplest way to do lossless video editing on GNU/Linux?
And, in particular, a workflow that works well for simple, cheap,
low-budget movies?  The technique is rather simple.

1. Look at your video clips in a conventional video player, and create
   an ordered list of segments you want to include in the final
   output.  Just use the filenames as-is in your list.

2. Use my [previous instructions]({{ site.baseurl
   }}/blog/2018/09/16/dvd-video-meets-html-5) on doing lossless video
   concatenation with FFMPEG.

3. Now, use the LosslessCut video editor.

So, LosslessCut is a new name in town here, but its purpose is rather
simple.  It is a lossless GUI video editor that only supports trimming
and cutting segments.  Fortunately, that's all we need for the final
video editing step.  If we want to copy segments or slice and
transpose segments within a single clip, we can simply list the
segments multiple times in the concatenation list and then just trim
away all the extra video information.  One great thing about
LosslessCut is that it can export a CSV cut list, so you can build a
precise command-line to rebuild your final output from the source
input.  Cutting apparently is restricted to keyframes, though, but
hopefully that is good enough for most cuts.

<!-- more -->

20210109/https://itsfoss.com/losslesscut-video-cutter/  
20210109/https://mifi.github.io/lossless-cut/  
20210109/https://github.com/mifi/lossless-cut

For a more sophisticated video editor, Kdenlive still remains a
preferred choice.

20210109/https://en.wikipedia.org/wiki/Kdenlive

UPDATE: It turns out that LosslessCut actually does allow you to
easily transpose segments, so you only need to list twice in the
initial concatenation list if you want to copy segments.  That's good
news!
