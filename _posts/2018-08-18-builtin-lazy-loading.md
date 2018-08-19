---
layout: post
title: Built-in lazy loading for Chrome
author: quorten
date: 2018-08-18 22:15 -0500
categories: [random-software]
tags: [random-software]
---

Built-in lazy loading has come to Google Chrome Canary, which is only
the development version thus far.  The main motivation here is to
optimize mobile Android browser experience.

What does this mean for you as a web developer?  Eventually, on pages
not marked otherwise, all images and inline frames will be lazy loaded
by default.  If you do not want the image or frame to be lazy loaded,
then you should put a `lazyload="auto/on/off"` attribute on the
corresponding element:

    < iframe src="http://www.example.com/" lazyload="auto/on/off" >< /iframe >

20180818/https://www.bleepingcomputer.com/news/google/built-in-lazy-loading-lands-in-google-chrome-canary/
