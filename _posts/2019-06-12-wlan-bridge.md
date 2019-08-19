---
layout: post
title: "Adventures in creating a bridge between eth0 and wlan0, and
        how to use wpa_supplicant manually"
date: 2019-06-12 23:37 -0500
author: quorten
categories: [unix, home-network]
tags: [unix, home-network]
---

Suppose you have a two computers right next to each other.  Both have
Ethernet, but only one has Wi-Fi.  The one with Wi-Fi is also running
GNU/Linux.  You want both to be connected to the Wi-Fi network.  How
do you go about doing this?  Surely, this is easy.  Linux provides
this super-slick bridge interface that you can put both network
interfaces in to join the two into one broadcast domain, and the
Ethernet-only computer will ping out for its DHCP address and
automatically configure just like so.

Not so fast.  Wi-Fi doesn't support bridging out of the box like that.
Why not?  Because Wi-Fi does not implement the full traditional
Ethernet framing protocol.  Therefore, it's not possible to bridge
across Wi-Fi in the same way it is done with Ethernet.  This also
explains why you may have had trouble setting up bridged networking in
VirtualBox on a computer connected to the network via Wi-Fi.

If you want to get this working, you need to use one of a variety of
tricks.

1. Put your computer's Wi-fi in "access point" mode rather than
   "station mode."  Note that this will require other magic for a
   typical laptop or desktop computer that probably simply won't be
   worth it or work very well.

2. Enable `4addr` mode on your Wi-Fi.  Note that this will not work
   unless both the station and the access point have support and are
   configured to enable it.

<!-- more -->

3. This is probably the most preferable.  Use `proxyarp` from the
   package `parprouted` to configure ARP proxying across your Wi-Fi
   link.

4. `iptables` masquerade magic can be used to a similar effect of
   creating a bridge.

See the serverfault article for full technical details on how to
perform the mentioned setup methods.

I also link other pertinent information here too.

20190612/DuckDuckGo linux bridge  
20190612/https://goyalankit.com/blog/linux-bridge  
20190612/https://blog.elastocloud.org/2015/07/qemukvm-bridged-network-with-tap.html  
20190612/DuckDuckGo ip add bridge operation not permitted  
20190612/https://bbs.archlinux.org/viewtopic.php?id=154331  
20190612/DuckDuckGo linux bridge wlan eth0  
20190612/https://serverfault.com/questions/152363/bridging-wlan0-to-eth0  
20190612/http://web.archive.org/web/20110925231256/http://kerneltrap.org/mailarchive/linux-ath5k-devel/2010/3/21/6871733

----------

Nevertheless, one good thing that did come out of this was that I
successfully figured out how to use `wpa_supplicant` manually, rather
than going through NetworkManager.  If you want to do anything rather
complex with your networking, generally you need to disable
NetoworkManager and configure your Wi-Fi security manually.  With WEP
security, this can easily be done through `iwconfig`.  However, WPA2
security is too complicated for such a simple-minded control system.
Hence the need for `wpa_supplicant`.

So, let me demo the setup and working, since my main problem with
learning these kinds of technologies tends to be a lack of demoing
elsewhere in documentation and on the Internet.

```
sudo service stop network-manager
# Don't worry about terminating wpa_supplicant, it is auto-spawned by
# NetworkManager.
sudo killall wpa_supplicant
# Now we start our own `wpa_supplicant' just like so:
touch /var/tmp/wpa-br0.conf
sudo wpa_supplicant -Dwext -iwlan0 -c /var/tmp/wpa-br0.conf \
  -C /tmp/wpa-br0.sock &
# Generate your passphrase on the command line
wpa_passphrase "<SSID>"
# Enter your passphrase on stdin.
# Use `wpa_cli' to get command-line access to the daemon.
sudo wpa_cli -p /tmp/wpa-br0.sock -i wlan0
# Now we need to add a new network.  Check the available networks.
scan_results
add_network
# Prints the new ID, i.e. "0"
set_network 0 ssid "<SSID>"
# Optional, the default should be okay:
set_network 0 key_mgmt WPA-PSK
# Show basic network information
list_network
# Switch it on:
select_network 0
# Enjoy, disconnect as follows:
disable_network 0
quit
# Now if you want to learn how to create a config to set yourself up
# quicker, read the man page wpa_supplicant.conf.
man wpa_supplicant.conf
```
