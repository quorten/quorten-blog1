---
layout: post
title: Find what handlers are available on logger object
author: quorten
date: 2016-08-10 12:00 -0500
categories: [python]
tags: [python]
---

Wow, important Python note.  Missing from the documentation?  How do
you find out what handlers are available on a `logger` object?  Well,
there is this undocumented `handlers` field that you can read from to
get the list.  Wow, weird.

20160810/http://stackoverflow.com/questions/6333916/python-logging-ensure-a-handler-is-added-only-once
