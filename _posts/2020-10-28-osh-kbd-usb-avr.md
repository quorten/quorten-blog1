---
layout: post
title: "Open Hardware keyboards, USB on AVR, old dual USB PS/2 keyboard
        controller IC, group buys"
date: 2020-10-28 03:28 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Looking for Open Hardware keyboards?  Look here for a great example,
they've got some pretty nice stuff going out there with mechanical
keyboard designs!

So, a few noteworthy things are pointing out about this design.  First
of all, a large, rigid PCB is used to cover the full area of all the
keys on the keyboard, rather than only being used for the
microcontroller and relegating the lion's share of the key surface
area to be covered by a cheaper flex printed circuit with no diode
isolation for n-key rollover.  Second, the project makes use of a
standardized USB Type-C daughter-board with protective electronics,
Unified Daughterboard Project C3.  Third, the keyboard microcontroller
is AVR-based and uses a standardized keyboard controller firmware
framework called QMK, and the keyboard itself it then just defined
using some header file definitions for the pinout of the keyboard
matrix and the key scan codes.  And last but not least, I found the
forum link to the great community behind this all, this is how they
sync their communications with each other, and unfortunately there is
clearly a broken link between this community's communications and that
of the 68kMLA community.  Matter of fact, the Open Hardware design of
the case came out of asking for permission from a member of this
community.

<!-- more -->

IMPORTANT UPDATE 2020-11-05!  All of the Bakeneko 60 keyboard project
links are broken because there was a licensing issue and the author
made all the projects private.  The crux of the matter was that the
part about getting permission to use the case, well kkatano didn't
really get permission correctly.

20201027/DuckDuckGo open source keyboard github  
broken/https://kkatano.github.io/bakeneko-60/
20201105/https://web.archive.org/web/20201106054307/https://webcache.googleusercontent.com/search?q=cache%3AjyovCJb1zcQJ%3Ahttps%3A%2F%2Fgithub.com%2Fkkatano%2Fbakeneko-60+&cd=1&hl=en&ct=clnk&gl=us  
20201027/https://geekhack.org/index.php?topic=98587.50  
20201105/https://github.com/evyd13/plain60-c  
20201027/https://github.com/ai03-2725/Unified-Daughterboard  
broken/https://github.com/kkatano/bakeneko-60-pcb  
20201105/https://web.archive.org/web/20201106054928/https://webcache.googleusercontent.com/search?q=cache%3AG2qMiDScY34J%3Ahttps%3A%2F%2Fgithub.com%2Fkkatano%2Fbakeneko-60-pcb+&cd=2&hl=en&ct=clnk&gl=us  
broken/https://raw.githubusercontent.com/kkatano/bakeneko-60-pcb/master/images/bakeneko-60-pcb-top.png  
broken/https://raw.githubusercontent.com/kkatano/bakeneko-60-pcb/master/images/bakeneko-60-pcb-bottom.png  
20201027/https://github.com/qmk/qmk_firmware/tree/master/keyboards/bakeneko60  
20201027/https://github.com/qmk/qmk_firmware/tree/master/keyboards/bakeneko60  
20201027/https://docs.qmk.fm/#/

20201105/https://webcache.googleusercontent.com/search?q=cache:xZdRO0GuuboJ:https://github.com/kkatano/bakeneko-60-aluminum-case+&cd=2&hl=en&ct=clnk&gl=us  
20201105/https://webcache.googleusercontent.com/search?q=cache:jMWURBqByAAJ:https://github.com/kkatano/bakeneko-60-3dprinted-case+&cd=3&hl=en&ct=clnk&gl=us  
20201105/https://webcache.googleusercontent.com/search?q=cache:bj1Cmmv6iGIJ:https://github.com/kkatano/bakeneko-60-fr4-full-plate+&cd=2&hl=en&ct=clnk&gl=us

Yes, these are some nice USB libraries for AVR microcontrollers!  The
first one is designed as a driver for AVR cores with hardware USB
functions, the second is a pure firmware (software) implementation.

20201027/https://github.com/qmk/lufa/tree/ce10f7642b0459e409839b23cc91498945119b4d  
20201027/https://github.com/qmk/v-usb/tree/bdb53e4c043d089279d9891b68bea77614cb97ee  
20201027/https://www.obdev.at/products/vusb/index.html

Does QMF support PS/2 output?  Apparently not, not without some
hacking of your own.  For the most part, it is designed exclusively
for USB-connected keyboards.

20201027/DuckDuckGo qmk ps/2  
20201027/https://www.reddit.com/r/olkb/comments/i2qsgi/qmk_ps2_output_support/

Mentioned in that discussion is this useful dual USB and PS/2 keyboard
controller.

20201027/http://www.farnell.com/datasheets/79209.pdf

Okay, then I'm not going to even be asking about ADB support.

The plate, you talk about?  What's that?  Oh wow, this is a great
article about the plate from Keyboard University, what?  Now that's a
thing too?  Yes, sponsored by a custom keyboard group sales broker
company.

20201027/DuckDuckGo keyboard plate  
20201027/https://keyboard.university/200-courses/plate-materials-sizes  
20201027/https://keyboard.university/  
20201027/https://thekey.company/

Now, what is the story behind the term "group buy"?  Here, it's on
Wikipedia, it's an very common in China and other Asian countries but
it has never really been popular in Western cultures.  Relatively
recently, it started to grow in popularity, mainly through specialized
use in physical goods manufacturing.

20201027/DuckDuckGo group buy  
20201027/https://en.wikipedia.org/wiki/Group_buying

----------

UPDATE 2020-11-05: Here is the inner scoop on the licensing problems
with Bakeneko 60.

20201105/https://geekhack.org/index.php?topic=107316.0  
20201105/https://geekhack.org/index.php?topic=107316.msg2975513#msg2975513

It's also not uncommon for others to go around in the mechanical
keyboard community having licensing issues, like this example.

20201105/http://www.40percent.club/p/license-violators.html

For the time being, I'd recommend looking at the list of open-source
mechanical keyboards instead of the particular Bakeneko 60 project.

https://github.com/BenRoe/awesome-mechanical-keyboard  
https://github.com/BenRoe/awesome-mechanical-keyboard/blob/master/docs/README.md
