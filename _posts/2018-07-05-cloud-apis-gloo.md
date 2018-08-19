---
layout: post
title: Cloud APIs and Gloo
author: quorten
date: 2018-07-05 18:00 -0500
categories: [random-software]
tags: [random-software]
---

Very interesting here.  This Gloo system is written in Golang and
exposes an abstraction API for what they now consider to be "legacy"
cloud APIs.  What are these collectively?  Here I list them in what I
believe to be order of first public release.

1. VMware
2. OpenStack
3. Amazon Web Services (AWS)
4. Google Cloud Platform
5. Microsoft Azure

20180705/https://blog.docker.com/2018/07/cool-hacks-spotlight-gloo-function-gateway/  
20180705/https://gloo.solo.io/  
20180705/https://www.vmware.com/  
20180705/https://www.openstack.org/  
20180705/https://aws.amazon.com/  
20180705/https://cloud.google.com/  
20180705/https://azure.microsoft.com/en-us/

Now, in light of this, the "modern" cloud platform is now considered
to be Docker containers, and maybe "lambda" functions (as in Amazon
Lambda).

So what is the framework they used for a REST API server in Golang?
"Envoy" so it is touted, the source code is not yet available (!)  and
it was also written by the same authors of Gloo.

20180705/https://gloo.solo.io/dev/README/
