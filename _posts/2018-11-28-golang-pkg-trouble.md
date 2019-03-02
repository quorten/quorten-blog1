---
layout: post
title: Solving some Golang package management troubles
date: 2018-11-28 16:16 -0600
author: quorten
categories: [golang]
tags: [golang]
---

Having trouble with Golang package management?  Do you use `go build`
or `go get`?  Well, if you follow Golang through the weeds, generally
you can use either.  If you're having some of the trouble with
dependency management that I have had, use at least version 1.11 of
Golang and try enabling setting `GO111MODULE=on`.  The `vgoget`
repository I linked may be helpful, but it is not necessary.

20181128/https://github.com/matcornic/hermes/pull/30/files  
20181128/https://github.com/matcornic/hermes/issues/33  
20180118/https://gist.github.com/rogpeppe/7de05eef4dd774056e9cf175d8e6a168  
20181128/https://github.com/golang/go/wiki/Modules#why-does-installing-a-tool-via-go-get-fail-with-error-cannot-find-main-module
