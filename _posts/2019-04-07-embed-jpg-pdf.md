---
layout: post
title: Lossless embed JPEG images inside PDF, revisited
date: 2019-04-07 13:36 -0500
author: quorten
categories: [media-prog, pentax-k-1-camera]
tags: [media-prog, pentax-k-1-camera]
---

So, you've scanned a bunch of documents and books via the DSLR camera
photography method, developed the RAW, generated one JPEG image per
page, and now you want to convert these to PDF files, one per logical
book or document.  Or, in other words, one PDF file per "print job."
Old fashioned conventional wisdom would state that you would use
ImageMagick to convert from JPEG to PDF, but that introduces losses.
Sure, the conversion process is simple enough for me to write my own
tool, but surely someone else must have already written a tool,
haven't they?

First things first, for extracting images from PDF files.  There is a
tool named `pdfimages` that is part of `poppler`, i.e. the Ghostscript
library.  So, no need to keep using my hand-rolled tool.

20190407/DuckDuckGo linux embed literal jpeg inside pdf no lossy
  conversion  
20190407/https://unix.stackexchange.com/questions/11835/pdf-to-jpg-without-quality-loss-gscan2pdf

Second, that important information and distraction aside, we want to
do the reverse.  So, keep searching.

20190407/DuckDuckGo linux embed unmodified lossless jpeg into pdf  
20190407/https://unix.stackexchange.com/questions/42856/how-can-i-convert-a-png-to-a-pdf-in-high-quality-so-its-not-blurry-or-fuzzy

<!-- more -->

Now let's create a list of methods to convert independent images to
PDF encapsulated format, and also methods for concatenating PDF files,
in order of quality.

* ImageMagick `convert`, strongly discouraged due to mandatory raster
  re-encoding.

* Ghostscript, can sometimes result in re-encoding.  Sometimes this is
  preferred if you want to reduce the resolution of embedded images.

* `pdflatex`, JPEG images will be embedded literally, but other types
  of images will be re-encoded in an inefficient manner.

* `qpdf`, possibly a good PDF merger.

* PyMuPDF, a Python binding for MuPDF, for merging PDF files.

* PDFMerger from Apache `pdfbox`.

* `pdfunite`, part of `poppler` for merging PDF files, but some have
  said it appears to break hyperlinks.  Also, it does not work on
  encrypted files.

* `pdfjoin`, works with joining encrypted PDFs but breaks annotations
  and additional non-graphics items.

* `tesseract`, in addition to OCR it can also embed images in PDF
  files in a lossless manner.

* `img2pdf`, a modern Python program designed to losslessly embed an
  image file into a single-page PDF.

* `pdftools`, another modern Python program for simple, literal page
  concatenation of PDF documents.

I reckon that I wish such software has made its way into the libre
world at an earlier time, but better late than never!

20190407/https://gitlab.mister-muffin.de/josch/img2pdf  
20190407/https://en.wikipedia.org/wiki/PDFtk  
20190407/DuckDuckGo linux concatenate pdf pages  
20190407/https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf

20190407/https://github.com/stlehmann/pdftools
