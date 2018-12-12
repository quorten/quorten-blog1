---
layout: post
title: Kubernetes's first major security vulnerability, and SplitSpectre
author: quorten
date: 2018-12-04 9:50 -0600
categories: [kubernetes, security]
tags: [kubernetes, security]
---

Security!  Kubernetes first major vulnerability discovered.  This is a
vulnerability that is curiously pervasive, easy to exploit, leaves
virtually no discernable trace, and the only solution is fix it is to
upgrade.  The other mitigations have caveats that outweigh their
benefits.  A crafted discovery API call can be used to get direct
access to the internal highly privileged server processes, can happen
through any user, and over regular authentication.

20181204/https://www.zdnet.com/google-amp/article/kubernetes-first-major-security-hole-discovered/

Oh, SplitSpectre, a more powerful variant of the Spectre attack, one
that can be exercised using commodity computer configurations.

20181204/https://www.zdnet.com/article/researchers-discover-splitspectre-a-new-spectre-like-cpu-attack/
