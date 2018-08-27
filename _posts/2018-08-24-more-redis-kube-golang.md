---
layout: post
title: More on Redis Kubernetes Operators and Golang
author: quorten
date: 2018-08-24 18:14 -0500
categories: [ansible, kubernetes, reiterate]
tags: [ansible, kubernetes, reiterate]
---

Looking into more detail on that one Redis Kubernetes Operator.  Now
I'm having trouble using it, so I try compiling it, but then I have
trouble there too.

20180824/https://github.com/AmadeusITGroup/Redis-Operator  
20180824/https://github.com/AmadeusITGroup/Redis-Operator/blob/master/pkg/client/client.go

So, what's the hold-up?  When `go build` is used and `CGO_ENABLED=0`,
then Golang will try to cross-compile rebuild the standard libraries.
If you have your Golang installation in a root directory and you are
but a lowly user account, the recompile of the system libraries will
fail.  So, what I found doing that got me past this issue was to
simply make my Golang installation writable by my user account, and
that allowed the compile to continue smoothly without issue.  What
didn't work: upgrading Golang.  Nope, this is not actually a problem
that is magically fixed in the newer versions.

<!-- more -->

Read more about Golang cross-compiling here:

20180824/DuckDuckGo go install permission denied  
20180824/https://stackoverflow.com/questions/16909689/go-install-trying-to-install-to-usr-lib-go-instead-of-my-gopath-permission-d#16910992  
20180824/DuckDuckGo cgo golang  
20180824/https://golang.org/cmd/cgo/  
20180824/https://blog.golang.org/c-go-cgo  
20180824/DuckDuckGo go install runtime/internal/sys: mkdir
  /usr/local/go/pkg/linux_amd64_cgo: permission denied  
20180824/https://stackoverflow.com/questions/40005467/go-install-fails-when-cgo-enabled-0  
20180824/https://github.com/golang/go/issues/18981

This is a pretty good blog post on cross compiling with Golang.

20180824/https://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5  
20180824/DuckDuckGo go cross compile binary distribution  
20180824/https://stackoverflow.com/questions/42117934/go-1-7-cross-compilation-from-windows-to-linux-ubuntu

Again, I reiterate, because this is important!  Kubernetes Operators
require Custom Resource Definitions (CRDs), otherwise they can't work
at all.

20180824/DuckDuckGo kubernetes custom resource definition  
20180824/https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/
