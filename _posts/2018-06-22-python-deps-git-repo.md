---
layout: post
title: Python package dependencies from Git repositories
author: quorten
date: 2018-06-22 16:00 -0500
categories: [random-software, important]
tags: [random-software, important]
---

Important!  Want to install Python packages from Git repositories?
Use `dependency_links` in `setup.py`, `--process-dependency-links`,
and `git+` to do this.

Also, make sure you make your URLs look like this.  The version must
be included in the "egg" URL or else it won't work.

    https://github.com/.../tarball/master#egg=pkgname-0.9.3

Also, make sure you are using `pip` >= 9 or else the functionality may
have been removed.

20180622/DuckDuckGo setup.py pip dependency links  
20180622/https://stackoverflow.com/questions/26061610/pip-install-dependency-links  
20180622/DuckDuckGo pip dependency links  
20180622/https://stackoverflow.com/questions/46320277/why-is-dependency-links-in-setup-py-deprecated  
20180622/https://github.com/pypa/pip
