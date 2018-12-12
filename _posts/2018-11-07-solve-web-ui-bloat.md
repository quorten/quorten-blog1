---
layout: post
title: Solutions to the web UI computational efficiency problem
author: quorten
date: 2018-11-07 22:00 -0600
categories: [tour-de-force, important]
tags: [tour-de-force, important]
---

Important!  So you're wondering about the Web UI problem?  Here's
simply what needs to happen.  UIs have been specified in markup for
quite some time, then rendered and executed by native code, so why not
bring enhanced functionality into the web browser?  Sure, web browsers
already have basic form rendering functionality built-in, they just
need the features to be extended.  So, first matter is to extend that
markup.  The second matter, the problem with markup parsing overhead.
Well, you can take an approach similar to WebAssembly.  First you
define the markup, second you define the compact binary format.
