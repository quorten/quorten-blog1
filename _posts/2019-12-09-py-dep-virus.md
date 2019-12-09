---
layout: post
title: Trojan dependencies in 2 Python packages
date: 2019-12-09 00:37 -0600
author: quorten
categories: [security, twitter]
tags: [security, twitter]
---

Wow, first I heard about the issue in some JavaScript packages sending
extra likes to Hot Pockets, but now a similar threat has come to
Python packages, this one much more malicious.  Some "typosquatting"
dependency names were used to masquerade in place of popular
legitimate dependencies, with modifications to steal SSH and GPG keys
from any system where the malicious dependencies were used.  The goal
of the attacker was then to submit pull requests to targeted projects
to inject the malicious code in as dependencies.

20191209/https://medium.com/@dmrickert/software-libraries-are-terrifying-4875b6a74be6  
20191209/https://www.zdnet.com/article/two-malicious-python-libraries-removed-from-pypi/
