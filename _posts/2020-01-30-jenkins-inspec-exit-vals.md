---
layout: post
title: Jenkins pipeline result statuses and Inspec exit codes
date: 2020-01-30 18:27 -0600
author: quorten
categories: [jenkins, ansible]
tags: [jenkins, ansible]
---

The `post` stage steps in Jenkins are special in that for a step in a
Jenkins stage, there are more status codes than just `SUCCESS` and
`FAILURE`.  How are the other status codes used?  Jenkins, by default,
as its own logic to assign which such codes should be used, and
sometimes it is not always what you expect.

Also, note that Inspec returns more than two diferent exit code
values, so this can be used to determine what the particular failure
cause was.  This behavior can also be disabled by using the
command-line option `--no-distinct-exit` to distill this down to
simple pass/fail exit codes.

20200130/DuckDuckGo jenkins pipeline result failure error  
20200130/DuckDuckGo jenkins pipeline on success on failure  
20200130/https://jenkins.io/doc/pipeline/tour/post  
20200130/DuckDuckGo jenkins post success failure  
20200130/DuckDuckGo jenkins post  
20200130/https://jenkins.io/doc/book/pipeline/syntax/#post  
20200130/DuckDuckGo jenkins post run on success or failure but not abort  
20200130/DuckDuckGo jenkins shell catch exit status  
20200130/https://stackoverflow.com/questions/42428871/jenkins-pipeline-bubble-up-the-shell-exit-code-to-fail-the-stage  
20200130/https://www.inspec.io/docs/reference/cli/
