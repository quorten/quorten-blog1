---
layout: post
title: "`SendInput()` for Windows PowerShell"
date: 2019-08-19 20:44 -0500
author: quorten
categories: [windows]
tags: [windows]
---

I've once before written a keyboard automation program using the
Windows API `SendInput()` function in a C program.  Is there a way to
do likewise in modern PowerShell?  Indeed, there is.  More than one,
actually.  The first way is based off of the old Visual Basic Script
(VBS) function called `SendKeys()`, and you can actually use that
verbatim inside PowerShell.  The second, more modern way, involves
another helper library to do some nicer things.  For now, I will not
detail that in this article, but leave it at providing the links for
more information.

20190819/DuckDuckGo powershell send gui input  
20190819/https://devblogs.microsoft.com/scripting/provide-input-to-applications-with-powershell/  
20190819/https://web.archive.org/web/20120107163730/http://msdn.microsoft.com/en-us/magazine/cc163301.aspx
