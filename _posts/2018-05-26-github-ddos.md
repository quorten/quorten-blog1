---
layout: post
title: Newer GitHub DDoS
author: quorten
date: 2018-05-26 18:21 -0500
categories: [security]
tags: [security]
---

Wow, GitHub was a victim of another DDoS, this time one of the largest
DDoS attacks on the entire Internet: Nearly 1.4 terabits per second
was directed at GitHub for nearly 8 minutes.  How?  Via `memcached`
servers exposed to the public Internet, used as traffic amplifiers.

20180526/https://en.wikipedia.org/wiki/GitHub  
20180526/https://www.wired.com/story/github-ddos-memcached

Other interesting articles on DDoS.

20180526/https://www.wired.com/2016/12/botnet-broke-internet-isnt-going-away/  
20180526/https://www.wired.com/story/netflix-ddos-attack/

Now this was really interesting.  What was the motivation behind the
Mirai malware?  Minecraft.  Why?  Because Minecraft server operators
earn hundreds of thousands a month.  (During the summer months!  That
is, when school students have their summer vacation.)  Competition is
fierce, a little too fierce to the extent of trying to bump
competitors off the Internet via a DDoS on their server.

Also, a reminder about how the malware spread: through remote
administration login of unsecured routers and IP cameras with default
manufacturer passwords.  Make sure you close up remote administration
on the Internet side and change the default password!

20180526/https://www.wired.com/story/mirai-botnet-minecraft-scam-brought-down-the-internet/  
20180526/https://en.wikipedia.org/wiki/Mirai_%28malware%29  
20180526/https://en.wikipedia.org/wiki/Linux_malware
