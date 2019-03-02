---
layout: post
title: Quick and easy way to update branch
date: 2016-07-25 21:13 -0500
author: quorten
categories: [git]
tags: [git]
---

Important!  Quick and easy way to to pull in master and rebase your
commit to latest.

    git fetch -p
    SAVE=`git rev-parse HEAD`
    git reset --hard origin/master
    git cherry-pick ${SAVE}~1..${SAVE}
    git push --force
