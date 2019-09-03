---
layout: post
title: What happened to VirtualBox on Trisquel?
date: 2019-04-17 22:17 -0500
author: quorten
categories: [unix]
tags: [unix]
---

Trisquel 10.04 LTS included VirtualBox, I could install and use it
easily, and all was well, except that maybe it was a bit more buggy in
the emulation than QEMU, or maybe that was just due to my old laptop
having buggy VT-x.  But in the newer versions, it is not to be found
in the package repositories.  Why is this?  Purportedly, it was
removed because its BIOS implementation requires OpenWatcom to
compile, which is not Free Software due to its license.  Therefore,
they cut VirtualBox out completely.  Debian also cut VirtualBox from
the Main repo.  But no worries, QEMU is still available, purportedly
because it is more politically correct.

Earlier versions of VirtualBox could use `bcc`.  But in later
versions, they switched to OpenWatcom because they touted that `bcc`
didn't have all the features they needed.

Though because of this overall, time and time again, people are asking
for VirtualBox on the Trisquel forums, and it keeps needing to get
re-explained.  Old habits die hard.

20190903/https://trisquel.info/en/forum/virtualbox-eclipse-java  
20190903/https://trisquel.info/en/forum/cant-seem-install-virtualbox  
20190903/https://trisquel.info/en/forum/there-something-we-can-do-about-virtualbox  
20190903/https://trisquel.info/en/forum/looking-virtualbox-alternative  
20190903/https://trisquel.info/en/forum/why-has-no-one-made-fork-virtualbox-any-form-linux  
20190903/https://www.virtualbox.org/ticket/12011  
20190903/https://trisquel.info/en/forum/virtualbox-being-removed-trisquel
---
codename: broken-cmdinst-trisquel
layout: post
title: Broken command line installer in Trisquel
date: 2019-04-17 22:16 -0500
author: quorten
categories: [unix]
tags: [unix]
---

In a hurry, I was hoping I could do a minimal command line install of
Trisquel for some software development work with Golang and Docker in
a virtual machine.  Unfortunately, I ran into a serious roadblock.
`debian-installer` was failing to load the libc6 udeb.  After
searching around, this was caused due to some mal-planned updates, and
although there was a fix out in Debian upstream, unfortunately it
didn't quite make it to Ubunntu, and ultimately the version of
Trisquel I was using.  Very annoying, all these politics that must
happen, but that was the way it was.

20190417/DuckDuckGo trisquel failed to load libc6 udeb  
20190417/https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=833706  
20190417/https://bugs.kali.org/view.php?id=3417  
20190417/https://askubuntu.com/questions/1131988/shouldnt-critical-netboot-fixes-propagate-back-to-the-base-image
