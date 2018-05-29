---
layout: post
title: Categories of software/user interfaces in modern computing
author: quorten
date: 2018-05-25 13:35 -0500
categories: [tour-de-force, reiterate]
tags: [tour-de-force, reiterate]
---

* UART serial communications
* Command-line based user interface
* Login managers
    * An unchanging implement now on modern desktop computing.
      Optional for single user systems, but even for kiosks, a "login
      screen" is used to display messages such as terms of service
      before the user may use the system.  Also, to make sure the next
      guest user has a clean slate to start from, and confidential
      information doesn't leak from the previous user.
* Terminal user interface, i.e. two-dimensional smart video display
  terminal
* Pseudo-terminals and terminal multiplexing, i.e. Emacs, GNU Screen,
  tmux.
* Bitmapped raster graphics screen
* Window Manager
    * Only rectangular windows need to be supported!  Overlapping and
      transparency can be used to give an illusion for non-rectangular
      shapes.

* Widget library
* Themes/styles

<!-- more -->

* Footnote: Now you have just enough technology to build a web
  browser.  Do that, and the rest of application software can be
  supported through there.  Even users accounts are supported via that
  means!

    * Screen locking?  It can be done via web apps, or the user can
      assign a custom temporary password for the duration of the login
      session to use for the screen lock.

* Otherwise, you have your standard suite of local software all
  programmed together in an integrated manner to support a single look
  and feel.

First category.  "Standard basic OS software suite."  Only very basic
software is permitted!  More complex and advanced painting is
verboten.  Alternatively, this software can be excluded entirely from
a computer system, as it is seldom used by the common modern office
worker.

* Terminal, command-line
* File manager
* Control panel

* Footnote: The text terminal has become permanently fixated in the
  world of IT system administration and software development.  Its
  foothold is impossible to dethrone, irrespective of previous
  attempts to obsolesce it.  In practice, those who did not want to
  use terminals had entirely different desires out of software use,
  not remotely similar to those of the terminal users.  Hence,
  entirely different software platforms formed.  Namely, that of
  "office" and "communication" software.

* Text editor
* Drawing/painting software
* Photo viewer
* PDF document viewer
* Camera control and photographing
* Audio/video playback
* Audio/video recording
* Simple games

* Footnote: Many of these are vestiges of early personal computing,
  the early days of the Macintosh and Windows, when computers were
  "fun" and not so business-oriented.  Matter of fact, none of these
  applications are neccessary for a "business-oriented setup."  A
  "business-oriented setup" only uses applications that were specially
  installed by the IT system administrators, and generally encompass
  the body of highly complex or specialized software.  Literally,
  popularity is the business driving force here, although we do have
  some means of predicting which classes and categories of software
  will tend to be popular among businesses.

    * Yes, yes, I have to accept this fact, make it clear to myself
      and understand it.  Popularity is a huge driving force in
      software use adoption.  Because of this, software upgrades are
      sometimes just necessary for fashion and cultural reasons, not
      technical reasons.  This is where things get problematic, if the
      platform such software is designed for is difficult to make
      available via a libre software implementation.

        * I should also emphasize that "adoption" is the key here.
          Popularity together with adoption of an existing symbolic
          interface.

Second category.  "Standard office suite."  Very complex software of
these categories are required.  Also, as a consequence of the high
complexity required and the fact that most people are very stubborn
when it comes to learning new things, this software is heavily driven
by popularity trends.  Users will only want to use it if it is
something highly compatible with the popular ones.

* Footnote: The problem of complexity is solved only through
  /popularity/.  When the system is simple, it is easy to learn and
  use on its own regardless of its popularity merits.  On the other
  hand, complex systems are only adopted in so far as they conform
  with the current trends in popularity.

  This is by far the main reason why complex libre software has not
  reached much progress on the "consumer level" it is never exactly
  conformant with the consumer popularity trends.  On the other hand,
  libre software has established the main inroads for software
  development and network communications architectures.

* Word processor
* Spreadsheet software
* Presentation software

* E-mail software
* Web browser

Third category.  "Standard communication suite."  Moderate complexity
is permitted, but ease of use is paramount.

* Voice & video chat or conference software
* Text messaging

* Footnote: Suffice it to say, text, pointing/drawing, video, and
  audio are the main communication modes of modern computer users.

* However, a smartphone is generally impractical for drawing pictures,
  which is generally only done on a tablet, laptop, or desktop
  computer.

Each conceptual layer has uncertainties in the symbolic interface.
Therefore, there is a need to "impedence-match" the interface between
the hardware and the software.  However, this is generally not a
solvable problem.  The problem can be minimized, however, through the
use of /popularity/ on both ends: a single abstraction system that
supports a wide array of hardware and is used by a large array of
software.  What are those?

* RS-232
* VGA analog video connector, DVI, HDMI, DisplayPort
* PS/2 connectors, USB
* ASCII, UTF-8 Unicode
* Unix curses
    * Previous attempts to introduce a newer MS-DOS and Windows
      terminal have all but fallen by the wayside, disreputable in
      terms of application popularity.
* ??? terminal multiplexers, anything similar to GNU Screen
* SVGALib, X11, XFree86, X.org, QuickDraw, Windows GDI
* ??? For desktops and laptops, window managers similar to those of
  the classic Macintosh and Windows 95.  For tablets and smartphones,
  window managers similar to that of iOS and Android.

    * For desktops and laptops, an overlapping window manager is the
      way to go.  There actually isn't any clear winner in technical
      implementation for smartphones, other than the general idea of
      some single active window approach with some support for
      switching.  Tablets tend to borrow from smartphones, but
      overlapping windows can work on tablets too.

And that's where we end up veering off into increasing uncertainty.
As you could see, we started reaching a limit on window managers, and
could only way what interfaces are "similar" to what is common and
popular.  Ultimately, the interfaces much closer to humans are much
less precise, software, and mushier.

But, something to deliberately exclude from the list: emulators and
virtual machines.  Why?  Because the common office user only does
common office tasks, and they only want to do so in the most
convenient manner.  The most popular applications will get reinvented
in the most convenient manner on the newer technology, and these other
things are only for super-techies.

So, what do you do if you can't support the "most complex"
applications demanded?  Simply exclude them.  However, the one that
you absolutely cannot short-change the user on is the web browser.
This must support full complexity and must not be excluded, as it is
where all the other excluded applications are offloaded to and
accessed from.

Everything else not included in the list is a "specialized
application."

Some software is very common in practical use but only on systems
managed by professional IT.  These are servers, virtual machines, and
"container hosts," for example.

* But this is the problem that I personally always complain about.
  Why must it be this way?  Why don't people want to move that special
  IT stuff to be closer to where they are?  Why do they want some
  single central mega-corporate powers to do everything for them?

* Again, I reiterate, because this is important!  Software like the
  stock market.  Trying to choose the biggest platforms in hopes of
  combatting uncertainty.  And ultimately many decisions are arbitrary
  and "cultural."
