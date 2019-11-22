---
layout: post
title: More useful resources on 3D scanning
date: 2016-06-04 21:00 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

Wow, that Scanning from Heating paper is a really valuable resource.
I was able to find links to other 3D scanners out and about in the
market.  And guess what?  I found information on the API that is used
to connect the 3D scanner with the host software too: Nikon Metrology
API.  Well, that's 3D scanners for at least one case.  I'm going to
see if I can find links to more 3D scanners on the market so that I
can learn about more software interfaces.  This is of course crucial
to get right, because doing so will make it dramatically easier to
integrate home-grown 3D scanner designs with.

20160604/http://www.nikonmetrology.com/Products/Laser-Scanning/Handheld-scanning/ModelMaker-MMDx  
20160604/http://www.nikonmetrology.com/handheld_scanners/mmdx_mmc/  
20160604/http://www.nikonmetrology.com/content/download/12579/256644/version/23/file/MMDx-MCAx_EN.pdf  
20160604/http://www.nikonmetrology.com/content/download/12579/256644/version/23/file/MMDx-MCAx_EN.pdf

Oh yeah, and "all standard point, mesh and CAD formats, such as IGES,
STL, CATIA, UG, Pro/E, STEP, VDA, etc".  I personally note Wavefront
OBJ too.  As a matter of fact (_de facto_), Wavefront OBJ seems to
have more support across commodity open-source 3D software.

<!-- more -->

Do you know what's most interesting about the professional laser
scanner product?  It looks like the line generator beam size is about
identical to that from my cheap laser.  Plus, they also use a class 2
laser diode.  So, it turns out that my laser isn't that bad after all.
For the other imperfections that I've noted, I can just use software
to correct for them.

Nikon metrology API?  I better seriously search for more information
on that.  I need a tech spec.  What?  There isn't one available?

This is as close as I could get.  I guess they really want to sell you
turn-key solution software as opposed to trying to create a standard
interface.  Vendor lock-in, it seems.

So what did you say?  You say that without a documented API, they are
complicating the matter of getting custom software to directly
interpret the output of their 3D scanner hardware?  You ask them for a
solution?  What will they tell you?  Oh, they might end up telling you
that you can just export to one of the standard file formats, then
import the results into your software.  But, you say, that isn't good
enough.  You need your software to be able to process the point cloud
data in real-time when it is being received from the device.  Well,
then I guess you're in for quite a problem then.

20160604/http://www.nikonmetrology.com/Products/Software/Point-cloud-software/Nikon-Metrology-API  
20160604/http://www.nikonmetrology.com/content/download/11057/228828/version/7/file/Focus_EN.pdf
