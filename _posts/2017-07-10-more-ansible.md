---
layout: post
title: "More Ansible notes: `delegate_to`, local playbook run, gather
        facts, `when`, `lineinfile`, `vmware_guest`, and more"
author: quorten
date: 2017-07-10
categories: [ansible, important]
tags: [ansible, important]
---

Ansible notes.

Important!  How do you have one task run on the local machine
rather than the remote?  Use the `delegate_to` task property.

    delegate_to: localhost

20170710/http://docs.ansible.com/ansible/playbooks_delegation.html#delegation

There are also methods to have the entire playbook run locally.

20170710/DuckDuckGo ansible create a role that runs locally  
20170710/https://stackoverflow.com/questions/18900236/run-command-on-the-ansible-host

<!-- more -->

----------

Important!  Play failing because a machine cannot be connected to
gather facts?  How do you continue to run plays that don't require a
connection?  Use `gather_facts: false` the beginning of the play.

20170717/https://viewsby.wordpress.com/2014/11/25/ansible-disable-gather-facts/

Important!  Use `meta: reset_host_failures` if you want to continue a
playbook after a host failed due to a connection failure.

20170717/http://docs.ansible.com/ansible/playbooks_error_handling.html#ignoring-failed-commands

Important!  How to wait until a guest VM has been shutdown.  And, how
to figure out what is registered in a variable when the Ansible
documentation is lacking.

20170717/http://docs.ansible.com/ansible/vmware_guest_facts_module.html  
20170717/http://docs.ansible.com/ansible/debug_module.html  
20170717/http://docs.ansible.com/ansible/playbooks_loops.html  
20170717/http://docs.ansible.com/ansible/wait_for_module.html

Important!  There are a lot of things you can do with inventory files
in Ansible.  A first read of the related documentation is not enough.

20170717/https://docs.ansible.com/ansible/intro_inventory.html

Important!  Do you want to generate an inventory file when
provisioning VMs using Ansible?  Use this to help get yourself
started.

20170717/https://stackoverflow.com/questions/26732241/ansible-save-registered-variable-to-file

Having trouble with lineinfile and selinux Python module?  Look here
for a solution.  Basically, you just copy the `selinux` Python module
directory from your system into your virtualenv.

20170818/DuckDuckGo python selinux  
20170818/https://dmsimard.com/2016/01/08/selinux-python-virtualenv-chroot-and-ansible-dont-play-nice/

    cp -piR /usr/lib64/python2.7/site-packages/selinux ~/aenv/lib/python2.7/site-packages/

Another option is to build your virtualenv to include all the system
site packages as follows:

    virtualenv --system-site-packages myenv

----------

Important!  Ansible notes.  Using `when` with loops will mean that the
when will be applied for each loop item.  Simple note, easy as that,
from the official documentation.

Oh yeah, don't worry about needing generated variable names,
dictionary syntax `this[that]` will work adequately.

Important!  Ansible notes.  How do you access the variables
assigned to a different host?  Use `hostvars`.

How do you find out all these variables of Ansible?  Difficult stuff,
read the source code, dump the list of all variables, and so on.

    {{ hostvars.tomcat }}

Global variables?  Don't bother.  Setting a variable in a `run_once`
section should be good enough.

20170819/DuckDuckGo ansible run once with items inventory hosts  
20170819/https://stackoverflow.com/questions/21908363/ansible-read-inventory-hosts-and-variables-to-group-vars-all-file

----------

Important!  Having trouble creating VMware VMs using Ansible
`vmware_guest` module?  Well you're troubles are indeed valid.  This
has been filed as a known issue with a fix in the latest development
version, merged just a few days ago.

20170719/Yahoo vmware_guest resource_pool  
20170719/https://github.com/ansible/ansible/issues/22706  
20170719/https://github.com/ansible/ansible/pull/24768

Now what?  Now when I try to run the role, it fails because it
can't find a template file.

20170719/DuckDuckGo vmware_guest Unable to access the virtual machine
  configuration: Unable to access file  
20170719/https://communities.vmware.com/thread/69466

Solution?  I don't know.
