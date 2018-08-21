---
layout: post
title: Golang versus Python in containers
author: quorten
date: 2018-07-06 10:46 -0500
categories: [golang, python]
tags: [golang, python]
---

So, I'm wondering about a followup question to the one I've asked you
earlier about Python versus Golang.  How does containers change the
picture about deployment?

The only difference would be container size. Your python app requires
the interpreter, which is dynamically linked. In addition, the
dependencies you pull in might be dynamically linked. Either you need
an OS that provides those libs, or you need to pack up those libs into
your container. By contrast, you'd generally statically link golang
apps, so you add the binary to your container and that's it.
