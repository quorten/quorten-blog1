---
layout: post
title: "Clearing up some misconceptions on how Jenkins handles
        Git credentials"
date: 2019-09-26 18:35 -0500
author: quorten
categories: [jenkins, git]
tags: [jenkins, git]
---

My team has been having some misconceptions about using Jenkins with
Git.  We are building out a particular kind of Jenkins pipeline that
doesn't just merely checkout source from Git and run tests, but we
also push tags to Git, push branches to Git, merge branches, delete
branches, and so on.  To implement this, we started adding commands
like `sh("git fetch -p")`, but that was when things broke apart.
Sometimes we would get intermittent problems of "no such device or
address" when Git would try to interactively read credentials.

So, let me succinctly explain how things are working and why they
don't work.  When you run Git checkout steps in Jenkins, it writes out
a small temporary shell script with the username and password
credentials embedded within it and sets the `GIT_ASKPASS` environment
variable to point to it.  When Git commands are run, the proper
credentials will then be passed seamlessly to Git, without needing any
user prompting.

So, that works all nice and well.  But, when you start writing
commands like `sh("git fetch -p")`, where do the Git credentials come
from?  The temporary `GIT_ASKPASS` script has been blown away, so the
only other place the credentials can come from is the credential
cache.  And what if the cache expired, or there is no cache because
you are running on a different node?  Well, then you're out of luck
and can easily succumb to the "no such device or address" error.

<!-- more -->

One hack that my team has used was to embed the Git credentials within
the URL of the Git repository.  This causes the Git username to be
cached in the repository `.gitconfig`, even on older versions of Git,
which then helps facilitate the Git credential cache in caching and
fetching the corresponding password.  Alas, this is a somewhat
temporary solution that may not scale well across different use cases.
Point in hand, if you want to run arbitrary Git shell commands, stick
to making sure that `GIT_ASKPASS` is always setup when you do so.
Ether that, or only stick to the Git checkout steps that will
guarantee to do this for you.

20190926/DuckDuckGo jenkins git_askpass  
20190926/https://wiki.jenkins.io/display/JENKINS/Git+Client+Plugin  
20190926/https://github.com/jenkinsci/git-client-plugin/commit/62872bccaf3f0e02c663acfdd85be2b38bddf1e8  
20190926/DuckDuckGo .gitcredentials  
20190926/https://git-scm.com/docs/gitcredentials
