---
layout: post
title: "`version_compare` in Ansible"
author: quorten
date: 2016-07-01
categories: [ansible]
tags: [ansible]
---

Wow, in trying to understand `version_compare` in Ansible.  Coming to
a discussion forum among the implementors really cleared up how things
work.  They discussed alternatives of implementing it either as a
function or as a "jinja2 filter."  So, that weird syntax style is the
alternative that is used for jinja2 filters.  Oh, that makes a lot
more sense.

20160701/https://groups.google.com/forum/#!msg/ansible-project/P_Rp4fVJYHk/mQMvVPC3g1AJ

It's too bad that discussion can't be in the documentation.

* So what were you saying?  You should write some easy to read
  documentation that does not include the full details, it just does
  straight to the point?  Maybe not.  Maybe including the full details
  makes much more sense than trying to "only include what is
  relevant."
