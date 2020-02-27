---
layout: post
title: Escape sequences in YAML multiline strings
date: 2020-02-21 17:48 -0600
author: quorten
categories: [misc]
tags: [misc]
---

Okay, so now here is a tip on a tricky aspect of YAML syntax.  How do
you create a multiline string in YAML that has backslashes and does
not end with a newline?  Within a multiline string using either the
`|` or `>` character to indicate it, backslashes do not start escape
sequences, they are represented literally.  Now, if you don't want
there to be a trailing newline, you use `|-` as your indicator
character sequence.

20200221/https://en.wikipedia.org/wiki/YAML  
20200221/DuckDuckGo yaml multiline strings escape sequences  
20200221/https://yaml-multiline.info/  
20200221/https://yaml.org/spec/1.2/spec.html/#id2794534
