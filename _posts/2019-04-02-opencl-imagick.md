---
layout: post
title: OpenCL acceleration in ImageMagick
date: 2019-04-02 20:42 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Does ImageMagick have OpenCL GPU acceleration?  If it's not in the
official version, surely there is a development branch with the
feature out.  Looks like there was a patch made and merged into the
master version of the source code.  The OpenCL GPU acceleration is
only implemented on some operations, such as resize.  That is one of
the most important and essentials operations to accelerate for me, so
that works out quite nicely for me.

Note that you have to verify if your particular build of ImageMagick
includes the OpenCL acceleration.  If not, you'll need to rebuild your
own ImageMagick with the feature enabled.

20190402/DuckDuckGo ImageMagick OpenCL GPU acceleration  
20190402/DuckDuckGo raspberry pi command line gpu accelerated image
  manipulation  
20190402/DuckDuckGo image magick gpu acceleration  
20190402/DuckDuckGo imagemagick gpu acceleration at DuckDuckGo  
20190402/DuckDuckGo imagemagick command line gpu image resize  
20190402/DuckDuckGo raspberry pi command line gpu image resize  
20190402/DuckDuckGo imagemagick gpu acceleration at DuckDuckGo  
20190402/https://imagemagick.org/script/opencl.php  
20190402/https://stackoverflow.com/questions/31582141/how-do-i-build-imagemagick-with-opencl
