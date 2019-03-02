---
layout: post
title: Find when Git commit was merged into a branch
date: 2017-06-09 21:14 -0500
author: quorten
categories: [git]
tags: [git]
---

How do you find out when a particular Git commit was merged into a
branch?  Use this tool.

20170609/https://github.com/mhagger/git-when-merged

How do you find out what release branches a Git commit is part
of?  Use this command:

    git tag --contains <commit>
    # Or this:
    git describe --contains <commit>

20170609/https://stackoverflow.com/questions/1474115/find-tag-information-for-a-given-commit/7561599#7561599
