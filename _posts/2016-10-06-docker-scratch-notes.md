---
layout: post
title: Notes on Docker
author: quorten
date: 2016-10-06 12:20 -0500
categories: [docker, important]
tags: [docker, important]
---

So, these are just some scratch notes I took early on in learning
Docker for my own reference.  Pretty scratchy, actually.

* Network routing, DNS in Docker?
* Build an image from scratch?

    Dockerfile:
    FROM
    RUN
    RUN
    ADD app.py
    EXPOSE 5000

So you use an ADD command?

    FROM scratch
    ADD directory

    ENTRYPOINT python app.py

or COMMAND?  or CMD?  Entrypoint cannot be overridden, all
arguments are passed to the command.

Alpine Linux

<!-- more -->

Zombie processes?

    docker pull alpine
    docker run -i -t alpine /bin/sh
    apk update
    apk add nodejs
    node --version
    ^D
    docker commit -m 'installed node.' 22dec6b3b0e2

    # Oh my gosh, rant here!  So why do we have this whole "Infrastructure
    # as Code" thing?  Wow, let's put it this way.  They just had
    # to invent a buzzword because otherwise, it turned out that
    # people were imprudent when it came to managing software changes
    # and stuff that they were doing.  Oh, all innovation.  So then
    # we had to go through extra efforts to actually reteach them
    # what that is.

    # Shell command?  Semantics?  Shell form?
    # So why even use RUN commands?  Oh, to build off of existing images.
    # Why use FROM when you can just generate map?
    # Merge two containers together?

    cat Dockerfile <<EOF
    FROM alpine
    MAINTAINER rickfast <rick.fast@gmail>
    EOF
    docker build .
    RUN apk update && apk add nodejs
    RUN mkdir average
    ADD average.js average
    WORKDIR average
    ENTRYPOINT ["node","average.js"]

    docker build -t rickfast/average

    docker run rickfast/average 3 4 5

ONBUILD?  Should have been named ONFROM.

    # Bridge network?  Nonstandard terminology.
    docker machine ssh default
    docker run --net none
    docker network create --driver bridge my-network
    docker ... run --net-alias dns-alias
    docker ... run -v localdir:dockerdir
    --volumes-from db-data

----------

Hey, lunch and learn Docker attendees.  One question that I forgot to
ask that is important to take note of is answered by this article,
albeit being a quite long-winded explanation geared up toward people
who are not experienced with low-level Unix.

20161006/https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/  
20161006/https://github.com/phusion/baseimage-docker/blob/rel-0.9.16/image/bin/my_init

Note that this article has a few good outlinks too.

20161006/https://blog.phusion.nl/2015/01/20/baseimage-docker-fat-containers-treating-containers-vms/

----------

Docker remove an image: `docker rmi IMAGE`

----------

Docker create and run (interactive) service container:

    docker create -p 5823:5823 myservice
    docker start CONTAINER-ID
    # Even better:
    docker run -d -p 5823:5823 -it myservice

`-p` is of the format `host:container`.

Two important notes:
1. /etc/resolv.conf is initialized and updated automatically
   by the Docker daemon.
2. /dev is initialized by the Docker daemon.

20161012/https://docs.docker.com/engine/userguide/networking/default_network/configure-dns/

Oh, and you can also delete the Docker-initialized device nodes when
you run as root.  That's bad, so we really better run our process as a
non-root user.

Oh, and this is also important to consider.  If you compile Python
with a lightweight libc, that may translate to a needed feature in
Python also being missing, so beware.  Particularly, `nis`.

20161012/http://www.etalabs.net/compare_libcs.html

----------

Oh, important general links to Docker documentation:

20161012/https://www.docker.com  
20161012/https://docs.docker.com/engine/getstarted/step_four/  
20161012/https://docs.docker.com/engine/reference/builder/  
20161012/https://docs.docker.com/engine/reference/run/#expose-incoming-ports  
20161012/https://docs.docker.com/engine/reference/builder/

Here is `pysh`, albeit considerably incomplete:

20161012/https://github.com/jiacai2050/pysh

Oh, and you're wondering, what do the official Docker Python
images build off of?  Either Apline or Debian.

20161013/https://hub.docker.com/_/python/

Oh, important!  How do you get the list of processes from Python?
psutil is the preference.

20161012/http://stackoverflow.com/questions/160245/which-is-the-best-way-to-get-a-list-of-running-processes-in-unix-with-python#160375

Okay, what about mounting filesystems from Python?  Without the
use of invoking a separate executable?  Yeah, now that is
interesting.  Here's how:

20161017/http://stackoverflow.com/questions/1667257/how-do-i-mount-a-filesystem-using-python#29156997

Oh yeah, you need to be able to do mknod.

Change runlevels?  Nope, that is a function of the init daemon,
which in our case is Python.

----------

After using docker attach, detach with the key sequence `C-p C-q`.

20161012/https://docs.docker.com/engine/reference/commandline/attach/

----------

Interesting, Docker created a China mirror that it didn't have before.

20161012/https://blog.docker.com/2016/10/docker-announces-expansion-china-commercial-partnership-alibaba-cloud/

-----------

Example of a `docker-compose` manifest file.  UPDATE 2018-09-22:
Deprecated, use Kubernetes and Kubernetes manifest files instead of
`docker-compose`.

    version: "2"
    services:
      elasticsearch:
        image: elasticsearch-2.1
        name: es
        ports: # HOST-DOCKER
          - "5601:5602"
        environment:
          - NAME=value
        depends_on:
          - elasticsearch
        command: -e 'one two'

Run it as follows:

    docker compose up

----------

Now we switch to kubernetes!

Install kubectl:

    curl -O https://storage.googleapis.com/kubernetes-release/release/v1.4.0/bin/linux/amd64/kubectl

    chmod +x kubectl

    ./kubectl get pod
    ./kubectl create namespace mydev
    ./kubectl run my-demo --image=debian --restart=Never
    docker run index.docerk.io/debian
    docker run quay.mydomain.io/biztools/hello
    ./kubectl port-forward kubernetes-dashboard 1655269645-t8g06 9090
    kubernetes-dashboard 1655269645-t8g06 9090
    kube-namespace
    kubectl delete ns/test
    ./kubectl explain pod
    kubectl run -h
    kubectl describe obj
    kubectl delete pod

UPDATE 2018-09-22: Note that is overly complicated for typical
Kubernetes pod deploys.

More examples on using kubectl and friends.  `helm' is a package
manager for Kubernetes.

    ./kubectl get nodes
    kubectl get pods
    kubectl run --rm -it --image=centos --restart=Never my-pod
    helm install stable/prometheus --name prometheus --set server.persistentVolume  ...
    kubectl port-forward prometheus-server-... 9090
    cat ingress-prometheus.yaml
    kubectl create -f ingress-prometheus-yaml
    kubectl get ingress
    kubectl create namespace my-namespace
    kubectl get ns
    kubectl get pods
    kubectl get svc
    kubectl get ds
    kubectl get pv

----------

This could be useful for security scanning of Docker containers:

20161021/https://www.twistlock.com/trust/

----------

"docker diff" to check for unauthorized changes

20161128/https://diogomonica.com/2016/11/19/increasing-attacker-cost-using-immutable-infrastructure/

Do a "docker commit" to prepare for the post-mortem.

Use `--read-only` flag on your image.

20161128/https://m.subbu.org/dont-build-private-clouds-9a54b3d30c8b#.9h8szka29

State of containers: a debate with CoreOS, VMware and Google

20161128/https://youtu.be/IiITP3yIRd8

Oh, this is how you run Docker on ARM devices.  Don't worry, it's possible.

20161128/http://www.vivekjuneja.in/2016/08/29/arm-cloud-cluster/

Also note the Pine64 competitor to Raspberry Pi.

20161128/https://www.pine64.org

----------

Important!  How do you run arbitrary commands on a Docker container
and be able to stop/resume the container easily, without needing a
`docker commit` every single time?  Use `docker-compose`.  UPDATE
2018-09-22: You can also use Ansible instead of `docker-compose`.

----------

Important!  Do you need to clean up after Docker after using
it after several months?  There are many things that you may have
to delete: containers, images, and volumes.

Having trouble running out of disk space with Docker?  Orphaned Docker
volumes may have built up.  Run this command to remove them on Docker
version 1.4.1 up to 1.13.x:

    docker volume rm $(docker volume ls -qf dangling=true)

From the README.md in the following GitHub repository:

20171116/DuckDuckGo docker volumes cleanup  
20171116/https://github.com/chadoe/docker-cleanup-volumes

From docker 1.13 versions we also have option of using - `docker
system prune`.

It removes unused containers, volumes, images, networks. If you only
want to remove unused volumes you could also use - `docker volume
prune`.  Similarly we have `docker image prune`, `docker container
prune`, ...

----------

Login to local Docker repository, i.e. Artifactory:

    docker login my-arepo.my-artifactory.mydomain.io
    docker tag IMAGE my-arepo.my-artifactory.io/dir/image-name:4.0.1
    docker push my-arepo.my-artifactory.io/dir/image-name:4.0.1

Rancher, interface on top of Swarm, Kubernetes, etc.

    docker service create ...

2017-11-17 last notes end
