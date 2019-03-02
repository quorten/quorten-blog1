---
layout: post
title: Mount FTP filesystem on GNU/Linux
date: 2019-02-23 10:41 -0600
author: quorten
categories: [unix]
tags: [unix]
---

How do you mount an FTP filesystem on GNU/Linux so that you can access
it in a graphical file manager?  Well, unlike Windows Explorer, there
generally is no function built-into the graphical file manager for
special handling of FTP servers, so you must do a FUSE mount yourself
as follows.

```
apt-get install curlftpfs
mkdir /mnt/my_ftp
curlftpfs -o allow_other ftp-user:user@email /mnt/my_ftp/
```

20190223/DuckDuckGo linux mount ftplinux mount ftp  
20190223/https://linuxconfig.org/mount-remote-ftp-directory-host-locally-into-linux-filesystem  
20190223/https://www.linuxnix.com/mount-ftp-server-linux/

Gosh, I must say.  Even on GNU/Linux, mounting Samba shares is easier
than mounting FTP shares.  On a typical desktop distro, I can mount
Samba shares right out of the box, for for FTP shares, I have to
install an additional package.  So, I guess the winner-take-all
solution for graphical file manager shares between Windows, GNU/Linux,
and Mac OS X is Samba.  I was really hoping I could avoid using Samba
due to its reputation of being insecure and getting blocked by
antivirus software, but it looks like it is the only technical way to
make graphical file manager sharing work with ease.  Otherwise, you
have to use an upload-download workflow, unless your entire editing
application is also implemented as a web app.
