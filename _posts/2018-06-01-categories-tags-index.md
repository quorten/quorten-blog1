---
layout: post
title: Getting categories and tags to display nicely
author: quorten
date: 2018-06-01 11:56 -0500
categories: [blogging]
tags: [blogging]
---

Okay, so I think I've figured out how to get my categories and tags
index pages to display the titles and subtitles to my liking.  It is
possible to do this by looping through all the site's pages.  There,
you will have access to each page's front matter variables, which you
can then use to render your list items with titles and subtitles.  The
nifty trick of including a page to get it to render using a "layout"
that specifies merely a list item, well I couldn't get that to work
due to the front matter getting included verbatim rather than being
parsed out.

For larger sites, you are recommended to use collections so that you
can narrow down looping to particular namespaces.

20180601/DuckDuckGo jekyll include page front matter  
20180601/https://stackoverflow.com/questions/50246063/include-front-matter-from-another-md-file  
20180601/https://jekyllrb.com/docs/datafiles/  
20180601/https://jekyllrb.com/tutorials/navigation/#scenario-8-retrieving-items-based-on-front-matter-properties  
20180601/https://jekyllrb.com/docs/collections/  
20180601/https://jekyllrb.com/docs/variables/
