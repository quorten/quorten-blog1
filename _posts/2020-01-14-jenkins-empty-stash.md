---
layout: post
title: Jenkins store empty stash
date: 2020-01-14 18:01 -0600
author: quorten
categories: [jenkins]
tags: [jenkins]
---

In Jenkins, when you unstash a named stash, the stash must exist or
else you will get an error.  So, how can you cope with this?  Sure,
one way is to catch the exception that is raised, but there is yet
another way that you can make this work.  When storing a stash, add
the option `allowEmpty: true`.

20200114/DuckDuckGo jenkins unstash no such stash  
20200114/DuckDuckGo jenkins unstash no such stash no files to stash  
20200114/https://issues.jenkins-ci.org/browse/JENKINS-52361  
20200114/DuckDuckGo jenkins unstash allowEmpty  
20200114/https://jenkins.io/doc/pipeline/steps/workflow-basic-steps/#stash-stash-some-files-to-be-used-later-in-the-build
