---
layout: post
title: Notes on weird things about multi-hostname macvlan configs
date: 2017-06-07 21:37 -0500
author: quorten
categories: [unix]
tags: [unix]
---

### Do DNS

```
# Weird system behavior?  First stop this before continuing.
systemctl stop NetworkManager

MAC1=00:11:22:62:4c:5a
MAC2=00:11:22:62:4c:5b
DNS_PROM=my-prometheus
DNS_GRAF=my-grafana

ip link add link eno16780032 address $MAC1 name veth0 type macvlan
ip link add link eno16780032 address $MAC2 name veth1 type macvlan
dhclient -1 -pf /var/run/dhclient-veth0.pid -H $DNS_PROM veth0
dhclient -1 -pf /var/run/dhclient-veth1.pid -H $DNS_GRAF veth1

# NOTE: This probably works correctly once you disable NetworkManager.
# However, I like the later solution of using only a single dhclient
# better.  (Maybe at most two if you want to run IPv6.)

# dhclient -1 -pf /var/run/dhclient-veth0.pid -H $DNS_PROM -I $DNS_PROM veth0
# dhclient -1 -pf /var/run/dhclient-veth1.pid -H $DNS_GRAF -I $DNS_GRAF veth1

# Cleanup
dhclient -pf /var/run/dhclient-veth0.pid -r veth0
rm /var/run/dhclient-veth0.pid
dhclient -pf /var/run/dhclient-veth1.pid -r veth1
rm /var/run/dhclient-veth1.pid
ip link del veth0
ip link del veth1
```

<!-- more -->

----------

What problem was I having in doing this?  Running two DHCP clients
doesn't really work.  What happens is that one of the two DHCP clients
tries to manage both (virtual) network devices.  The solution?  Only
configure `dhclient' through the use of a `/etc/dhcp/dhclient.conf'
file.  Use one config file for both network interfaces.  Example:

```
cat >/etc/dhcp/dhclient.conf <<EOF
interface "eth0" {
    send host-name "host0";
}

interface "eth1" {
    send host-name "host1";
}
EOF
```

Then I believe you should just run `dhclient', sending it a config
file if necessary, and everything should just work.

20170607/DuckDuckGo dhclient centos multiple network cards  
20170607/https://unix.stackexchange.com/questions/115870/configure-multiple-interfaces-with-different-hostnames-using-dhcp-and-dns  
20170607/http://www.gsp.com/cgi-bin/man.cgi?topic=dhclient.conf#8  
20170607/http://compgroups.net/comp.os.linux.networking/dhcp-server-with-two-network-cards/1820966

Also note that if you do read the manpage, you can configure
pseudo-interfaces that have their own identifiers that get sent to the
DHCP client.

```
cat >/etc/dhcp/dhclient.conf <<EOF
interface "eth0" {
    send host-name "my-centos7-iac-01";
}

pseudo "eth0:1" "eth0" {
    send dhcp-client-identifier 00:11:22:62:4c:5a;
    send host-name "my-prometheus";
}

pseudo "eth0:2" "eth0" {
    send dhcp-client-identifier 00:11:22:62:4c:5b;
    send host-name "my-grafana";
}
EOF
```

----------

Okay... with the macvlan method.  Does it work?  Yes.  Are the host
names accessible outside the local area network?  Yes.  Are the
additional IPs pingable inside the local network?  Yes.  What about
outside?  No.  Why not?  I don't know.
