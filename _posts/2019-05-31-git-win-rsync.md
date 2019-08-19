---
layout: post
title: Trouble with Git for Windows, Rsync, and MSYS
date: 2019-05-31 22:51 -0500
author: quorten
categories: [git, windows]
tags: [git, windows]
---

So, recently, I had the ordeal of setting up Git for Windows, Rsync on
Windows, **and** Ruby on Windows on a Windows 10 computer.  Why?
Obviously, if you know me, this was **not** for my own agenda, so
clearly it was because I was doing work on someone else's behalf, and
due mainly in part to corporate bureaucracy in IT device management
and the relative costs of the different supported IT device
configurations, this is what happened to be supported and selected for
me.  Macs were available, but too expensive for a contractor, so okay,
we're going with a Windows computer, and heck no Linux-based standard
corporate system configuration is supported here, unfortunately.

So, I'm playing along with this system setup.  Okay, sure, this
problem again.  We have these Unix developers who are dispassionate
about supporting Windows, so they just slop together a ton of Unix
dependencies ported to Windows in some poster-titled software package
with the intent of **only** getting that one software package working,
to the ignorance of all others included within.  But, I'm thinking.
Gosh, if Git for Windows includes MSYS within it, and I need Rsync
too, why can't I just do an install of Rsync inside that Git for
Windows MSYS environment?  Well, well, that is where you run amok onto
territorial wars and some very heavy code-writing but not very
collaborative developer working on Git for Windows, who by the way is
employed by Microsoft.

<!-- more -->

So, how did this whole mess get started?  First of all, Git for
Windows was originally named Git for MSYS, but allegedly, the main Git
for Windows user didn't know what MSYS was and honestly didn't care,
so a rename was a necessity.  Within that process, a fork of MSYS was
made to fix some miscellaneous problems to get some things working for
Git for Windows.  Then they tried to merge those changes back to MSYS,
but, here we have the not very collaborative developer involved in the
loop, who decides to give up and declare Git for Windows a perpetual
fork.  It doesn't stop here.  Over the course of development of Git
for Windows, we have yet more people coming on requesting various
common missed features like a package manager and Rsync that once was
previously part of Git for Windows, and here we have this somewhat
controversial developer to partially sympathize with them, while also
rebutting them off for their incorrectness and misunderstanding to the
ideals of the Git for Windows project.

So, anyways, here I am with a list of quirks and workarounds that must
be employed.  Honestly, at the end of the day, we have to admit that
it is much the Windows porting developers' own fault for making things
much harder for the end users, and they didn't have to do things that
way, but they chose to do so.  And this just seems to keep happening
with every single Windows port of Unix software, over and over again
and again.  Why does it have to be that way?  At the end of the day, I
think the by far and large agreement on the subject is that the
typical such Windows developer of Unix ports is dispassionate about
their project.  They are only in it for some bureaucratic reason that
they'd rather not have to be involved with, and this extends to the
way in which they work with the software.

20190531/DuckDuckGo git for windows msys rsync  
20190531/https://blog.tiger-workshop.com/add-rsync-to-git-bash-for-windows/  
20190531/https://groups.google.com/forum/#!topic/git-for-windows/p4DWwAV_aJ0  
20190531/https://github.com/git-for-windows/build-extra/pull/131  
20190531/https://github.com/git-for-windows/git/issues/1912  
20190531/https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper  
20190531/https://github.com/git-for-windows/git/issues/284  
20190531/https://github.com/msys2/MSYS2-packages/pull/786  
20190531/http://github.com/git-for-windows/git/wiki/The-difference-between-MINGW-and-MSYS

And, my reaction of what `dscho` says in pull requests?  Why doesn't
this `dscho` person ever contribute to documentation?
