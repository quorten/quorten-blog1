---
layout: post
title: Extract Red Hat/CentOS package manually without installing it
author: quorten
date: 2016-08-02
categories: [centos, important]
tags: [centos, important]
---

Important!  How do you extract a Red Hat package manually without
installing it?  Like this:

    rpm2cpio ../giflib-devel-4.1.6-1.fc11.x86_64.rpm | cpio -idmv

20160802/http://www.cyberciti.biz/tips/how-to-extract-an-rpm-package-without-installing-it.html

Oh yeah, and don't forget how to list packages via yum.

    yum list

20160802/https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sec-Listing_Packages.html

Important!  How to find which package installed a particular file.

    yum whatprovides /usr/bin/msgfmt

Get the installed version of a package:

    yum list readline

Want to get the short description on a package?  Sorry, you can't do
web search because there is no web directory for CentOS, so instead
you must do it in the package manager like follows:

    yum search check-devel
