---
layout: post
title: Interesting Golang vulnerability scanner by JFrog
date: 2020-07-15 19:25 -0500
author: quorten
categories: [golang]
tags: [golang]
---

Very interesting.  The GoMN Meetup today covered JFrog's new Golang
integrations partly related to their JFrog XRay product, for
vulnerability scanning from their databases.  The no-cost API access
only covers mirrors of public databases like CERT, apparently there's
a such thing as proprietary vulnerability databases.  Wow.

JFrog GoCenter is the name of the game.

`vulnDB` is a proprietary vulnerability database.

Currently the functionality is only integrated into VScode IDE, this
has something to do with trying to avoid revealing too much
information about the proprietary API access.
