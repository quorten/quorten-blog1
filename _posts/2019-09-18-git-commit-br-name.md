---
layout: post
title: Get branch name of commit hash in Git
date: 2019-09-18 21:26 -0500
author: quorten
categories: [git]
tags: [git]
---

How do you get the branch name of a commit hash in Git?  Easy, just
run this one command:

```
git rev-parse --abbrev-ref <COMMIT>
```

And another way to know which branch is the current branch:

```
git rev-parse --abbrev-ref HEAD
```
