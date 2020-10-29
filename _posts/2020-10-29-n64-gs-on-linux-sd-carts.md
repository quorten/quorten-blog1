---
layout: post
title: "N64 Gameshark Linux tools, Everdrive Nintendo cartridge SD
        card adapters, and more"
date: 2020-10-29 01:23 -0500
author: quorten
categories: [vintage-computing, raspberry-pi]
tags: [vintage-computing, raspberry-pi]
---

Gameshark... Gameshark?  Yes, the novelty of Gameshark is that it has
a parallel port interface for communicating with a PC, and although we
had no shortage of such interfaces on 1990s PCs, nowadays they are
quite hard to come by.  In my particular case, I was looking for some
interesting use cases to test my `pi-parport` board that I have built,
and a Nintendo 64 Gameshark is one of them.  The problem... can I get
the software to run on Linux?  The original software was written for
Windows, but good news, there is at least one hobbyist development
that ported it to Linux.

20201029/DuckDuckGo open source game shark nintendo 64  
20201029/https://hackaday.com/2019/01/11/nintendo-64-homebrew-via-game-shark/

So, follow the trail here.  The Hackaday article links to a modded
version designed to work with one particular model of those annoying
cheap Chinese USB parallel port interfaces.  Follow the link to the
original project that was designed for direct use with traditional PC
parallel ports.  Yep, Linux support.

20201029/https://github.com/hcs64/gs_libusb  
20201029/DuckDuckGo ppcasm gsuploader  
20201029/https://github.com/ppcasm/gsuploader

<!-- more -->

Now, note that this project might be coded up to use the memory-mapped
addresses rather than `ppdev`, so it may require some minor
modifications on that front.  Also note that it is specialized for the
purpose of uploading games through the parallel port interface to the
4 MB expansion ROM in a Nintendo 64.

----------

Well, I have to break it with you, the "vintage gaming world" has an
established standard on building SD card adapters to get games to your
old game consoles wherever cartridges, optical discs, or hard disk
drives were used.  I've covered GC Loader for GameCube, and yes there
is FloppyEmu, SCSI2SD, RaSCSI, and MacSD for classic Macintosh, Apple
II, and others!  Now, what about those Nintendo 64 game cartridges,
Gameboy cartridges, Super Nintendo, NES, and so on?  There is
Everdrive.

20201029/DuckDuckGo nintendo 64 everdrive  
20201029/https://krikzz.com/store/home/55-everdrive-64-x7.html  
20201029/https://krikzz.com/store/content/4-about-us  
20201029/https://krikzz.com/store/

Yes, I see the hardware is out there and out for sale, but is it Open
Hardware or proprietary?  My guess from the looks so far is that it is
proprietary.  It may have been Open Hardware in the past, but now they
are so focused on commercialism that idea may be been drowned out.

Okay, reading up further on article links, the general class of these
devices is called "ROM carts."  There is another one for Nintendo 64
called 64 Drive.  This one is apparently much more open than the
Everdrive.  Well, better hardware documentation, but still a
proprietary design.  And, better yet, looks like 64 Drive hardware is
designed to be upgradeable to a GameShark design!

20201029/https://www.retrorgb.com/romcarts.html  
20201029/http://64drive.retroactive.be/

Oh, and GameCube DVDs?  More information on those?  These are not
custom proprietary discs at all, they are stock DVD minidiscs.  You
can read the full data as a raw disk image using PC DVD drives with no
issue.  The only thing special about GameCube for security is that the
barcode serial number in the center ring of the disc, called the
"Burst Cutting Area" (BCA), is specially formatted for legitimate
GameCube games.  So yes, the disc manufacturer must be negotiated with
to print this, DVD-R minidiscs use a pre-printed serial number that is
invalid.  But actually, this is where things get interesting.  Even
though the GameCube stock ROM could just check this info itself, the
logic to check this for security is built into the DVD disk controller
instead, and there is a "debug mode" pin that can be used to disable
the security check.  This is the common method to allow you to run
homebrew GameCube game discs, there is a whole "mod chip" set to do
this.

Well... apparently also the laser potentiometer needs to be adjusted
to work with the weaker dyes inside DVD-R minidiscs.

Back in the day, the company that made Action Replay figured out how
to get around thte GameCube disc security: their game disc had no
serial number at all.  Rather, they wrote the contents of the serial
number barcode as part of the ISO disk image data, so they could get
the proper formatting there.  That was how they got around the disc
security check.

But, the best method I, almost, like for homebrew games?  Make a
GameCube memory card mod that accepts a MicroSD card, and use Action
Replay as your boot disk.  This seems to potentially involve the least
hardware modifications too, except for the fact that you need to buy a
type of disc that almost nobody bought back in the day and is no
longer in production.  Also, apparently disc emulation like GCLoader
is much faster.  ODE = Optical Drive Emulator.

20201029/http://www.racketboy.com/retro/how-to-burn-retro-game-images-with-all-free-software  
20201029/http://www.racketboy.com/retro/how-to-burn-retro-game-images-with-all-free-software#gcm
20201029/DuckDuckGo gamecube disc mod chip  
20201029/https://www.instructables.com/Homemade-GameCube-Mod-Chip/  
20201029/DuckDuckGo gamecube disc security  
20201029/https://hackaday.com/2019/02/04/how-one-company-cracked-the-gamecube-disc-protection/  
20201029/https://www.retrorgb.com/gamecubeode.html

Now, this is interesting, there is a Super Nintendo physical hardware
clone out and about on the market, not sure if it's Open Hardware,
that means it probably isn't.

20201029/https://www.retrorgb.com/gettingstarted.html

GameShark repair?  Typically it's just the flash memory that gets
corrupted and needs to be rewritten.  But, never fear, with the right
GameShark version, you can stack up multiple GameSharks to reflash
them all at once from the parallel port of a working one at the
bottom.  Stack a random game at top to terminate the bus.

20201029/http://micro-64.com/features/gsrepair1.shtml

The Nintendo 64 implements a blur filter on video output, interesting.
This article is also how I came to many of my other informative
articles on the Retro RGB website.  It can be removed in software with
the help of a GameShark.

20201029/https://www.retrorgb.com/n64blur.html

This is an interesting and useful website I've found with lots of
links to help you get started on homebrew Nintendo 64 game
development, or at least so I'm saying.  A great idea I saw there?
Dump Gameboy ROMs and save game data using the Transfer Pak and a
GameShark.

20201029/DuckDuckGo open source game shark nintendo 64open source game
  shark nintendo 64  
20201029/http://n64dev.org/

----------

Looking for hints of open source of the 64drive on GitHub, all signs
point to third party developers.

20201029/DuckDuckGo 64drive github  
20201029/https://github.com/rasky/g64drive  
20201029/https://github.com/tj90241/64drive  
20201029/https://github.com/buu342/N64-UNFLoader/  
20201029/https://github.com/RenaKunisaki/64drive-usb-linux

So, hey, from the looks of this, software development is clearly a
weakpoint for the original proprietors.

Random interesting GitHub repository.  A utility to translate
GameShark codes to patches for a WebAssembly translation of Super
Mario 64 that can run on your PC.

20201029/https://github.com/sm64gs2pc/sm64gs2pc
