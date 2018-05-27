---
layout: post
title: Relating to modern-day web computing security
author: quorten
date: 2018-05-26 21:51 -0500
categories: [security]
tags: [security]
---

Many times in web/Internet history of times past, people have
advocated toward uninstalling things on the local computer system to
make things more secure.  "Uninstall Java."  "Restrict plugins."  Of
course, nowadays things like Java and plugins have been made obsolete
by the advent of modern JavaScript programming frameworks and HTML 5
APIs.  But, that's just the thing.  Where does security relate with
all that new JavaScript code?

<!-- more -->

Historically, the approach taken to JavaScript security was that the
web browser would handle all security-related things for the
JavaScript.  By definition, the web browser is supposed to be a
locked-down, jailed environment where malicious JavaScript cannot do
any harm.  Therefore, legitimate JavaScript users can rest assured
that so long as their code works as they intend, it can be assumed
that because the browser is locked down the way it is, all other
security related issues will have been taken care of, otherwise the
browser would block some key behavior and break the site.

However, this simply fails to address the full picture.  Where does
security related to widget libraries come in?  Again, here the modern
web throws in a twist.  Historically, widget libraries tended to
either (1) be built into the operating system itself or (2) acquired
from a third party and distributed with the application.  Many simple
programs could run entirely off of the OS widget library, but very
complex programs would tend to use their own higher-level widget
library to support advanced features and functions.  But, the thing
with JavaScript software nowadays is that increasingly, option #2,
bundling libraries with applications, is the mainstream choice among
web developers.  And this means that the effectively of the security
landscape is generally _decreased_ in comparison with older native
programming.  The burden of keeping third-party libraries up-to-date
is upon the app developer, not the OS distribution developer, and any
apps that have out-of-date dependencies can easily have
vulnerabilities in those exploited.  Yes, even the JavaScript
programming language shares some vulnerability paths that you may have
thought only existed in C programs.

So, this is purportedly the problem going on.  We have an increasing
body of increasingly complex web JavaScript code, and although some of
it uses a means of linking to an upstream latest version to download
the latest, most secure version, there are still very many web
developers and web apps that have older versions of the libraries
stowed away on their sites.  Suffice it to say, from only these two
parameters, there is a growing security problem with JavaScript code,
irrespective of mitigations that the web browser might make to try to
prevent malicious activity among JavaScript code.
