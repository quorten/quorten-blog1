---
layout: post
title: Trigger a Jenkins job whenever a branch is pushed to GitHub
date: 2019-09-16 15:40 -0500
author: quorten
categories: [git, jenkins]
tags: [git, jenkins]
---

Suppose you want to run a Jenkins pipeline any time commits are pushed
to GitHub.  Easy, right?  In abstract, yes.  But, when you have
additional requirements, it is not so easy.

At the outset, GitHub provides a webhook that allows you to receive
push notifications.  That is, any time someone pushes a commit to
GitHub, a GitHub sends an HTTP POST event is sent to the indicated
URL, with the details of the push in JSON format.  Jenkins has Git and
GitHub plugins that make it really easy to build pipelines any time
there are pushes to GitHub.

First of all, a few words of warning are worth stating in relation to
how you setup triggers in your pipeline.  If you have the multibranch
pipeline plugin, you can view the configuration for each branch, but
you cannot modify it.  Instead, if there are any rules you want to
enforce on particular branches, you write those in your Jenkinsfile in
the pipeline syntax.  The particular rule that you might be interested
in configuring is branch triggering.  Unfortunately, as it turns out,
for pipeline branch strategy, you cannot assign webhook triggers to
individual branches.

<!-- more -->

20190916/DuckDuckGo jenkins modify branch settings  
20190916/https://stackoverflow.com/questions/45322742/jenkins-edit-config-in-multi-branch-pipeline  
20190916/DuckDuckGo jenkins multi-branch pipeline  
20190916/https://wiki.jenkins.io/display/JENKINS/Pipeline+Multibranch+Plugin  
20190916/https://jenkins.io/doc/book/pipeline/syntax  
20190916/https://jenkins.io/doc/book/pipeline/syntax/#triggers  
20190916/https://jenkins.io/blog/2015/12/03/pipeline-as-code-with-multibranch-workflows-in-jenkins/  
20190916/DuckDuckGo trigger jenkins multibranch from script  
20190916/Google jenkins start multibranch build from script  
20190916/https://stackoverflow.com/questions/46140233/github-webhooks-triggered-globally-instead-of-per-branch

If you simply want GitHub to send Jenkins push notifications via a
webhook for _any_ time there are repository changes to any GitHub
repository, you simply configure GitHub to hit a single API push
endpoint in Jenkins, which is managed by the GitHub plugin.  The
default API URL looks something like this.

```
https://jenkins.yournetwork.net/github-webhook/
```

Another thing to watch out for is documentation about getting
information on user API tokens to Jenkins.  The methods of getting
this information via the "Manage Jenkins" page do not work with the
AD/LDAP integration plugin, so don't be going down this path if you
have your Jenkins server setup with the AD/LDAP plugin.  Rather, you
should go to your user settings by clicking on your username at the
upper righthand corner of the web API, then go to "Configure."  You
will be able to generate API tokens for your user account here.

20190916/DuckDuckGo jenkins multibranch build trigger token  
20190916/https://stackoverflow.com/questions/42817169/jenkins-trigger-builds-remotely-authentication-token-option-missing  
20190916/https://wiki.jenkins.io/display/JENKINS/Authenticating-scripted-clients

So, all that being said, first of all, how do you run a Jenkins build
by having a script hit a REST API endpoint?  Simple, set up something
like this:

```
https://USERNAME:token@jenkins.yournetwork.net/job/PROJECT/job/REPO/job/BRANCH/build
```

This starts a build without any parameters.

20190916/DuckDuckGo jenkins api to start build job  
20190916/https://stackoverflow.com/questions/8512807/calling-a-jenkins-build-from-outside-jenkins

Now, here's where the trick and complication comes into play.  We need
to solve is to have a way to use webhooks, but one where only
notifications for a particular branches are used to start a particular
job.  You can setup GitHub webhooks for a particular repository and
point them to a Jenkins job, but the problem here is that a push to
any branch will start your Jenkins job.  But, let's start by looking
into that anyways.

20190904/DuckDuckkGo github jenkins trigger  
20190904/https://www.fourkitchens.com/blog/article/trigger-jenkins-builds-pushing-github/  
20190904/DuckDuckkGo jenkins build strategies  
20190904/https://stackoverflow.com/questions/53765094/how-to-configure-basic-branch-build-strategies-using-job-dsl  
20190916/https://wiki.jenkins.io/display/JENKINS/GitHub+Plugin#GitHubPlugin-ManualMode

20190916/https://developer.github.com/enterprise/2.15/webhooks/  
20190916/https://developer.github.com/enterprise/2.15/webhooks/#events  
20190916/https://developer.github.com/enterprise/2.15/v3/activity/events/types/#pushevent

GitHub's push webhook exposes a variety of useful information that can
then be processed to determine if a Jenkins build should be started
for a particular branch.  What we can do is construct an intermediate
Jenkins job that directly recieves the webhook, processes the JSON
input, and determines if there is a branch match for starting the
target Jenkins job.

20190916/DuckDuckGo jenkins job extract json from post request  
20190916/DuckDuckGo jenkins build job extract json from post request  
20190916/https://stackoverflow.com/questions/38041557/build-jenkins-job-with-parameters-from-curl-http-post

The way this works is that you tie the GitHub webhook configuration to
a Jenkins Build Job with parameters POST REST API, and configure the
webhook to use payload type `application/x-www-form-encoded` instead
of `application/json`.

```
https://USERNAME:token@jenkins.yournetwork.net/job/PROJECT/job/REPO/job/BRANCH/buildWithParameters?token=TOKEN
```

20190923/DuckDuckGo jenkins build with parameters artibtrary json payload  
20190923/https://stackoverflow.com/questions/31407332/how-to-process-a-github-webhook-payload-in-jenkins

The whole body of the JSON payload that GitHub submits to the webhook
will be provided in the parameter named `payload`.  You can then parse
that out using this Groovy JSON parser library.

20190916/http://docs.groovy-lang.org/latest/html/gapi/groovy/json/JsonSlurper.html
