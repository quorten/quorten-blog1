---
layout: post
title: History of math typesetting on the web up to 2018
author: quorten
date: 2018-05-28 23:49 -0500
categories: [blogging]
tags: [blogging]
---

* 1995 - 2010: By far and large, images were used for math display on
  the web, even though there were newer technologies and possibly
  better ways available to do math typesetting on the web.

* 2010 - 2014: MathML and jsMath emerge as two viable solutions for
  displaying browser-side typeset math on the web.  A few adventurous
  site authors start using these newer solutions, but the biggest
  operators still stick to image display.  A variety of tools emerge
  for generating or authoring MathML, all with their early
  limitations, but none of them become sufficiently popular to reach
  critical mass and speed up in development.

* 2014 - 2018: Even the big sites have since switched over to either
  MathML or a solution like MathJax.  Kahn Academy creates yet more
  math on the web solution called KaTeX and SsKaTeX, both of which
  prove to become quite popular, unlike the older MathML tools.

In any case, what most of this otherwise redundant implementation
progress has done is successfully affirm one unchanging standard in
math typesetting: Donald Knuth's TeX system, responsible for the core
typesetting algorithms, and the derived LaTeX system, mainly a
syntactic convenience library.
