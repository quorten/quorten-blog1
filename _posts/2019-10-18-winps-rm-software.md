---
layout: post
title: List and remove installed software via Powershell
date: 2019-10-18 20:17 -0500
author: quorten
categories: [windows]
tags: [windows]
---

How do you uninstall software via Powershell on Windows?  Here's the
lowdown.  Unfortunately, there is a scatter-brain chaos here when it
comes to Windows software install management.  There are two ways to
do this.  The more "modern" way involves the `Win32_package` class in
`wmic`.

```
Get-WmiObject -Class Win32_product
wmic product where "name='<SOFTWARE-NAME>'" uninstall
```

20191018/DuckDuckGo powershell remove software  
20191018/https://devblogs.microsoft.com/scripting/use-powershell-to-find-and-uninstall-software/  
20191018/DuckDuckGo wmic product where name remove  
20191018/http://www.joseftschiggerl.name/2012/02/uninstall-programs-with-wmic/  
20191018/DuckDuckGo powershell list installed software  
20191018/https://www.maketecheasier.com/get-installed-software-list-windows/  
20191018/windows 10 powershell list installed software  
20191018/https://www.howtogeek.com/165293/how-to-get-a-list-of-software-installed-on-your-pc-with-a-single-command/

<!-- more -->

Alas, older software installers use a different outdated technique
where you must go through registry keys.  Even worse, there is not
always guaranteed to be a silent uninstaller available, so GUI dialogs
might pop up that will have to be automated away by generating
artificial input.  As we've picked up a hint from our previous sources
on that technique, let's search around more on the tech details.  And here
we are, we have an answer article on .

20191018/DuckDuckGo powershell uninstall get-itemproperty  
20191018/https://stackoverflow.com/questions/53062464/uninstall-application-using-powershell

And here we go.

```
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize

$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

$app = Get-ChildItem -Path $RegPath | Get-ItemProperty | Where-Object {$_.DisplayName -match "firefox" }
```
