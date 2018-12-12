---
layout: post
title: Python mock documentation and Sphinx
author: quorten
date: 2016-09-22
categories: [python, important]
tags: [python, important]
---

Is this the "mock import" you were looking for?  No, not quite.  It
goes in the opposite direction, but the name is correct.

20160922/https://github.com/posener/mock-import  
20170201/https://pypi.python.org/pypi/mock-import/0.0.2

Important! It would be useful for my Python package integration tests
to use something like this as an external module.  Unfortunately, the
mentioned module's scope is a little bit narrower than would be
desired.  The mock import is only setup to cause imports to pass, not
to fail.

On the subject of my Python package, using Sphinx for the
documentation may also be another good thing to do.

20170201/http://www.sphinx-doc.org/en/1.5.1/tutorial.html
