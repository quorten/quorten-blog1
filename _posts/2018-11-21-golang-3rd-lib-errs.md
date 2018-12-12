---
layout: post
title: Opinions on Golang's error handling and third-party libraries
author: quorten
date: 2018-11-21 17:06 -0600
categories: [golang]
tags: [golang]
---

Wow, this is interesting.  So, here's a different opinion and
experience about Golang's error handling model.  The main argument
against not providing an exception-throwing model?  Without an
exception-throwing model, you rely on third-party library code obeying
proper errror messaging conventions... which in practice, it doesn't.
Not unless you limit your choice of third-party libraries to such an
extremely small subset that... well, you'd talking more of a curated
core of libraries rather than _everything_ were that the case.  And of
course you want _everything_ so that you maximize the possibility of
finding existing code for your application and minimize the amount of
code that you have to write.

20181121/https://opencredo.com/why-i-dont-like-error-handling-in-go/
