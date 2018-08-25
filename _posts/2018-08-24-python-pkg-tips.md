---
layout: post
title: Python package management tips and tricks
author: quorten
date: 2018-08-24 11:58 -0500
categories: [python]
tags: [python]
---

You can install Python packages from source code repositories.  This
is really useful when you do not want to insert an extra step of
creating and uploading a package to the PyPI repository.  Most
notably, it's most useful to download your packages from your GitHub
source repository.

20180824/https://pip.pypa.io/en/stable/reference/pip_install/#vcs-support

Want to install Python packages into a virtual environment, but still
be able to develop them with ease?  Look here for the documentation on
so-called "editable" installs that allows you to do this.

20180824/https://pip.pypa.io/en/stable/reference/pip_install/#editable-installs  
20180824/https://setuptools.readthedocs.io/en/latest/setuptools.html#development-mode
