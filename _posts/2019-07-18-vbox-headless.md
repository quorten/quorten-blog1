---
layout: post
title: VirtualBox does allow you to hide the VM GUI
date: 2019-07-18 16:34 -0500
author: quorten
categories: [misc]
tags: [misc]
---

Wow, VirtualBox does have a GUI option to detach so that you can
operate in "headless" mode without the virtual machine GUI window
present on your desktop, but it came about with a hide-and-seek game
of GUI reorganization.

20190718/DuckDuckGo virtualbox hide window daemon vm  
20190718/https://www.virtualbox.org/ticket/2597

20190718/DuckDuckGo virtualbox start vm daemon no gui

Beware!  You MUST start a VM as headless via the command line or else
you will not get the "detach GUI" option in the GUI.

```
VBoxManage startvm --type headless <name>
```
