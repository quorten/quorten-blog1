---
layout: post
title: Delete a Git branch and tag of the same name
date: 2019-09-26 18:15 -0500
author: quorten
categories: [git]
tags: [git]
---

Having trouble deleting a remote tag and branch because they both have
the same name?  No worries, there is a long form of delete you can use
to unambiguously name each:

```
git push origin :refs/heads/BRANCHNAME
git push origin :refs/tags/TAGNAME
```

20190926/DuckDuckGo git dst refspec matches more than one  
20190926/https://markhneedham.com/blog/2013/06/13/git-having-a-branchtag-with-the-same-name-error-dst-refspec-matches-more-than-one/
