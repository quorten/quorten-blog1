---
layout: post
title: How to ensure web clients get latest page updates
author: quorten
date: 2018-07-28 12:12 -0500
categories: [web-dev, important]
tags: [web-dev, important]
---

Important!  Having problems with clients not getting the latest
version of page updates?  Here's the solution.  Make sure your server
is sending the `Expires` and `Cache-Control` headers.  These will
indicate to the browser that it should send an HTTP request to
revalidate the cache entry when a user accesses the page.  If it is
still valid, you still save bandwidth.  Otherwise, you guarantee that
the user is seeing a fresh page.  You can set this to zero to always
require revalidation every time the user visits the page.

20180728/DuckDuckGo apache cache expiration header  
20180728/https://httpd.apache.org/docs/2.4/mod/mod_expires.html  
20180728/http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9
