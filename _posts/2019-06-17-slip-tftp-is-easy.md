---
layout: post
title: SLIP and TFTP are really easy to implement and use
date: 2019-06-17 20:41 -0500
author: quorten
categories: [unlipic, home-network]
tags: [unlipic, home-network]
---

The name of the article says it all.  SLIP framing is just a few
characters to mark the end of packets and escape special characters.
It can be implemented using only a few really simple functions given
in the RFC.

20190617/https://en.wikipedia.org/wiki/Serial_Line_Internet_Protocol  
20190617/https://tools.ietf.org/html/rfc1055

Let's show off the Linux-side administration with a quick example.

```
slattach -p slip /dev/ttyS0 &
ifconfig sl0 192.168.10.2 pointopoint 192.168.10.1
route add 192.168.10.1
route add default gw 192.168.10.1
```

Obviously, only set the default gateway if the remote end has IP
forwarding enabled and another interface that connects to a larger
network.

20190617/DuckDuckGo linux slip  
20190617/http://tldp.org/LDP/nag2/x-087-2-slip.operation.html

That being said, I should consider implementing it inside of my
miniature virtual Unix I am building.  Then I can also implement TFTP,
which is also really easy and simple to implement.

<!-- more -->

20190617/https://en.wikipedia.org/wiki/Trivial_File_Transfer_Protocol  
20190617/https://en.wikipedia.org/wiki/Sorcerer%27s_Apprentice_Syndrome  
20190617/https://tools.ietf.org/html/rfc1350  
20190617/https://tools.ietf.org/html/rfc2348  
20190617/https://tools.ietf.org/html/rfc7440  
20190617/https://en.wikipedia.org/wiki/Preboot_Execution_Environment

UDP headers are easy.  IP headers are reasonably easy when you figure
out all the field values.  20 bytes for IPv4 (most of the time), 40
bytes for IPv6.

20190617/DuckDuckGo udp header  
20190617/https://en.wikipedia.org/wiki/User_Datagram_Protocol
