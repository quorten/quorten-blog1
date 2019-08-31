---
layout: post
title: Install Python on Windows without Admin privileges
date: 2019-08-31 08:57 -0500
author: quorten
categories: [python, windows]
tags: [python, windows]
---

When you run the Python installer on Windows, it typically always
wants to request Admin privileges, even if you only want to install
for your own user account.  But, there is this interesting trick
that allows you to run the Python installer without it asking for
Admin privileges.

```
msiexec /a python-3.4.0.msi /qb TARGETDIR=C:\Users\%USERNAME%\python34
```
