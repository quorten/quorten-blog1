---
layout: post
title: Learning more about Cloudflare hosting
author: quorten
date: 2018-09-29 19:47 -0500
categories: [random-software]
tags: [random-software]
---

Okay, so now I'm wondering about Cloudflare hosting.  Yeah, despite
the criticism on Wikipedia, it seems that a lot of people use it, so
it should be good to go with for my own use.  So they provide free
hosting?  Not quite.  Take a good careful look at the details: they
provide a _free CDN_, _free DDoS mitigation_, and _free DNS proxying_.
For hosting, as you'll learn from reading the information on their
website carefully, that is on a hosting provider of your own, i.e.
your own Raspberry Pi server.

So, Amazon also provides a CDN.  They call it _Cloudfront_.

20180929/https://www.cloudflare.com/  
20180929/https://www.cloudflare.com/plans/  
20180929/https://www.cloudflare.com/cdn/  
20180929/https://en.wikipedia.org/wiki/Cloudflare  
20180929/DuckDuckGo amazon cdn  
20180929/https://aws.amazon.com/cloudfront/

Oh, so I see that there is now HTTP/2 out and about.  Indeed, this is
closely based off of the earlier SPDY protocol that is now termed to
have only been "experimental" by Google.  The binary protocol of
HTTP/2 is not strictly compatible with HTTP/1.1 due to the
multiplexing and pipelining features of HTTP/2, but the high-level
primitives are the same.  Alas, HTTP/2 isn't supported before Apache
2.4.17, and Debian Jesse only gives me Apache 2.4.10.

20180929/https://www.cloudflare.com/website-optimization/http2/  
20180929/https://en.wikipedia.org/wiki/HTTP/2  
20180929/https://en.wikipedia.org/wiki/Head-of-line_blocking

Oh, and are you looking for an implementation of HTTP/2 to use in a
lightweight C web server?  Look around here for references.  Deuterium
web server looks particularly promising.

20180929/https://github.com/http2/http2-spec/wiki/Implementations  
20180929/http://robbysimpson.com/deuterium/
