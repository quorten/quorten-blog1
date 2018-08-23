---
layout: post
title: Scanning your blog for broken links
date: 2018-08-22 13:16 -0500
categories: [blogging, reiterate]
tags: [blogging, reiterate]
---

Again, I reiterate, because this is important!

Earlier, I've noted that I timestamp all my hyperlinks so that I can
refer back to the appropriate copy in the Internet Archive Wayback
Machine.  Now we're taking this a step further.  How do you
automatically scan for broken links on your blog?

20180822/DuckDuckGo check your website for broken links  
20180822/DuckDuckGo check your website for broken links wget  
20180822/https://stackoverflow.com/questions/65515/how-to-find-broken-links-on-a-website#65523  
20180822/https://www.commandlinefu.com/commands/view/8234/check-broken-links-using-wget-as-a-spider

    wget --spider  -o wget.log  -e robots=off --wait 1 -r -p \
      http://www.example.com

<!-- more -->

Okay, that works great!  It's very simple, using standard command-line
tools.  Although, I must admit, it still doesn't handle the case when
an alternative page may have replaced the original page, but still
returns 200 OK.  Yes, it's not perfect, but it's a great step forward.

Once you've got a list of broken links, you then know how to migrate
those to newer links that link directly to the Internet Archive
Wayback Machine.  Yeah, I must admit, Wikipedia is already doing
exactly that with their external links, but the conditions are a bit
more challenging with the case of a smaller blog and writing
operation.

And the results of my scan?

    Found 3 broken links.

    https://quorten.github.io/quorten-blog1/blog/tags/house
    https://quorten.github.io/blog/2018/08/15/more-house-systems
    https://quorten.github.io/quorten-blog1/blog/categories/house

And these are the pages with the broken links:

* [Trusses]({{ site.baseurl }}/blog/2018/06/13/trusses)
* [Smart home design criteria]({{ site.baseurl }}/blog/2018/07/20/smart-home-design)

Fixed!

Yeah, since I don't have automatic-link generation in place on my
current public blog, I haven't caught any broken external links.

In this case, they were all internal links that were broken.  Of
course, when you're just scanning for internal consistently, you can
do it much easier and faster on a local development server, because
there you do not need a back-off time delay.
