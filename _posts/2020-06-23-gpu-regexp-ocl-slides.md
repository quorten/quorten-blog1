---
layout: post
title: "GPU regular expression matching libraries, and good slides for
        OpenCL"
date: 2020-06-23 21:14 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

What are some of the existing GPU regular expression matching
libraries that are out and about?  Um fortunately, there aren't really
that many ones out there, not to mention that the few that are out
there aren't all that great.  The first option only works on Nvidia
GPUs due to the use of CUDA, the second is far less developed, not to
mention that the first one is already rather but an incomplete proof
of concept.

20200623/DuckDuckGo opencl regular expression  
20200623/http://bkase.github.io/CUDA-grep/finalreport.html  
20200623/https://github.com/crepererum/oclgrep

Another interesting thing I found along the way.  I learned OpenCL by
reading the OpenCL 1.0 specification, in addition to reading the CUDA
documentation.  But, for those who were not initiated along this
learning path, here is an alternative educational history you can
follow.  This is a great set of slides for learning OpenCL, _hands-on_
as they tout.

20200623/https://www.nersc.gov/assets/pubs_presos/MattsonTutorialSC14.pdf
