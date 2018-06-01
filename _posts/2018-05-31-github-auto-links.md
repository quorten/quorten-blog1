---
layout: post
title: Automatically generate links for GitHub pages
author: quorten
date: 2018-05-31 19:51 -0500
categories: [blogging]
tags: [blogging]
---

So, it appears that Kramdown doesn't have support for automatically
generating links for URLs in the text.  That is unfortunate.  The only
way to handle this is through a Jekyll plugin, and for that to work, I
would need to use another web service for CICD like Travis CI.  For
the time being, I want to refrain from using too many external site
services and making things too complicated like that.  Also, I want to
keep the original Markdown clean so that it still makes sense to read
on its own.  My apologies for the inconvenience.

I've been thinking about adding support to Kramdown so that it can
automatically generate such links, but looking at the design
architecture of Kramdown, this might not make logical sense.  So,
plugin filter it shall be.

20180531/DuckDuckGo kramdown auto url link  
20180531/DuckDuckGo kramdown generate url link automatically  
20180531/https://github.com/shoyan/kramdown_easy_link
