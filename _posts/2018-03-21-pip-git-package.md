---
layout: post
title: Use a Git repository as a `pip` package
author: quorten
date: 2018-03-21
categories: [python, important]
tags: [python, important]
---

Important!  Python notes.

Can you use a Git repository with `pip`?  Yes you can.  You can even
specify branches or tags like follows.

    git+https://example.com/repo.git@branch#egg=pkg&subdirectory=pkg_dir

20180321/https://pip.pypa.io/en/stable/reference/pip_install/#vcs-support
