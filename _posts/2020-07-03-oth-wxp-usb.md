---
layout: post
title: "Other things you can do with a Windows XP VM, and connecting
        physical USB devices to Windows XP"
date: 2020-07-03 17:46 -0500
author: quorten
categories: [windows]
tags: [windows]
---

So, since gaming on a Windows XP virtual machine is pretty much doomed
due to the difficulty of getting proper the video modes and 3D
acceleration, what useful things can you do with a Windows XP virtual
machine?  I'll list a few clearly obvious ones from my experience.

* Put together some Microsoft office documents, like a slide show, a
  spreadsheet, or a short letter/article/essay.  Write them to virtual
  USB memory sticks, or burn them to a virtual CD so that you can put
  them in your virtual pocket to take with you to present at school,
  in the office, etc.  Maybe you even end up printing a hard copy of
  some of your papers.  Nostalgia about the 2000s era of office
  productivity software.

* Browse through a photo collection on Windows XP, nostalgia about the
  old world of many people's first experience with digital photography
  and digital cameras.

* Listen to music from a music collection on Windows XP, use Windows
  XP to organize a music collection, within the limits that fit on the
  computer.  Burn virtual music CDs from your own collection.

* Watch DVDs through Windows XP (via disk images, of course),
  nostalgia about the old world where for many people, their new
  computer was their first DVD player in their home.  Doesn't work
  with copy-protected works, of course.

<!-- more -->

* Run old versions of proprietary digital image manipulation software
  like Paint Shop Pro 8, Adobe Photoshop, and so on.

* Perform vintage software development activities right in your
  Windows XP virtual machine.  Look at the MSDN library installed
  entirely on your hard drive, a tremendous convenience over CD-ROM
  access or slow dialup Internet access, work in your favorite IDE,
  compile software natively for Windows XP within Windows XP itself.

Now, burning virtual CDs... that requires proper drivers and
hypervisor support.  But, we're not finished yet.  The very last idea
we need to introduce, and given the limits of what can be done with a
Windows XP virtual machine, arguably the most important.  Access
physical vintage USB devices through your virtual machine, devices for
which only Windows XP drivers were ever developed and can therefore
not be accessed through any other platform.  All of QEMU, VirtualBox,
and VMware have excellent USB device pass-through support.  And,
incidentally, there are very many old USB devices that will only work
on Windows XP.  After all, USB didn't really become popular in the PC
world until the advent of Windows XP.

----------

So, now as I've learned, it's never enough just to write a blog
article saying something is possible... with vintage virtualization,
you have to actually try it, since often times it turns out that
things aren't actually possible.

So, what was my USB device test case?  I chose a rather rigorous test
case, but at the same time one that I had an important and real need
behind to perform: connect a camcorder via USB to a Windows XP PC.
Why?  There was one particular DVD-R disc recorded on the camcorder
that "finalized" (that is, the UDF filesystem was written to
officially point to all the video fragments recorded by the camcorder
onto the write-once medium) before it filled to 100% capacity, and the
DVD camcorder handled the spare sectors by just leaving them totally
unformatted rather than formatting them as blanks.  This causes PC DVD
drives to slow down and continuously attempt to do an error-correcting
read on those sectors, and this slowdown was severe enough to make it
impractical for me to try to copy a disc image directly from a PC
optical disc drive.

The thing about this particular camcorder was that I could not get it
to work on Linux, despite its USB mass storage device class and
optical disc drive classification.  Apparently this isn't fully
compatible with the standard interface.  What happens when I try to do
a `dd` on Linux is that `dd` just locks up, waiting, blocked on file
open, until I disconnect the device.  So, looks like the only way I
can access this camcorder is through the Windows XP drivers, and I'm
assuming, just to be on the safe side, that these drivers will only
ever work on Windows XP.

So, I try this whole USB device redirection thing out in my pristine
virtualized copy of a physical Windows XP machine, and the result?
It... almost, works.  First of all, there are some very long time
delays, over 60 seconds, when I connect first click to redirect the
USB device, and there were a few times when my `virt-manager` client
crashed entirely.  But, after enough patience and persistence, I got
the device connected and visible to the virtual Windows XP machine.
Meanwhile, Linux is showing a ton of USB device resets in the `dmesg`
kernel log.  And, finally, when the device is connected to the guest
machine okay, even my first accesses to the device are wrought with
horrible time delays, more than 60 seconds.  But after all that
trashing with time delays, it is clear that the logical interface to
access the camcorder DVD drive over USB is working just fine.

So, why just toy around with this setup when I can do some real work?
Let's start by playing a DVD video from the camcorder optical disc
drive.  This is as simple as pointing any DVD player in Windows XP at
the camcorder's optical disc drive, of which they were ubiquitous in
operating systems at the time of the 2000s.  Nowadays, as of 2020,
you'd be lucky to find a DVD player installed by default on a modern
operating system.  Heck, most modern computer hardware isn't even sold
with an optical disc drive.

But, all of that aside, the result?  Despicable, to say the least, but
it somewhat works.  Once video playback starts, the video seems to run
smoothly, but then I periodically get some serious stalls, jitter, and
blocking artifacts.  I suspected this was because of artificial delays
inserted by the virtualization process, and I confirmed this by
playing back the exact same setup on the corresponding physical
machine and observed no issues whatsoever.  Thus I can be confident
that the source media of the optical disc was without any data errors,
all of the apparent disc read errors were introduced by the inability
of the virtualization process to keep I/O within near-realtime
deadlines.

So, the whole USB device connection thing, it's one one of those "your
mileage may vary" kind of things.  What really matters that will give
you a somewhat decent experience is that you aren't connecting
particularly sophisticated USB devices.  Anything with does not
require isochronous, near-realtime communications will perform better
than anything that does.  And, anything that requires only a low
bandwidth connection will perform better than anything that requires a
high bandwidth connection, like DVD/MPEG-2 video streaming.

----------

Okay, okay, again, it's not enough to say that in theory, it should be
possible to virtually burn virtual CDs.  How do you do it in practice?
First  of  all, searching  around,  indeed  I  do  have to  agree  the
situation here was as abysmal as I thought it was.  The QEMU community
has no  useful information  on the subject,  but searching  around the
VirtualBox community, I do find some mentions.

Here is the answer.  Most users who have tried had never got optical
disc burning to work by enabling optical disc drive pass-through,
apparently the recordable media extension commands are not passed
through.  So, don't even ask about doing likewise to generate a
virtual optical disc image.  However, on the subject of generating
physical optical discs, a USB attached CD drive reader/burner works
quite well.

20200704/DuckDuckGo qemu virtual optical disc write record  
20200704/DuckDuckGo qemu write to optical disc  
20200704/DuckDuckGo virtualbox cd-rw  
20200704/https://forums.virtualbox.org/viewtopic.php?t=7893

Well, that's a real bummer, it is just like I thought.  If you want to
use any hardware device of reasonable sophistication on a virtual
machine, pretty much the first thing you must do is to try to find or
create an equivalent USB device to use in conjunction with your
virtual machine.  Because, after all, USB at the lowest level is a
dead simple protocol, this fully allows for all the implementation
complexity to be on the two ends of the connection but nothing special
is needed in between, unlike PCI, ISA, SCSI, ATAPI, ATA, SATA, PS/2,
serial ports, parallel ports, game port, MIDI ports, IrDA infrared
port, floppy disk drives, PC speaker, Apple Desktop Bus, and pretty
much anything else that is considered a primary hardware interface on
a PC, or even Macintosh computer for that matter.  Audio input/output
is the sole exception, of which hypervisors typically fail to provide
input virtualization but they will at least provide audio output as
standard.  If you're unlucky, even audio output is not provided.

Also, by being able to fully encapsulate your hardware from the
hypervisor, you can completely sidestep the politics of hypervisor
software development where there is constant pressure to strip out
every feature and function that is not directly related to running an
Ethernet-connected service inside a datacenter.  And, a fully abstract
service at that, one that only pushes around bits between memory
storage devices with no need to ever come in concept with physical,
real-world sensing or manipulation.

How do you create a virtual USB device?  Now that's a bit tough...
worst comes to worst, you can use a physical embedded computer board
with USB on-the-go/gadgets capability like Raspberry Pi Zero and
program it from there.  Otherwise, conditions better permitting, you
can write the virtual USB software running directly on the host
computer and connecting to the hypervisor via a special software
interface.  Unfortunately, I can't vouch for the practicality of the
virtual USB interface for hypervisors, as far as my failed web
searches go, I have to conclude that all the politics are against this
approach.

Failed search.

20200704/DuckDuckGo write a virtual usb device virtualbox
