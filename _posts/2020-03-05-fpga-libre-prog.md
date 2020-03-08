---
layout: post
title: Still trouble with libre software development FPGAs
date: 2020-03-05 18:46 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Programming FPGAs... looking more into this, I imagine there could be
complications getting the FPGA programming software running on
GNU/Linux.  What hardware interface do I even have for programming an
FPGA?  Is it something like SPI?  That would be ideal.  Unfortunately,
the details remain clouded...

First of all, many FPGAs do not have libre development tools.  Only a
few libre development tools have been developed through reverse
engineering of the simplest of FPGAs, and they are not officially
supported by the manufacturer.  Worse yet, looks like the osftware may
be primarily targeted toward development boards.  Okay, okay,
something is better than nothing, but maybe this won't quite be good
enough for me to use for an actual project.

20200305/DuckDuckGo linux fpga development  
20200305/https://wiki.debian.org/FPGA  
20200305/https://wiki.debian.org/FPGA/Lattice
