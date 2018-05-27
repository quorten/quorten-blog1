---
layout: post
title: Local development with Jekyll
author: quorten
date: 2018-05-26 15:10 -0500
categories: [blogging]
tags: [blogging]
---

So, once you create your first and minimal GitHub pages Jekyll site,
what else is required for local development?  Easy, just follow
these few steps.

1. Make sure you have the local Jekyll development environment setup,
   i.e.  follow the instructions in installing Jekyll.

2. Add the following contents to the Gemfile in your repository:

       source "https://rubygems.org"
       gem "github-pages"

3. Add any necessary plugins to your `_config.yml`.  For example:

       plugins:
         - jekyll-paginate

It's that easy!  Sure, not quite as easy as going to publish directly
to GitHub pages to see how your site looks, but much faster for
adjusting styling, for example.

20180526/https://jekyllrb.com/docs/plugins/  
20180526/DuckDuckGo github pages install themes locally  
20180526/https://stackoverflow.com/questions/45803463/how-do-i-install-one-of-github-pages-jekyll-themes-for-local-preview#45804000
