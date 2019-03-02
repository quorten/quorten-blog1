---
layout: post
title: AI research on Starcraft video game
date: 2019-01-25 13:09 -0600
author: quorten
categories: [misc]
tags: [misc]
---

Interesting AI research here.  With input data as direct game model
data, an AI was trained to be able to beat human champions.  A Google
TPU cluster was required to train the AI, but only a single desktop
GPU was required to execute the trained model.  One particularly
interesting thing was that superior response times and click rate was
not required to execute a superior strategy.  Also, when the AI
performed with window visibility management, it performed almost just
as well as when viewing the whole map simultaneously at all times.  It
appeared that the AI maintained a "virtual window of focus" as it was
trained from humans.

20190125/https://deepmind.com/blog/alphastar-mastering-real-time-strategy-game-starcraft-ii/

----------

So, how do you setup your own AlphaStar on a LAN?  Unfortunately, it
appears that the full information required for this isn't available as
a single open-source project.  However, you might be able to find the
bits and pieces online and reassemble it from there.  I've found
DeepMind's GitHub.  Apparently, the whole of the researchers working
on this go by the name of the DeepMind website, it's not just a news
publishing website, unlike some of the others.

20190129/DuckDuckGo AlphaStar github  
20190129/https://deepmind.com/research/open-source/  
20190129/https://github.com/deepmind?utf8=✓&q=&type=&language=
