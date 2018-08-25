---
layout: post
title: "Generate command lines in Ansible, read YAML data from `kubectl`"
author: quorten
date: 2018-08-24 17:57 -0500
categories: [ansible, kubernetes]
tags: [ansible, kubernetes]
---

So, how do you generate a command line from a list variable in
Ansible?  Look around here for the solution.

20180824/DuckDuckGo ansible create command line from list  
20180824/DuckDuckGo ansible create command line from list variable  
20180824/DuckDuckGo ansible generate command arguments from list variable  
20180824/https://stackoverflow.com/questions/30846813/ansible-variable-length-command-line-options#30851649  
20180824/DuckDuckGo jinja2 join filter  
20180824/https://stackoverflow.com/questions/24041885/conditionally-join-a-list-of-strings-in-jinja#24042287

----------

Yet more useful links on the subject, even information if you want to
do this from output from a `kubectl` YAML command.

20180802/DuckDuckGo ansible read in yaml from stdout  
20180802/https://stackoverflow.com/questions/40178795/ansible-parse-json-with-yaml#40178991  
20180802/https://docs.ansible.com/ansible/latest/modules/set_fact_module.html  
20180802/DuckDuckGo kubernetes get pods with label  
20180802/http://kubernetesbyexample.com/labels/  
20180802/DuckDuckGo ansible read from_yaml  
20180802/https://stackoverflow.com/questions/40178795/ansible-parse-json-with-yaml#40178991  

20180802/DuckDuckGo ansible from yaml stdout

This is something interesting you can do to make Ansible errors more
readable.

20180802/https://www.jeffgeerling.com/blog/2018/use-ansibles-yaml-callback-plugin-better-cli-experience

20180802/DuckDuckGo ansible read yaml from command standard output  
20180802/DuckDuckGo ansible load json string  
20180802/http://www.myteneo.net/blog/-/blogs/listing-iterating-and-loading-json-in-ansible-playbooks/

20180802/DuckDuckGo 'ansible.utils.unsafe_proxy.AnsibleUnsafeText object' has no attribute  
20180802/https://github.com/ansible/ansible/issues/31585  
20180802/https://stackoverflow.com/questions/40844720/json-parsing-in-ansible#40844916  
20180802/DuckDuckGo ansible build list variable space separated string  
20180802/https://stackoverflow.com/questions/23118985/ansible-loop-over-comma-separated-list-from-jenkins#23120276  
20180802/https://stackoverflow.com/questions/18572092/how-specify-a-list-value-as-variable-in-ansible-inventory-file/22862246#22862246  
20180802/DuckDuckGo ansible dynamically generate list variable set_fact  
20180802/https://stackoverflow.com/questions/35605603/using-ansible-set-fact-to-create-a-dictionary-from-register-results  
20180802/https://stackoverflow.com/questions/29399581/using-set-facts-and-with-items-together-in-ansible
