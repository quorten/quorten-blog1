---
layout: post
title: "Ideas on creating \"vendoring generating\" software packages"
date: 2020-05-14 11:06 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

Often times I'm finding that for many of my software projects, I have
a clear need to have an organized system for the simple case where you
want code to be shared across projects principally, almost exactly, by
copying and pasting code.

Okay, the **right way** to work with such modular code bases.

1. Create a "mother" code base.

2. The primary "build system" in the mother code base is to generate a
   vendorable subset using a configure system.  Or, in the case of
   extreme simplicity, just by named scripts to copy a select
   configuration.

3. Once a configuration is chosen, a destination directory structure
   is generated using the selected subset to be vendored.

4. This code can now be copied and pasted into the master project
   and worked into the master project's build system.

When using GitHub, this can all be implemented as a modified theme of
the GitHub Pages publishing method.  A CI/CD system automatically
generates all of the required vendorable configurations upon code
change, and these can be included in projects using them using Git
submodules.

<!-- more -->

How well does this scale?  Well, first of all, let's be clear.  This
methodology is intended only for **simple** projects, so by definition
it does not "scale well."  Typically, I imagine the largest practical
use case for the setup can be described as follows:

* Device drivers and operating system kernel features subset

* Standard C library subset

* Data structures and algorithms library subset

* Math library subset

* Graphics library subset

* Graphical user interface library subset

* Audio/video codecs library subset

* Network protocols library subset

And that's about it.  All of these libraries, of course, must be
specifically designed for simplicity, else things will become
unwieldly really quickly.  And unfortunately, with modern web
standards that require complex encryption libraries, this is often
times no longer the case.
