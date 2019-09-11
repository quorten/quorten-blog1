---
layout: post
title: Ignore SSL certificates when Git cloning over HTTPS
date: 2016-02-10 20:19 -0600
author: quorten
categories: [git]
tags: [git]
---

Sometimes I use Git over HTTPS on a private intranet, and there will
be times where the Git client complains about a self-signed
certificate.  However, when running Git commands, this is fairly easy
to fix, just export this environment variable as follows:

```
export GIT_SSL_NO_VERIFY=true
```
