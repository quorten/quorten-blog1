---
layout: post
title: Evolution of text editors for programmers and multiple cursors
author: quorten
date: 2018-09-21 11:10 -0500
categories: [tour-de-force]
tags: [tour-de-force]
---

Evolution of text editors for programmers.

* 1940s: Computers are highly experimental such as the ENIAC.
  Programming is not thought of in the form of text editing, but in
  the form of wiring modules together.  Yes, the idea of computer
  programs as text is not even in the picture at this point.  This is
  even so despite the fact that some early computers used "paper tape"
  for their programs.

* 1950s: EDSAC (1949), UNIVAC I and other very early mainframe
  computer systems are commercially introduced.  Text editing on these
  systems involves a multistage process.  (1) Writing down notes on
  paper.  (2) Writing more formal program code into a coding form.
  (3) Type that coding form into a key punch or magnetic tape
  typewriter to produce machine-readable input.

  The most viable form of text editing is rearranging a deck of
  punched cards to rearrange lines of program code, and retype lines
  that need to be edited.

* 1960s: Minicomputers are introduced.  In practice, the main feature
  these systems provide over mainframes of times past are
  _timesharing_ rather than batch processing.  The programmer's text
  editing experience becomes smarter at this point, mainly focusing
  around paper-printing teletypes connected to a minicomputer.  Hence,
  text editing software is largely line-based: you print and edit a
  few lines at a time, without being able to constantly see a whole
  screenful of text.

  Some programmers prefer to write down their edit commands on a
  source code printout, then type the editor directives into the
  computer at a later time, all at once, rather than work
  interactively on the computer.  (Why?  Surely it would have been
  cost motivated, given the high fees of early timesharing.)

<!-- more -->

* 1970s: Timesharing systems mature with the introduction and rapid
  rise in popularity of Unix.  Smarter video display terminals become
  available.  The more advanced ones have local text load and save
  capabilities onto magnetic tape media.  Therefore, editing whole
  screenfuls of text becomes more popular.

* 1979: The introduction Apple II computer and other very early home
  microcomputers presents a compelling new opportunity in text
  editing.  The prices of the lowest terminals that can edit save text
  locally have just gotten lower.

* 1981: Improved floppy disk drive technology for low-cost home
  microcomputers ups their game in competitiveness with the larger,
  more featureful, and more expensive minicomputer systems.  Even
  without any other hardware features, being able to edit and save
  larger volumes of text locally is a considerable value proposition
  in its own right.

  The advent of low-cost home microcomputers being out and about for a
  little while also meant that the user interface of visual text
  editors became a little bit better.

* 1984: The introduction of the Macintosh computer results in using a
  mouse for text editing becoming wildly popular across all computer
  platforms.  At this point in time, the user interface of software
  also became much improved and easier to use.

* 1985 - 1990: Hard disk drives drop in price dramatically and become
  widespread in computers.  As a consequence, it becomes possible to
  store programmer's reference documentation in the computer and
  search it from the programmer's text editor.  This becomes very
  popular.

* 1990 - 1995: Color graphics become widespread on PCs, leading to the
  widespread use of colored syntax highlighting in programmer's text
  editors.

* 1995 - 2000: Microsoft Visual C++ 6.0 is introduced with
  "Intellisense" or code helpers, smart code completion and context
  capabilities.  Again, keep in mind that in many respects, Microsoft
  Visual C++ was the "second" of its kind: true there were a few that
  came before it, but it was the main one that became wildly popular
  during this time era.

* 2000s: More new programmer's text editors keep getting introduced
  and created, mainly building off of newer base component
  technologies, but otherwise are no better than those that came
  before them feature-wise.

* 2010s: Almost the same story, but "Multiple carets" introduced in
  Sublime Text become popular in Visual Studio Code.  "Multiple
  carets" are basically just a different user interface for search and
  replace.  In practice, this was never used before because this user
  interface design doesn't work very well on smaller screens where you
  cannot see all instances of the text being replaced simultaneously.

  Larger, higher resolution screens for computers become widespread
  and available.

  Monitors, at 4K and 8K resolutions, have almost reached the limits
  of human visual perception, so there isn't much room left for
  programmer's text editors to advance, hardware-wise.  Software-wise,
  we've kind of reached the limits of how much intelligence we know
  users will want in their editors.  Too much and the risk of false
  predictions becomes too high.  Too little and there is too much room
  for manual human errors.  In practice, non-programmer's text editors
  have much stronger predictive powers as not only is the text easier
  to learn and predict, but the risk that errors cause is also much
  lower, given the result is typically read in an informal context
  rather than being read by a machine under the interpretation of a
  strictly formal grammar.

  Programming languages themselves have evolved to stick to relatively
  formal grammars.  Less formal grammar languages have emerged, but
  the verdict among programmers is that they dislike these excess
  informalities.

* The possibility of using a text editor via an audio interface.
  Despite the improvement of text-to-speech and speech-to-text
  software, it hasn't happened.  Only became popular among visually
  impaired people.  Purportedly, the need to otherwise wear a "voice
  mask" when working in an office environment to prevent speech
  interference and noise is the main impediment to this becoming more
  popular.

* 3D in text editors?

As you can see, this timeline follows a variable-pace path.  The 1980s
and 1990s experienced a ton of progress really quickly, then things
slowed down after the year 2000.  Yes, computers were still getting
more advanced for important applications not related to programmer's
text editing such as digital photography and digital video, it's just
that none of these advances had compelling feature improvements
pertinent to the field of programmer's text editors.

----------

Okay, all of that said.  If you use an older editor such as `vim` or
`emacs`, how do you look cool and show off multiple cursors too?

For Emacs, there is `iedit` (an older solution that I learned of many
years back but haven't really tried), and there is `multiple-cursors`.

20180921/DuckDuckGo emacs multiple cursors  
20180921/https://github.com/magnars/multiple-cursors.el  
20180921/http://emacsrocks.com/e13.html

> Of course, there are lots of other ways to accomplish tasks like the
> above (e.g. using macros or regular expressions in query-replace, or
> using iedit), many of which we will look at in the future, but I
> like multiple cursors as a nice visual way of making these sorts of
> edits.

20180921/http://pragmaticemacs.com/emacs/multiple-cursors/  
20180921/DuckDuckGo emacs iedit  
20180921/https://www.emacswiki.org/emacs/Iedit

For `vim`, there is a plugin named `vim-multiple-cursors`.  Alas,
apparently it is not well maintained, the current builds are failing,
and it has quite a number of bugs that have been noted by earlier
users.  Plus, typical `vim` users appear to be less eager to adopt
this than typical Emcas users.

20180921/DuckDuckGo vim multiple cursors  
20180921/https://github.com/terryma/vim-multiple-cursors  
20180921/https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db

So you're wondering.  What is the purpose of multiple cursors,
exactly?  There's nothing that multiple cursors can't do that couldn't
already have been done by previous techniques, as evidenced by the
quote from the Emacs article.  So, searching around, indeed some
commentary from Reddit confirms my suspicions.

> Yes, you can do same manipulations with macro-record, dot and so on,
> but multiple cursors are easier and more comfortable to use in some
> cases - you see result on multi places immediately, and can correct
> mistakes fast - it is more "ad-hoc" mechanism. Macros have their own
> advantages, and I would prefer to have both mechanisms and use one
> which fits best for particular task.

20180921/https://www.reddit.com/r/vim/comments/5babba/multiple_cursors_in_vim_quick_demo/

So, for me to summarize.  Why have multiple cursors?  If you have a
large, high resolution monitor, so that all instances of the text you
want to edit fit on screen, then multiple cursors works well.
Otherwise, traditional search and replace works better.  Of course,
that being said, the reason why simultaneous editing didn't become
popular until relatively recently was because earlier computer
displays couldn't display as large of a page of text simultaneously,
so it would have been moot from a visual feedback standpoint in the
earlier days of computing compared to interactive search and replace.

Finally, what does Wikipedia have to say on the subject?  It has a
really short article on this.

20180921/https://en.wikipedia.org/wiki/Simultaneous_editing  
20180921/https://en.wikipedia.org/wiki/Data_wrangling
