---
layout: post
title: Export a 3D model of a board with components on it in KiCAD
date: 2020-04-28 19:42 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, okay, I've been playing around with the 3D visualization in
KiCAD, and now I want to be able to export a 3D model of a complete
board with components populated on it.  How do I do that?  Ah, now
that's the trick question.  In the earlier versions of KiCAD that used
VRML and X3D format models for the boarda components, you simply
couldn't do it within KiCAD itself.  Instead, you had to make sure you
had STEP models of all the componentson the board, and then run a
converter program called "StepUp" to generate a STEP model of the
board that copies and embeds all the STEP models of the components.
Then you can import the overall STEP model to MCAD and go from there
to do things like visualize a multi-board assembly, design enclosures,
and so on.

Alas, one point to keep in mind... with KiCAD, the 3D interface was in
bad need of a lot of refactoring, and that turned out to be a lot more
work than was expected.  KiCAD was reworked to be able to work with
STEP models directly, so hopefully exporting a 3D model of your entire
board will be quick and painless in future versions of KiCAD.  Please
note that within this forum there are links to equivalent STEP models
of the old KiCAD VRML models, so you can use that as a starting point
if you've started using the old VRML models to get a 3D visualization
of a board.

20200428/DuckDuckGo kicad export 3d model of board  
20200428/https://forum.kicad.info/t/how-to-share-step-3d-model-with-all-the-components-on-the-pcb-too/2542

<!-- more -->

MCAD?  It's a generic term for mechanical CAD, a prime example being
FreeCAD.  Ah, yes, FreeCAD, we meet again.  And right here in the
article is an example of an Arduino board being viewed in FreeCAD,
exported from Eagle CAD.  So it's not too far of a jump to export from
KiCAD instead.

20200428/https://en.wikipedia.org/wiki/FreeCAD  
20200428/https://en.wikipedia.org/wiki/File:Freecad_screenshot_--_Arduino_(Eagle_import).jpg

And, yes, here again is the dreaded STEP format.  It's not the most
ideal format, other than the fact that it's become standardized.

20200428/https://en.wikipedia.org/wiki/ISO_10303
