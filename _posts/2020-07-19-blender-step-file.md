---
layout: post
title: "Import STEP files directly into Blender?  Go through FreeCAD."
date: 2020-07-19 00:18 -0500
author: quorten
categories: [3d-scanning, 3d-scanner, 3d-printing, media-prog, raspberry-pi]
tags: [3d-scanning, 3d-scanner, 3d-printing, media-prog, raspberry-pi]
---

Can you import STEP files directly into Blender?  Do you really need
to go through that FreeCAD import/export intermediary?  Well, looks
like you do, it's pretty much inevitable.  Apparently there has never
been a STEP file importer to send you directly into Blender.  Maybe it
is because STEP files are Constructive Solid Geometry (CSG) rather
than mesh geometry, and that is the source of the big problem.  And,
hence, the reason why FreeCAD is required as an intermediary.

Oh, and what else does this forum thread recommend?  Keep a version of
Blender 2.49 handy in case you are missing a converter.  Yeah,
right... 10 years later and I still feel I need a version of Blender
2.49 around just for that purpose.  This isn't going to go well
looking into the future... I better see what I can do to compile that
version of Blender on modern distros on my own.

20200718/DuckDuckGo blender step file  
20200718/https://blenderartists.org/t/how-to-convert-and-use-step-files-in-blender/493325/4  
20200718/https://blender.stackexchange.com/questions/126324/import-step-file-to-blender
