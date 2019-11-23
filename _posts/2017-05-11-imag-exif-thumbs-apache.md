---
layout: post
title: "Thumbnail generation, ImageMagick tips and tricks, `exiftool`,
        Apache configuration"
date: 2017-05-11 21:00 -0600
author: quorten
categories: [media-prog]
tags: [media-prog]
---

Is there an easy web index thumbnail generation I can download from
the Internet?  I don't know.

20170511/DuckDuckGo generate http thumbnail image index  
20170511/http://www.linuxquestions.org/questions/linux-server-73/apache-indexes-with-thumbnails-492452/  
20170511/http://search.cpan.org/~gozer/Apache-AutoIndex-0.08/AutoIndex.pm  
20170511/https://httpd.apache.org/docs/2.2/mod/mod_autoindex.html  
20170511/http://www.imagemagick.org/Usage/thumbnails/  
20170511/DuckDuckGo apache generate thumbnail index page  
20170511/https://metacpan.org/pod/Apache::Image

Okay, now I"m wondering about easing batch file upload to the server.
Can a single input element upload multiple files?  Short answer is no.
Not until HTML 5 can you open up the file selection dialog, have the
user select multiple files, and upload them all to the server.  So
there you go, it's not possible using the earlier simpler web
technologies of times past.  You'd have to ask the user to use FTP or
the like to get the graphical experience and mass drag and drop.

20170513/DuckDuckGo http upload form multiple files  
20170513/http://stackoverflow.com/questions/15726439/how-to-upload-multiple-files-using-one-file-input-element  
20170513/https://www.fyneworks.com/jquery/multiple-file-upload/  
20170513/https://www.fyneworks.com/jquery/multifile/

<!-- more -->

Looks like some code modifications may be required to get what you
want.

Well, let's get to writing our own CGI thumbnail index generator,
that's easy.  Besides, since the mass majority of the code writing
work is customization and the entire code base is small, it really
doesn't matter that I'm writing from scratch (using the Perl CGI.pm
library, of course).

More ImageMagick notes.  This time, information on resizing to fit a
target size and fill the borders.  It's fairly simple.

Plus some more random but possibly useful information.

20170513/http://www.imagemagick.org/Usage/resize/  
20170513/http://www.imagemagick.org/Usage/crop/  
20170513/http://www.imagemagick.org/Usage/layers/#flatten

You can choose one of these two choices.

Add a border:

```
convert logo: -resize 80x80 \
  -size 80x80 xc:blue +swap -gravity center  -composite \
  space_resize.jpg
```

Chop off edges:

```
convert logo:    -resize x80 \
  -gravity center  -crop 80x80+0+0 +repage   space_crop.jpg
```

----------

Now when working with pictures from primitive cameras, we need to be
able to change the EXIF orientation tag to specify the desired
orientation losslessly.  How do we do that?  Use exiftool.

20170513/DuckDuckGo exiftool lossless jpeg rotation  
20170513/https://superuser.com/questions/36645/how-to-rotate-images-automatically-based-on-exif-data  
20170513/https://linux.die.net/man/1/exiftran  
20170513/https://superuser.com/questions/435443/how-can-i-modify-the-exif-orientation-tag-of-an-image

Read:

```
exiftool -Orientation -n image.jpg
```

Write:

```
exiftool -Orientation=1 -n image.jpg
```

Here are the important details on the meanings of the orientation
numbers.

20170513/http://sylvana.net/jpegcrop/exif_orientation.html

Note that exiftran is useful if you want to apply the lossless JPEG
rotation to the image data and remove the need to pay attention to the
orientation tag.

----------

Also it's important to serve up `index.svg` files as the actual index
files.

20170513/http://stackoverflow.com/questions/16192049/how-to-make-apache-serve-index-php-instead-of-index-html

In `.htaccess` or whatever Apache server config you want:

```
DirectoryIndex index.php index.phtml index.html index.htm
```

Web design questions.  Should we use a "single-web-page" design or use
multiple web pages?  On one hand, multiple web pages would not require
JavaScript, but on the other hand, it would be slower.  Well, let's do
both.  Let's support graphical clients both with and without
JavaScript, it's just that the ones that do have JavaScript will get a
faster and richer experience of the site than those that do not.
