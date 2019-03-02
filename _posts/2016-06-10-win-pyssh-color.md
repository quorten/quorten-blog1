---
layout: post
title: Windows Python SSH client, color in the Windows Python console
date: 2016-06-10 21:13 -0500
author: quorten
categories: [python, windows]
tags: [python, windows]
---

Hate windows all you want.  What is the easiest way to setup SSH on
Windows?  Well, there's PuTTY.  But what about through Python?

20160610/https://wiki.python.org/moin/SecureShell  
20160610/http://stackoverflow.com/questions/17228943/python-interactive-ssh-client-using-paramiko

I guess, you know the way Windows is, that downloading files from web
pages isn't all that hard.  Of course, that is really the only builtin
behavior that is guaranteed on Windows systems.  ftp?  Sometimes that
is available, sometimes not.  So, those are your options for getting
data onto a Windows computer to begin with.

Okay, finally!  I found it!  It's in the Paramiko source code
repository.  Demos.  Of course.  I just needed to look a little bit
harder.  Wow, sometimes it really surprises me that ta sub-par results
comes out on top in Google search results, but I should have known
better.  You have been forewarned.

20160610/http://stackoverflow.com/questions/373639/running-interactive-commands-in-paramiko  
20160610/https://github.com/paramiko/paramiko/tree/master/demos  
20160610/https://github.com/paramiko/paramiko/blob/master/demos/interactive.py

Okay, so it works.  Just run `demo_simple.py', but don't forget to do
data.decode('utf-8') before writes in `interactive.py'!  Yes, yes, the
demo code wasn't quite ported to Python 3.

Oh yeah, there's another caveat.  ANSI escape sequences don't get
translated inside of your NT command shell.

<!-- more -->

20160610/https://en.wikipedia.org/wiki/ANSI.SYS

Is it not possible to do the translation from the NT command shell?

Yes, as far as Python programs are concerned.  There are two
solutions, the second of which, `colorama', is the preferred solution.
And yes, you'll conveniently find it in your Python package manager.

20160610/http://www.kierdugan.com/2013/02/27/simple-emulation-of-vt100-colour-codes-in-python-on-windows/  
20160610/http://stackoverflow.com/questions/12492810/python-how-can-i-make-the-ansi-escape-codes-to-work-also-in-windows  
20160610/https://pypi.python.org/pypi/colorama

```
import colorama
colorama.init()
```
