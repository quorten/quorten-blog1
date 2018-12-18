---
layout: post
title: "Programmatically check if a URL is archived on the Wayback
        Machine"
date: 2018-12-17 19:59 -0600
author: quorten
categories: [blogging]
tags: [blogging]
---

How do you programmatically check if a URL is archived on the Wayback
Machine?  This would be important for verifying that the timestamped
URLs in my blog indeed are available in the Wayback Machine.

Good news, there is a simple, easy-to-use API for doing this.  Use it
like the following example.

    http://archive.org/wayback/available?url=example.com&timestamp=20060101

20181217/DuckDuckGo programatically check if a url is archived wayback
machine  
20181217/https://stackoverflow.com/questions/33811582/how-to-access-wayback-machine-programmatically  
20181217/https://archive.org/help/wayback_api.php

Additionally, the Wayback Machine supports the Memento protocol, so
you can use that, too.  My understanding is that the Memento protocol
is more complex for this simple task, though.
