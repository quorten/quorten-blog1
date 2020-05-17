---
layout: post
title: "Important info and lessons learned from the black and white
        Macintosh family"
date: 2017-12-02 21:00 -0600
author: quorten
categories: [mac-classic, important]
tags: [mac-classic, important]
---

Important!  Some very interesting things about the Black and White
Macintosh family:

* QuickDraw is one of the first drawing routine libraries to use
  region clipping.

* QuickDraw used custom microcode of the MC68000 microprocessor to
  achieve its speed.

* The Computer History Museum interview contained lots of explanations
  about particular shortcomings in the decisions made in the early
  Macintosh user interface.  Some of them were made solely for a world
  where very few people actually had experience using a computer
  graphical user interface.  Others had long since become artifacts of
  widespread graphical user interfaces despite their suboptimalities.

    * Scroll bar at the right?  That was for the sake of the placement
      of the sizing box, to avoid accidentally clicking the window
      iconify button.

* The menus were originally located at the top of windows, but then
  relocated to the top of the screen for the Macintosh.  This was seen
  as advantageous given the small screen size.  Yes, for larger
  screens, menus attached to the windows does make more sense.

    * In order to use use with this setup, pointer acceleration was
      also implemented in the Macintosh.

<!-- more -->

* Changing the cursor to the current tool in MacPaint was of course
  viewed as essential given the modal nature of the program, which
  only made sense for its use case.

* Photo scanning for digital photos was done very early on with the
  Apple II as an enthusiast effort.

** Bill Atkinson's wife always wondered why he wanted to take a
   perfectly nice photo and create a not-so-nice-looking approximation
   of it.  For a very long time, he had no answer to this question.
   But now, with the ubiquity of digital photography, the answer is
   obvious.  Because it was the future of photogrpahy, digital
   photography.

Yes, indeed X11 didn't come onto the scene until well after the
Macintosh was already released.  Even X1 didn't come on until
afterward.  The Lisa and Macintosh projects were already well in
development before the X Windowing System even started development.
Not to mention they were much more beautiful in design and usable for
inexperienced computer users.

Other interesting questions answered.

* Why was the Macintosh programmed in Pascal?  Pascal was basically
  the first reasonably high-level programming system for the Apple II.
  Variable scoping, that was the most important advantage over the
  Integer/Applesoft BASIC.  So that's why.  All the work in porting to
  the 6502 was already done by UCSD, only the BIOS needed to be
  written to glue that programming platform into the Apple II.  The
  earliest Macintosh software was cross developed.  First the Lisa was
  cross developed from an Apple II, then the Macintosh was
  cross-developed from the Lisa.

20171202/DuckDuckGo macpaint quickdraw source code donald knuth  
20171202/http://computerhistory.org/atchm/macpaint-and-quickdraw-source-code/  
20171202/http://www.computerhistory.org/collections/catalog/102658007

So where is the video interview?  I'd like to see those select photos.
It must be around somewhere, just not linked directly from the
transcript landing page.

This is the backstory behind getting the source code publicly
released.  Importantly, the technical work on getting the source code
to modern computers was all quickly finished in the year 2004, the
same year that there was the 20th anniversary celebration where Donald
Knuth was in attendance and requested the MacPaint/Quickdraw source
code, but in order to get through legal at Apple, they had to
dilly-dally around for 6 years until finally Andy Hertzfeld met
personally with Apple CEO Steve Jobs, and the request then went
through almost immediately.

20200517/https://www.macworld.com/article/1152817/macpaint.html

20171202/https://en.wikipedia.org/wiki/X_Window_System  
20171202/https://www.folklore.org/  
20171202/https://www.folklore.org/StoryView.py?project=Macintosh&story=I%27ll_Be_Your_Best_Friend.txt&sortOrder=Sort+by+Date  
20171202/https://www.folklore.org/StoryView.py?project=Macintosh&story=Well_See_About_That.txt&sortOrder=Sort+by+Date  
20171202/https://www.folklore.org/StoryView.py?project=Macintosh&story=Scrooge_McDuck.txt&sortOrder=Sort+by+Date  
20171202/https://www.folklore.org/StoryView.py?project=Macintosh&story=Moustache.txt&sortOrder=Sort+by+Date  
20171202/https://www.folklore.org/StoryView.py?project=Macintosh&story=Good_Earth.txt&sortOrder=Sort+by+Date
