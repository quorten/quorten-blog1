---
layout: post
title: Compiling Emacs 23.1 on RHEL 6
author: quorten
date: 2016-11-15 12:27 -0600
categories: [centos]
tags: [centos]
---

Or so I thought.  This is where the issues come into play.  To
summarize from a top-level:

1. The packaging for Emacs 23.1 is broken.  Thus, you should go with
   Emacs 23.2b instead.

2. The packaging of developer packages on RHEL 6 is broken.
   Specifically, `giflib-devel' was not in the RHEL 6 package archive.
   Thus, you're going to need to do a variety of trickery here, either
   by building your own package or by only unpacking the needed
   development headers and dynamic libraries.

3. RHEL 6 is missing the glibc-static package, so you're not going to
   be able to compile statically-linked binaries.  Yes, there is
   reason to be concerned that this may create some portability
   issues, but lucky for me, my only target system I was intending to
   run the binaries on was RHEL 7 x86_64, so given these limitations,
   I'm still good.

<!-- more -->

----------

Okay, so let's first start with the traceback of the steps I had to go
through.

Here are the third-party libraries that I want Emacs to have support
compiled in for: libxaw3d libxpm libpng libz libjpeg libtiff libgif.

Here is what I must do to get them on a RHEL 6 system:

    yum -y install Xaw3d libXaw-devel libXpm-devel zlib-devel libjpeg-devel \
      libtiff-devel giflib libpng-devel

Note: In later versions, you may need to specify Xaw3d-devel instead.

From the first try of a configure command line...

Ouch!  RHEL 6 does not include the giflib-devel package.  This is a
known problem for which there have decidedly not been an official fix
put out, as it was not an upgrade priority.

https://lists.gnu.org/archive/html/emacs-devel/2015-09/msg00430.html

20160802/https://bugzilla.redhat.com/show_bug.cgi?id=659854  
20160802/https://access.redhat.com/solutions/11312

Well, I guess I'll have to find a replacement package on the Fedora
project, for a version not officially supported as to go with RHEL 6.

20160802/https://admin.fedoraproject.org/pkgdb/package/rpms/giflib/  
20160802/https://apps.fedoraproject.org/packages/giflib  
20160802/http://koji.fedoraproject.org/koji/buildinfo?buildID=683525  
20160802/https://kojipkgs.fedoraproject.org//packages/giflib/4.1.6/1.fc11/

Oh my, problems getting this package installed directly.  Glibc
version dependency failures.  And libc is supposed to be an iron-heart
standard!  Why do they have to make the version dependencies so tight
and inflexible?  They're not trying to make the dependencies so tight,
it's just that they didn't put in the extra effort to loosen up the
dependencies.  Okay, fine then.

* So what's the point of noting such detailed workflows?  The point is
  to show how much effort it took to get things up and running.  Yeah,
  not like an easy straight line, for those who want to know how hard
  it was to get started.  Actually, you know how I found those URLs
  above?  I had to type in some keywords in a search engine (which I
  did not keep track of this time), and I couldn't just click on the
  first result, I had to read into the various results and try to
  determine which page most likely had the information that I was
  looking for.

  "At this point I was typing frantically fast and the conference was
  running late, as it was supposed to have already started 5 minutes
  ago."  Yes, like that.  So is that really what software is about?

And that (building Emacs from source) was supposed to be easy, and I
got myself into this big mess?

Well, fine.  Let's static link then, even though at present, the only
missing dependency for dynamic linking on rsvdev1 is Xaw3d.

----------

Considering that I'm trying to avoid the package dependency problem,
What version of giflib am I going with?

Dated 2009?  That's a really old giflib, why don't I use a newer one
just because?  Okay, one version newer for the binary manual unpack.

    giflib-4.1.6-10.fc21.x86_64.rpm giflib-devel-4.1.6-10.fc21.x86_64.rpm

Note that I have to unpack both packages so that at the linker stage
in compilation, the shared library will be able to be perused to
verify that the necessary symbols are present.

    ./configure --prefix=/home/amakousk/local \
      --with-x-toolkit=athena \
      C_INCLUDE_PATH=/usr/include:/tmp/amakousk/usr/include \
      LD_LIBRARY_PATH=/usr/lib64:/tmp/amakousk/usr/lib64 \
      LDFLAGS=-Wl,-static

No, not that.  Use `LDFLAGS=-static'.

    ./configure --prefix=/home/amakousk/local \
      --with-x-toolkit=athena \
      C_INCLUDE_PATH=/usr/include:/tmp/amakousk/usr/include \
      LD_LIBRARY_PATH=/usr/lib64:/tmp/amakousk/usr/lib64 \
      LDFLAGS=-static

Oh no!  Can't do static build!  Well, I guess I'll just have to do
without it.

    ./configure --prefix=/home/amakousk/local \
      --with-x-toolkit=athena \
      C_INCLUDE_PATH=/usr/include:/tmp/amakousk/usr/include \
      LD_LIBRARY_PATH=/usr/lib64:/tmp/amakousk/usr/lib64

Okay, that doesn't work.  Try this.

    setenv C_INCLUDE_PATH /usr/include:/tmp/amakousk/usr/include
    setenv LIBRARY_PATH usr/lib64:/tmp/amakousk/usr/lib64
    ./configure --prefix=/home/amakousk/local --with-x-toolkit=athena

Oh my, I give up.  I believe that was a bugged up release.  Okay, try
again with 23.2b.  Okay, much better.

20160802/http://stackoverflow.com/questions/7783920/gnu-make-yields-commands-commence-before-first-target-error

Wow, this really makes you wonder what's been happening in the
software profession.  It seems like the quality just keeps getting
lower and lower.
