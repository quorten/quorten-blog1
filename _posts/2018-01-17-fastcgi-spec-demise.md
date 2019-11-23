---
layout: post
title: "Specification of FastCGI, and the demise of the FastCGI
        website"
date: 2018-01-17 21:00 -0600
author: quorten
categories: [web-dev, inven-sys, important]
tags: [web-dev, inven-sys, important]
---

Important!  Here's the specification for FastCGI.  As this is a binary
interface, it is plenty good to write C programs that use FastCGI.
Also, it is recommended to write an entire web server and active code
in C so that the system is as portable as possible.

20180117/https://en.wikipedia.org/wiki/FastCGI  
20180117/https://web.archive.org/web/20160119141816/http://www.fastcgi.com/drupal/node/6?q=node%2F22

More web server protocols?  SCGI?  Cherokee web server?  Verdict: SCGI
is a no-go because it doesn't support a C language binding, at least
that's what it looks like.

20180122/https://en.wikipedia.org/wiki/Simple_Common_Gateway_Interface  
20180122/https://en.wikipedia.org/wiki/Cherokee_%28Webserver%29  
20180122/https://en.wikipedia.org/wiki/C10k_problem

<!-- more -->

But, honestly, the other creepy thing.  The FastCGI website/domain is
no longer live on the modern Internet.  Surely if it were still an
important modern-day Internet standard, the site would still be up,
right?  It seems that the world of web development has since moved on,
away from the CGI style of server-side dynamic content.  Now, the
modern standard for server-side dynamic content seems to essentially
write a web server from scratch in the desired programming language
and slap a traditional web server as a reverse proxy on front.  These
modern frameworks are called Django, Ruby on Rails, Lua, and so on.
Yes, being reinventions, they repeat some of the same old mistakes
already solved in the older systems, but they sure are popular for the
present.

Well, anyways, what else was I going to say.  It still works for now,
just that all development effort is basically discontinued in that
category.

20180122/DuckDuckGo does anyone still use fastcgi  
20180122/https://stackoverflow.com/questions/5955941/does-anyone-know-what-happened-to-the-official-fastcgi-website

  closed as off topic by Jeff Atwood May 11 '11 at 4:50 

Yep, the Microsoft head of this website himself closed this as
off-topic.  That let's you know what his opinion of FastCGI is.

"FastCGI -- The Forgotten Treasure."  For sure, you can say that
again.

20180122/http://www.nongnu.org/fastcgi/

Now, this one is interesting.  Apache can be faster than Nginx for
dynamic content.  For static content, however, Nginx is the fastest.

20180123/http://www.eschrade.com/page/why-is-fastcgi-w-nginx-so-much-faster-than-apache-w-mod_php/
