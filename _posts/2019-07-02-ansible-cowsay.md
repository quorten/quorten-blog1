---
layout: post
title: Ansible, cowsay, and figlet
date: 2019-07-02 12:07 -0500
author: quorten
categories: [random-software, ansible]
tags: [random-software, ansible]
---

This is interesting.  If `cowsay` is installed, Ansible will use it
for printing messages like when you start running a playbook.  It's
interesting that I never saw this before.  If you install Ansible from
`pip`, there is no way that it can bring in the Perl-based `cowsay`
dependency.

`cowsay` and `figlet` used to be a pretty popular geek joke in the
1990s, but they seem to have fallen out of favor in modern times.
Probably because moderners are more interested in real graphics,
vector graphics on high-resolution displays, than ASCII art.

20190702/https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-disable-cowsay  
20190702/https://en.wikipedia.org/wiki/Cowsay  
20190702/https://en.wikipedia.org/wiki/FIGlet
