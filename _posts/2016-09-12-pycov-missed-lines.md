---
layout: post
title: Find missed lines with the Python code coverage tool
author: quorten
date: 2016-09-12
categories: [python, important]
tags: [python, important]
---

Important!  How do you figure out which lines were not executed from a
py.test with code coverage?  Here's how:

    coverage report -m

20160912/https://coverage.readthedocs.io/en/coverage-4.2/

Now, this is very interesting.  How do you unit test import errors?
Here's how:

    try: import builtins
    except ImportError: import __builtin__ as builtins
    realimport = builtins.__import__
    def myimport(name, globals, locals, fromlist, level):
       if ... : raise ImportError
       return realimport(name, globals, locals, fromlist, level)
    builtins.__import__ = myimport

Of course, make sure you see my actual implemented code for a few
practical improvements.

20160912/http://stackoverflow.com/questions/2481511/mocking-importerror-in-python#2481588

<!-- more -->

And static class variables in Python?  Here's how:

20160912/http://stackoverflow.com/questions/68645/static-class-variables-in-python

And, in case you're interested, here's how to implement a class
factory so that you can achieve similar to how would be done in C++
with template classes:

20160912/http://stackoverflow.com/questions/4858298/python-3-class-template-function-that-returns-a-parameterized-class

----------

It's still an unsolved mystery for me to figure out how to get unit
testing working when you need to make copies of objects, but this
sheds a tiny bit of light on a way toward the solution.  It still
doesn't work for me, though.

20160912/http://stackoverflow.com/questions/33585431/mock-a-class-and-a-class-method-in-python-unit-tests

----------

So you want to run unit tests in parallel?  Here's how:

20160913/https://qxf2.com/blog/xdist-run-tests-parallel-pytest/

Unfortunately, I'll have to improve my test suite in order for this to
work correctly.  Right now, there is only but one portion of the code
that is not parallelism-friendly, an integration testing portion.
