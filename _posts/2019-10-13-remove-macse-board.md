---
layout: post
title: Info on removing Macintosh SE logic board
date: 2019-10-13 10:39 -0500
author: quorten
categories: [vintage-computing, mac-classic]
tags: [vintage-computing, mac-classic]
---

How do you remove the Macintosh SE logic board?  It's fairly simple
once you get the hang of it.

First of all, take a look at the logic board at a glance.

20191013/DuckDuckGo remove macintosh se logic board  
20191013/https://pc-restorer.com/repairing-a-macintosh-se30-with-no-sound/  
20191013/http://pc-restorer.com/wp-content/uploads/2014/02/mac-SE30-board.jpg

At the bottom of the photo is the externally visible connectors.  Note
that the internal connectors for the internal floppy disk and internal
SCSI hard drive plug right into connectors positioned right next to
the external ports, and also have similar pin counts.  (There are
twice as many pins on the internal SCSI connector compared to the
external one.)  Near the middle bottom of the board is the analog
board connector (big white one) and the sound connector to the right
side.  To the left side of the board, the big long black socket
"female" connector is that for the PDS slot, conveniently right next
to the iconic MC68000 CPU.  Also noteworthy is that the Macintosh SE
uses a SIMM slot for a removable ROM module... so that gives you the
opportunity to make your own custom ROMs with ease.

Now, to summarize the instructions on the other site.  Remove these
two internal drive connectors.  Remove the analog board connector by
depressing and unlatching the locking tab.  Now lift up the board
gently (i.e. toward the connectors side of the logic board) so that
the slots line up with the chassis, and swing it outward (right-side
first in the photo).  Now you can access the speaker cable and
disconnect that.  Now you can completely remove the logic board, with
PDS card still connected, and you can proceed to investigate what the
PDS card has to offer.

20191013/DuckDuckGo macintosh se pds slot connector  
20191013/https://lowendmac.com/2000/pds-the-processor-direct-slot/  
20191013/https://www.hardwaresecrets.com/inside-the-macintosh-se/6/

Here is some useful information about the Radius Full Page Display
(FPD).

20191013/DuckDuckGo macintosh se radius fpd  
20191013/http://32by32.com/radius-full-page-display/
