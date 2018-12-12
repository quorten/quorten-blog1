---
layout: post
title: Setup Vim indent without tabs
author: quorten
date: 2016-08-26
categories: [misc, important]
tags: [misc, important]
---

Important!  Vim indent without tabs.  Example to indent 4 spaces.

    :set shiftwidth=4
    :set expandtab
    5>>

And to show existing tabs as 4 spaces wide:

    :set tabstop=4

And to change cursor behavior on backspace when expanding tabs:

    :set softtabstop=4

But you probably don't want to do this, in order to make existing tabs
stick out as incorrect.

To stay simple, you want to do this:

    :set tabstop=4
    :set expandtab

There's also autoindent and smartindent.
