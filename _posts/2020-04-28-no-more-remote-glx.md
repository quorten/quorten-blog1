---
layout: post
title: Why remote GLX is a thing of the past
date: 2020-04-28 17:45 -0500
author: quorten
categories: [unix, media-prog]
tags: [unix, media-prog]
---

I've been having trouble running OpenGL over an SSH-forwarded X11
connection.  The problem is that OpenGL is rendered on the remote
computer, then the rendered image is sent to the SSH client computer.
Why is this?

Here's why.  OpenGL GLX opcodes are specified up to OpenGL 2.1.
However, implementation of GLX opcodes for many of the newer features
is optional.  GLX opcodes are only mandatory up to OpenGL 1.4.  OpenGL
1.5 introduced vertex buffer objects.  Yeah, that must-have feature
for virtually all modern 3D software, with the exception of (basic) 3D
modeling software where all vertex data must exist in system memory.

So, that's why most modern systems will default to "direct" rendering
followed by forwarding the resulting image, even when they ought to
usee indirect rendering for better 3D performance.  The whole idea of
indirect rendering, well is pretty clearly outside the motivations of
late 2000s era OpenGL as a competitive platform for the video game
market and GPUs targeted for such _at the time_.  And even now in the
present, things are still pretty much the same.

20200428/DuckDuckGo ssh remote x11 opengl  
20200428/https://stackoverflow.com/questions/40260056/opengl-over-ssh-glx
