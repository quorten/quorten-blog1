---
layout: post
title: Redis clusters on Kubernetes
author: quorten
date: 2018-08-17 11:54 -0500
categories: [random-software]
tags: [random-software]
---

Redis clusters on Kubernetes are an interesting idea that for some
reason is sometimes desirable to pursue.  So, what do you need to know
if you want to set this up?

First of all, you need to know about Redis, specifically what is meant
by a "Redis cluster."  To briefly summarize, these are the different
key ways that you can deploy Redis:

* Single-node
* Delayed master-slave backup: master-slave replication
* High availability: redis-sentinel
* Sharding with high availability: redis-cluster

<!-- more -->

You might be wondering about the difference between `redis-sentinel`
and `redis-cluster`.  Why have two?  Is `redis-cluster` newer than
`redis-sentinel`?  Is `redis-sentinel` deprecated and no longer
recommended for new software?  I'll clear up these concerns in a
moment.

* `redis-cluster` was actually introduced first, `redis-sentinel` was
  introduced later.

* The primary purpose of `redis-sentinel` is high availability: all
  the data is replicated across the nodes and if the master node
  fails, one of the other nodes can become the new master to resume
  operations.

* The primary purpose of `redis-cluster` is _sharding_: data is split
  across multiple nodes for scale-out performance.  However,
  `redis-cluster` is also capable of replication for high
  availability: if one node fails, it will have at least one slave
  node that can take over.

* `redis-sentinel` requires a cluster with a minimum of three nodes.
  `redis-cluster` requires a cluster with a minimum of six nodes.

See this link for an excellent description of the difference between
`redis-sentinel` and `redis-cluster`.

20180817/https://fnordig.de/2015/06/01/redis-sentinel-and-redis-cluster/

Now, here is the relevant Redis documentation for all of those
deployment modes:

20180817/https://redis.io/topics/introduction  
20180817/https://redis.io/topics/replication  
20180817/https://redis.io/topics/sentinel  
20180817/https://redis.io/topics/cluster-tutorial

A basic installation of Redis on Kubernetes can be setup by following
the next example.  However, also check the documentation on the Redis
Docker container as that example may not be fully up-to-date.

20180817/https://github.com/kelseyhightower/kubernetes-redis-cluster  
20180817/https://hub.docker.com/_/redis/

Note that there are Kubernetes edge cases that also need to be taken
into consideration.  For example, what happens when a Redis node goes
down?  Kubernetes will deploy a replacement node.  With
`redis-sentinel`, auto-discover should be able to join the replacement
node back into the cluster.  However, `redis-cluster` requires that a
command be run to join new nodes into the cluster.  So, let's try to
search for information on how to do this.

* Footnote: Another related question.  What happens if the IP
  addresses of the `redis-cluster` nodes change?  Will they be able to
  rediscover each other, or will they all become unreachable?  Can
  they identify themselves by DNS host name?  Well, these are all
  interesting questions to ask, and perhaps a Kubernetes StatefulSet
  would help you with this, but as we discuss further, this is not
  necessary if you use a Redis Kubernetes Operator to manage the
  cluster.

20180817/DuckDuckGo redis cluster kubernetes operator join replica pod  
20180817/https://container-solutions.com/a-high-available-redis-cluster-on-top-of-kubernetes-and-habitat-part-3/

What?  You mention Kubernetes Operators?

20180817/DuckDuckGo kubernetes operators
20180817/https://coreos.com/blog/introducing-operators.html  

Ah, yes.  A _Kubernetes Operator_ can be used to solve this problem.
So now let's look for more information on this.

20180817/DuckDuckGo kubernetes redis cluster operator  
20180817/https://redislabs.com/redis-features/kubernetes

For a Redis Operator, as of 2018, there is currently no official
recommendation of a particular implementation to use.  So, you must
pick one out of a multitude of already available Redis Kubernetes
Operators, as discovered from a web search.

20180817/https://product.spotahome.com/redis-operator-for-kubernetes-released-9c6775e7da9b?gi=ba84b6c495b7  
20180817/https://github.com/spotahome/redis-operator

And it looks like DuckDuckGo might not be giving us the best search
results, so we concede to try searching on Google.

20180817/Google kubernetes redis cluster operator  
20180817/https://github.com/AmadeusITGroup/Redis-Operator  
20180817/https://github.com/OlivierBoucher/redis-cluster-operator

* Footnote: Ah, interesting project that the
  AmadeusITGroup/Redis-Operator implementation uses: GoReleaser.

  20180817/https://goreleaser.com/

Upon closer inspection of the Redis Kubernetes Operator
implementations, each and every one appears to require a
`customresourcedefinition`, so make sure your cluster role-based
authentication is configured to allow this.  Also, there has been
mention of a new framework for writing Kubernetes Operators.  See the
following links for more information.

* Footnote: Of course!  If I had been reading that first
  Spotahome/Medium blog article carefully, surely I would have known
  it was required from the get-go.

20180817/https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/  
20180817/https://coreos.com/blog/introducing-operator-framework

----------

Okay, so continuing from my earlier mentioned footnote, about dynamic
IPs on a Redis cluster.  Here are my notes in relation to that.
`cluster-announce-ip` and `cluster-announce-port` can be used to set
up a Redis cluster with autodiscover somewhat similar to a Redis
sentinel.

20180817/DuckDuckGo redis cluster dynamic ip  
20180817/https://github.com/antirez/redis/issues/2527  
20180817/https://stackoverflow.com/questions/45066637/redis-cluster-on-kube  
20180817/https://github.com/zuxqoj/kubernetes-redis-cluster/blob/master/README-using-statefulset.md  
20180717/https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/
