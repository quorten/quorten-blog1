---
layout: post
title: Workaround for trouble installing sosreport
date: 2019-07-18 16:37 -0500
author: quorten
categories: [centos]
tags: [centos]
---

Trouble installing sosreport?  Here is the dig that you need to know.

```
yum -y install sos
cd /usr/lib/python2.7/site-packages/sos/
ls policies/
vi policies/redhat.py
:s:RHEL_RELEASE_NAME...CentOS:Red Hat Enterprise:g

sosreport --batch --tmp-dir /var/tmp/capture
```

The issue is only apparent if you are installing the CentOS package on
Red Hat Enterprise Linux.  Unfortunately, some hacks are used such
that the general package doesn't support both distros simultaneously.
So you have to make a hack to switch that if they aren't matched up
perfectly.

20190718/DuckDuckGo install sosreport no valid plugins were enabled  
20190718/https://access.redhat.com/solution/3006791

20190718/https://bugzilla.redhat.com/show_bug.cgi?id=386691  
20190718/https://bugzilla.redhat.com/show_bug.cgi?id=1197302

20190718/DuckDuckGo sospreport superclasses  
20190718/https://github.com/sosreport/sos/wiki/How-to-Write-a-Policy

20190718/DuckDuckGo run sosreport non interactively  
20190718/https://github.com/sosreport/sos/issues/405
