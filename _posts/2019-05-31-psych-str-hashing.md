---
layout: post
title: String hashing algorithms and psychology
date: 2019-05-31 23:28 -0500
author: quorten
categories: [unlipic, tour-de-force]
tags: [unlipic, tour-de-force]
---

What makes a good string hashing algorithm?  In general, it depends on
what type of contents are typically in your strings, but for short
strings of words in natural language, we can look toward an
interesting psychological observation to help simplify the challenge.
If you take a passage of English text, and for each word, you scramble
up the letters in between the word, but keep the first and the last
letter the same, many people will be able to read the passage just
fine.  Essentially, the simplifying observation here is that words are
disassembled into data structures where by only the first character,
the last character, and the length of the data structure is stored
precisely, and all letters in between are simply treated as an
unordered set.  This means you can define your programming language
word hashing data structure as follows:

```
struct WordHash_tag
{
  char first;
  char last;
  unsigned char length;
  /* Bit mask of which alphabet letters appear in the word.
     Essentially, uppercase, lowercase, and special characters are
     modulo wrap-around folded into the same numeric space.  */
  unsigned long letters;
};
typedef struct WordHash_tag WordHash;
```

<!-- more -->

So, an average English word is typically 5 characters in length.  This
data structure is... 7 characters in length.  Okay, so we have a
problem that this isn't quite simplifying things for a single word.
But, for a short string of words, i.e. the typical case of computer
programmer variable names, it can provide an advantageous
simplification.  But, by far, the greatest advantage here is that it
makes searching a table of strings much easier when you can classify
strings like this.  You don't need to do a full binary search of all
the strings in the table, but a simple hash table indexing will do the
trick.

Furthermore, you can further compress the data structures compared to
what I've provided to you in order to save space, if you do not need
that much uniqueness in your hash table.
