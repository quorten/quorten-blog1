---
layout: post
title: The solution to footnotes in Markdown/Jekyll
author: quorten
date: 2018-08-17 14:39 -0500
categories: [blogging]
tags: [blogging]
---

So, earlier I was having a bit of trouble with a practical idea of how
to implement footnotes in Markdown/Jekyll.  Now I think I've come up
with a practical solution.  Check it out as an example here.
[\[1\]](#dsaef-f1)

----------

### Footnotes:

1. <a id="dsaef-f1" name="dsaef-f1"></a>
   The idea is to have a separate section at the end of the article
   for footnotes.  When I want to indicate a particular footnote
   reference in the middle of the text, I can use name anchors and
   links for that.  Unfortunately, this also has the potential to get
   a bit messy if I need to reformat.

   Suffice it to say, this also makes data migrations more difficult.
   I may just as well end up using my older proposed syntax to write
   the source information, then run it through a script converter to
   use the more fancy footnote format that is more similar to what
   readers are accustomed to seeing elsewhere on the web, especially
   Wikipedia.

2. I realized that overly-simplistic name anchors would cause
   conflicts in the pagination view.  Using a random prefix can help
   mitigate this, but again, that means that the authorship is yet
   more challenging without automatic generation.
