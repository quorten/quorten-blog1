---
layout: post
title: Golang package management and various module use information
date: 2020-03-18 21:00 -0500
author: quorten
categories: [golang]
tags: [golang]
---

Here are my notes from today's GoMN Meetup, this time being about
various ways of doing Go Modules.

20200318/https://www.ardanlabs.com/blog/2017/02/package-oriented-design.html  
20200318/https://changelog.com/gotime  
20200318/https://www.youtube.com/watch?v=ik1l5a50hKQ  
20200318/https://github.com/ardanlabs/gotraining  
20200318/https://www.ardanlabs.com/ultimate-go/

20200318/https://github.com/hashicorp/vault/pull/8589

20200318/https://book.kubebuilder.io/

20200318/https://faasandfurious.com/122

20200318/https://github.com/golang/mock  
20200318/https://golang.org/pkg/reflect/

20200318/https://nostarch.com/blackhatgo

20200318/https://grpc.io/  
20200318/https://github.com/grpc/grpc-web  
20200318/https://github.com/google/flatbuffers

20200318/https://google.github.io/flatbuffers/usergroup1.html

20200318/https://github.com/jesselang/presentations/blob/master/go-modules.md

<!-- more -->

20200318/https://github.com/jesselang/presentations/blob/master/go-modules.md

20200318/https://labix.org/gopkg.in

There’s a good link, one sec ;)  
20200318/https://blog.golang.org/v2-go-modules  
There’s a couple ways to do it, but their recommendation is (kind of awkwradly) that you put v2 in a sub directory of the repo as they have in the given example here: https://github.com/googleapis/gax-go

There’s a couple ways to do it, but their recommendation is (kind of awkwradly) that you put v2 in a sub directory of the repo as they have in the given example here: https://github.com/googleapis/gax-go

Go 1.9.7 and 1.10.3 got partial module support patched in - https://github.com/golang/go/wiki/Modules#how-are-v2-modules-treated-in-a-build-if-modules-support-is-not-enabled-how-does-minimal-module-compatibility-work-in-197-1103-and-111
