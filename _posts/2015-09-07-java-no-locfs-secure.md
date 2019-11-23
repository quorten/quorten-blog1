---
layout: post
title: Java restricted local filesystem access for security
date: 2015-09-07 21:40 -0600
author: quorten
categories: [security]
tags: [security]
---

Java.  No local filesystem access?  Why not?  Security, they say.  The
local filesystem has no sufficient security by default.  Of course
not.  And of course you're not supposed to be storing private data in
the local file system.  And if it is private, there shouldn't be all
that much to loose.  After all, the file system is supposed to be a
small partition.  Big data should be delegated to large partitions.

True, but the imprecision of how people use computers results in this
not being the case.
