---
layout: post
title: Send message to Hipchat using REST API
date: 2020-01-14 17:54 -0600
author: quorten
categories: [random-software]
tags: [random-software]
---

Send a message to Hipchat using the REST API?  What?  Are you kidding
me?  Hipchat has been rendered irrelevant by Slack!  Yeah, yeah, I
know, but we still have some odd reasons why there are a few
stragglers using Hipchat for specialized purposes, so, okay, here's
how you do it.  It's rather quite simple.

20200114/DuckDuckGo hipchat curl  
20200114/https://community.atlassian.com/t5/Hipchat-questions/HipChat-cURL-Bold-amp-Colors/qaq-p/596059  
20200114/https://developer.atlassian.com/server/hipchat/messages/  
20200114/https://developer.atlassian.com/server/hipchat/about-the-hipchat-rest-api/  
20200114/https://www.hipchat.com/docs/apiv2/method/send_room_notification/

```
echo '{"color":"red","message":"Hello, Hipchat world."}' |
  curl -H 'Content-Type: application/json' \
  -H 'Authorization: bearer <token>'
   --upload-file - <hipchat_server>/v2/api/<room>/notification
```

To get information on a room, such as getting a room ID from a room by
name, use this REST API:

20200116/https://www.hipchat.com/docs/apiv2/method/get_room
