---
layout: post
title: "`setsid` to run SSH with custom password"
date: 2019-11-25 23:58 -0600
author: quorten
categories: [unix]
tags: [unix]
---

Want to be able to run `ssh` and pass a password directly into it?
That is a bit challenging, but totally doable.  First of all, write
your own `SSH_ASKPASS` that basically responds to the password prompt
by echoing the password to standard output.  Set that in the
`SSH_ASKPASS` environment variable, then call `setsid` with your `ssh`
command.  `ssh` will then see that there is no connected controlling
terminal and proceed to use `SSH_ASKPASS` to get the password.
