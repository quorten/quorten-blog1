---
layout: post
title: "Things I learned about new Trisquel and Raspberry Pi firmware
        flashing"
author: quorten
date: 2018-09-18 20:00 -0500
categories: [misc, raspberry-pi]
tags: [misc, raspberry-pi]
---

Some interesting things I learned from the Trisquel forum, or from
upgrading from Trisquel 7 to Trisquel 8.

Some nifty tricks if you want to install KDE on Trisquel 8.

    sudo apt install plasma-desktop
    sudo apt install triskel

20180918/https://trisquel.info/en/forum/why-mate  
20180918/https://trisquel.info/en/forum/why-mate-instead-kde

Beware that Trisquel 8 is bigger than Trisquel 7... but there
are some things you can do about that.

20180918/https://trisquel.info/en/forum/why-trisquel-8-so-much-bigger-trisquel-7

For example, if you do a `dist-upgrade`, there will be old GNOME
packages left behind from Trisquel 7.  You can purge those packages as
follows:

    sudo apt purge gnome-system-monitor gnome-screenshot baobab \
      file-roller gnome-search-tool gnome-calculator gcalctool gedit \
      gedit-common gnome-dictionary gthumb gthumb-data

    sudo apt purge libgtkmm-3.0-1v5 libgtksourceview-3.0-1 \
      libgtksourceview-3.0-common gir1.2-gtksource-3.0 libgdict-1.0-9 \
      libgdict-common

<!-- more -->

Realtek Ethernet controllers?  They tend to load non-free firmware.
So, if you were wondering about that one Windows PC I have at home
(okay, maybe _you_ weren't) that started having trouble coming out of
standby for its Ethernet card, this could be it.  Windows driver
updates decided to load new firmware for it that has some bug in it.
Luckily, the card has its own built-in default firmware that appears
not to have this bug problem, conveniently avoided if you use
Trisquel.

20180918/https://trisquel.info/en/forum/dmesg-output-missing-free-firmware-non-free-firmware-loading-disable

Want to setup an image you can write directly to disk?  Install
the `oem-config` package for this.

20180918/https://trisquel.info/en/forum/trisquel-pre-install-img-versions

Interesting article here advocating for the avoidance of "passive
consumerism" in the libre software community.  WARNING: inappropriate
language in linked article.

20180918/https://trisquel.info/en/forum/carl-chenet-warns-free-software-slowly-dying  
20180918/https://carlchenet.com/foss-passive-consumerism-kills-our-community/  
20180918/https://trisquel.info/en/forum/dont-kill-our-community

Example of bad forum conduct.  Also, there is an important note from
`jxself` on how to contribute to Trisquel distribution development.

20180918/https://trisquel.info/en/forum/trisquel-needs-be-rebooted-and-based-ubuntu-1804

Failed search.

Worthy of mention is that Wikipedia does not have an article on
passive consumerism.

Now this links to an interesting article on using a Raspberry Pi as a
flash chip programmer, with SOIC clip to connect directly to the pins
on the motherboard.  Yes, for flashing Libreboot onto your laptop's
BIOS firmware.

20180919/https://trisquel.info/en/forum/libreboot-installation-winsond-chip  
20180919/https://libreboot.org/docs/install/rpi_setup.html

Want to do drawing on modern computers in 2018?  The all-out
recommendation seems to be to use a tablet computer if you want to do
drawing with a stylus, not a tablet input device without a display.

20180919/https://trisquel.info/en/forum/should-i-get-ipad-instead-xp-pen-drawing-tablet

The most important place to look for information on Trisquel?  The
documentation.

20180919/https://trisquel.info/en/wiki/documentation

I must say, though, this is an important but frequently overlooked
resource.  Trisquel seems to have quite nice documentation in quality,
though the quantity of course doesn't compare with that of Ubuntu.
This is also the go-to for information on development of Trisquel.
