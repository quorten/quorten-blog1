---
layout: post
title: Install CentOS 7 development tools
author: quorten
date: 2018-01-30
categories: [centos, important]
tags: [centos, important]
---

Important!

Red Hat notes.

This is what you need to do to install development tools on version 7
systems.

    yum --setopt=group_package_types=mandatory,default,optional \
      groupinstall "Development Tools"

20180130/https://www.cyberciti.biz/faq/centos-rhel-7-redhat-linux-install-gcc-compiler-development-tools/
