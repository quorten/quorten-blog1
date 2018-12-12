---
layout: post
title: "Get profiling and timestamps in Ansible, and disable host key
        checking"
author: quorten
date: 2017-07-20
categories: [ansible, important]
tags: [ansible, important]
---

Important!  Ansible notes.

Add to `ansible.cfg`:

    callback_whitelist = profile_tasks

to enable profiling and get timestamps on task execution.

20170720/https://github.com/jlafon/ansible-profile

----------

Important!  Ansible notes.  Have that silly problem with host key
checking causing connections to fail?  Use this environment variable
setup:

    ANSIBLE_HOST_KEY_CHECKING=false

20170728/https://stackoverflow.com/questions/23492032/cant-disable-ansibles-host-key-checking#23494998

Do you want to specify a list or other complex variables in an
inventory file?  Use single quotes ('') to quote it.

20170729/https://stackoverflow.com/questions/18572092/how-specify-a-list-value-as-variable-in-ansible-inventory-file?rq=1

Important!  Is it possible to write Ansible hosts/inventory files in
YAML?  Yes.

20170912/https://stackoverflow.com/questions/41094864/is-it-possible-to-write-ansible-hosts-inventory-files-in-yaml
