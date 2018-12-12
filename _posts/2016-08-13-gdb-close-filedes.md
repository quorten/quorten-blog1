---
layout: post
title: Close a file descriptor on a process through `gdb`
author: quorten
date: 2016-08-13
categories: [misc]
tags: [misc]
---

Important note.  How do you close a file descriptor on a process?  You
attach to it in gdb, and run the following command:

    call close(filedes)

where `filedes` is the descriptor number.

20160813/http://stackoverflow.com/questions/5987820/how-to-close-file-descriptor-via-linux-shell-command

Now, this is an interesting link.  It clearly demonstrates (at the
time of visit) the imperfection of the StackOverflow website.  And, it
shows how sometimes, you must actually read further in order to get
the correct information.

20160813/http://stackoverflow.com/questions/323146/how-to-close-a-file-descriptor-from-another-process-in-unix-systems
