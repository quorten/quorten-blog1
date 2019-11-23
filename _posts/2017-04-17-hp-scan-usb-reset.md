---
layout: post
title: Info on getting HP ScanJet 5300C working, USB reset code
date: 2017-04-17 21:00 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

HP ScanJet 5300C notes.

Okay, continued research on this machine.  How have people got this
scanner to work under GNU/Linux?  After much research and a little bit
of experimentation, this is how.  Open up Simple Scan on Ubuntu (or
any derived distribution), of a somewhat old vintage, say 10.04 LTS,
Karmic Koala, or Hardy Heron, and just do a regular 300 DPI color
photograph scan, no customizations involved.  Then everything will
just work.  But, if you make any customizations or use a newer
distribution, or a distribution that is too old, then it won't work.

Note that you will also be able to get everything to work if you run
the operating system in a virtual machine and have the guest OS use
the USB device exclusively.

Oh yeah, and if you do mess up the USB device and need to reset it,
here's how.

20170417/DuckDuckGo linux command line close usb device  
20170417/https://askubuntu.com/questions/645/how-do-you-reset-a-usb-device-from-the-command-line

Including the source code and instructions of that program here for
posterity:

<!-- more -->

----------

```
/* usbreset -- send a USB port reset to a USB device */

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>

#include <linux/usbdevice_fs.h>


int main(int argc, char **argv)
{
    const char *filename;
    int fd;
    int rc;

    if (argc != 2) {
        fprintf(stderr, "Usage: usbreset device-filename\n");
        return 1;
    }
    filename = argv[1];

    fd = open(filename, O_WRONLY);
    if (fd < 0) {
        perror("Error opening output file");
        return 1;
    }

    printf("Resetting USB device %s\n", filename);
    rc = ioctl(fd, USBDEVFS_RESET, 0);
    if (rc < 0) {
        perror("Error in ioctl");
        return 1;
    }
    printf("Reset successful\n");

    close(fd);
    return 0;
}
```

----------

```
cc usbreset.c -o usbreset
$ lsusb
Bus 002 Device 003: ID 0fe9:9010 DVICO
$ sudo ./usbreset /dev/bus/usb/002/003
```

Source of above program:

20170417/http://marc.info/?l=linux-usb&m=121459435621262&w=2

20170417/DuckDuckGo ubuntu hp scanjet 5300c simplescan  
20170417/https://askubuntu.com/questions/846243/hp-scanjet-5300c-on-ubuntu-16-06  
20170417/http://www.linuxquestions.org/questions/linux-hardware-18/hp-scanjet-5300-debian-388866/  
20170417/https://ubuntuforums.org/archive/index.php/t-947076.html

Oh yeah, I like this quote:

  Thanks for the advice. I really know nothing about computers, so
  I'll wait for this to get fixed. In the meantime, I'm using my
  wife's computer to scan documents, and carting them over to my
  machine. Sure it's cumbersome, but it'll work for now.

Too bad, waiting will never get it fixed!

20170417/https://blog.lundscape.com/2010/03/simple-scan-on-ubuntu/  
20170417/https://en.wikipedia.org/wiki/Ubuntu_version_history

Oh, that LundScape website was particularly interesting and useful,
here I'll include another link to it about setting up FreeNX because I
saw it nearby.

20170417/https://blog.lundscape.com/2010/04/freenx-on-ubuntu/
