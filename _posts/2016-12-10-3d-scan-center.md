---
layout: post
title: Finding the center of a 3D scan model
date: 2016-12-10 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

Point slicing consistency and center analysis.  How does this work?
Basically, you designate a certain point as the "center" of the model,
and planes are drawn emerging from that point to determine the stitch
boundary patterns for stiching two separate 3D scans together into
one.  That was my older idea.  But my newer idea...

Don't worry about the merge lines being weird.  The main idea is to
choose the highest quality points, and only one of them from available
candidates.  Note that available candidates must agree in normal
direction so that we don't have issues when trying to scan things like
thin card pyramids.
