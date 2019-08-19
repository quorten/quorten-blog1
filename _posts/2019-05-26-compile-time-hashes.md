---
layout: post
title: Compile-time hashes
date: 2019-05-26 13:10 -0500
author: quorten
categories: [unlipic, tour-de-force]
tags: [unlipic, tour-de-force]
---

I happened to be reviewing some code that I've wrote a while earlier.
At the time I was writing it, I thought I "just shoved some stuff
together," but on second thought and further analysis, I realized I
had some pretty good ideas going on there.

So, what exactly was happening in my code?  Basically, I had written a
simple application that needed a very simple way to store key-value
data in a plain text file.  So, naturally, I settled on the technique
that is referred to as some as _Unix conf-style_ or
_delimiter-separated values_: this is a text file with one field per
line, the key name of the field is the text from the beginning of the
line to the first colon, and the value is everything else after the
first colon until the newline character at the end of the line.
Example:

```
one:two
three:four
five:six
```

<!-- more -->

The primary purpose for using this very simple data specification
format is to populate a text substitution list used for what I call
"simple templating."  That is, owing to the terminology in modern web
development, often times you have an HTML layout file where there are
a few areas where you want to substitute the values of certain
variables as determined at runtime.  However, in my specific highly
simplified use, these variables were all determined in advance and
stored in a simple plain text file.  So, to execute a "simple
template," it is merely a matter of reading in that substitution list,
reading in the template file, and replacing the text strings with the
contents of the substitution list.

But, here's where things get interesting.  I wanted to extend this
simple concept to a slighly less simple use case where I was reading
the values into a program.  So, how did I go about doing this?  This
is the interesting answer.  I just wrote a whole bunch of individual
variables to store the values of each field, and then I wrote a simple
loop to loop through all fields in the data structure and check
whether the field name matched via a string comparison.

```
for (i = 0; i < records.len; i++) {
  char *key = records.d[i].key;
  char *val = records.d[i].val;
  if (!strcmp(key, "one")) {
    k_one = val;
  } else if (!strcmp(key, "three")) {
    k_three = val;
  } else if (!strcmp(key, "five")) {
    k_five = val;
  }
}
```

Yeah, quick and dirty, but it does the job.  This is even the case
when I was writing the original software in Perl, whereas I presented
the example code above in C!  But come on, it was like I was saying, I
was trying to keep it all simple, so even the Perl data structures
were kept simple too!

But, now here's the key.  If you really think about it, this does
bring up a good point.  After you are done parsing out the fields,
what is the computational overhead of using the variables as-is in the
above code?  Basically, the computational overhead is no different
than a binary data structure.  Data structure member use is as
efficient as things get here.

Compare that with the more conventional approach, namely to place the
field values inside a dictionary data structure, and then reference
the fields by name every time you want to access the values.
Technically speaking, there will generally be additional overhead
involved in order to perform a hash table lookup, and this overhead
will be incurred for every single time you access the dictionary
fields by name.  What exactly is that overhead?

* Scan the key string to compute a short hash value.
* Index into the hash table to find the corresponding bucket.
* Scan the key string again via an `strcmp()` to verify that the key
  string matches a value in the corresponding bucket.

Essentially, every single time you reference the dictionary field by
name, you need to scan the key string at least once.  Sure, that might
not sound like much overhead for your average web dev, but for
performance critical code, all those extra hash table lookups can add
up.

Now, here's the good idea that has come out of my code that was just
"shoved together."  If you know all the keys of a dictionary at
compile-time, is it ever necessary to do a traditional hash table
lookup at runtime?  When you think about it, the typical answer is
"no."  The only exception might be if the runtime hash table value
computation specifics differs substantially from what was computed at
compile-time, i.e. if you have an adaptive structure and the total
hash table size is substantially different than predicted.  But, other
than that, the hash key string is a constant at compile-time, so the
hash value can be precomputed, thus reducing the runtime operation to
a simple structure field indexing.

Of course, this optimization is fairly common among C programmers, but
almost unheard of in the higher-level language world.  But, heres's
the point.  Most of the time, for higher-level languages, this
optimization can be determined and performed _completely
automatically_, so why not?
