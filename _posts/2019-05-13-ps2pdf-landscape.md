---
layout: post
title: Ghostscript ps2pdf force landscape rotation
date: 2019-05-13 13:36 -0500
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Quick note here, suppose you save a PostScript file and convert it to
PDF via `ps2pdf`, but the orientation was not properly embedded in the
PDF.  How do you fix this?  Use this command line rather than the
`ps2pdf` command:

```
gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite \
  -sOutputFile=printout.pdf -dAutoRotatePages=/None \
  -c "<</Orientation 3>> setpagedevice" -f printout.ps
```

20190513/DuckDuckGo ghostscript ps2pdf orientation landscape  
20190513/https://superuser.com/questions/70054/set-page-orientation-to-landscape-using-ps2pdf  
20190513/https://www.linuxquestions.org/questions/linux-newbie-8/how-to-create-landscape-oriented-pdf-with-ghostscript-775308/

I thought there was an easier way I used before... I'll have to
investigate more.  But yes, I had to use a Ghostscript command line.

Well, I guess this must have been the alternative command line I was
using before:

```
gs -q -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite \
  -sOutputFile=dummy2.pdf -dDEVICEWIDTHPOINTS=792 \
  -dDEVICEHEIGHTPOINTS=612 -dFIXEDMEDIA -dPSFitPage pirates.ps
```

<!-- more -->

The idea was that I set the paper size to a landscape size and forced
the contents to fit in that new size.  It works, but it is not nearly
as general as the other solution I've found more recently, since it
does not allow for flipping.  But, that's what you get if you read the
local documentation and experiment rather than searching the Internet.
