---
layout: post
title: Rsync a hard disk image
date: 2019-12-26 23:23 -0600
author: quorten
categories: [unix]
tags: [unix]
---

Okay, so I've made a full disk image backup of one disk image before
an expected migration, but then the expected migration got delayed
while the system was still in use, so now I have to update the full
disk image backup.  But, I do not want to have to recopy the full
thing because that will take a while.  Can I rsync the disk image?
No, because rsync doesn't work on block devices, not without a patch
from `rsync-patches`.  Yeah, but that sounds kind of finicky,
especially considering I was reading articles dated from 2012.  If
rsync mainline doesn't want the change applied, it will keep getting
knocked back when they update their software in incompatible ways and
the patchset doesn't keep pace.

Luckily, there is an independent third-party solution that builds off
of a more stable foundation.  `bscp` is a minimal Python script that
uses only Python builtins to synchronize disk images by only copying
blocks that have changed.  It looks fairly robust, like it should be
able to work with both Python 2 and Python 3, so you can use this for
a large range of systems from old to new.

20191226/DuckDuckGo rsync disk image  
20191226/https://www.linuxquestions.org/questions/linux-general-1/using-rsync-to-clone-hard-drive-921303/  
20191226/DuckDuckGo rsync block device  
20191226/https://arstechnica.com/civis/viewtopic.php?t=1173708  
20191226/https://unix.stackexchange.com/questions/344756/is-there-anything-similar-to-rsync-to-syncing-block-devices  
20191226/https://vog.github.io/bscp/  
20191226/https://github.com/vog/bscp  
20191226/https://github.com/vog/bscp/blob/master/bscp
