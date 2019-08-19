---
layout: post
title: Front panel control switch discussion, and TV Typewriter
date: 2019-06-14 22:10 -0500
author: quorten
categories: [unlipic, computer-history, tour-de-force]
tags: [unlipic, computer-history, tour-de-force]
---

There's more than one way to build a front panel control switch.  A
front panel control switch is one level up in sophistication above the
absolute lowest layer, a patch panel used to wire together functional
units or define memory tables, like was done on the ENIAC.

The oldest way to design a front panel control switch is to use a
series of switches and lights to set both the address and data, or
view the data contents at a particular address.  Slightly better is to
provide a means to auto-increment memory addresses.

<!-- more -->

The COMSAC ELF was a particularly influential example of a front panel
control switch within the reach of the hobbyist computer space.
Previously,, these front panel control switches were only seen on
large and expensive mainframe or minicomputers that were well beyond
the reach of an individual person's financial means.

20190614/https://en.wikipedia.org/wiki/COSMAC_ELF

The COMSAC ELF's front panel control switch was designed as follows:

* LOAD, enable or disable progam/data load mode.  When program load
  mode is disabled, the current address is set to zero.
* Input (IN), increment the current address
* Memory Protect (MP), enable/disable memory modification
* RUN, initiate the CPU to run your program
* Data toggle switch 0
* Data toggle switch 1
* Data toggle switch 2
* Data toggle switch 3
* Data toggle switch 4
* Data toggle switch 5
* Data toggle switch 6
* Data toggle switch 7

Note that the Altair 8800 also uses a similar front panel control
switch.  The IMSAI 8080, by contrast, does use a more ergonomic
design.

20190615/https://en.wikipedia.org/wiki/Altair_8800  
20190615/https://upload.wikimedia.org/wikipedia/commons/0/03/Altair_8800_at_the_Computer_History_Museum%2C_cropped.jpg  
20190615/https://en.wikipedia.org/wiki/IMSAI_8080  
20190615/https://upload.wikimedia.org/wikipedia/commons/3/35/IMSAI_8080-IMG_1477.jpg

Now, let me pitch in my own ideas after looking at some of the
previous designs and thinking about this.  First of all, the COMSAC
ELF uses 12 switches for its input methodology.  But, come on!  You
could just as well do the same with a 16-key matrix keyboard with
10-digit keypad, plus provide for a better user interface.  Indeed, a
hexidecimal keypad was provided as an expansion.

Okay, but here's my idea, inspired by the Comptometor keyboard.
Rather than providing separate keys for hexidecimal A through F, you
could just use a sequence of two decimal keys added together to
compute the hexidecimal value, and it is rather straightforward.  9-1
corresponds to A, 9-2 corresponds to B, and so on.  And for simple
decimal digits, you simply key in 5-0 or the like.  You enter a
sequence of such digits to fill out an entire data or address, and the
input cursor wraps around so you can overwrite your old input in case
of a mistake.  Then, of course, you can display the values on a
standard 7-segment digital display.

Now, we add the additional control buttons as follows.

* Toggle view/set address mode versus view/set data mode (A)
* Previous address (<)
* Next address (>)
* RUN

In total, this is 14 switches.  Also, my design calls for a
multiplexed 4-digit 7-segment LED display with a few indicator LEDs.
Slightly more complex for sure, but I think the enhanced expressive
power and user experience is worth it, plus it can still be built
using relatively simple discrete digital logic electronics modules,
before you delve into writing complex logic that demands running on a
full-featured CPU.

----------

Speaking of early computer input interfaces, let's also revisit the TV
Typewriter, which was also purportedly interfaced with the COMSAC ELF.
So, how does it work?

* Keyboard: Matrix scan design with circuitry to convert to ASCII
  codes.

* Video screen control: Shift register memory with all TTL logic
  modules for control.  No microprocessor or RAM is used.  Character
  data must be in some sort of ROM, with TTL logic for address
  computation.

* Serial communications came on an additional module that was not
  included in the base design.

* More features included cassette tape data recording interface, hard
  copy, and internal modems.

20190614/https://en.wikipedia.org/wiki/TV_Typewriter  
20190614/https://upload.wikimedia.org/wikipedia/commons/6/66/SWTPC_Keyboard.jpg

In the early days of microcomputers, the TV Typewriter was a great way
to get a higher level interface to your microcomputer.  However, it
does require more support logic such as a basic "monitor" program that
would need to be entered into your microcomputer via the front panel
control switch.  But the point is, we're still talking about hardware
that can be wired up by hand... or assembled using relatively
primitive machinery (i.e., assembling the character PROMs).

* Footnote: Please note: Early terminals like the TV typewriter do not
  have brackets and braces characters, so writing C code with them is
  rather difficult.  The least esoteric way is to substitute braces
  with `begin` and `end` keywords.  What about brackets?  BASIC uses
  parentheses instead, but that is already taken in C.  Technically,
  you can program in the C language with pointer arithmetic in place
  of brackets.  My best suggestion is to define a macro `BK(var, idx)`
  that amounts to using brackets by means of pointer arithmetic.  On
  more modern computers, this can be automatically substituted with
  the more modern syntax.  In general, when special characters are
  missing, I would recommend using macro syntax instead.

  All C characters that have digraphs or trigraphs: # \ ^ [ ] { } ~

Again, I reiterate, because this is important!  So, the gameplan for
early computer development is as I have been previously stating it.

* First you need your most basic switching components, and a whole lot
  of them.  You put them in an array and connect them up to a patch
  panel.

* Then, at your patch panel, you wire your switching components
  together to create a CPU.

* You also need a whole lot of random-access memory (RAM).  The most
  naive way to go about this is to multiply the patch panel concept
  for developing memory modules.  It works, but it is pretty expensive
  and maybe not the prettiest way to do it.  You could use a concept
  more similar to printed circuit boards since you will need to
  replicate the same design so many times.

* Now you need to build your front panel control switch logic.  This
  is explicitly simple and can be easily built by hand from basic
  switching components, input switches, indicator displays, and maybe
  also 7-segment digital displays.

* Since you're going to want a nice video display terminal, you're
  going to need to wire that "TV Typewrite" up, with serial
  communications.  You can do it all by hand with discrete logic.  The
  character memory might not be pretty an initial implementation, but
  you can get something working.

* You also need a television set.  That can again be built all from
  discrete circuitry, with the vacuum tube for the CRT display being
  the most specialized component.  But, again, that can be built using
  relatively simple and crude industrial manufacturing processes and
  tools.

* You also need to wire up a serial communications peripheral for your
  computer so that you can connect with the TV Typewriter.  That is
  pretty easy to wire up, of course.

* At the end of your hard work that will be coming next, you need an
  efficient way to persistently store a lot of data in a
  machine-readable format.  Build your persistent storage interface
  and connect it up to your computer.

* Now you can connect your TV Typewriter to your computer.

* The first thing you need to do is power on your RAM, but keep the
  CPU halted.  Now you enter in your initial program via the front
  panel control switch.  Your initial program, of course, is a
  "monitor" program that interacts with your TV Typewriter so that you
  can have a nice keyboard interface for interacting with memory,
  rather than needing to use the front panel control switch.

* After you run your program, you can now relax and enter your more
  complex program via the more comfortable TV Typewriter interface.
  Here, your first order of business is to write a byte code
  interpreter, so that further programming can efficiently take place
  in a higher level byte code that doesn't consume as much RAM.

* After your byte code interpreter is written, your next order of
  business is to implement a high-level language text editor and
  compiler, with interactive execution.  Traditionally, the most
  popular such language was BASIC, but nowadays you might want to do
  something more C-like, as your ultimate destination is the Unix
  operating system.  However, for early development, you will want
  some BLOAD and BSAVE commands so you can easily resume later.

* Okay, okay, so far so good.  We're at a great point now to save our
  work to our persistent disk storage.  Switch back to your monitor
  program and start writing a simple bootloader in machine code.
  Ideally, make sure there is some magic number in the first sector
  that can be recognized as marking the medium as bootable, but if you
  don't do this, you can compromise later.  The sole purpose of this
  code is to fetch blocks up to the a specified size limit from your
  disk.storage and store them in RAM.  A more sophisticated disk
  operating system will need to be developed later.  Now, use your
  fancy BSAVE command you've wrote at the higher level to store all
  that precious code you've written up in RAM to your disk.

* Now with all your work saved, you can power off.

* Now time to make hardware modifications so that your system can boot
  from disk.  You need to build a pre-boot state machine for this sort
  of thing to work with the architecture I've laid out thus far.  Upon
  the press of a new "boot" you bring to your front panel control
  switch, the pre-boot state machine requests connected devices to
  check for a bootable sector.  If they return affirmative, then the
  pre-boot state machine copies the boot sector into the system RAM,
  then initiates the CPU.

  Option B is more applicable for a later generation of computers,
  once you have better software development tools at hand.  A boot
  firmware ROM chip is placed at the initial address of the
  microprocessor execution that executes this procedure.  The fallback
  that allows the front panel control switch to function is that the
  front panel control switch issues a small program that checks the
  status of the front panel control switch to determine if the CPU
  should HALT or if it should RUN.  The RUN switch on the front panel
  control switch is then renamed to RESET.

* Now you can boot from disk.  Congratulations!  You've got yourself
  bootstrapped into a reasonably sophisticated early software
  development environment.  At this point, your first order of
  business, as previously mentioned, is to write a disk operating
  system so you can start working with significantly more data rich
  software development.  The disk operating system is simply a series
  of software subroutines that is loaded into RAM and persists for the
  sake of being used by other resident software.  In essence, it is a
  highly simplified operating system kernel with only one purpose: to
  provide convenient access to a filesystem on disk.  Therefore, you
  can simply extend your existing spartan bootloader to also load
  these routines into RAM on boot.

* Now you have to reinvent some of your software tooling to be
  designed in line with your disk operating system.  At minimum, you
  need a binary editor, a text editor, a compiler, and a shell.  These
  early programs can be entered, compiled, and tested in RAM, then
  transferred to your disk filesystem by writing some simple utility
  programs to make direct calls to your disk operating system
  routines.

  Or, I should put it this way.  First you write the binary editor,
  and the binary editor has the special feature of "loading a file
  from RAM."  Then, your binary editor can "save as a disk file."
  Tada!  You've got yourself an easy way to transfer programs compiled
  in RAM to disk.  The binary editor itself is the first order of
  business.  At this point, for this rewrite, you also want to start
  saving source code to disk too.  A similar trick can be done
  likewise in your binary editor to save source code to disk.

  Once you've got all of your binary editor, text editor, compiler,
  and shell written, you can modify your boot routine so that your
  disk operating system can run your shell on boot.  How do you do
  this?  First of all, let's review our boot process as-is.  We load
  code from disk, then we continue executing at the memory address
  immediately following our boot code.  In this case, that is
  currently the monitor program.  From the monitor program, we've
  needed to manually call into our high-level language runtime in
  order to keep going up to the higher levels.  So, the point here is
  that now our disk operating system needs an entry point of its own
  where it has executable boot code, rather than just being a library
  of routines.  So we write this routine so that checks the disk for
  the special file disk boot program (i.e. named `init`,
  `autoexec.bat`, `command.com`, `System`, or the like), and if found,
  it runs that program.  Otherwise, it returns to whatever called it,
  which may mean we fall back into either the monitor program or the
  high-level language runtime.

  So actually, we can go backwards and make some modifications to our
  early boot software as follows.  The monitor program checks if there
  is a high-level language runtime available (magic number), and if
  so, it calls it.  The high-level language runtime checks if there is
  a disk operating system available, and if so, it calls it.  Then the
  disk operating system checks if there is a boot program available,
  and if so, it runs it.  In this case, we end up running the shell,
  which gives visibility into the filesystem contents and, most
  importantly, the ability to run other programs that do useful things
  like edit text files and compile additional programs.

  So now we have a bit of a dilemma.  We want to make this
  modification to our earlier developed software, but is there an easy
  way to do it?  Surely, if we had the source code on our disk
  operating system, it would be an easy fix, right?  But now we need
  to make some changes to low-level software, the monitor program, and
  we don't have a low-level machine assembler.  Surely the code
  changes would be easier with such software available, so we need
  multiple architecture assemblers too, right?

  Okay, okay, fine, so we need more tools for the rewrites involved.
  Yep, first we write an native assembler.  Then we rewrite the
  monitor program in assembly language source code, ans assemble that
  to get the object code.  We do likewise with the byte code
  interpreter, and the early high-level language runtime.  Now we can
  easily make the needed modifications to do the boot continuation
  checks.  We have it stored as files on disk.  Now we need to the
  tricky thing: we need to rebuild the early portions of the
  bootloader on disk, potentially rebuilding the filesystem.  Ut oh...

* Save our work now and shut down.  Now we will attach another disk
  unit to make our life so much easier.  Turn on, boot up, and enter
  your disk operating system.

* Now we need to build out software tools for initializing a bootable
  disk and filesystem from our disk operating system.

* Once you have those tools, initialize your new disk as bootable,
  with your newly improved boot code.  Then copy over all your
  filesystem files.  Shut down, swap the disks so your new disk is
  booted from in preference to the old one, and reboot.  Tada!  You've
  just shown you can replicate a bootable disk from within your disk
  operating system.  Now you could make many copies of your software
  to give to other colleagues if only you could have just as many
  computers.  Alas, the computer system you were working on was the
  product of tedious manual labor.

* That being said, your next order of business is to get to work on
  computer manufacturing automation and mass production tools.  Heck,
  at this point, we might as well write software for photolithography
  to avoid needing to do too much automatic wire wrap machinery and
  the like.

  Suffice it to say, this means you do need the graphics software core
  to generate photolithographic masks and a means to control some kind
  of printing equipment for them too.  Probably the first chips you'll
  print is more RAM for your own development sake, before you move on
  to CPUs and the like.  For the sake of modernity, you will also
  develop a framebuffer for your graphics operations.

* Okay, so now you have a mass production line for computers up and
  running.  You are mass producing the hardware and the necessary
  software to run a disk operating system.  All is well with many
  colleagues using their own computers and writing much new software.
  No, not quite!  How does everyone keep everyone else in sync with
  their new software?  Ah, yes, people were just exchanging computer
  disks to get each other started.  But surely, you can do better than
  that.  For the very basic beginners, you can add more serial port
  hardware, create a modem, and connect the computers up over the
  telephone network.  But who built this telephone network?  Can we
  really assume it to just simply exist?

  Well, don't worry.  In case it doesn't exist, the concept scales
  reasonably well to analog direct telephone lines without a switching
  station, and if it really needs be, you can use your fancy computers
  to build a new switching station at this point.

* At this point in time, you can take the initiative to do the boot
  firmware ROM redesign that I mentioned previously, now that you've
  got a steady line of computer production running and a clear toolset
  for computerized development of computers themselves.

* After many years of geekery in technology development, the computer
  hardware advances rapidly, graphical user interfaces are developed,
  computers are miniaturized, and now they're ready to make their
  first foray into the non-technical computer user market.  In the
  process of preparing for non-technical users, language
  internationalization and localization features and functions also
  need to be developed.  This is no longer a geek affair, computers
  must be able to communicate with people in their familiar and
  preferred languages, not the other way around.

* Well, not quite.  We have these graphical user interface computers
  up and running, but not yet with any software.  Next follows a long
  period of developing progressively more software for the graphical
  user interface computers.  Slowly the following software is
  developed: raster painting, word processing, terminal emulators,
  diagramming software, spreadsheet software, photo touching software,
  presentation software, email clients, web browsers, and many games.

* Now I'll just leave the rest of the progression to my summary list
  that I cover next.

In summary, this is the interface stack progression that was
described:

1. Front panel control switch
2. Video display terminal
3. Serial communications
4. Persistent disk storage
5. "Monitor" program
6. Byte code interpreter
7. High-level language, with compiler, interactive interpreter, BLOAD,
   and BSAVE
8. Bootloader
9. Pre-boot state machine
10. Disk operating system
11. DOS binary editor, text editor, compiler, shell, assembler
12. Disk initialization, filesystem formating, and bootable disk
    building tools
13. Graphics core library, framebuffer
14. Electronic design automation
15. Modem file transfer tools
16. Boot firmware ROM redesign
17. Expanded computer capacities, graphical user interface library,
    internationalization, localization
18. GUI software application development: raster painting, word
    processing, terminal emulators, diagramming software, spreadsheet
    software, photo touching software, presentation software, email
    clients, web browsers, and many games
19. Expanded computer capacities, full operating system kernel, audio
    and video playback software, audio recording software, 3D graphics
20. Greatly expanded computer capacities
21. Plug and play USB webcam support
22. Video conferencing software
23. Miniaturization of all computer functions into smartphone form
    factor
