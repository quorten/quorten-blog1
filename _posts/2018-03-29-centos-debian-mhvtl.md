---
layout: post
title: "CentOS or Debian?  And MHVTL."
date: 2018-03-29 21:00 -0600
author: quorten
categories: [unix]
tags: [unix]
---

CentOS or Debian?  Which one?  Okay, so now I have a clear and
definitive answer from experience.

CentOS is most useful only in specific company environments.  Many of
the practices and methods for working with CentOS are highly
specialized, meaning to build a machine only to be used for a specific
purpose.

If you want something more general purpose, like is the case for libre
software development at home, you definitely want to go with the
Debian side of matters.  DKMS is well supported which is needed for a
variety of applications, but DKMS does not exist on the Red Hat side
of affairs.  Also, the official package repositories are much broader,
a big boon to typical hobbyist use that is much more inclusive in
features and functions on a single machine for "development."  The
typical hobbyist use for specialized configurations is embedded
systems.  The other use, large server farms, is of course too
expensive.

I saw that the MHVTL installation uses rpmbuild to build the kernel
modules from source, and I was wondering why they didn't simply use
DKMS in a binary package to do likewise.  So it turns out that Red Hat
doesn't want to support DKMS, that's why.

20180329/https://access.redhat.com/discussions/2336291

<!-- more -->

So, the alternative.  Since test configs do not use rolling upgrades
that change the kernel version on live configs, we can pre-build the
kernel packages for the specific kernel version that we are using and
put those in Artifactory.
