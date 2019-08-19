---
layout: post
title: Last name NOT NULL... but what if it is?
date: 2019-06-12 12:20 -0500
author: quorten
categories: [random-software]
tags: [random-software]
---

Very interesting, in old style web programming and development,
database field inputs for names were not properly quoted and
sanitized, so if someone had the last name of "Null", the web
application would reject their input stating that last name is
missing.

20190612/http://www.bbc.com/future/story/20160325-the-names-that-break-computer-systems
