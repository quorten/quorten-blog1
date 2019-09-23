---
layout: post
title: Create an empty Git branch
date: 2019-09-23 16:46 -0500
author: quorten
categories: [git]
tags: [git]
---

Do you want to create an empty branch on an already existing
repository?  There is a fairly simple way to do this.

```
git checkout --orphan <branchname>
git rm --cached -r .
```

20190923/https://stackoverflow.com/questions/13969050/how-to-create-a-new-empty-branch-for-a-new-project/13969482#13969482
