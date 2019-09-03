---
layout: post
title: Set up Rudel in newer Emacs and  `paint.el` in older Emacs
date: 2016-05-15 21:12 -0500
author: quorten
categories: [emacs]
tags: [emacs]
---

Emacs Lisp packages, there are so many interesting things you can do
in Emacs if you have the right extension packages.  But unfortunately,
as fate must turn out, both Emacs and its packages have a drifting
problem.  Newer versions of Emacs come out with new features,
therefore some new packages are incompatible with old Emacs.
Alternatively, newer versions of Emacs also drop support for some
older platforms, so sometimes older versions of Emacs really are
required.  Within these constraints, sometimes you can make simple
source code modifications to bring your desired Emacs Lisp packages
forward or backward a few Emacs versions.

So, let's start with `paint.el`.  A very small and simple one source
code file package that allows you to draw pretty pictures in Emacs,
just like you would draw on a whiteboard.  The source code
modifications for running in older Emacs are simple as follows:

```
;; Paint doesn't work so well in Emacs version 21 or earlier, but this
;; is how to get it up and running regardless.

(defun window-inside-pixel-edges (&optional window)
  (list 9 0 (* 7 80) (* 13 40)))
  (paint 512 512)
```

To setup Rudel on older Emacs, you need to byte-compile twice.  The
first time won't successfully compile every single file.

Other notes on using Rudel.  If you don't choose a unique-enough color
that can be seen even on an `xterm`, then you will get the error
`obby-color-in-use`.
