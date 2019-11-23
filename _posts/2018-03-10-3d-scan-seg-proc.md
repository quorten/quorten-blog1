---
layout: post
title: 3D scanning segmented processing
date: 2018-03-10 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner, important]
tags: [3d-scanning, 3d-scanner, important]
---

Each video stream can be divided up into segments where the scanning
software processes it in a specific mode.  Ideally, these segments can
be auto-detected based off of contents inside the video streams.

Matter of fact, for our purposes, our typical video streams should
only have like three stages:

1. Compute location/orientation of camera.
2. Compute location/orientation of laser.
3. Main scanner loop, record video sweep of laser acros scan field.
