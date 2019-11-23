---
layout: post
title: Visualize a single perspective 3D scan
date: 2017-04-18 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

So how do you visualize a 3D scan involving only a single perspective?
Here's the thing to realize.

* Dominant eye, recessive eye.  The dominant eye is used for the main
  2D color data, the recessive eye is mainly used to match of features
  with the dominant eye to perform the triangulation computation.
  This depth data is then added to the 2D image primarily presented by
  the dominant eye.
