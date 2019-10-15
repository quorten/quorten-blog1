---
layout: post
title: "Underscores in numbers and \"atomic\" Unicode operator in Perl"
date: 2019-10-10 20:01 -0500
author: quorten
categories: [perl, ruby]
tags: [perl, ruby]
---

One day we are having `rubocop` bother us that numbers should have
underscores in them to separate the thousands?  Really?  Wow, now that
is sure strange, now isn't it?  Interestingly, with some searching
around, there was a GitHub issue and the feature was traced back to
having come from Perl, among several other languages.  Wow,
interesting.  As some in our group joked, Perl is a useful scapegoat
to use any time there is some weird feature in Ruby that is disliked.

At least Ruby isn't using Emoji for operators like Perl, yet.  Upon
closer examination, this actually isn't a full multi-colored Emoji,
but it comes from the older lineage of Unicode monochrome pictograms.

20191009/https://github.com/rubocop-hq/ruby-style-guide/issues/535  
20191009/https://docs.perl6.org/type/atomicint#infix_%E2%9A%9B=
