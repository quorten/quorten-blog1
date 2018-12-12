---
layout: post
title: "Discussion on Ansible strengths and weaknesses, documentation
        links"
author: quorten
date: 2017-05-10
categories: [ansible, important]
tags: [ansible, important]
---

Important!  Random but historically useful Ansible documentation
links.

On the topics of block-in-file, generating users and encrypted
passwords, using handlers in playbooks, and the "fail" module for
printing a custom error message under certain conditions.
Block-in-file is one of the better features of Ansible, contrast to
the great weakness of Ansible that it takes like 5 lines to "su to
root."  "Fail-early" is the best practical use of the fail module.

20170510/https://docs.ansible.com/ansible/blockinfile_module.html  
20170510/http://docs.ansible.com/ansible/user_module.html  
20170510/http://docs.ansible.com/ansible/faq.html#how-do-i-generate-crypted-passwords-for-the-user-module  
20170510/http://docs.ansible.com/ansible/playbooks_intro.html  
20170510/http://docs.ansible.com/ansible/fail_module.html  
20170510/http://docs.ansible.com/ansible/intro_windows.html
