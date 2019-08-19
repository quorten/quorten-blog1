---
layout: post
title: Unit testing in Ansible
date: 2019-08-01 16:18 -0500
author: quorten
categories: [ansible]
tags: [ansible]
---

How do you do unit testing in Ansible?  Good question, so far I've
only ever done integration testing in Ansible by the means of
Testinfra.  However, Ansible does have the means by which you can
write true unit tests, rather than self-contained integration tests as
is the case when you write tests using Testinfra, Serverspec,
Molecule, or otherwise.

20190801/https://docs.ansible.com/ansible/latest/dev_guide/testing_units_modules.html#use-of-mocks  
20190801/https://docs.ansible.com/ansible/latest/dev_guide/testing_units.html
