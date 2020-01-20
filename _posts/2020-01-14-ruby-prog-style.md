---
layout: post
title: Interesting articles on Ruby programming style
date: 2020-01-14 17:46 -0600
author: quorten
categories: [ruby]
tags: [ruby]
---

When searching for information on handling HTTP errors in Jenkins,
I've found some other unrelated but interesting information on the
Ruby lonely operator and exception handling style in Ruby.

20200114/http://blog.travisspangle.com/safe-navigation-operator-or-rubys-lonely-operator/  
20200114/http://www.virtuouscode.com/2011/07/05/demeter-its-not-just-a-good-idea-its-the-law/

So, what is the Ruby lonely operator?  Basically, it is designated as
a way to safely access members when you don't know if they are defined
or not.  Then there is the other question about using exception
handling to access such member variables.  Although at the outset, it
seems to be a bad idea, "a code smell," there are certain
circumstances when this can be a good way to do this and a good idea.
