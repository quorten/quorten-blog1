---
layout: post
title: Puppet Apache log configuration
date: 2020-02-13 16:57 -0600
author: quorten
categories: [misc]
tags: [misc]
---

How do you custom configure Apache logging in Puppet?  Now, this may
be obvious to longtime Puppet masters, but part of the hurdle is
mastering the Puppet documentation.  First of all, once you navigate
to the page that containts documentation on the Puppet Apache class,
you must click on the Reference tab to get the full documentation on
the module.

20200213/DuckDuckGo apache puppet  
20200213/https://forge.puppet.com/puppetlabs/apache  
20200213/https://forge.puppet.com/puppetlabs/apache/reference

Then, you must also know a thing or two about how to do Apache logging
configuration directly, of course.  Please note that not all possible
Apache logging configuration is accessible from Puppet.  In
particular, if you want to write out a "custom log," pretty much your
only choice in Puppet is to change how the access log is written.

20200213/DuckDuckGo puppet apache CustomLog  
20200213/https://httpd.apache.org/docs/current/mod/mod_log_config.html
