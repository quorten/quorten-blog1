---
layout: post
title: "Golang in Lua, recompile code automatically, and Golang in a
        Jupyter notebook"
date: 2020-04-15 19:55 -0500
author: quorten
categories: [golang]
tags: [golang]
---

I went to an interesting Golang Meetup about running Lua in Golang and
vice versa, these are the notes.

20200415/https://github.com/andreburgaud/meetup-golang-lua

Want to recompile code automatically during development of a server of
a sort?  `modd` is a great system to do this with Golang.

20200415/https://github.com/cortesi/modd

Also, another related subject.  Can you get a "notebook-style"
interface to Golang?  Indeed you can, there are many options available
if you search around, but the first one that comes up is Gophernotes.
It actually works directly with Jupyter.

20200415/https://github.com/gopherdata/gophernotes
