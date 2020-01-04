---
layout: post
title: "Difference between smbfs and cifs and Windows 7 vs. 10"
date: 2020-01-01 16:45 -0600
author: quorten
categories: [unix]
tags: [unix]
---

What's the difference between `smbfs` and `cifs` when mounting Samba
shares?  They are **not** just different names for the same thing.
`smbfs` supports Windows 98 shares, `cifs` only supports Windows NT
and newer shares.  That is the difference, and nowadays `smbfs` is
deprecated, obsolete, and support was completely removed from Samba.
So if you're looking to access Windows 98 shares, you better run an
older GNU/Linux in a virtual machine, a 2010 version should actually
be old enough to be compatible.

20200101/DuckDuckGo cifs host is down windows 98 share  
20200101/https://unix.stackexchange.com/questions/338563/mounting-old-windows-98-share

Finally, there is another caveat I discovered relating to software
versions.  `gvfs-smb` doesn't support Windows 7 shares?  Why not?
Because it uses a special new feature only available on Windows 10 to
avoid writing files to the host: hidden "junctures" are transparently
placed in the file hierarchy when mounting.  So they say... and
they're not making changes to be able to support Windows 7 shares.  So
that means you must use Windows 10 if you want the user-friendliness
of GVFS mounting like you'd get from PCManFM and the like.  Otherwise,
if you really want to access Windows 7 shares, you can do so from the
command... though one error will be printed, the mounting will still
be successful regardless.

20200101/DuckDuckGo gvfs-mount windows 7 says password required but public  
20200101/https://github.com/Microsoft/VFSForGit/issues/6
