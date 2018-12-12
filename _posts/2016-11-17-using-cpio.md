---
layout: post
title: Notes on using `cpio`
author: quorten
date: 2016-11-17
categories: [unix, important]
tags: [unix, important]
---

Important!  Notes on using `cpio`.

    find ARCH-DIR -depth | cpio -oV -H ustar > backup.tar
    cpio -idmV < ../backup.tar

Let's explain how this works.  `-H` selects the format.  You almost
always wnat to use this to avoid using an old and obsolete format.
Using `tar` may be convenient because it allows for interoperability
with `tar`.  `-depth` is necessary so that directories are written
last.  This is to preserve their modification times on the copy-out.
But then `-d` is needed for this to work on copy-out.  `-m` is used to
preserve modification times on copy-out.  And `-V` is an alternative
for `-v` depending on what kinds of screen displays you like to see.

"Why not just use tar"? you ask.  Well, because as described above, in
relation to directories and the `-depth` option, tar-archives don't
work as well with `cpio`, but the reverse works just fine.  Hence, it
is a matter of maximizing interoperability.

But, beware, `-V` is not available in BSD `cpio`.

20161117/http://www.linuxjournal.com/article/1213
