---
layout: post
title: Interesting software for testing Ansible roles, Docker-in-Docker
author: quorten
date: 2018-09-17 20:00 -0500
categories: [ansible]
tags: [ansible]
---

Interesting software for testing Ansible roles, even within
Docker-in-Docker.

20180917/https://molecule.readthedocs.io/en/latest/

An interesting Ansible blog post, Ansible in large scale deployments.
The trick to using Ansible in large-scale deployments?  Ansible is
only meant to be used to automate functions that you want to perform
across a cluster all at once.  Typically in very large scale
deployments, you don't want to change everything all at once.  Rather,
you want to upgrade in shards.  It is these individual shards that you
would run Ansible on to manage them with, one at a time.

20180926/https://www.ansible.com/blog/large-scale-deployments-using-ansible

This Ansible script is useful for removing deprecated Ansible syntax
with tests as filters to proper `jinja2` test syntax.  The old syntax
has been removed in Ansible 2.9.

20180927/https://raw.githubusercontent.com/ansible/ansible/devel/hacking/fix_test_syntax.py
