---
layout: post
title: "Source-to-source translator that can translate target updates
        to source updates?"
author: quorten
date: 2018-06-30 10:55 -0500
categories: [unlipic, important]
tags: [unlipic, important]
---

Important!  Want to design a source-to-source translator or compiler
that easily links the original and translated versions, and can
propagate edits made to the translated version to the original
version?  Rather than using the traditional read from input stream and
write to output stream approach, use an in-text substitution approach.
This way, if you use my versioning buffer backend, you will
automatically get links between consistent text on both ends, and even
a means to insert translated statements on-demand.

This can even be used to speed translation of compiled code, when the
programmer goes in and only but makes a few text edits here and there
to the source.  Sure, some changes would need to be implemented on the
compilation system, but it is totally doable.
