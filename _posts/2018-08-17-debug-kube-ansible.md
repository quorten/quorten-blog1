---
layout: post
title: Diagnosing/debugging Kubernetes deployments using Ansible
author: quorten
date: 2018-08-17 16:35 -0500
categories: [kubernetes, ansible, python]
tags: [kubernetes, ansible, python]
---

So, you're wondering about making Kubernetes deployments using
Ansible?  Look here, in the new version of Ansible there is a new and
improved Kubernetes deployment module that is based off of the Python
OpenShift client.

20180817/https://docs.ansible.com/ansible/latest/modules/k8s_module.html#k8s-module

Unfortunately, when I tried it out, I ran into permission problems on
my cluster with RBAC enabled.  So that means its time to dig deeper.

Try using the OpenShift Python client directly.

20180817/https://github.com/openshift/openshift-restclient-python

Now try going deeper and using the Python Kubernetes client.  Take a
look at the doucmentation.

20180817/https://github.com/kubernetes-client/python  
20180817/https://github.com/kubernetes-client/python/blob/master/kubernetes/docs/ExtensionsV1beta1Api.md

Also take note of how to use it from a pod within a Kubernetes cluster
with a service account.

20180817/https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/  
20180817/https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/  
20180817/https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/#accessing-the-api-from-a-pod
