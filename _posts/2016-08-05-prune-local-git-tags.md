---
layout: post
title: Prune local Git tags that are no longer upstream
author: quorten
date: 2016-08-05
categories: [git, important]
tags: [git, important]
---

Important!  Prune local Git tags that are no longer upstream.

20160805/https://demisx.github.io/git/2014/11/02/git-prune-local-tags-dont-exist-remote.html

    git tag -l | xargs git tag -d && git fetch -t
