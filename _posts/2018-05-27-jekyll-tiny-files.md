---
layout: post
title: The solution to huge numbers of tiny files
author: quorten
date: 2018-05-27 21:00 -0500
categories: [blogging]
tags: [blogging]
---

As it turns out, the solution to dealing with Jekyll for local
development on a blog involving huge numbers of tiny files is
non-trivial.  Why?  Because Jekyll itself, when you run the local
server, will copy out every single individual post into a tiny file of
its own.  So, clearly when you are running your local development
server, a bad problem of thousands of tiny files is going to become a
worse one.  What is the way out of this?  Clearly, any solution must
be improved efficiency at the filesystem level.

So, I am going to propose this potential solution to the problem,
though I haven't tested it yet: compressed RAM disk filesystem.  On
Linux, this means using the `zram` module.  The idea is that you can
reasonably deal with filesystem fragmentation causing padding out to 4
KB if you can compress the filesystem: assuming all of that extra
padded wasted space is all zeros, this will compress to be a sparse
coding format, hence solving your problem of wasted space with
thousands of tiny files.  Again, I haven't tested this yet, so time
will tell if this works well for me or not.

20180527/DuckDuckGo linux ram compressed file system  
20180527/DuckDuckGo linux compressed ramdisk  
20180527/https://en.wikipedia.org/wiki/Zram
