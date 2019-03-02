---
layout: post
title: Pull updates from upstream to your branch in Git
date: 2016-05-16 21:12 -0500
author: quorten
categories: [git]
tags: [git]
---

Take note, this is how you deal with pulling updates from upstream
that result in commits getting deleted.

    git fetch --all
    git reset --hard origin/feature/my-feature
    git pull origin feature/my-feature
