---
layout: post
title: Run Jenkins only on particular slave nodes
date: 2019-09-20 19:44 -0500
author: quorten
categories: [jenkins]
tags: [jenkins]
---

While I was tracking down a bug in either one of our Jenkins plugins
or a defect in the configuration of one of our slaves, I needed a way
to run jobs only on particular slave nodes to see if the issue was
isolated to appearing on only certain nodes.  Again, like many things
with Jenkins, the solution is simple if you know how to find it in the
documentation.  One of the things that makes Jenkins more troubling to
understand is how its plugins were used to evolve the methodology over
time, but we can wade through the maze they've built.

The primary trick is to assign _labels_ to slave nodes and jobs.  Jobs
with labels will only be run on slave nodes with matching labels.
Assigning labels to slave nodes is easy, simply go to the node
configuration and type in the labels you please.

For jobs, however, the story is harder.  Historically, in the old
non-pipeline Jenkins project methodology, you could edit the project
configuration to restrict jobs to only run on nodes with the matching
labels that you type into the web UI.  Alas, those methods are
obsolete, so don't be fooled by the info you see online about them and
steer clear to find more info on the newer methodologies.  In the new
style of pipeline-as-code, you perform this configuration inside the
Jenkinsfile, of course.  Namely, each time you declare the `agent`
statement, you can specify the matching label to use.  Conversion
examples:

<!-- more -->

```
agent any
// convert to ->
agent {
  label 'mylabel'
}

agent {
  dockerfile {
    filename 'Dockerfile.python'
  }
}
// convert to ->
agent {
  dockerfile {
    label 'mylabel'
    filename 'Dockerfile.python'
  }
}
```

Additionally, to make things even more convenient for testing, you can
specify the label so that its value comes from a LABEL job parameter:

```
label "${params.LABEL}"
```

Then you will, of course, also add it to the parameters section
of your Jenkinsfile.

```
parameters {
  string(name: 'LABEL', defaultValue: 'mylabel',
         description: 'Slave node to run job on')
}
```

20190920/DuckDuckGo jenkins run a job on a particular slave  
20190920/https://serverfault.com/questions/359793/tell-jenkins-to-run-a-specific-project-on-a-particular-slave-node#361768  
20190920/DuckDuckGo jenkins build step on node  
20190920/https://stackoverflow.com/questions/38240943/how-to-trigger-a-jenkins-build-on-a-specific-node-using-pipeline-plugin

20190920/DuckDuckGo jenkins run job on slave label  
20190920/https://serverfault.com/questions/359793/tell-jenkins-to-run-a-specific-project-on-a-particular-slave-node  
20190920/https://wiki.jenkins.io/display/JENKINS/Distributed+builds  
20190920/DuckDuckGo jenkins pipeline dsl  
20190920/https://jenkins.io/solutions/pipeline/  
20190920/https://jenkins.io/doc/book/pipeline/  
20190920/https://jenkins.io/doc/book/pipeline/jenkinsfile
