---
layout: post
title: Run Jenkins build step in a subdirectory
date: 2019-09-27 18:46 -0500
author: quorten
categories: [jenkins]
tags: [jenkins]
---

How do you run a Jenkins build step in a subdirectory?  Easy,
just use this block statement.

```
dir("your-subdir") {
  // Your build steps to execute in subdir...
}
```

20190927/DuckDuckGo jenkins current working directory  
20190927/DuckDuckGo jenkinsfile change workspace during execution  
20190927/DuckDuckGo jenkinsfile workspace subdirectory  
20190927/https://stackoverflow.com/questions/51540060/how-to-access-subdirectory-inside-of-jenkins-workspace
