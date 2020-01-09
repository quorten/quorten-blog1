---
layout: post
title: Move relative symbolic links
date: 2020-01-07 20:55 -0600
author: quorten
categories: [unix]
tags: [unix]
---

How do you move relative symbolic links correctly?  Normally, the move
command just moves the symbolic link file without changing its target.
Unfortunately, there looks to be no easy way to do this with default
commands.  Rather, you must use third-party commands like the `symlink
-c` command to change absolute links to relative, for example.  Before
moving, you should convert the relative links to absolute links.

20200107/DuckDuckGo move preserving relative symlinks  
20200107/https://stackoverflow.com/questions/8523159/how-do-i-move-a-relative-symbolic-link
