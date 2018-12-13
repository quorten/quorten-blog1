---
layout: post
title: "Peculiarities of SVG images, Jekyll permalinks in blogging,
        and Jekyll syntax highlighting"
author: quorten
date: 2018-12-12 12:10 -0600
categories: [blogging]
tags: [blogging]
---

So, recently a did a bulk import of some of my recent pending blog
entries that haven't been brought into the Jekyll and GitHub Pages
system yet, and I fixed some interesting peculiarities that are worth
taking note of.

First of all, I started using SVG diagrams in my blog.  Previously, I
haven't yet had any opportunities to put images in my blog due to not
yet having decided on an image hosting service.  But, after thinking
through things carefully, I realized that, of course, this is not a
problem with SVG images as SVG images are, in fact, "source code" of a
sort: the XML data format is a text format, and the file format itself
encodes line drawing commands that are essentially the same as the
author's intent (if authored dilligently).  So, why not?
}
There's another important point worth noting about SVG images.
Previously...  as it turns out, 10 years ago by now, not all browsers
supported SVG images.  Microsoft Internet Explorer version 6 was the
particular hold-out, and even Internet Explorer 7 wasn't much better.
So, at the time, if you ever wanted to use SVG images in your web
pages and get a good experience across all browsers, you needed to do
so using an `<object>` tag that had an inline raster image fallback.
And, of course, the raster image fallback may have a pure ASCII art
text fallback for text-only browsers.  I still use that authoring
practice for modern web pages.  So, now the question comes down to
this.  When you generate a PNG image from your SVG image source, what
should you do about that?  Is it okay to store the generated image in
the repository?  Ideally, you won't do this, but because of the way I
am publishing via GitHub pages, somehow storing the raster PNG image
in the repository is the only way for me to get it to come out the
other end on the published pages.  Okay, so here's the thing I can do
for now.  I can setup my pages to have links to the PNG fallback, even
though it will not be visible until I fix the build system issue.

<!-- more -->

Additionally, now that I've uploaded an SVG image with both text and
graphics to illustrate a wiring diagram, I've encountered an issue.
The text was all messed up when I looked at it in Safari and Chrome.
What was the cause of this?  I wrote my text with a fixed-width font
and using a run of spaces to get a fixed-width layout.  However, the
Safari and Chrome were collapsing the run of spaces into a single
space due to the parsing methods by which the WebKit browser work by.
The solution to this is to make sure the `xml:space="preserve"`
attribute is set on all your text span elements.  After this change,
the text displayed correctly on Safari, Chrome, Midori, and all other
WebKit-based browsers, in fact.

20181212/DuckDuckGo safari svg text multiple spaces  
20181212/https://github.com/fabricjs/fabric.js/issues/4869  
20181212/https://github.com/fabricjs/fabric.js/pull/4880  
20181212/https://github.com/fabricjs/fabric.js/pull/4880/files

----------

Second, Jekyll permalink issues.  I've been having some trouble some
time before with cross-referencing my blog articles using the
permalinks.  Typically I would observe the dates being off by one from
what I would expect, and I knew this was due to time zone conversion
issues.  Now that I am doing more local development to preview my blog
before pushing it to GitHub, the issue has become more severe, so I
decided to dig into it.  So, here's what I found out.  In Jekyll, the
date used in the permalinks is generated using the date in the local
time of the machine Jekyll is running on.  So, for GitHub, this
happens to be GMT, but when you run on your own computer for
development, it's whatever you set your local time zone to.  After
some searching around, I found that this problem was reported quite
some time back, and the proposed and implemented solution was a pull
request to add a `timezone` option to the config file.  When
specified, this overrides.  So, to solve your woes, simple add
`timezone: GMT` int your `_config.yml`.  Unfortunately, I believe this
is not very well documented in the official documentation as quick
searches on my part have failed to find major documentation section
mentions on this issue.  (Yeah, if you read every single little
detail, you might find reasonable mention on this.)

20181212/DuckDuckGo jekyll time zone  
20181212/DuckDuckGo jekyll time zone permalink  
20181212/DuckDuckGo jekyll time zone date  
20181212/DuckDuckGo github pages jekyll time zone date  
20181212/DuckDuckGo jekyll permalink time zone  
20181212/https://github.com/jekyll/jekyll/issues/850  
20181212/https://github.com/jekyll/jekyll/pull/957/files

----------

Syntax highlighting in code portions in your blogs?  Wow!  So, if you
want that nifty feature in code blocks you include in your blog posts,
it looks like you need to use triple backticks around the section.  I
have to look more into this to be sure about it.
