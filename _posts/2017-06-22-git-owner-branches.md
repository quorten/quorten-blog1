---
layout: post
title: Find out which branches are owned by you in Git
author: quorten
date: 2017-06-22
categories: [git, important]
tags: [git, important]
---

Important!  Git notes.

Find out which branches are owned by you?

    git for-each-ref \
      --format='%(committerdate) %09 %(authorname) %09 %(refname)' | \
      sort -k5n -k2M -k3n -k4n | grep <your name>

For pull requests, you can filter by author in BitBucket.
