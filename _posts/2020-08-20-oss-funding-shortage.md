---
layout: post
title: "Articles on some open-source software quality problems, lack
        of maintenance monies, data typematic error in Microsoft
        Flight Simulator"
date: 2020-08-20 19:41 -0500
author: quorten
categories: [random-software, twitter]
tags: [random-software, twitter]
---

After reading about an xkcd comic that joked about the problem of
undermaintained software dependencies that hold up the entirety of the
Internet, I found some other interesting stories about past cases.
The proposition was that failure in ImageMagick will cause the entire
Internet to come topling down.

Post Heartbleed crisis, more funding for OpenSSL.

20200820/https://arstechnica.com/information-technology/2014/04/tech-giants-chastened-by-heartbleed-finally-agree-to-fund-openssl/

This other issue, when a developer, upset by a legal request to rename
a package called `kik`.  It was forcibly removed from NPM by the CEO,
that angered the author who promptly unpublished all his packages,
thereby causing most major Node.js projects to break because they
depended on one called `left-pad`.

20200820/DuckDuckGo leftpad broke the internet  
20200820/https://www.theregister.com/2016/03/23/npm_left_pad_chaos/

And this other interesting one, a typematic error in OpenStreetMap
that was later corrected, but not before Microsoft Flight Simulator
pulled in the data, resulted in a 212-story tall obelisk in the middle
of an otherwise quiet Melbourne suburb.

20200820/DuckDuckGo microsoft flight simulator melbourne tower  
20200820/https://www.engadget.com/flight-simulator-open-street-map-building-205545509.html
