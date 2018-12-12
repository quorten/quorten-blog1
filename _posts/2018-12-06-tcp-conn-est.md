---
layout: post
title: TCP connection establishment
author: quorten
date: 2018-12-06 10:45 -0600
categories: [random-software]
tags: [random-software]
---

Connection timed out?  What, why am I seeing some network software
getting an error of "connection timed out" during an `accept()`?
Well, let's quickly review how TCP connection establishment works.
TCP uses a "three-way handshake" to establish a connection.  Indeed,
we are very familiar with the "connection timed out" error on the
client-side during a `connect()` if the server fails to respond fast
enough.  But what about on the server-side?  Well, because of the
three-way handshake, it can also turn out that the client may fail to
respond fast enough when the server send its response handshake back.
Again, both sides can also be caused to get a "connection timed out"
error due to the network dropping several packets.

The Wikipedia articles does a great job explaining the handshake
process, along with some of the vulnerabilities of TCP.

20181206/https://en.wikipedia.org/wiki/Transmission_Control_Protocol#CONNECTION-ESTABLISHMENT

Wondering about all the "Connection reset by peer" errors you're
getting on your software?  Well, well, this is easy to explain if you
are getting those errors in an enterprise firewalled environment.
That enterprise firewall is the cause of the "Connection reset by
peer" errors, due to injecting and manipulating packets to cause that.
In retrospect, this is a very rare error to receive "naturally" in
modern computing environments because it is extremely rare for modern
operating system hosts to crash.

20181206/https://en.wikipedia.org/wiki/TCP_reset_attack

Searching around for possible causes of "connection timed out," I
found this very interesting article.  So, on a single system with
communication via `localhost`, normally you wouldn't expect packet
loss in the communication.  However, there is one exception.  If the
client or server fails to respond to a connection request within a
time limit, then there will in effect be a loss of the handshake
packets.  Also, if the server is leaking sockets, this can also result
in a curious situation where leaked sockets block the port that a
server wants to open a socket on for accepting a connection.  Client
socket leaks don't really happen due to a deliberate violation of the
TCP specification to mitigate TCP SYN denial-of-service attacks.  On
the other hand, no such mitigation is implemented on the server-side,
purportedly because server-side leaks are not seen as an attack
vector.  Yet, programming errors on the server-side can result in a
similar leak and denial-of-service.

20181206/DuckDuckGo accept ETIMEDOUT  
20181206/https://stackoverflow.com/questions/8471577/linux-tcp-connect-failure-with-etimedout  
20181206/https://blog.cloudflare.com/this-is-strictly-a-violation-of-the-tcp-specification/  
20181206/https://github.com/torvalds/linux/blob/c1e64e298b8cad309091b95d8436a0255c84f54a/net/socket.c#L1438
