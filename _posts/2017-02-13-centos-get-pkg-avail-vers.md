---
layout: post
title: Getting available versions of a particular package on CentOS
author: quorten
date: 2017-02-13
categories: [centos]
tags: [centos]
---

Red Hat notes.  RHEL notes.

Useful information on getting the available versions of a particular
package:

20170213/http://unix.stackexchange.com/questions/151689/how-can-i-instruct-yum-to-install-a-specific-version-of-package-x#151690

Important!  If you can't upgrade your RHEL 7.2 to the latest version
of its packages due to some artificial hold-backs, what can you do?
Here's how to install a specific version of Docker that works on my
older systems:

    yum -y install docker-engine-1.12.2-6.el7.centos \
      docker-engine-selinux-1.12.6-1.el7.centos
