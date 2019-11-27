---
layout: post
title: Get files of installed CentOS package
author: quorten
date: 2018-08-29
categories: [centos, important]
tags: [centos, important]
---

Important!  RHEL Red Hat CentOS notes.  Find out the list of files
that are in an installed package.

    repoquery --list autofs
    # UPDATE 2019-11-26: Alternatively:
    rpm -ql autofs

Find out which package a file belongs to.

    rpm -qf /usr/sbin/service
