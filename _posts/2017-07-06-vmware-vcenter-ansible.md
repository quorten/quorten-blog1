---
layout: post
title: Control VMware vCenter using Ansible
author: quorten
date: 2017-07-06
categories: [ansible, vmware, important]
tags: [ansible, vmware, important]
---

Important!  Ansible notes.  VMWare notes.

How do you use Ansible to control VMs in a VMWare vCenter?  Use the
`vmware_guest` and `vmware_guest_snapshot` modules.  These are the
modules that use the official Python SDK for connecting with the
vCenter and they have the features.  The alternative, `vsphere_guest`,
uses an API that was written by an independent developer and "got
there first," but it is not longer supported.  Although the
`vsphere_guest` module makes some operations more convenient than
others, pushing source code modifications upstream to the
`vmware_guest` module is a good approach.

NOTE: My search as recorded here is somewhat condensed.

20170706/http://docs.ansible.com/ansible/vmware_guest_snapshot_module.html  
20170706/http://docs.ansible.com/ansible/vsphere_guest_module.html

Having trouble with Ansible using `/usr/bin/python` when you want to
use Python from a virtualenv?  Here is the solution.  Use an inventory
file as follows:

    [localhost]
    localhost ansible_python_interpreter=python

20170706/DuckDuckGo ansible /usr/bin/python local  
20170706/https://www.zigg.com/2014/using-virtualenv-python-local-ansible.html

<!-- more -->

Now I'm wondering about the `vmware_guest` module.  Why isn't it
working correctly?  Well there is a bug in my version of it.  The
latest upstream version partially fixes so that it doesn't crash
entirely, but it still doesn't set the task result status correctly.
Also, don't get confused between the vmware versus vsphere modules.

20170706/https://github.com/ansible/ansible/blob/devel/lib/ansible/modules/cloud/vmware/vsphere_guest.py  
20170706/https://github.com/ansible/ansible/blob/v2.3.0.0-1/lib/ansible/modules/cloud/vmware/vsphere_guest.py  
20170706/https://docs.ansible.com/ansible/vmware_guest_module.html#id2  
20170706/https://github.com/ViaSat/ansible-vsphere  
20170706/https://github.com/ansible/ansible/blob/devel/lib/ansible/modules/cloud/vmware/vmware_guest.py

The PyVmomi module is authored by VMWare.

20170706/https://github.com/vmware/pyvmomi

The PySphere module is no longer being maintained.

20170706/https://github.com/argos83/pysphere
