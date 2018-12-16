---
layout: post
title: Auto URL link generation in Jekyll
author: quorten
date: 2018-05-28 22:00 -0500
categories: [blogging]
tags: [blogging]
---

The short answer?  You can't do it without plugins.

The long answer?  Well, in GitHub pages history of times past, you
would have been able to use the `redcarpet` Markdown parser that you
could then configure an `autolink` plugin, and Voila!  It would just
work.  Nowadays you can't do that anymore since Kramdown is now the
only supported Markdown parser on GitHub Pages.

And unfortunately, it appears the only easy way to get this working
with Kramdown is through the use of a plugin, which isn't as
convenient on GitHub pages.

20180528/DuckDuckGo jekyll markdown flavor  
20180528/https://stackoverflow.com/questions/13464590/github-flavored-markdown-and-pygments-highlighting-in-jekyll#13614020  
20180528/https://github.com/nono/Jekyll-plugins  
20180528/https://github.com/vmg/redcarpet  
20180528/https://jekyllrb.com/docs/plugins/  
20180528/https://jekyllrb.com/docs/configuration/

20180528/https://help.github.com/articles/updating-your-markdown-processor-to-kramdown/

20180528/https://kramdown.gettalong.org/documentation.html  
20180528/https://kramdown.gettalong.org/quickref.html  
20180528/https://kramdown.gettalong.org/rdoc/index.html  
20180528/https://kramdown.gettalong.org/rdoc/Kramdown/Document.html  
20180528/https://kramdown.gettalong.org/rdoc/Kramdown/Options.html

20180528/DuckDuckGo kramdown auto links url  
20180528/https://github.com/shoyan/kramdown_easy_link

<!-- more -->

----------

Now, the updated state-of-the-art situation of math on the web.
What's going on with this new KaTeX?  Basically, it's a MathML
generator, rather than a solution that eschews on MathML.  Yeah, so
just like `blahtex`/`blahtexml` 10 years ago, only more popular this
time through.  It's main claim is that it is _faster_ than MathJax.
SsKaTeX runs server-side, but it is not recommended to be used with
untrusted code.

20180528/https://kramdown.gettalong.org/math_engine/mathjax.html  
20180528/https://khan.github.io/KaTeX/  
20180528/https://kramdown.gettalong.org/math_engine/sskatex.html
