---
layout: post
title: LibreSSL not working with latest Python
author: quorten
date: 2018-06-11 16:02 -0500
categories: [python]
tags: [python]
---

LibreSSL not working with the latest version of Python?  Yes, read
about what's going on here.  Basically, LibreSSL isn't keeping up with
extensions to OpenSSL, and the Python community is moving toward using
OpenSSL extensions because their development team is so small.

20180611/https://github.com/libressl-portable/portable/issues/381
