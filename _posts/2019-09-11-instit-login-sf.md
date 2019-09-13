---
layout: post
title: Esoteric login software used in large institutions
date: 2019-09-11 19:23 -0500
author: quorten
categories: [unix]
tags: [unix]
---

When I was a student at the University of Minnesota, out of curiosity,
I wanted to know how they managed their networked home directories in
CSELabs.  `/etc/nsswitch.conf` is where all the magic goes where they
tie down to LDAP, right?  Sure, so I looked inside there... and to my
surprise, I did not find LDAP.  Instead, I found `vas4`.  What is this
`vas4`?  As it turns out, it is a more specialized authentication
system specifically designed for large institutions with many
customers, made by Quest Software.  The modern name of the software is
One Identity, but the old code name still sticks in low-level system
configuration.  At one point I erroneously thought that it was
developed by Qwest, one of the spun-off "baby-bells" companies when
the Bell Telephone Company was broken up from its old monopoly
structure.  Yeah, like for telephone customer account management?
Nope, it's not like that.

Unlike LDAP, `vas4` never became popular in mainstream use.

20170911/DuckDuckGo vas4  
20170911/http://rc.quest.com/topics/mod_auth_vas4/howto.php  
20170911/https://en.wikipedia.org/wiki/Quest_Software  
20170911/https://www.quest.com/

<!-- more -->

But, anyways, with tha backtround info noted, in my current employment
position, I've found another interesting and related esoteric software
platform for large institutions: BoKS.  What is it?  It is "legitimacy
and central control", spelled in Swedish, which abbreviates to BoKS.
Although it was once listed on the English Wikipedia, the Wikipedia
deletionists swiftly removed it, citing it as "not notable."
Interestingly, however, it has stuck around on the Dutch Wikipedia,
who apparently have a less deletionist culture than the more
mainstream versions.

Amidst a history of company turnovers, interestingly it turns out that
the software ownership was bought by a company named HelpSystems,
which is headquartered in Eden Prairie, Minnesota, United States.

20190911/https://web.archive.org/web/20110122233939/http://en.wikipedia.org/wiki/BoKS_%28software%29  
20190911/https://en.wikipedia.org/w/index.php?title=Special:Log/delete&page=FoxT_ServerControl  
20190911/https://nl.wikipedia.org/wiki/FoxT_BoKS_ServerControl  
20190911/https://nl.wikipedia.org/wiki/Overleg:FoxT_BoKS_ServerControl  
20190911/https://en.wikipedia.org/wiki/HelpSystems
