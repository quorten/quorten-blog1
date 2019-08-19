---
layout: post
title: pip proxy and certificates
date: 2019-06-18 21:36 -0500
author: quorten
categories: [unix, python]
tags: [unix, python]
---

How do you use pip behind an HTTP proxy that is used via an explicit
proxy server name?  Simply set the `http_proxy` environment variable
to the name of the proxy server, and it will run through that alright.
The `http_proxy` environment variable also works for `apt-get` and
`apk`.

20190618/DuckDuckGo pip http_proxy stackoverflow  
20190618/https://stackoverflow.com/questions/14149422/using-pip-behind-a-proxy-with-cntlm?noredirect=1

What if you need a custom certificate to be accepted by `pip`?  Use
the `--cert` command line option.

20190618/DuckDuckGo chenghlee.com pip --cert digicert  
20190618/https://chenghlee.com/2014/06/18/using-pip-with-an-alternate-ca-bundle/
