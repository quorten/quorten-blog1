---
layout: post
title: VMware `ovftool` and special characters in passwords
author: quorten
date: 2018-09-07 14:00 -0500
categories: [random-software]
tags: [random-software]
---

Having trouble with some scripts that call VMware `ovftool`
internally?  Make sure the scripts are URI encoding usernames and
passwords before passing them on to `ovftool`, otherwise you're going
to have problems with some very non-descript errors.

20180907/DuckDuckGo ovftool host name resolve failed user name  
20180907/https://communities.vmware.com/thread/328498  
20180907/DuckDuckGo ovftool Error: cURL error: URL using bad/illegal
  format or missing URL  
20180907/https://communities.vmware.com/thread/449807  
20180907/https://blog.edfine.io/blog/2017/05/02/how-vmwares-ovftool-gave-me-a-headache/
