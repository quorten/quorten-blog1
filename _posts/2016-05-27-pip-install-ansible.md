---
layout: post
title: Install Ansible via `pip`
author: quorten
date: 2016-05-27
categories: [ansible, important]
tags: [ansible, important]
---

Important!  Ansible notes.  Install Ansible via pip:

    pip install ansible

But, you'll need `sshpass` installed first, and make sure that
`/usr/include/ffi.h` exists, otherwise you should go install it per my
instructions elsewhere.

    yum -y install sshpass

Alternatively, you can use my `ansible-virtualenv.sh` script,
available elsewhere.
