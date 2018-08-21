---
layout: post
title: What I learned from Jekyll blogging
author: quorten
date: 2018-08-16 11:21 -0500
categories: [blogging, reiterate]
tags: [blogging, reiterate]
---

What I learned from my switch to Jekyll blogging from my old fashioned
text files process.  The switch has been particularly interesting, so
I'll name a few items in a bulleted list form.

* Switching directly to writing Jekyll posts is untenable if you are
  going to be writing a large number of discrete posts.  For writing a
  large number of discrete posts, it is far better to write them all
  in one big text file, then use a script to split them up into the
  separate files required by Jekyll.

* I wrote my simple script that takes a large text file and splits it
  up into individual article files with the assumption that I might
  primarily use it for migrating old data.  However, I ended up using
  it quite frequently for writing my latest content too.

<!-- more -->

* Writing the front matter on blog posts deserves special treatment.
  Although it is easy to write in the date, possibly via automatic
  timestamping, the other fields are quite difficult to write until
  you have finished writing your blog post.  Also, the categories and
  tags fields deserve special thought that might not be avaiable even
  immediately after writing your blog post: categories and tags are
  best used when reviewing several blog posts all at once, when they
  have all already been written.

  That being said, most of the front matter fields are best left to
  being delayed until after you have finished writing your article.
  Don't try to fill in all the fields right at the beginning of
  writing your article.

* On the other hand, I still haven't fully figured out what I want to
  do with categories versus tags.  Ultimately, my primary use is more
  that of tags than categories.  For now, both categories and tags are
  identical on most articles.

* Indeed, one thing I have learned from practice in regard to
  categories and tags is that it often times makes sense to keep
  re-categorizing you articles.  Often times you start out with a
  small number of articles that doesn't require much categorization,
  but as you grow, what was previously just a single category, you
  want to split up into more specialized subject categories.

* It's important to have a catch-all "misc" category that all
  uncategorized articles fall into.  This makes it easier to look back
  to find which articles should be reviewed for insertion into a more
  specific category.

* One thing I like about Jekyll is that you have to create the
  categories and tags manually.  It turns out this helps assure that
  you are reusing as many existing categories as possible to bin
  things together into.

* Writing blog posts in Markdown is great!

* Looking back on the text content once it is published in modern blog
  form, it sure looks and feels "smaller" than it did when I was using
  one big text file.  Not to mention, the categories and tags
  organization mechanism works great!  Well, at least when you use it
  properly.

* Taking a large number of existing articles and assigning them
  titles, categories, and tags is easier than I thought.  The main
  point of difficulty is when no dates have been recorded: often times
  it is possible to guess from surrounding entries, but this can be
  tough too.

* One bad habit that I still need to practice getting rid of is
  writing articles that are too long.  Specifically, when an article's
  contents contain multiple different search subjects in a single
  article body.  For the time being, I need to carefully review my
  articles and split apart single articles that should be listed as
  multiple articles.  The big benefit of this is that it improves
  searching for information, by virtue of being able to use categories
  and tags generously.

* Especially when operating in the field of technology, timestamps
  work quite well to determine what era of technology a particular
  article pertains to.  Although obsolete technology is rarely useful
  for modern applications, it is always helpful to have accurate
  historic documentation when working with legacy systems.

  Again, I reiterate, because this is important!  Also, as it turns
  out, humans are quite bad at perceiving time, so recorded timestamps
  are quite useful in making decisions.

* GitHub Pages runs short on a key formatting feature that I must have
  for my blog: auto-generate hyperlinks from URL text.

* Also, reviewing my blog, it would be really nice if when I cited a
  URL, I could have an auto-generated brief inserted too.  For the
  time being, carrying over from my traditional notes process, it is
  at my discretion to add a short text description before the link if
  I feel such would be worthwhile.

* Sometimes I forget to add the "more" divider tag to denote the end
  of the article brief view.
