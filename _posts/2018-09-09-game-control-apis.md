---
layout: post
title: "Updates on (Windows) PC game controller APIs, their future,
        and Linux support"
author: quorten
date: 2018-09-09 16:46 -0500
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, I'm wondering about that old Driver's Education software.  Now I'm
thinking this through a second time.  So, it's not using the modern
DirectInput APIs?  Surely, then, since it's worked with game port
controllers of times past, it must be somewhat similar to the parallel
port on old PCs.  For Windows XP, there exists a parallel port
emulator driver that you can use to get the same direct I/O functions
you'd normally get from a parallel port in hardware.  So, it must be
similar, then, with the game port.  Right?

Yeah, maybe, but you'll have to be searching a lot harder for such a
solution, keeping in mind that game port programming is a lot less
popular with the technically skilled people who publish on the
Internet.

Failed search.

20180909/DuckDuckGo directinput gameport usb emulation legacy

No, no, no.  You've been misguided here.  The picture is much more
bleak.  DirectInput you ask?  Well, Microsoft basically killed off all
of the sophistication and elegance that you remember from that API of
times past.  What happened?  After the Xbox sales really took off,
Microsoft basically lost interest in the diverse market of third party
gaming hardware.  Yep, all of it.  Why should they care if they can
get most of their revenue from their own Xbox hardware sales?  So, the
issue at hand here is that DirectInput has been "deprecated" in favor
of "XInput."  Unfortunately, XInput doesn't even technically match
with DirectInput!  It's not, in fact, a real replacement.  DirectInput
supported controllers without limits... in terms of buttons and analog
axes.  XInput comes with distinctive limits that suffocate the vital
air supply, the API, needed for more advanced controllers.  Basically,
Microsoft has unplugged themself from supporting the advanced PC
gaming controllers market.

<!-- more -->

20180909/https://en.wikipedia.org/wiki/DirectInput  
20190909/https://steamcommunity.com/sharedfiles/filedetails/?id=760956259  
20190909/https://answers.microsoft.com/en-us/windows/forum/windows_7-hardware/how-can-i-run-gameport/47c08363-d2e3-4e33-a77d-9fee01e9a12a

Bummer, that's a real bummer.  The big problem here is also that given
the limits, issues, lack of drivers, and lack of standardization that
plagued this market on competing operating systems, Microsoft's system
was one of the best to use for that particular purpose.  If Microsoft
is not supporting these systems anymore, who will?

Let's turn to the technical details of the game port on Wikipedia.
Indeed, it's like you were saying, early software read directly from
the game port, without an operating system to perform book-keeping
tasks.  It's not clear if that was also true with some Windows
software.  I thought for sure that Driver's Education executable
linked up with `DINPUT.DLL`, the only problem was that somehow the old
API could not be compatible with modern USB game controllers.

20180909/https://en.wikipedia.org/wiki/Game_port

Failed search.

20180909/DuckDuckGo windows legacy software gameport emulation

This one doesn't look like it's actually that useful.

20180909/http://www.liutilities.com/device-driver/creative-joystick-emulation/

Nope, still not getting anywhere on the software.  On the other hand,
I found some interesting materials on building a USB adapter for using
a Nintendo 64 game controller as a PC game controller.  In any case,
that might be helpful for me to reverse engineer my existing USB game
controllers so as to reinvent adequate drivers as needed.

20180909/https://www.zophar.net/joy.html  
20180909/https://www.zophar.net/joy/usb-converter.html  
20180909/DuckDuckGo Simon Nield N64 USB converter  
20180909/http://arcadecontrols.com/arcade_newbie_1main.php  
20180909/https://web.archive.org/web/20000111081607/http://www.users.globalnet.co.uk:80/~snandhe/usbpads.htm

Run the Windows software in DOSBOX?  That might be an idea well worth
taking, if only the software in question could run on Windows 3.1.  I
don't think that is the case, I think it requires Windows 95 at the
very least.

20180909/https://www.vogons.org/viewtopic.php?t=7618

Failed search.

20180909/DuckDuckGo windows virtual game port

Okay, last resort here.  Let's see what the state-of-the-art is on
Linux.  Well, well, I'd be surprised.  Yes, for older controllers, you
will be up for a hassle, but you could get lucky with the tools
`joystick` and `jstest-gtk` getting it to work.  However, it is the
newest controllers that have the most streamlined support.

20180909/DuckDuckGo linux usb game controller  
20180909/https://www.makeuseof.com/tag/get-game-controllers-running-linux/  
20180909/https://web.archive.org/web/20151226195720/http://www.linux.org:80/threads/joystick-and-other-game-controllers.4120

In any case, regardless of the platform, game controllers have a
long-standing problem of impending obsolescence.  Unfortunately the
only "long-term" solution is to keep buying new controllers when the
hardware and software interfaces become obsolete.  This is especially
a bummer for more expensive controllers like flight simulation
consoles and steering wheels.

----------

Okay, okay, enough of that.  I have to remind myself.  Yep,
historically driving simulation software previously was really
something back in the 1990s, and even stretching into the early 2000s,
but those times are over.  Nowadays, if you ask anyone about computers
and software coming together, they will have their mind on one thing,
and only one thing: self-driving cars!!!  When will cars drive
themselves?  You're doing software with cars?  Oh, I assume you're
running a self-driving car simulator, right?

Well, well, all that being said, what's the best libre, open-source
self-driving car simulator I can find?  Well, the options so far don't
look all that convincing, but the Quora on the subject looks pretty
good.  Pretty well written reference source on where to go next, that
seems to include everything I've found from my search results.

20180909/DuckDuckGo self driving car simulator open source  
20180909/http://opensourceforu.com/2017/01/openai-transforms-gta-v-self-driving-car-simulator/  
20180909/https://www.quora.com/What-are-the-most-active-and-complete-self-driving-car-open-source-hardware-and-software-projects

Interesting open hardware electric vehicle design here.

20180909/https://www.openmotors.co/homepage/
