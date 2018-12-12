---
layout: post
title: Set up a Darwin cross compiler, to target Mac OS X
author: quorten
date: 2016-11-02
categories: [misc, important]
tags: [misc, important]
---

Important!  Set up a Darwin cross compiler, so that you can compile
native binaries that work on OS X, but without the hassle of needing
to download the proprietary XCode SDK.

20161102/http://askubuntu.com/questions/274471/cross-compiler-for-darwin-x  
20161102/https://github.com/tpoechtrager/osxcross  
20161102/http://ranger.befunk.com/fink/darwin-cross/  
20161102/http://ranger.befunk.com/fink/darwin-cross/darwin-cross-centos.repo  
20161102/http://ranger.befunk.com/fink/darwin-cross/SRPMS/  
20161102/https://github.com/distcc/distcc  
20161102/http://docs.huihoo.com/darwin/opendarwin/projects/odcctools/  
20161102/http://docs.huihoo.com/darwin/opendarwin/projects/odcctools/usingodcctools.html  
20161102/http://stackoverflow.com/questions/13227162/automatically-install-build-dependencies-prior-to-building-an-rpm-package#13228992

`__LP64__` build problems...

20161102/http://www.unix.org/version2/whatsnew/lp64_wp.html  
20161102/http://stackoverflow.com/questions/1753834/lp64-on-os-x-snow-leopard-equivalent

So it turns out that the previous build is not known to succeed
compiling under a 64-bit compiler.  Well, that kind of makes sense,
though it is not fully correct form as we are building a _cross_
compiler.

<!-- more -->

Unfortunately, it turns out I have the latest odcctools, which means
that odcctools does not support x86_64.  But it does support i386.  So
I guess I have to go with that.

Er... maybe I really do need to do the whole Darwin virtual machine
thing.

Okay, the OpenDarwin project it originated from was shut down.  So
yes, that's true.  PureDarwin instead.

20161102/https://en.wikipedia.org/wiki/Darwin_(operating_system)#OpenDarwin  
20161102/http://www.puredarwin.org  
20161102/http://www.puredarwin.org/users

20161102/https://en.wikipedia.org/wiki/Apple_Disk_Image

* Spot on!  The Wikipedia link to the `hdiutil(1)` man page says
  _Darwin_ and OS X General Commands Manual.

20161102/DuckDuckGo create dmg on linux

Ha!  You can create a `dmg` with ease on GNU/Linux:

20161102/http://stackoverflow.com/questions/286419/how-to-build-a-dmg-mac-os-x-file-on-a-non-mac-platform#3776463

    dd if=/dev/zero of=/tmp/foo.dmg bs=1M count=64
    mkfs.hfsplus -v ThisIsFoo /tmp/foo.dmg

You can also use `genisoimage`.

Also check out this utility.  You can create compressed `dmg` images
with it, albeit with caveats.

20161102/https://github.com/hamstergene/libdmg-hfsplus

If only there were more recent versions of similar software available.

If not on your favorite cross platform of choice, you can also create
a dmg natively on OS X using the Disk Utility.

`hdiutil`!  That's it!  That's how to create dmg images on OS X via
the command line!  Okay, now time to see if it is available in Darwin.
If it is, we're in good news.

20161102/http://www.elstensoftware.com/blog/2013/04/17/scripting-dmg-build-osx-linux/

20161102/http://unix.stackexchange.com/questions/267009/creating-a-dmg-file-on-gentoo

Yep, I believe we're in good luck.  FileVault.  Source code.

20161102/http://opensource.apple.com//source/Security/Security-176/Keychain/FileVaultSPI.h

20161102/https://en.wikipedia.org/wiki/FileVault

`dmg2img`?  And what about the reverse?

20161102/http://eastmanreference.com/how-to-work-with-dmg-files-on-linux/

Wow, this is really interesting.  Active thread, waiting to make an
advance at every possible opportunity.  This is especially useful when
combined with Electron to be able to package apps for every possible
modern web-enabled platform.  Finally, the platform problem would have
been solved, but it certainly took quite a bit of years.

20161102/https://github.com/LinusU/node-appdmg/issues/14  
20161102/https://serverhorror.wordpress.com/2011/02/26/create-dmg-images-for-os-x-on-linux/

`getattrlist`, we also need in Darwin.

We're getting there fast.

20161102/https://pypi.python.org/pypi/ds_store  
20161102/http://search.cpan.org/~wiml/Mac-Finder-DSStore/DSStoreFormat.pod  
20161102/https://wiki.mozilla.org/DS_Store_File_Format

There's a `node.js` version of the library too, but it is not as
complete as the Python and Perl versions.  There's certainly no
shortage of library rewrites available in these modern scripting
languages, it seems.  Hah, the pundits of these languages would tell
me it is because they are so easy to program in, that you can write
new software that much faster in the scripting languages than the
traditional languages.

20161103/https://github.com/LinusU/node-ds-store

Ha!  We got `bless`!  It's right here:

20161102/https://opensource.apple.com/source/bless/bless-105/
