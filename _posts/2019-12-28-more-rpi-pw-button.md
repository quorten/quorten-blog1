---
layout: post
title: "More discussion on Raspberry Pi power button, suspend to disk,
        suspend to RAM"
date: 2019-12-28 17:17 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Whoo!  Setting up a Raspberry Pi as a full replacement for a desktop
PC is quite a challenge, even when you're competing against a 10+ year
old desktop PC.  Let's discuss one small but important subject in
particular, the power button.

On all PCs manufactured since the year 2000, there is a dedicated
microcontroller board that is pretty much responsible for all of the
power management in a PC.  When you push the power button, that is not
merely an electrical switch, but it is a sensor input to that
processing logic.  In particular, the following functions are
provided:

* When the PC is powered off, pushing the power button switches the PC
  on.

* On some boards, if the PC lost power from a power outage, the
  control board will automatically power on the PC when power is
  restored.

* When you push the power button when the PC is powered on, an ACPI
  shutdown "push button" event will be sent to the operating system,
  which can then process it in software however it pleases.

* When you push and hold down the power button for three seconds, then
  a "force shutdown" is performed instead: the microcontroller
  immediately cuts power to the PC without waiting for the operating
  system software to finish its processing.

<!-- more -->

* When the PC is in the suspend to RAM power state, pushing the power
  button wakes the CPU.

Now, that's a lot of complex features and functions for a power button
to provide.  The primary thing that adds to the complexity is the
ability to support more than one power state.  Speaking of which, does
Raspberry Pi support suspend to RAM?  That is a very useful power
state to have if you are using the Raspberry Pi like you would use a
PC or laptop.  Unfortunately, it does not.

On the other hand, in the midst of this discussion is mention of the
PowerBlock.  Ah, yes, this is what I was talking about.  If you want
more complex and complete power management functions on your Raspberry
Pi, the PowerBlock is one way to go.  Alas, it is quite a bit more
primitive than the ideals I've mentioned in my previous description,
but nevertheless, it was one of the historic approaches used by
Raspberry Pi users.

20191228/DuckDuckGo raspberry pi suspend to ram  
20191228/https://raspberrypi.stackexchange.com/questions/9267/how-to-make-raspberry-pi-suspend-to-ram  
20191228/https://github.com/raspberrypi/linux/issues/1281  
20191228/https://www.reddit.com/r/raspberry_pi/comments/6zifib/is_there_a_raspberry_pi_class_computer_with/  
20191228/DuckDuckGo raspberry pi powerblock  
20191228/https://blog.petrockblock.com/2015/07/04/powerblock-another-power-switch-for-the-raspberry-pi/

The software Raspberry Pi power button by wiring GPIO 3 to GND is by
far the easiest to setup, but it is decidedly incomplete: as soon as
your Raspberry Pi gets power, it powers on immediately.  And, you
cannot press and hold the button to force a shutdown.

On the other hand, you can take a few more steps using simple circuits
to enhance the basic software power button.  By using a simple 555
timer circuit, you can setup the power button so that if you push and
hold it for three seconds, then you send a RUN signal that resets the
Raspberry Pi.  Yeah, I know, not quite like a force shutdown, but
pretty close.  At least it kicks the system out of a hanging state if
it gets stuck in one.

Now, from my previous discussion, there is still yet another option:
suspend to disk.  This is purportedly easier to implement without
special hardware support, right?

20191231/https://raspberrypi.stackexchange.com/questions/33723/how-to-achieve-low-power-consumption-on-raspberry-pi-via-software-and-hardware-c  
20191231/https://www.reddit.com/r/raspberry_pi/comments/50324h/standbysleephibernation_mode/

Alas, amongst this discussion, looks like yet another missing feature
from Raspberry Pi is the ability to disable cores that are not in use,
like is done on Android phones.

Why does the answer to every single question have to be no?!

Okay, okay, but looks like there's good hope for hibernate if you have
your system configured correctly.  Alas, stock Raspbian appears not to
be.

20191231/DuckDuckGo raspberry pi hibernate  
20191231/https://www.raspberrypi.org/forums/viewtopic.php?p=83849  
20191231/https://raspberrypi.stackexchange.com/questions/104221/how-to-hibernate-suspend-rapberry-pi  
20191231/DuckDuckGo failed to hibernate system via logind: sleep verb
  not supported  
20191231/https://bbs.archlinux.org/viewtopic.php?id=233037  
20191231/https://askubuntu.com/questions/1174872/how-to-enable-systemctl-hibernate-without-turning-off-secureboot  
20191231/https://askubuntu.com/questions/868208/how-to-activate-hibernation-in-16-04-1-systemd

Okay, okay, this is all very unhelpful, but apparently Secure Boot is
one of the things that can interfere with the ability to hibernate.
Now that could just as well be also related to issues with the
Raspberry Pi's bespoke bootloader.  Oh, dang it, hibernate would be
one of those really useful features for Raspberry Pi if you want a
truly portable computer.

Looks like there is still very much a long road ahead to get true
Raspberry Pi desktop and laptop computers.
