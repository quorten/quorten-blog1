---
layout: post
title: "Use a generator to create a `dict` in Python, bool, and more
        Python documentation"
author: quorten
date: 2017-05-30
categories: [python]
tags: [python]
---

Python notes.

Create a `dict` using a generator in Python.

20170530/DuckDuckGo python dict generator  
20170530/https://stackoverflow.com/questions/1747817/create-a-dictionary-with-list-comprehension-in-python#1747827

20170530/DuckDuckGo python bool base class  
20170530/https://stackoverflow.com/questions/2233786/overriding-bool-for-custom-class#2233801  
20170530/https://stackoverflow.com/questions/8205558/defining-boolness-of-a-class-in-python

<!-- more -->

20170530/DuckDuckGo isinstance subclass bool

Interesting find here.  (A "random advertisement" at that.)  According
to the author, the official Python documentation is not nearly as good
as that of VB.NET and JavaScript on MDN.

20170530/http://python-reference.readthedocs.io/en/latest/docs/functions/isinstance.html  
20170530/http://python-reference.readthedocs.io/en/latest/index.html  
20170530/http://python-reference.readthedocs.io/en/latest/intro.html  
20170530/DuckDuckGo TypeError: type 'bool' is not an acceptable base type  
20170530/https://stackoverflow.com/questions/10061752/which-classes-cannot-be-subclassed

`bool` cannot be subclassed.  Why?  Bool is supposed to follow the
theory that there are only two instances of it, True and False, and
that you can't actually create objects that are instances of `bool`
but have a True or False value because that would violate Python's
`bool` data type concept.  According to Guido.

20170530/https://stackoverflow.com/questions/2172189/why-i-cant-extend-bool-in-python/2172204#2172204
