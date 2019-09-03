---
layout: post
title: Reusable linked list code algorithms
date: 2019-01-12 23:41 -0600
author: quorten
categories: [unlipic]
tags: [unlipic]
---

Linked lists done right.  Motivation?  Build efficient, reusable
linked list code.

This is simple to implement in code, but what is missing is
compile-time optimizations.  Rather than having linked list pointers
point to the head of the container data structure, they point to the
next pointer in sequence itself.  This makes the pointers independent
of the specific implementation of the data structures, so that the
code for navigating linked lists is therefore generic and can be
reused.

The next higher level up is referencing members of the node data
structure.  Here is the main optimization at this point.  Define an
arithmetic expression with only add and subtract constants and one
variable.  The amount you add or subtract depends on which field you
want to access.  The variable is the yet-unknown address of the final
data structure.  Only when you convert that to an actual pointer to
dereference must you compute the full value.  This allows you to save
some extra and unnecessary pointer dereferencing and arithmetic.

In some cases this means that you never need to allocate storage for a
variable.  You simply use the storage of one variable and an
arithmetic expression to "load" the other variable.

<!-- more -->

Most basic constraint: reference one other variable with _only_
compile-time constants.  Compiler volatile optimizations must also be
considered.  How do you do this?  Well, think of it this way.  You are
creating a list data structure, and you want to know the size of an
element.  Sure, you can create a field in the data structure that
stores the value and write code to read that value, but if it is a
compile-time constant, you don't need to carry that extra data around
in the data structures.  Rather, you can define a macro in your code
that contains the constant value, and reference that macro, using
token pasting magic, when you want to read the value.
