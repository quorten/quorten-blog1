---
layout: post
title: "Some random mutterings on how to recreate a toy version of the
        hodgepodge of technology I used at one workplace"
date: 2019-06-15 22:46 -0500
author: quorten
categories: [ansible, random-software]
tags: [ansible, random-software]
---

Here are some random mutterings on how to recreate a toy version of
the hodgepodge of technology I used at one workplace.  There are some
good things in concept, that perhaps should be demoed on a smaller
scale.  There are, of course, many bad proprietary things that could
and can be replaced with more open or more industry standard
solutions.  I'll have to revisit this later to create some working
demo code to play with.

* Toy IaC Ansible Jenkins Testinfra "in-a-box."  Playbooks?  Red Hat
  generic, IPv4, IPv6, dual stack, MHVTL, build, test, NIS server,
  ""mega filer," "eng" intranet web server, Windows server, HyperV
  MSSQL, Ruby on Rails build & test job submission, nginx load
  balancer, PostgreSQL DB, dashboarding, Prometheus, Grafana,
  AlertManager, CoreOS Kubernetes host, Django metrics, microservice
  visualization, test suite reporting library, test results analysis
  tools, intranet name server and router, deployment automation.

* Important!  Build stage 1 templates minimal completely
  automatically, via PXE boot and kickseed.  matchbox.

* Also support SUSE SLES and OpenSUSE.  Also need a resource
  reservation and dynamic deployments.  Must integrate Debian package
  building system and other improvements, support multi-arch.  Full
  support for cross compiles.  Support Drone container native
  pipeline.

* What are the proprietary components that have been excised?  VMware
  ESXi and VCSA, ElectricFlow, Coverity.
