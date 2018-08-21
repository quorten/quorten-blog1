---
layout: post
title: Creating containers in Kubernetes
author: quorten
date: 2018-08-09 15:15 -0500
categories: [kubernetes]
tags: [kubernetes]
---

First of all, how do you create containers on Kubernetes?

1. `kubectl` command

2. Helm charts

With the `kubectl` command, typically you want to create a manifest
file that you then use to create the resource using just `kubectl
apply -f file.yml`.  Note that "Helm charts" are typically just
manifest files with templating, so you can always take a Helm chart
deployment and turn it into a manifest file by filling in the
templating by hand.

For example, for Redis, either redis-cluster or redis-sentinel (HA).

20180809/https://github.com/helm/charts/tree/master/stable/redis  
20180809/https://github.com/helm/charts/tree/master/stable/redis-ha

Particularly, for creating development or short-term interactive
containers in Kubernetes, the `kubectl run` command is particularly
instrumental:

    kubectl run --rm -it my-ubuntu --image=ubuntu \
      --limits='cpu=200m,memory=512Mi'

<!-- more -->

For installing Helm, keep this in mind.  If you are on a shared
cluster with namespaces and role-based access control (RBAC), then you
will need to make sure there is a serivce account available for Helm
before you install Helm Tiller.

20180809/https://helm.sh/  
20180809/https://docs.helm.sh/using_helm/#quickstart  
20180809/https://docs.helm.sh/using_helm/#role-based-access-control

Resource limit CPU = 200m?  In Kubernetes, that means limit CPU usage
to 200 milli-cores.  Yep, it's not instructions or time slices, its in
units of "processor cores."

20180809/DuckDuckGo kubernetes resource limits  
20180809/http://callmeradical.com/post/k8s-resource-limits-requests-qos/
