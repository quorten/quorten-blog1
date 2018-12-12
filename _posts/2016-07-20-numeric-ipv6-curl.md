---
layout: post
title: Get numeric IPv6 address with `curl`
author: quorten
date: 2016-07-20 14:00 -0500
categories: [misc]
tags: [misc]
---

Oh, this is important.  How do you curl a numeric IPv6 address?
Here's how:

    curl -g -6 -X GET 'http://[::1]:5000/url'

20160720/http://superuser.com/questions/885753/how-can-i-use-curl-with-1-for-ipv6-based-loopback
