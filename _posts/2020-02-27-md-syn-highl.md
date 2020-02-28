---
layout: post
title: GitHub pages Markdown syntax highlighting
date: 2020-02-27 09:01 -0600
author: quorten
categories: [blogging]
tags: [blogging]
---

Many times I've tripped over this, you've got to be careful when using
triple backticks, Kramdown Markdown will try to auto-detect the
programming language for syntax highlighting, but if it fails, your
GitHub pages will fail to build.  Sidestep the problem entirely by
specifying the programming language explicitly at the beginning of the
three backticks.  See a list of supported syntax highlighters here.

20200227/https://stackoverflow.com/questions/11568093/syntax-highlighting-on-githubs-wiki-specifying-the-programming-language  
20200227/https://pygments.org/docs/lexers/
