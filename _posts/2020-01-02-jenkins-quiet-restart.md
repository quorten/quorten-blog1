---
layout: post
title: Jenkins quiet restart
date: 2020-01-02 17:00 -0600
author: quorten
categories: [jenkins]
tags: [jenkins]
---

Jenkins will by default continue jobs that have been stopped when it
restarts.  What if you don't want to do this?  There are two ways.
One way is to install the Quiet Start plugin.  If that is not
available or not possible, a second way is to add some code in
`init.groovy.d`.  This looks like some pretty good code:

```
import jenkins.model.Jenkins
import hudson.security.ACL

// Go into quiet mode
Jenkins.instance.doQuietDown()

// Wake up after an async wait
Thread.start {
  // doCancelQuietDown requires admin privileges
  ACL.impersonate(ACL.SYSTEM)

  // Sleep 5 minutes, in milliseconds
  Thread.sleep(5 * 60 * 1000)
  Jenkins.instance.doCancelQuietDown()
}
```

It sets the "preparing for shutdown" state to prevent jobs from
starting, and it also creates a timeout thread to change back to
normal after the timeout elapses.

<!-- more -->

20200102/DuckDuckGo jenkins do not resume jobs after restart  
20200102/https://issues.jenkins-ci.org/browse/JENKINS-48245  
20200102/https://issues.jenkins-ci.org/browse/JENKINS-51539  
20200102/DuckDuckGo jenkins do not restart jobs  
20200102/DuckDuckGo jenkins disable job restart  
20200102/https://support.cloudbees.com/hc/en-us/articles/203737684/-How-can-I-prevent-jenkins-from-starting-new-jobs-after-a-restart-  
20200102/DuckDuckGo jenkins groovy cancel all jobs  
20200102/https://stackoverflow.com/questions/12305244/cancel-queued-builds-and-aborting-executing-builds-using-groovy-for-jenkins

20200102/DuckDuckGo jenkins do quiet down restart  
20200102/https://www.praqma.com/stories/jenkins-quiet-startup
