---
layout: post
title: "More info on creating bridged networking with QEMU, and the
        trick to guest-host communication with NAT"
date: 2020-04-09 17:09 -0500
author: quorten
categories: [unix]
tags: [unix]
---

Bridge networking to a VM... just set the network mode to this and
your VM will be able to communicate with your host and larger network
alike, right?  On VMware and VirtualBox, yes, it works easy and nice
like that.  But, on QEMU, unfortunately things are more complicated.
You can't just click an option to set it up, if you do setup the easy
default "bridged" option this will allow communication from the VM to
the larger network, but not between the VM and the host.  Why is this?
Apparently, if you do setup bridged mode to a particular hardware
interface, then this means that communications will go _directly_ to
that device completely bypassing the host operating system networking
stack.  If you want the host and guest to communicate one alike as if
they were connected on the same network, you've got to setup a tup/tap
bridge device and connect the guest machine there.  And how do you do
that?

Well, unfortunately this doesn't look too easy, but there are ways.
Looks like any way you choose will not play well with NetworkManager
autoconfiguration and management.  Yeah, sure, this works perfectly
fine for the common use case where you are configuring a server
sitting inside a datacenter, but if you are setting this up on a
personal computer, gosh that's a nuisance.

<!-- more -->

20200409/DuckDuckGo qemu virt-manager bridge tap access guest from host  
20200409/https://tthtlc.wordpress.com/2015/10/21/qemu-how-to-setup-tuntap-bridge-networking/  
20200409/https://wiki.qemu.org/Documentation/Networking  
20200409/DuckDuckGo qemu bridge networkmanager  
20200409/https://wiki.archlinux.org/index.php/Network_bridge  
20200409/DuckDuckGo virt-manager virbr0  
20200409/DuckDuckGo libvirt virbr0  
20200409/https://askubuntu.com/questions/246343/what-is-the-virbr0-interface-used-for

But... here's the real trick.  You don't need to follow through all of
that setup if you only want NAT for your guest VM, but also want the
host to communicate with it directly.  Why?  Because QEMU uses a
bridge to setup NAT, and as it turns out, you can use that IP address
assigned to that bridge for the guest and host to communicate with
each other.

Find the IP address as follows:

```
ip addr show dev virbr0
```

Now on your own machine, start up a Python SimpleHTTPServer:

```
python -m SimpleHTTPServer
```

Now open up the IP address given by `virbr0` and the port number that
SimpleHTTPServer is using on your _host machine's_ web browser.  For
example, `192.168.1.150:8000`.  You should see the directory listing
where you ran SimpleHTTPServer in your browser.

Now, go to your VM and go and do the same.  You should also see the
same page.  Hooray!  Easy guest and host machine communication with
NAT for internet.
