---
layout: post
title: Actual setup of a Windows XP virtual machine
date: 2020-07-02 22:42 -0500
author: quorten
categories: [windows]
tags: [windows]
---

In my [previous blog article]({{ site.baseurl
}}/blog/2020/02/07/virt-winxp), I outlined some overall procedures to
get a Windows XP virtual machine setup.  But, that was it, I never
actually successfully got one setup myself.  So, here I actually go.

So, first of all, how do I apply those much-needed registry changes so
that Windows XP will not fail to boot due to disk driver device ID
mismatches?  Rather than needing to go through the whole
chicken-and-egg problem of modifying by booting a disk image that I
captured from pristine unmodified hardware, I can achieve the same
effect by editing the registry off-line, from GNU/Linux.  So, here's
the low-down on the actual procedure I use.

First, you need to mount your virtual machine disk image to your host
machine.  If `guestfish` is not available to use the [oVirt approach I
mentioned]({{ site.baseurl }}/blog/2018/10/10/ovirt-howto) previously,
you can use `nbd` instead.

<!-- more -->

```
sudo modprobe nbd
sudo qemu-nbd -c /dev/nbd1 ./v-home-dell-2300.vmdk
# Determine the offset to the NTFS partition in the disk image.
sudo fdisk -lu /dev/nbd1
# Now mount a loop device with the indicated offset, i.e. `512 * 63`.
sudo losetup -o $((512 * 63)) /dev/loop0 /dev/nbd1
# Now we can mount NTFS.
sudo mkdir /mnt/wxp
sudo mount -t ntfs /dev/loop0 /mnt/wxp

# Now we can finally edit the registry.
chntpw -e /mnt/wxp/WINDOWS/system32/config/system
# Enter your edit commands interactively or via script input...

# Dismount, disconnect, and cleanup.
sudo umount /mnt/wxp
sudo rmdir /mnt/wxp
sudo losetup -d /dev/loop0
sudo qemu-nbd -d /dev/nbd1
sudo modprobe -r nbd
```

20200702/DuckDuckGo qemu mount vmdk host  
20200702/https://unix.stackexchange.com/questions/550569/how-can-i-access-the-files-in-a-vmdk-file

Another thing, using `chntpw`, sure you can do `sudo apt-get install
chntpw`, but you may want to ensure you have the latest version by
going to the official website.

20200702/DuckDuckGo chntpw  
20200702/https://en.wikipedia.org/wiki/Chntpw  
20200702/http://pogostick.net/~pnh/ntpasswd/

Also, beware when using `chntpw`!  It is very brittle and fragile when
it comes to error handing.  If you type the wrong number of arguments
at the interactive prompt, it will crash with a segmentation fault.
Also, if you use the wrong command line switches, chances are it will
also crash.

20200702/DuckDuckGo chntpw segmentation fault  
20200702/https://askubuntu.com/questions/893414/chntpw-hex-on-windows-10-registry-entry-crashes-to-get-bt-session-key

Okay, now let's get into the lowdown of making the changes.  Since
`chntpw` does not support reading `.reg` files directly and merging
them, we need to translate that into our own commands.  So, as noted
in the previous command line, since we are editing the
`HKEY_LOCAL_MACHINE\SYSTEM` root, we open up the `system` hive file on
the command line.  Then, in the `.reg` file in `MergeIDE`, we are
instructed to edit under the key `CurrentControlSet`.  Alas, we don't
see that listed, but we see numbered control sets listed, which one is
it?  Take a look under the `Select` key, this will tell you data about
which one is the "current" one.  Then, only edit the "current" one and
not the "previous" one, since the current one is meant to house
changes for next boot and the previous one has a backup known safe
configuration on last boot.  Typically, `ControlSet001` is the current
one, that's easy.

The other side of the issue, we need to extract files from CAB
archives?  Here, 7-Zip is my preferred GNU/Linux tool to perform the
extraction.  However, in my case, the files were already extracted to
the target directory, so there was nothing for me to do.

20200702/DuckDuckGo windows register determine current control set  
20200702/https://stackoverflow.com/questions/291519/how-does-currentcontrolset-differ-from-controlset001-and-controlset002#291528  
20200702/https://web.archive.org/web/20150217152952/http://support.microsoft.com/kb/100010  
20200702/DuckDuckGo linux expand cab file  
20200702/http://tuxdiary.com/2016/01/18/extract-exe-cab-files-linux/

Nevertheless, these are the commands I would have used to extract then
had it been necessary.

```
#! /bin/sh
MNTROOT=/mnt/wxp
# N.B.: On my particular Windows XP system, the drivers are already
# all extracted out.
cd $MNTROOT/WINDOWS/system32/drivers
7z x $MNTROOT/WINDOWS/Driver\ Cache/i386/driver.cab \
   atapi.sys intelide.sys pciide.sys pciidex.sys
```

Now, for the interactive shell commands that form the equivalent of
the registry changes.  I have found that I only needed to apply the
changes for the pnp, azt, and PCI devices, all of the other `atapi`
devices were already present, `gendisk` was present, and so were the
big driver definitions.  Nevertheless, I list all of the commands in
the event that none of the entries are available.  Please, before
running these commands, check carefully to see if there are any
devices already present, and do not run the commands if that is the
case... else there might be crashes or worse, who knows with the
unreliability of `chntpw`.

Alas, I do **not** show how to add the big driver definitions.

```
cd ControlSet001\Control\CriticalDeviceDatabase

nk primary_ide_channel
cd primary_ide_channel
nv 1 Service
ed Service
atapi
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk secondary_ide_channel
cd secondary_ide_channel
nv 1 Service
ed Service
atapi
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk *pnp0600
cd *pnp0600
nv 1 Service
ed Service
atapi
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk *azt0502
cd *azt0502
nv 1 Service
ed Service
atapi
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk gendisk
cd gendisk
nv 1 Service
ed Service
disk
nv 1 ClassGUID
ed ClassGUID
{4D36E967-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#cc_0101
cd pci#cc_0101
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_0e11&dev_ae33
cd pci#ven_0e11&dev_ae33
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1039&dev_0601
cd pci#ven_1039&dev_0601
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1039&dev_5513
cd pci#ven_1039&dev_5513
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1042&dev_1000
cd pci#ven_1042&dev_1000
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_105a&dev_4d33
cd pci#ven_105a&dev_4d33
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1095&dev_0640
cd pci#ven_1095&dev_0640
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1095&dev_0646
cd pci#ven_1095&dev_0646
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1095&dev_0646&REV_05
cd pci#ven_1095&dev_0646&REV_05
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1095&dev_0646&REV_07
cd pci#ven_1095&dev_0646&REV_07
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1095&dev_0648
cd pci#ven_1095&dev_0648
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1095&dev_0649
cd pci#ven_1095&dev_0649
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1097&dev_0038
cd pci#ven_1097&dev_0038
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_10ad&dev_0001
cd pci#ven_10ad&dev_0001
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_10ad&dev_0150
cd pci#ven_10ad&dev_0150
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_10b9&dev_5215
cd pci#ven_10b9&dev_5215
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_10b9&dev_5219
cd pci#ven_10b9&dev_5219
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_10b9&dev_5229
cd pci#ven_10b9&dev_5229
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_1106&dev_0571
cd pci#ven_1106&dev_0571
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_8086&dev_1222
cd pci#ven_8086&dev_1222
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_8086&dev_1230
cd pci#ven_8086&dev_1230
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_8086&dev_2411
cd pci#ven_8086&dev_2411
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_8086&dev_2421
cd pci#ven_8086&dev_2421
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_8086&dev_7010
cd pci#ven_8086&dev_7010
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_8086&dev_7111
cd pci#ven_8086&dev_7111
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..

nk pci#ven_8086&dev_7199
cd pci#ven_8086&dev_7199
nv 1 Service
ed Service
pciide
nv 1 ClassGUID
ed ClassGUID
{4D36E96A-E325-11CE-BFC1-08002BE10318}
cd ..
```

Now, what about the other mentioned changes in the VirtualBox article?
Fortunately, I'm running on QEMU and QEMU appears that it does
virtualize IO APIC, so I have no need to worry about this being an
issue causing Windows XP to refuse to start.  But, yeah if it was,
then I'd need to also do that setup.

20200702/DuckDuckGo qemu io apic  
20200702/http://terenceli.github.io/%E6%8A%80%E6%9C%AF/2018/08/29/apicv

Finally, fortunately copying from my particular physical machine
configuration and running in QEMU, I also did not have any trouble
with the AGP driver causing crashes, so I'm all set to boot at this
point!

----------

So, now that I finally have a Windows XP virtual machine in a
boot-ready configuration, the next obvious problem comes up: Windows
Product Activation, or WPA for short.  Because the machine has
undergone radical hardware changes, Windows will promptly require
re=activation upon login.  However, if you boot normally, when Windows
prompts for re-activation, it will conclude the product is already
activated and log you right out, without allowing you to do anything.
So, here's the way around that issue.

First of all, you must boot in Safe Mode.  Press F8 when booting, and
select either "Safe Mode" or "Safe Mode with Command Prompt,"
depending on whether you want Windows Explorer or nothing but a
command prompt.  Now, run this command:

```
rundll32.exe syssetup,SetupOobeBnk
```

This will totally reset Windows Product Activation so you'll end up
with a 30-day countdown timer where you must activate before then.

20200702/DuckDuckGo virtual machine this copy of windows must be
  activated before you log on  
20200702/https://answers.microsoft.com/en-us/windows/forum/windows_xp-security/this-copy-of-windows-must-be-activated-before-you/387f3367-5fc4-4aa1-937d-6788a626029d  
20200702/https://www.mysysadmintips.com/windows/clients/205-this-copy-of-windows-must-be-activated-before-you-can-log-on  
20200702/https://docs.vmware.com/en/VMware-Fusion/11/com.vmware.fusion.using.doc/GUID-50FC0AF1-AA0A-486D-89AB-4FA4C1CAA56C.html  
20200702/https://satheesh.net/2010/08/24/this-copy-of-windows-must-be-activated-before-you-can-log-on/  
20200702/https://community.spiceworks.com/how_to/3381-how-to-fix-windows-xp-activation-after-a-windows-xp-repair

However, chances are when we are living in the modern ages of post
Windows XP support, contacting an activation server or Microsoft over
the phone will simply not work.  So... we are left with no other
option than to do some slightly evil stuff: disable the Windows
product activation timer entirely.  Here's how.  Change the contents
of this registry entry to the indicated value:

```
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\WPAEvents\OOBETimer

FF D5 71 D6 8B 6A 8D 6F
D5 33 93 FD
```

In Windows... now that you're booted into Safe Mode, you can open
`regedit`, right click the "WPAEvents" folder and click on
"Permissions..."

* Under `SYSTEM`, click "Deny Full Control"

* Click "Yes" to the warning message

Now you can reboot normally, and that should completely eliminate your
Windows product activation issues.  You should now be able to go on
just like normal with your existing Windows license key being
functionally accepted as valid, exactly like the original physical
machine presented it.

Searching for more info on what people do to setup vintage Windows XP
virtual machines, there is no clear strategy around the activation
problem as Windows XP is no longer supported by Microsoft, but the
overall consensus seems to be to just sidestep the count-down on the
product activation timer.  In the past, Microsoft has touted creating
a later Windows XP patch to remove Windows Product Activation
entirely, but they never followed up fully on that promise.  At the
very least, they loosened product activation requirements in Windows
XP SP3.

20200702/DuckDuckGo windows xp virtual machine license  
20200702/https://helpdeskgeek.com/virtualization/how-to-set-up-a-windows-xp-virtual-machine-for-free/  
20200702/https://www.hardanswers.net/activate-xp-mode-vm-on-windows-10  
20200702/DuckDuckGo windows xp end of life activation  
20200702/https://answers.microsoft.com/en-us/windows/forum/windows_xp-windows_install/future-windows-xp-activation-support/8b64edf7-8146-e011-9bac-78e7d160ad4e  
20200702/DuckDuckGo microsoft windows xp end of support info  
20200702/https://www.microsoft.com/en-us/microsoft-365/windows/end-of-windows-xp-support  
20200702/https://support.microsoft.com/en-us/help/14223/windows-xp-end-of-support

Now, after all that, after "the last page of the book" of Windows XP
life has been written, let's revisit an article that I did not quite
read up enough on.  Ah, yes, from Ed Bott, on Windows 7 activation
licenses, and ways to actually crack them and work around them
entirely.  How can this be extended to Windows XP?  Well, it can't
really... as noted, historically Windows XP unauthorized duplicators
would only go so far as stealing known good license keys.  The idea of
tricking the activation system entirely without using license keys or
even contacting the activation server was a newer idea,
unfortunately... yes this didn't come until later.  Nevertheless, that
being said, there is plenty of good tech in that area if you want to
use Windows 7 in a modern virtualization environment... bear in mind
that Windows 7 Home Edition is specially developed to resist
virtualization, unlike Windows XP.

20200702/DuckDuckGo zdnet windows activation  
20200702/DuckDuckGo zdnet windows 7 activation  
20200702/DuckDuckGo zdnet confessions windows activation  
20200702/https://www.zdnet.com/article/confessions-of-a-windows-7-pirate/  
20200702/https://www.zdnet.com/blog/bott/90/  
20200702/https://www.zdnet.com/article/microsoft-to-relax-xp-activation-rules-with-sp3-6034000339/

----------

UPDATE 2021-03-06: Unfortunately this isn't well documented.  The
rundll32 command only resets the 30-day grace period, and this can
only be done 3 times.  After that, you have to snap-revert your
Windows XP VM image if you want to keep using it.  But after hard
scour searching, I've found this great bit of information.  Worth
pursuing.

Here's the variation: You leave the `WPAEvents directory writable, but
you edit `OOBETimer` so that it is a zero-length binary value.  Then
you go through the activation dialog, request telephone activation,
but then change the product key, and you can thus bypass activation
entirely.

20210306/how to install windows xp activation  
20210306/https://superuser.com/questions/1502796/how-do-i-activate-windowsxp-now-that-support-has-ended  
20210306/https://www.wikihow.com/Make-Windows-XP-Genuine-Forever

----------

Now, once you have all that Windows Product Activation stuff out of
the way, you can focus on installing drivers for all your hardware.
For the most part, this is almost exactly the same instructions I've
given for newer versions of Windows in my oVirt blog article, just
that you need to select the respective versions of the drivers for
Windows XP.

One difference to mention, sound.  Or... maybe it's just that I never
noticed when I was merely configuring Windows server instances to run
as network hosting servers in an enterprise environment.  AC'97 audio
is built straight into Windows XP, but if you want High Definition
Audio (i.e. Intel HDA, ICH6, etc.), then you need to install a driver.
Also note that one of my particular target systems, a bit older of a
Windows XP computer, has its integrated sound card more similar to
AC'97 than HDA (PCI VEN=8086, DEV=24C5, SoundMAX Integrated Digital
Audio).  Microsoft previously provided a universal HDA driver, but
they discontinued their direct download link, so you'll have to look
elsewhere to download this.

20200702/DuckDuckGo pci vendor 8086 dev 2668  
20200702/https://devid.info/en/search?text=PCI%5CVEN_8086%26DEV_2668  
20200702/https://devid.info/en/26580/Microsoft+UAA+Bus+Driver+for+High+Definition+Audio  
20200702/DuckDuckGo Microsoft UAA Bus Driver for High Definition Audio  
20200702/https://support.microsoft.com/en-us/help/888111/universal-audio-architecture-uaa-high-definition-audio-class-driver-ve  
20200702/https://drivers.softpedia.com/get/SOUND-CARD/OTHER-SOUNDCARDS/Microsoft-UAA-Bus-Driver-for-High-Definition-Audio.shtml  
20200702/DuckDuckGo qemu windows xp ich6 sound driver  
20200702/https://www.linux-kvm.org/page/Sound

And, finally, what we would be waiting for.  3D graphics?
Unfortunately, you generally won't be able to achieve that on QEMU,
nor will it work on VirtualBox.  Only software OpenGL rendering will
work, Direct3D will pretty much fail.  Fortunately, if you run under
VMware, VMware's Windows XP guest tools tool provide for 3D
acceleration if you also enable this in the virtual machine
configuration.  However, this is still going to perform slower than
you'd expect on a physical machine that is directly compatible with
the operating system.

But... apparently if you use an older version of VirtualBox, you can
get some Windows XP 3D acceleration back.

20200702/DuckDuckGo windows xp directx virtual machine virtualbox  
20200702/https://www.youtube.com/watch?v=Ck0GBCzK5mc  
20200702/https://www.reddit.com/r/virtualbox/comments/eiyjla/cant_install_direct3d_on_windows_xp_guest/

Another big bummer is that the QXL display drivers do not expose a
256-color mode, so you will not be able to play some old 256-color
games on QEMU, even when they normally work just fine on vintage
physical hardware running Windows XP.  However, interestingly
low-color depth MS-DOS software works just fine under NTVDM.
Purportedly another alternative would be to eliminate.  Also, you can
get 256-color mode back... but only in older versions of QEMU.  Set
the video card type to Cirrus and you'll be able to put the display
into 256-color mode!  Also, this provides a partial workaround that
allows some old Direct3D 5 software to work, but still lots of other
Direct3D software refuses to cooperate.

One problem consistent with both Windows XP's default VGA driver the
QXL driver, and by extension, the Cirrus driver (based off of VGA
driver), is that switching to MS-DOS full-screen text console mode is
buggy.  You'll get weird double-character print and missing character
issues.  But, there is a workaround.  I have been able to start a VGA
mode MS-DOS program like one of the DJGPP GRX demo programs, then
exit.  You'll come back to a full-screen text console, and it won't be
buggy!  Also, regardless of this workaround, MS-DOS `edit` is not
buggy in display modes.  Why does all of this happen like that?  I do
not know.

Another big bummer with video, consistent with my Windows 98 video
woes in QEMU, is that MS-DOS Doom game engine video rendering is
despicably slow, and vertical retrace synchronization is not correctly
implemented, functionally it happens at a time interval of zero.  So
this means that all software that relies of timer ticks clocked by
`vsync` will not work correctly.  For PC games relying on `vsync`
timer ticks, the vertical refresh rate should be around 60 Hz for
reasonable gameplay.

Here's a nice cumulative Windows XP updates pack put together by
hobbyists, switch on and off what you do and don't want.

20200702/https://retrosystemsrevival.blogspot.com/2019/12/unofficial-cumulative-windows-xp-update.html

Finally, another "gotcha" from my testing, though this doesn't
strictly apply to Windows XP, but rather old software developed with
oversight of new large-capacity disks.  One particular software game I
use, Orly's Draw-a-Story, will refuse to start on Windows XP for two
reasons.  First of all, it uses load-time DLL bindings to
`winspool.dll`, this can bee easily fixed by putting a dummy stub in
the directory and the software will use the alternative API path for
connecting to Windows print services.

The second issue is that sometimes, depenending on your specific disk
capacity and free space, it will complain that you need at least 5 MB
of free disk space to be able to run the software.  But you have
_gigabytes_ of free space, what gives?  Surely, this has to do with
peculiarities of using the 32-bit API function `GetDiskFreeSpace()`.
Try decreasing your disk free space by adding one or two gigabytes of
random filler data, and this shoild solve the problem, allowing you to
start up the software!
