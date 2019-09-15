---
layout: post
title: Kermit and serial communications on a Macintosh Classic
date: 2019-05-16 00:37 -0500
author: quorten
categories: [mac-classic, home-network, reiterate]
tags: [mac-classic, home-network, reiterate]
---

JJJ TODO LINK!

Recently, I've been following through on my previous notes on how to
build a serial cable to connect a Macintosh SE to a PC via a null
modem serial cable.  Indeed, the devil is in the details!  I didn't
realize the first time upon discovering those sources that the
original Macintosh didn't support full hardware handshaking, but later
ones did, and this resulted in some early software having bugs whereby
it doesn't manage the handshaking status lines.  So, that one really
threw me off with three potential decisions to make on how to wire up
a Macintosh Classic serial cable.  Oh, and the fact that there is no
easy way to wire up the much needed critical DCD signal, unlike is the
case with the Apple IIc Plus.  Initially, I planned on this scheme for
my use:

* Tie RTS & CTS together on the PC-side.
* Wire DCD to DTR on the PC-side.

But, after having worked with the serial cable for a little while and
learned a bit more about the software, I decided it makes the most
sense to wire up the cable with full hardware handshaking.  Why is
this?  Luckily, when you are controlling the other end of a serial
port via a computer, it is very easy to reconfigure how your computer
interacts with the serial interface.  You can enable and disable
hardware handshaking at your pleasing.  Got a program that is being
uncooperative with hardware handshaking wired up and enabled?  Simply
disable hardware handshaking _in software_, no need to cut wires.

<!-- more -->

So, using that plan, I resoldered the generic, definitely
non-Macintosh cable that I previously mentioned to the designated
variation of a Macintosh to PC null modem cable.  Because I am a
soldering novice, the first time through, I made the mistake of trying
to solder with some wires cut shorter than others, by quite a bit.
(More specifically, the commercially soldered wires were left at full
length.)  That was pretty hard to solder and did not work out well, so
I had to come back and redo it a second time, with the wires cut to be
closer to all the same length.  Better, but because I was lazy about
cutting the wires, I still had some length variation that made the
cable a bit less optimal, but overall I got much better results.

Finally, if you do so desire, I've devised a cable that is also an
"Apple printer cable" that can be used to connect up printers, or a
virtual printer via a PC on the other end of the null modem if you
will.  And it also is plug-compatible for use as a null modem serial
cable for the Apple IIc Plus.  I've tested it, and it also works great
there.  The main change (compared to the Apple II Disk Transfer ProDOS
specifications) is how DCD is wired, which only has an effect on the
PC-side, not the Apple computer side.  One cable design, many vintage
computer equipment supported.

<object type="image/svg+xml"
        data="{{ site.baseurl }}/blog/images/2019-05-16-mac_serial.svg"
        width="765" height="540">
  <img src="{{ site.baseurl }}/blog/images/2019-05-16-mac_serial.png"
       alt="Mac serial cable wiring diagram"
       width="765" height="540" />
</object>

Okay, so I thought that getting the cable soldered was hard, but wow,
looking more into the details on what software to install on the
Macintosh Classic side for terminal access, I had yet to see the end
of the maze.

My first choice on serial software is Kermit.  Yes, Kermit is the
software of choice if you want to perform some sort of serial
communications file transfer on an old 1980s vintage computer, which
was exactly what this is.  BUT... reading into Kermit further, I found
out that there is a considerable culture divide.  Kermit, despite
supporting a large number of different computers, was, in fact, never
really largely used by _most_ computer users. The original scope of
Kermit use was for connections between mainframe and PC
microcomputers, like that which was found at Columbia University.  Who
ever had mainframe computers, anyways?  Unilaterally, this was large
"institutions," such as universities, governments, banks, or
enterprise companies, of which there relatively few that actually had
"mainframe" computers compared to today.  (Read "mainframe" = "cloud"
of today.)  Also, relatively speaking, there were proportionally a lot
more "computer hobbyists" back then than there are today.  That is,
although the number is less than that of today, the proportion set
them as virtually the "dominant" type of computer user in the 1980s,
of which very few ever had access to a mainframe computer of the time.

So, to be more specific, the world of computer networking in the 1980s
was cleaved distinctively into two different camps: the
"institutional" camp and the "hobbyist" camp.  Each of these camps had
their own cultures, their own views, and ultimately didn't really
communicate much between each other.  So, reading into all of this, I
realize that Kermit is really outside the side of the computer world
that I am trying to target and stay close to.  That is, the
traditional 1980s hobbyist computer user.

Also, reading further into Kermit, I realize that although Kermit did
make a version for Windows called Kermit 95, apparently this never
really caught on among your typical Windows user.  How do I come to
this conclusion?  First off, the software was sold with a fee, and it
had to introduce itself by asking the question "Why would you use
Kermit 95 instead of one of the other options?"  And that's just it.
Your typical Windows user had other less expensive options that they
used every time except for those few times where they actually needed
a feature specific to Kermit 95.

Ultimately, the picture painted of networking among the hobbyist
computer is this.  In the 1980s, the dominant form of networking was
by means of Bulletin Board Systems (BBSs).  These involved setting up
PC microcomputers connected through modems, so naturally all
communication was by means of serial communications.  In the BBS
world, the dominant protocols for file transfer that emerged were
XMODEM, YMODEM, and ZMODEM.  Although Kermit was sometimes supported,
these implementations tended to be low-quality third party ones, which
caused Kermit to develop an indelible reputation of being "slow" among
those of the BBS world.  So, no Kermit file transfers if you want to
be politically correct down to the party line of the BBS world, ZMODEM
is the way to go.

Also, in case you are wondering about Apple II Kermit, yes there is
one out there, but compared to Apple Disk Transfer (ADT) ProDOS, it is
definitely much harder to setup if you are just getting started with
an Apple II, like I was when I bought my first Apple II first and
foremost for the sake of using it with ADT ProDOS.  ADT ProDOS was
definitely a timesaver for me to transfer 800K Macintosh Classic
floppy disk images to modern PCs.  (PC floppy disk hardware cannot
read 800K Apple floppy disks due to the zone recording technique they
employ to boost the capacity from the PC double-density floppy disk
limit of 720 KB to 800 KB.)  But, if you have your Apple II already
all setup, and you want to transfer individual files rather than whole
disk images, Apple II Kermit may be the way to go.

20190516/http://www.columbia.edu/kermit/mac.html  
20190516/http://www.columbia.edu/kermit/k95.html  
20190516/http://www.columbia.edu/kermit/mskermit.html  
20190516/http://www.kermitproject.org/k95sourcecode.html  
20190516/http://www.columbia.edu/kermit/appleii.html  
20190516/ftp://kermit.columbia.edu/kermit/a/apple.doc  
20190516/http://www.columbia.edu/kermit/ck90.html  
20190516/http://www.kermitproject.org/  
20190516/http://www.kermitproject.org/kermit.html  
20190516/http://www.kermitproject.org/kermit.html#controversy

The Wikipedia article on Kermit is severely out-of-date.

20190516/https://en.wikipedia.org/wiki/Kermit_%28protocol%29  
20190516/https://en.wikipedia.org/wiki/XMODEM  
20190516/https://en.wikipedia.org/wiki/ZMODEM

So, all that being said, off to looking at a Macintosh Classic ZMODEM
tool it is.  And indeed, I found some good ones... almost.  But, yes,
definitely like I was saying, these appear to have been much more
widely used at the time than was the case for Macintosh Kermit, which
never reached a full version 1.0, staying a perpetual beta.  ZTerm
looks to be the way to go, **but** it does not support Macintosh
System 6, which I happen to have installed to a hard drive of my
particular Macintosh SE as it is.  Sure, I can install Macintosh
System 7 on it, but let's save the more invasive changes until after I
figure out how to copy a full disk image of this classic Macintosh.

20190516/DuckDuckGo zmoden macintosh  
20190516/http://www.macintoshrepository.org/156-zmodem-tool  
20190516/DuckDuckGo ymodem macintosh  
20190516/https://en.wikipedia.org/wiki/ZTerm  
20190516/http://dalverson.com/zterm/  
20190516/https://en.wikipedia.org/wiki/System_7  
20190516/https://en.wikipedia.org/wiki/System_6

Kermit, by contrast, claims that it should work on all versions of Mac
OS Classic.

But, I am undeterred.  I'm still looking to see if there really is a
Macintosh Classic terminal emulator that works on System 6, one that
is more into the Macintosh hobbyist computing mindset than Kermit.

Failed search.

20190516/DuckDuckGo macintosh classic system 6 serial modem  

On the other hand, I did find this useful article on Macintosh serial
throughput.  So, are you looking for a good fastest baud rate to get
started with?  Start with 28.8 kbps.  If that works, see if you can go
up to 57.6 kbps.  To go faster, you may need to install FreePPP, which
basically removes some hard-coded operating system limits on serial
port speed.  BUT, please note, as we discuss later, that FreePPP
requires at least a 68020 processor and System 7.1, so that means no
"128k, 512k, Plus, SE, or Classic."

20190516/http://lowendmac.com/1998/macintosh-serial-throughput/  
20190516/http://www.mac.org/internet/freeppp/

In particular, running System 7 on an old Macintosh will slow down
your serial port throughput.  So, that means on ZTerm for me.  If you
get some errors at 28.8 kbps, you may need to slow down to 19.2 kbps.
If you want the full speed for the higher speeds, make sure you don't
use your floppy disk drive, hard drive, or CPU intensive software
during the transfer.  If possible and necessary, copy your files to be
transferred to a RAM drive first.

20190516/http://lowendmac.com/1999/real-world-mac-serial-throughput/

----------

Now, let's segway into another important topic to discuss, then we'll
come back to our first subject at hand.  It seems there's a relative
shortage of Macintosh networking software, why is that?  Well, when I
think about this, I want to say that most Macintosh users weren't
really concerned about connecting to the Internet.  The rason for the
shortage of software and knowledge is not so much the technical
capabilities of the machine, but the typical desires of end computer
uesrs.  My undertanding is that most early Macintosh users used the
Macintosh computer solely for WYSIWYG document editing and printing.
For that, the combination of a Apple LaserWriter laser printer
connected to an AppleTalk network to share with multiple Macintosh
computers was extremely popular.  Such a setup could easily be built
into a single shared computer lab room, not to mention that this was
_extremely_ popular.

So, now for the lowdown on AppleTalk.  The physical implementation of
AppleTalk is termed LocalTalk.  This is basically a very simple
splitter device with automatic electrical termination that is inserted
into the printer serial port of a Macintosh computer.  It creates a
single twisted-pair shared communication bus connected in a daisy
chain manner.  At the outset, this of course is only useful for local
area networks.  The addition of router and bridge equipment is needed
to scale up to Internet proportions.  As I understand it, though there
were a few early incarnations of such dedicated equipment for
AppleTalk networks, by far and large, by the time Macintosh users were
interested in connecting to the Internet, which didn't happen until a
few years later, twisted pair Ethernet was already gaining a
considerable foothold.

20190516/https://en.wikipedia.org/wiki/AppleTalk  
20190516/https://en.wikipedia.org/wiki/LocalTalk

----------

Aha!  Now we're making progress.  Comet is a terminal emulator program
designed with old black and white Macintoshes in mind.  Alas, I get
led to a broken link!  Luckily, I was able to find a copy on other
sites.

20190516/DuckDuckGo macintosh classic terminal emulator  
20190516/DuckDuckGo macintosh classic remote terminal  
20190516/http://www.macorchard.com/classic/#terminal  
broken/ftp://mirrors.aol.com/pub/info-mac/comm/inet/comet-311.hqx  
20190516/DuckDuckGo comet-311.hqx  
20190516/Google comet-311.hqx  
20190516/https://www.info-mac.org/viewtopic.php?t=5997  
20190516/https://www.applefritter.com/node/15166

Okay, but I'm still looking for more information.  Maybe there is yet
a better terminal emulation solution for classic Macintosh System 6.

20190516/DuckDuckGo macintosh classic terminal login

Oh, here we have some vague discussion on the forum of ways in which
some people connect up their classic Macintosh to modern computers,
but nothing in enough detail for me to figure out how they are doing
it.

20190516/https://forums.macrumors.com/threads/easiest-way-to-transfer-files-to-macintosh-classic.1658488/

20190516/DuckDuckGo macintosh classic serial terminal unix

Whoa, now this one is it, the big find.

First we have this great page with links out to other Macintosh
information reference pages regarding networking and Internet on the
m68k classic Macintosh.

20190516/https://www.jagshouse.com/MacClassic.html

From here, there is a rudimentary information page on getting your
Macintosh on the web with System 7 and 2.5 MB of RAM, useful but not
particularly so, given the statement about System 7 being slower than
System 6.  And, of course, the fact that 2.5 MB of RAM is quite
restrictive in terms of supported classic Macintosh models.  Software
to keep in mind: MacTCP, MacPPP, Config PPP, GifWatcher, GifConverter,
MacWeb, and Eudora.

20190516/https://web.archive.org/web/20001212061400/http://jagshouse.com/classic.html#web%20kit

Here is yet another useful page on ZTerm, again advocating that you
need at least System 7 to run it.

20190516/https://web.archive.org/web/20020108014553/http://www.pclan.calpoly.edu/User_Guides/commsuite/zterm.htm

Again, if you really have the far-end of a somewhat high-end classic
Macintosh, these are some useful tips for running the newest possible
Netscape web browser that hardware can support.

20190516/https://web.archive.org/web/20010309022422/http://www.jagshouse.com/browsingtips.html  
20190516/https://web.archive.org/web/20010309141621/http://www.jagshouse.com/browsers.html

Here is another page confirming some expected serial communication
(modem) speeds you can have with a classic Macintosh.  Again, around
19.2 kbps and 28.8 kbps.

Also note that the original Macintosh 128K does not have enough RAM to
run a TCP/IP PPP Internet connection.  But, it's good news that all
newer Macintoshes are capable of running the TCP/IP PPP stack.  That
simply gives you a lot more software to choose from for your
networking needs.

20190516/https://www.jagshouse.com/MacPlusModem.html

Ah, yes!  This is it!  The repository _ne ultra_ of classic Macintosh
tips and tricks for getting on the Internet.  This has virtually all
the information you could ever need.

20190516/https://web.archive.org/web/20000903002651/http://www.sjoki.uta.fi/~shmhav/  
20190516/https://web.archive.org/web/20000904173135if_/http://www.sjoki.uta.fi:80/~shmhav/68000.txt  
20190516/https://web.archive.org/web/20000828060013if_/http://www.sjoki.uta.fi:80/~shmhav/mac-internet-faq.txt

* System 6.0.7 is probably the fastest and best.  System 6.0.8
  includes System 7 printer drivers which are not as fast as the
  System 6 printer drivers used by System 6.0.7.  (But if you need to
  use a System 7 printer, go with System 6.0.8 for sure.)

* You **can** in fact run ZTerm 1.0.1 on System 6.  In fact, you can
  run ZTerm ("zterm-10b3.hqx" = ZTerm 1.0b3?) on a computer with only
  1 MB of RAM, so this includes the Macintosh Plus and newer.  Or,
  alternatively, the only major Macintosh models excluded are the
  Macintosh 128K, Macintosh 512K, and Macintosh 512Ke.  You are
  probably going to want to strip the fat binaries so they only
  include m68k code when running on older Macintoshes.

  Purportedly, according to a later link I note on System 6 Internet,
  ZTerm can in fact run on the Macintosh 512, though you might need to
  specifically use version 0.09 for this (???).

* Black Night is another terminal emulator.  I'm not sure if it works
  on System 6 with 1 MB of RAM like ZTerm does.  Maybe not, it is
  designed with AppleScript scriptability in mind.

  20190516/DuckDuckGo black night terminal emulator  
  20190516/DuckDuckGo black night macintosh terminal emulator  
  20190516/https://www.files32.com/Black-Night-i75818.asp  
  20190516/https://web.archive.org/web/20020220051823/http://www.kagi.com/raine/x-bn-desc.html  
  20190516/https://web.archive.org/web/20011227225254/http://www.kagi.com/raine/x-bn-vers.html

* Kermit is mentioned, of course!  Purportedly, according to the
  Macintosh Kermit documentation (mentioned earlier), Macintosh Kermit
  will work with all Macintosh System Software versions.

* Some notable TCP/IP client software: NCSA Telnet, NCSA Mosaic,
  MacLynx, MacWeb, MacWWW, Fetch (ftp client), UULite (uucoder),
  uuUndo (uudecoder).

* Public Folder 1.01 allows System 6 Macintoshes to also be file
  servers.

* Basic Black is a minimal screensaver.

* Again, I reiterate, because this is important!  Disinfectant is a
  must-have when working with downloaded software in a classic
  Macintosh environment.

* You can install support for TrueType fonts on System 6.

Here is more specific information on connecting a System 6 Macintosh
to the Internet.  The required software versions are pre-packed into
three archives that you download.

20190516/DuckDuckGo macintosh system 6 modem software  
20190516/https://www.jagshouse.com/internet_on_system_6.html

Also note that RedRyder is another great old terminal emulator for
the Macintosh.  It will work on the Macintosh 512K.

20190516/https://en.wikipedia.org/wiki/Red_Ryder_%28software%29

Please note that FreePPP requires at least a 68020 processor and
System 7.1, so that means no "128k, 512k, Plus, SE, or Classic."

20190516/https://www.jagshouse.com/internetfaq.html

Now, this is really it if you want to do things the Linux way.  Alan
Cox discussing his journey on how to get Linux running on a Macintosh
II.  Of course, because the Macintosh SE does not have an MMU, I can't
run Linux on my Macintosh... or can I?  Come on, there are Linux
variants that do not require an MMU.  Surely, I could run ELKS or
uCLinux, couldn't I?  But, the point in hand here.  Using Kermit to
transfer files to your Macintosh is definitely a good Unix-style way
of doing the file transfers, although it is not so much in the
hobbyist and BBS style of file transfer.

Also, indeed there still is good hardware information on the Linux
m68k website.

20190516/https://www.linuxjournal.com/article/2996  
20190516/DuckDuckGo ? <lost search string>  
20190516/http://www.mac.linux-m68k.org/devel/plushw.php  
20190516/http://www.mac.linux-m68k.org/status/MAC_MODEL_SE30.php  
20190516/http://www.mac.linux-m68k.org/docs/faq.php#sec-4.5  
20190516/https://en.wikipedia.org/wiki/Embeddable_Linux_Kernel_Subset  
20190516/https://en.wikipedia.org/wiki/%CE%9CClinux  

Here is more information on setting up Point-to-Point Protocol (PPP)
on your GNU/Linux server-side.  Good news, setting up PPP is pretty
easy if you have a direct serial link, just as follows.  Use these
commands on your PPP server (a.k.a. "modern modem").

```
alias ppp="exec /usr/sbin/pppd -detach"
pppd -detach lock proxyarp <local IP>:<remote IP> /dev/ttyS3 38400 &
```

Here, I am omitting `crtscts` so that we do not require hardware
handshaking.  And, surprise surprise, PPP login is quite mundane.
Literally, it is just built on top of the traditional Unix login
prompt, the client searches for the "login:" prompt string and then
uses that to automatically fill in the username and password as
provided by the GUI on the Macintosh (or Windows PC!) side.  That
being said, the HOWTO recommends after login, set your client to run a
`ppp` command alias that we've defined previously, and you're all set!

20190516/https://en.wikipedia.org/wiki/Point-to-point_protocol  
20190516/https://en.wikipedia.org/wiki/Point-to-Point_Protocol_over_Ethernet  
20190516/DuckDuckGo linux ppp howto  
20190516/http://tldp.org/HOWTO/PPP-HOWTO/  
20190516/http://tldp.org/HOWTO/PPP-HOWTO/x1577.html  
20190516/http://tldp.org/HOWTO/PPP-HOWTO/direct.html

SLIP is an older and less powerful protocol similar to PPP, sometimes
preferred due to its simplicity.

20190516/https://en.wikipedia.org/wiki/Serial_Line_Internet_Protocol

The Serial HOWTO, may contain some useful information.

20190516/http://tldp.org/HOWTO/Serial-HOWTO.html

Now, here is the lowdown on Mac OS versions and other useful software
that can be run on the oldest of Macintoshes.

* System 1-4 were not originally released with clear names.

* System 3 is the newest version that is recommended to work well on
  the Macintosh 128K.

* System 4 was distributed on 800K floppy disks, officially dropping
  support for the Macintosh 128K and 512K, although you might still be
  able to boot the Macintosh 512K into the newer operating systems by
  way of a hard disk.

* System 2 introduced AppleTalk and LaserWriter drivers.

* System 2.1 introduced support for the incompatible, proprietary
  Macintosh Hard Disk 20, and a preliminary HFS that was only
  supported in-RAM.  Therefore, Macintosh Hard Disk 20 is a good
  target for me to write custom software to support creating a backup
  image of the data from.

* System 3 officially implemented HFS, and also introduced 800K floppy
  disks, SCSI, and AppleShare.  Hence the name "Hard Disk 20SC" of
  later Macintosh hard disks.

* System 4.0 added support for Apple Desktop Bus (ADB), expansion
  slots, and the Macintosh SE in general.

* System 4.1 added features specific to the Macintosh II such as
  external color displays and the Motorola 68020 processor.

* System 5 introduced the MultiFinder.

* System 6 is a roll-up version that includes various features and
  functions of previous versions all rolled into one.

* System 7 introduced many major new features, at the expense of
  requiring a considerably more powerful minimum machine configuration
  to run on.  2.5+ MB of RAM, 32-bit clean addressing, virtual memory,
  TrueColor displays, TrueType fonts, MacTCP networking stack
  built-in, AppleScript, a persistent Trash that does not
  automatically empty itself, and so on.  It is also basically the
  last version to support the m68k family of Macintoshes.

* Mac OS 8 and Mac OS 9 transition into the PowerPC world.

* Mac OS X is the last Mac OS version to support PowerPC, with the
  transition to Intel happening during this OS version.  There are
  many versions of Mac OS X with key differences along the way, not
  worth detailing for the purposes of this discussion.

* OS X was a short-term rename of Mac OS X.

* macOS is the rename of Mac OS X designed with the iOS generation of
  operating system names and features in mind.

Now, for terminal software for the Macintosh 128K.  It's pretty tough
to run software inside the smaller and older environment, but
MacTerminal is one viable official option.  After MacTerminal became
irrelevant, ClarisWorks' terminal program provided some similar but
more modern functionality.

20190516/https://en.wikipedia.org/wiki/Classic_Mac_OS  
20190516/https://en.wikipedia.org/wiki/Hard_Disk_20  
20190516/https://en.wikipedia.org/wiki/System_6  
20190516/https://en.wikipedia.org/wiki/Macintosh_128K  
20190516/https://en.wikipedia.org/wiki/Macintosh_512K  
20190516/https://en.wikipedia.org/wiki/Macintosh_Plus  
20190516/https://en.wikipedia.org/wiki/MacTerminal  
20190516/https://en.wikipedia.org/wiki/ClarisWorks

The Internet Archive has some useful information on some of the early
Macintosh browsers, more so than Wikipedia.

20190527/DuckDuckGo MacWWW  
20190527/https://archive.org/details/macwww-evolt_browsers  
20190527/https://en.wikipedia.org/wiki/MacWWW  
20190527/DuckDuckGo MacLynx  
20190527/DuckDuckGo NCSA Mosaic System 6  
20190527/DuckDuckGo MacWeb  
20190527/https://archive.org/details/macweb-evolt_browsers

Okay, let's take a quick trip into the world of modems.  The Hayes
modems were some of the earliest and most successful modems, but they
quickly failed to modernize to higher speeds and were thus outmoded by
modems from the likes of U.S. Robotics.  Conexant was one of the last
companies to supply modems, with an emphasis on those built into PCs.

Good news about the command set for modems, it is pretty basic.  Like
a string of three plus signs "+++" with a guard pause of a one second
on each side, followed by some short string of characters for the
command.  Pretty easy to implement by means of a software emulator
running on your PC on the other side of the null modem serial
connection.

20190516/https://en.wikipedia.org/wiki/Microcom  
20190516/https://en.wikipedia.org/wiki/Hayes_Microcomputer_Products  
20190516/https://en.wikipedia.org/wiki/U.S._Robotics  
20190516/https://en.wikipedia.org/wiki/Telebit  
20190516/https://en.wikipedia.org/wiki/Conexant

----------

So, let's summarize.  What is the software of choice to pack into a
bundle, what services do those provide access to, and what is the
Macintosh compatibility range of the software?

* MacTerminal, terminal emulator, all classic Macintoshes.

* RedRyder, terminal emulator, Macintosh 512K and newer.

Definitely runs on the Macintosh Plus and newer, purportedly runs on
the Macintosh 512K, and definitely doesn't run on the Macintosh 128K.
Compatible with all System software versions:

* Macintosh Kermit, both a terminal emulator and file transfer via the
  Kermit protocol.

Definitely runs on the Macintosh Plus and newer (1 MB of RAM or more),
purportedly runs on the Macintosh 512K. and definitely doesn't run on
the Macintosh 128K.  Definitely compatible with System 6, possibly
compatible with older versions:

* ZTerm, both a terminal emulator and file transfer via the ZMODEM
  protocol.

* MacTCP, MacPPP, ConfigPPP, the must-have system software to get you
  connected to a modern TCP/IP network over a PPP serial link.

* Some notable TCP/IP client software: NCSA Telnet, Fetch (ftp client)

* Public Folder 1.01 allows System 6 Macintoshes to also be file
  servers.

* Some notable TCP/IP client software: MacWWW (no graphics)

Definitely runs on the Macintosh Plus and newer (1 MB of RAM or more),
purportedly runs on the Macintosh 512K. and definitely doesn't run on
the Macintosh 128K.  Definitely compatible with System 7, possibly
compatible with System 6:

* Some notable TCP/IP client software: NCSA Mosaic, MacLynx, MacWeb
  (external graphics), UULite (uucoder), uuUndo (uudecoder).

Requires System 7 or newer and 2.5+ MB of RAM:

* Black Night, an advanced terminal emulator that that looks to only
  work with System 7 and newer, and it probably requires 2.5 MB of
  RAM.

* FreePPP, "faster" alternative to MacPPP, but requires 68020
  processor and newer, System 7 and newer.  It's not faster if you
  can't get it running, of course.

----------

Modern style TCP/IP Internet.  On older Macintoshes without Ethernet,
this is solely by means of a "modem" as follows:

TCP/IP protocol stack -> PPP link -> serial connection -> modem ->
telephone system -> modem -> serial connection -> ISP host machine ->
PPP link -> TCP/IP protocol stack -> Internet switching and routing
network

In modern times, this connectivity diagram is simplified as follows:

TCP/IP protocol stack -> PPP link -> null modem serial connection ->
ISP host machine -> PPP link -> TCP/IP protocol stack -> Internet
switching and routing network

Furthermore, in this case, the "ISP host machine" is nothing special,
it's merely a moderm PC with both a serial port and modern network
communications attached.  It could be as simple as a Raspberry Pi.  In
fact, I would strongly recommend using such a small single-board
computer as your "moderm modem."
