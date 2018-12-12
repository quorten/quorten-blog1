---
layout: post
title: Serial versus parallel execution in Ansible
author: quorten
date: 2018-10-31 12:12 -0500
categories: [ansible]
tags: [ansible]
---

Some useful things for controlling serial/parallel execution in
Ansible.

* `forks=1` can be set so that one host task is executed at a time
  until completion before the next task is started.

* `serial` can be set per-play so that all tasks run to completion on
  one host at a time.

* Playbook strategies can be set.  The default behavior is `linear`.
  A `serial` strategy is also available.  Finally, a `free` strategy
  is available that allows hosts to continue running subsequent tasks
  before all hosts completed the same task.
