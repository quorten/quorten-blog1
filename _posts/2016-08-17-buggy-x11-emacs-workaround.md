---
layout: post
title: Working around a buggy X11 Emacs problem
author: quorten
date: 2016-08-17
categories: [misc]
tags: [misc]
---

Oh my gosh.  Now I have this particular problem with Emacs that when I
use it in daemon mode, sometimes my X11 connection to Emacs is buggy,
and in particular, sometimes when I control-click for a popup menu,
somehow I loose focus to the X window and cannot get it back, Emacs is
frozen and locked up in a loop that it thinks it can get out of but
will never get out, so what can I do?  Okay, here's my experience.
You have to open up GDB and manually jump out of the problematic code.
This will cause a segmentation violation in the offending thread.  At
this point, you probably want to restart your Emacs server, but before
you do, you can safely re-attach with `emacsclient -t` and do whatever
you want to do to wrap up and close down for a restart.  But don't use
`emacsclient -c`, because that is highly risky and may cause the
server to crash.

So what do you do in GDB?  This is what I did:

    (gdb) jump XSync
