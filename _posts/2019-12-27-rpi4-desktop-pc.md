---
layout: post
title: My setup and first test run using Raspberry Pi 4 as a desktop PC
date: 2019-12-27 19:50 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So what software do we want to install on top of the base Raspbian to
make a nice comfy desktop PC replacement?

* matchbox-keyboard
* GNU Screen
* xprintidle
* KolourPaint
* GIMP
* Inkscape
* Stellarium
* Emacs
* Blender
* unattended-upgrades

That does it for the basics.  Now for additional important system
configuration.

<!-- more -->

* Disable automatic logins in Raspberry Pi configuration to disable
  the auto-login on the text tty1, then configure lightdm to
  auto-login for the restricted user account.

* Make sure that SAMBA file sharing works.

  20191228/DuckDuckGo raspberry pi samba  
  20191228/DuckDuckGo raspberry pi connect to samba share  
  20191228/https://www.raspberrypi.org/documentation/remote-access/samba.md

  Please note that [Samba in the GUI is limited compared to that of
  the command line]({{ site.baseurl }}/blog/2020/01/02/smbfs-vs-cifs).

* Enable SSH for the admin account only.

  20191231/DuckDuckGo disable ssh login to particular account  
  20191231/https://www.ostechnix.com/allow-deny-ssh-access-particular-user-group-linux/

* Install Emoji fonts!  They appear not to be installed by default?

  20191231/DuckDuckGo raspberry pi emoji fonts  
  20191231/https://raspberrypi.stackexchange.com/questions/104181/colored-emojis-in-chromium  
  20191231/https://www.omgubuntu.co.uk/2016/08/enable-color-emoji-linux-google-chrome-noto  
  20191231/https://eosrei.github.io/emojione-color-font/full-demo.html

  Nowadays, there is a debian package for this: `sudo apt-get install
  fonts-noto-color-emoji`.

The PDF viewer included in Raspbian, `qpdfview`, doesn't have support
for selecting text?  Install the better PDF viewer Atril from MATE,
along with the XPS converter `xpstopdf` from the `libgxps-utils`
package:

```
sudo apt-get install libgxps-utils atril
```

Also, follow my later notes on other important configuration needed on
Raspberry Pi as a desktop PC:

* [How to implement a Raspberry Pi power button, and using `gpio-keys`
  for interrupt-driven GPIO key events]({{ site.baseurl
  }}/blog/2019/11/24/rpi-power-int-keyev)

* [How to setup proper DPMS on Raspberry Pi]({{ site.baseurl
  }}/blog/2019/12/28/rpi-dpms)

* [Virtualization on Raspberry Pi]({{ site.baseurl
  }}/blog/2019/12/28/virt-rpi)

* [More discussion on Raspberry Pi power button, suspend to disk,
  suspend to RAM]({{ site.baseurl
  }}/blog/2019/12/28/more-rpi-pw-button)

* [Raspberry Pi 4 video tearing explained]({{ site.baseurl
  }}/blog/2020/01/01/rpi4-vid-tear-expl)

* [Difference between smbfs and cifs and Windows 7 vs. 10]({{
  site.baseurl }}/blog/2020/01/02/smbfs-vs-cifs)

Then we are in business!

----------

So, my reflection on using Raspberry Pi 4 as a desktop PC?  Overall,
pretty awesome!  The _caveat emptor_ is the fact that to get the
awesomeness we expect from a garden variety desktop PC or laptop, a
lot of additional software configuration is required, and the
Raspberry Pi Foundation is always making up excuses why they can't do
this, they can't do that, they don't have enough resources to do this
correctly, blah blah blah.

ACPI power states and power button?  No.  Sleeping unused cores?  No.
DPMS in X11?  No.  PXE network boot?  No.  Wake on LAN?  No.  64-bit?
No.  Virtualization?  No.  Vsync?  No.

The lack of proper vsync in video playback in Chromium and on the X11
desktop in general is a considerable nuisance.  3D performance in
Blender for basic untextured polygon geometry is good, but more
geometry and textures quickly becomes slower than expected.  There is,
of course, much more work that needs to be done on the 3D drivers to
take the Pi 4 to its full potential.  Video playback, likewise, is a
bit slower and more jerky than expected, and Stellarium performance is
unusually slow.

The lack of proper power management configuration by default is a
major blunder.  Likewise, the lack of virtualization support by
default is also a major blunder.  Both of these hurdles can be either
mitigated or overcome with a little bit of extra effort, however.

----------

UPDATE 2020-06-27: After some system upgrades, sound was not working?
Why?  Web searches were failing to inform me on the underlying
problem, so I had to dive down to the source code.  I found out that
purportedly, the preferred sound configuration mechanism was changed
after system upgrades.  Now, when you set output to headphones in
`raspi-config`, it is not set system-wide, but only for the current
user, by generating an `~/.asoundrc` file that sets the ALSA card to
the preference.  There are two ALSA cards in Raspberry Pi 4, one for
HDMI output and one for headphones output.  So, after you set this for
the `pi` admin user, you must copy that config to all regular user
accounts or else they will not be able to hear sound.  I know, I know,
very annoying unless you run your Raspberry Pi as the admin user all
the time.
