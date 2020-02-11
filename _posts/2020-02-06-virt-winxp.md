---
layout: post
title: Migrate a Windows XP physical machine to a virtual machine
date: 2020-02-06 21:54 -0600
author: quorten
categories: [windows]
tags: [windows]
---

Running Windows XP on modern virtual machines is easier than doing
likewise with Windows 98, so surely migrating an existing physical
Windows XP machine to a virtual machine should also be easier, right?
Wrong, surprisingly it's actually harder!

So, what's the problem?  At boot, you get a blue screen of death
error: stop 0x0000007b (INACCESSIBLE_BOOT_DEVICE).  This indicates
that Windows XP is unable to access the hard drive because of a driver
error.

So, here's the problem.  Windows XP hard-codes the IDE disk controller
name into the disk driver during boot, and if that changes, like
during a migration to a virtual machine, Windows XP will fail the
check and refuse to boot.  Luckily, there are ways to relax the
stringentness of the checking so that it will be flexible enough to
boot under a new hardware platform.

The other issue is that you've got to be careful about changing
aspects of ACPI availability, IO APIC, and so on.  There is a specific
HAL driver configured for a particular machine, and again if this
changes, Windows XP will refuse to boot.

The VirtualBox article provides a good overview of the overall
process.

<!-- more -->

20200106/DuckDuckGo windows xp qemu stop 0x0000007b  
20200106/https://support.microsoft.com/en-us/help/324103/advanced-troubleshooting-for-stop-error-code-0x0000007b-inaccessible-b  
20200106/DuckDuckGo migrate windows xp to virtual machine  
20200106/https://www.virtualbox.org/wiki/Migrate_Windows

But, now the question is, how do you change the Windows registry of
another machine without booting into it?  The registry editor in
Windows XP and up allows you to load a hive from an external file for
editing, so you can mount the disk and use a different copy of Windows
to make the changes.  But how do you make changes without using
Windows at all?  There is the `chntpw` tool that allows you to edit
Windows registry files from the command line, and it is also possible
to use Python libraries to make similar edits.

On the proprietary software side of affairs, still another clever way
to do this is to use a "Mini Windows XP" bootable CD.  And another way
is to use a Debian-based "PCregedit" disk that has a proprietary GTK+
GUI tool for changing the Windows registry.  Alas, the website of the
freeware tool is long gone, only available on the Internet Archive
Wayback Machine, so don't even bother asking about where the source
code is for the live CD.

20200106/DuckDuckGo windows regedit second disk  
20200106/https://jchornsey.wordpress.com/2015/03/11/accessing-another-windows-computers-registry-from-a-disk-in-windows-8-1/  
20200106/https://www.raymond.cc/blog/how-to-edit-windows-registry-key-values-without-booting-in-windows/  
20200106/DuckDuckGo mini windows xp  
20200106/https://us.informatiweb.net/tutorials/it/1-articles/60--hiren-boot-cd-mini-windows-xp.html  
20200106/DuckDuckGo linux edit windows registry  
20200106/https://mashtips.com/how-to-edit-the-windows-registry-using-ubuntu/  
20200106/DuckDuckGo pc regedit live cd  
20200106/https://lifehacker.com/fix-the-windows-registry-from-a-linux-thumb-drive-5584762  
20200106/https://www.ultimatebootcd.com/forums/viewtopic.php?p=6928  
20200106/https://web.archive.org/web/20100108194412/http://www.pcregedit.com/
