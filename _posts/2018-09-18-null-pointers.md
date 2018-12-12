---
layout: post
title: Null pointers
author: quorten
date: 2018-09-18 11:00 -0500
categories: [unlipic, tour-de-force]
tags: [unlipic, tour-de-force]
---

About null pointers.  Yep, we've heard that the one of the main people
involved in popularizing null pointers regretted it.  Why?

20180918/https://en.wikipedia.org/wiki/Null_pointer

Well, the goal here was to have the compiler do all type safety checks
at compile-time to guarantee that the complex data types are
absolutely safe.  No runtime type checking necessary.  But what if you
have a function that can fail at runtime and can't really return a
valid object?  Well, as I understand it, the story must work like
this.  You use two separate variables, one that is always the correct,
static object type, and another to indicate if failure has happened.
Then it is up to the program to check for failure at runtime.  If it
doesn't, the program will pass around and attempt to process a dummy
object of the correct type, which should fail at runtime, maybe even
cause a crash if the complex type code is poorly written.

So, the point that I wanted to put forward is this.  There is no easy
way to do "safe typing" with complex types.  By definition, the data
and behavior must be more complex, and that requires more logic, which
means there will be more points of failure.
