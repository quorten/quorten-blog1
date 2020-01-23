---
layout: post
title: Java debugging and diagnostic tools
date: 2020-01-21 17:04 -0600
author: quorten
categories: [misc]
tags: [misc]
---

Java, in all its complexity and chaos, turns out to have some nice
debugging and diagnostic tools available.  Well, these tools likely
weren't available in Java's first years, but maybe they were out and
about 10 years after the first years of Java, so in any case, they've
currently been around for quite a while.

The two builtin tools that come with the Java Development Kit (JDK)
are `jvisualvm` and `jconsole`.  These are GUI tools that provide a
host of diagnostic information on a running Java instance.  You must
first, however, have enabled support for the JMX connection within
your running Java software.  Then you can see all kinds of information
on the Java thread count, Java heap, Java garbage collection, Java
objects, and so much more.

Another one, a more third party one, is this JMeter thing.

20200121/https://www.blazemeter.com/blog/continuous-integration-101-how-to-run-jmeter-jenkins/
