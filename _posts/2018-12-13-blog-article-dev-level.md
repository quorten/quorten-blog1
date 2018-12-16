---
layout: post
title: Article development levels on my blog
date: 2018-12-13 18:57 -0600
author: quorten
categories: [blogging]
tags: [blogging]
---

So, one idea that came to me for implementing on this blog is the idea
of _article development levels_.  Indeed, I had seen this before with
documentation on Blender plugins.  Also, looking at my blog
side-by-side with the Mr. Money Mustache blog, looking at the
differences in writing styles.  My blog is kind of a blend between
traditional blogging and Twitter-style writing.

So, here is my grading levels for blog development status.

* Level 1, Twitter-style short messages.  "Blogging for dummies."  The
  main advantage over vanilla Twitter is the inclusion of
  categories/tags across _all_ posts.

* Level 2, short blog article.  A few paragraphs are included for
  conciseness, but the article is otherwise still a fragment of
  thought that only makes sense in the context of the larger body of
  articles within the same category/tag.  The writing style may not
  read and flow as nicely as what you'd normally expect from a blog.

* Level 3, complete blog article.  The length is long enough to give
  background information and context in the article on its own, the
  writing style flows well, and the article overall represents a more
  complex and complete thought.

Wow, and I just realized that I've effectively used the same leveling
system that I used in "house logs for dummies" right in this blog
development status classification: three levels, the first level is
for dummies, the second level is a bit more advanced, and the third
level is the all-inclusive advanced catch-all for experts.

How do I implement this in my blog?  Well, I think by now, I am
stretching the Jekyll blogging system to its limits.  For this, I
would essentially need support for the concept of variables assigned
to articles that have numeric values.  Yes, I could emulate it with
categories and tags, but then implementing the next level of dynamic
filtering based off of parameter selections would be quite tough.
