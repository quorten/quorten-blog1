---
layout: post
title: Apple II monitor as a modern application
author: quorten
date: 2018-06-02 11:52 -0500
categories: [unlipic]
tags: [unlipic]
---

Okay, so this is an interesting thing to think about.  The Apple II
monitor program is a great "application" of its own in many ways.  Why
not implement it as a standalone "application" on modern platforms?
Well, come to think about it, the Apple II monitor isn't unique in its
own.  MS-DOS `debug` provides a very similar concept, but implemented
in a "more modern" manner and with some nice new features, like
assembling from user input.  Plus, it probably had a larger historic
user base, so searching for modern Linux-like alternatives to it may
be easier.

Okay, so let's do exactly that.  On first sights, it seems that people
are recommending GDB for this purpuse, but upon closer inspection
of GDB, it unfortunately doesn't appear to have the feature of assembling
from user input.  So, it's like as good as the Apple II monitor, but
not as good as MS-DOS `debug`.

<!-- more -->

Interestingly, this particular program says the language is "Chinese",
but given that the source code is written in assembly language and
there is so little natural language text in the actual program, it
really doesn't make any interface difference to the user.  The only
Chinese in the code bundle is in the README.  (The README is encoded
in `chinese-big5`, so you need to translate it to UTF-8 to make it
generally readable, then you can use Google Translate to translate it
to English.)  Also, unfortunately, this SourceForge project doesn't
use the "Files" functionality correctly, and the source code is stuck
in old read-only CVS.  Modification dates?  It comes from the year
2005.

20180602/DuckDuckGo unix equivalen ms-dos debug  
20180602/https://www.linuxquestions.org/questions/linux-software-2/equivalent-tool-for-dos-debug-in-linux-645468/  
20180602/DuckDuckGo gdb assemble like ms-dos debug  
20180602/https://sourceforge.net/projects/linux-debug/
