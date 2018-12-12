---
layout: post
title: Caveats with URL access under Python
author: quorten
date: 2018-11-03 18:00 -0500
categories: [python]
tags: [python]
---

Suppose you have a huge file that you only wnat to download a few
parts of it in Python, parse it around like a tar file, and then
process the rest as you please, seeking as needs be the case.
Unfortunately, I recon that there are no libraries to do this in
Python.  Well, at least I could find any.  If you want to do this
processing in Python, your only choice is to download the file whole,
process it, and continue.  This is especially annoying if your sole
destination is to just upload it to another server Failing that, maybe
there are some Linux FUSE libraries to make a remote file appear as if
it is a local file on the filesystem level, eh?  Yeah, that sounds
plausible, unfortunately I couldn't find any sane such libraries for
read-only access.  Much of the attention given those search terms and
concepts seems to be around WebDAV, which we know never became popular
enough to be worthy of being considered in practice.

Failed search.

20181103/DuckDuckGo http filesystem linux  
20181103/DuckDuckGo linux access file over http like local file  
20181103/DuckDuckGo linux mount http file  
20181103/DuckDuckGo python access remote http file like local descriptor  
20181103/DuckDuckGo python virtual file descriptor http file  
20181103/DuckDuckGo python access remote http file through descriptor  
20181103/https://grokbase.com/t/python/python-list/092qzmp824/how-to-open-a-remote-file-using-python  
20181103/https://stackoverflow.com/questions/10820376/how-do-i-access-a-remote-filesystem-using-python-on-windows  
20181103/DuckDuckGo python urllib open  
20181103/https://stackoverflow.com/questions/36965864/opening-a-url-with-urllib-in-python-3#36965905  
20181103/https://docs.python.org/2/library/urllib.html  
20181103/DuckDuckGo python url open with seek  
20181103/https://stackoverflow.com/questions/5209087/python-seek-in-http-response-stream  
20181103/DuckDuckGo linux read only url http file mount proxy
