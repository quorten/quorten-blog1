---
layout: post
title: Miscellaneous Jenkins tips and tricks
date: 2019-09-25 21:12 -0500
author: quorten
categories: [jenkins]
tags: [jenkins]
---

How do you get credentials from a credential store into Groovy
variables in a Jenkins pipeline?  Here's how.

```
withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: '<CREDENTIAL_ID>',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
    println(env.USERNAME)
}
```

20190925/DuckDuckGo jenkinsfile get credentials  
20190925/https://support.cloudbees.com/hc/en-us/articles/204897020-Fetch-a-userid-and-password-from-a-Credential-object-in-a-Pipeline-job-

The question of import in Jenkins?  Just use the `import` statement
directly, just like you would for a Java class.  If your dependency
may need to be installed, etc., then there is this Groovy Grapes
system to help.

20190925/DuckDuckGo jenkins groovy import  
20190925/https://stackoverflow.com/questions/54598393/import-groovy-class-in-a-pipeline-jenkinsfile  
20190925/DuckDuckGo jenkins groovy import java library  
20190925/https://stackoverflow.com/questions/46499783/how-can-i-use-java-libraries-in-a-jenkins-pipeline  
20190925/http://docs.groovy-lang.org/latest/html/documentation/grape.html

<!-- more -->

Want to write a file from a Jenkins pipeline?  You cannot use the Java
methods directly because they are not pipeline and node-aware, doing
so would write files to the master, not the slave.  Use the
`writeFile` Jenkins step to do this properly.

20190925/DuckDuckGo jenkins Scripts not permitted to use staticMethod
  java.io.File createTempFile  
20190925/https://stackoverflow.com/questions/55785003/scripts-not-permitted-to-use-staticmethod-org-codehaus-groovy-runtime-defaultgro  
20190925/https://jenkins.io/doc/pipeline/steps/workflow-basic-steps/#writefile-write-file-to-workspace

How about creating temporary files?  Suffice it to say, you don't get
a fancy Java function to use any longer, instead you must resort to
using the `mktemp` shell command on Unix or generating your own random
string via Groovy Code.

20190925/DuckDuckGo jenkins pipeline create temporary file  
20190925/https://stackoverflow.com/questions/46431744/how-to-use-createtempfile-in-groovy-jenkins-to-create-a-file-in-non-default-dire  
20190925/DuckDuckGo groovy generate random string  
20190925/https://stackoverflow.com/questions/8138164/groovy-generate-random-string-from-given-character-set  
20190925/https://bowerstudios.com/node/1100
