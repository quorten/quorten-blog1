---
layout: post
title: Network middleware still breaks encrpytion
author: quorten
date: 2018-11-10 23:30 -0500
categories: [security]
tags: [security]
---

What is this network middleware that this ZDnet article talks about?
In this case, it is software designed to monitor network traffic by a
third party, mainly used by enterprise networks on the premise of
monitoring for sensitive information leaks.  Unfortunately, currently
the only method practiced for doing this with SSL/TLS traffic is to
break the encryption entirely, rather than adding a second asymmetric
decrpytion key.  Often times in the process, the SSL/TLS security
level is reduced in the process, increasing the likelihood that a real
attacker could compromise a connection.

20181110/https://www.zdnet.com/article/its-2018-and-network-middleware-still-cant-handle-tls-without-breaking-encryption/
