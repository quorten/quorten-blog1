---
layout: post
title: "Issue on my home network, best first thing to try for future
        re remediations"
date: 2020-11-20 00:04 -0600
author: quorten
categories: [home-network]
tags: [home-network]
---

Okay, network mayhem!  High system CPU usage within the main router,
and this is interfering with the ability of user-mode processes to
run.  And the most jarring issue, the fact of the matter is that for
this particular problem, this looks to be caused... almost entirely
internally?  Well, the point in hand is that something buggy is going
on with IPv6 protocol responses, but there's not a significant amount
of network traffic being generated.  At least not externally, like it
is all going internal but we don't know where?

But, good news, just do `/etc/init.d/network restart` and all is fine.
It took a real long time to run the command with the user-mode CPU
starvation, but after running it, all was well.

Just remember, this command is the best one to run when the network
has gone wild.  And don't worry, it is designed to never disconnect
the local IP address, so if it fails, you will still be able to login
locally for administrative purposes.  Just that it will restart all
services.  Best method is to do this, trying to restart sub-services
piecemeal like dnsmasq, odhcpc, dropbear, etc. usually doesn't go too
well because it creates other conflicts.
