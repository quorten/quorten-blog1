---
layout: post
title: Setup your own Python Ansible dev machine
author: quorten
date: 2016-08-06
categories: [python, ansible]
tags: [python, ansible]
---

Setup your own Python Ansible dev machine?  This is what you need to
do.  After I do the usual for setting up my own RHEL 7 machines, I do
the following:

    yum -y install python-devel openssl-devel libaio readline-devel
    yum -y groupinstall 'Development Tools'
    # Bootstrap a virtualenv manually for this particular machine.
    pip install ansible

Then you can run the Ansible playbook just like normal.  Okay, yes
there will be a few peculiarities, but overall it will be doable.
