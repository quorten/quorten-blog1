---
layout: post
title: Run remote Powershell commands and copy files
date: 2019-08-14 18:55 -0500
author: quorten
categories: [windows]
tags: [windows]
---

How do you run remote Powershell commands?  Easy, like this:

```
Enter-PSSession -ComputerName ... -Credential username
```

Make sure PSRemoting is enabled.

20190814/DuckDuckGo winrm interactive command line  
20190814/https://www.nextofwindows.com/how-to-run-powershell-command-on-a-remote-computer  
20190814/DuckDuckgo Enter-PSSession authentication  
20190814/https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/enter-pssession?view=powershell-6

Copy to/from via winrm:

```
$SourceSession = New-PSSession -ComputerName ... -Credential username
Copy-Item -FromSession $SourceSession -Path $srcPath `
  -Destionation $destPath -Recurse
Copy-Item -ToSession $SourceSession -Path $srcPath `
  -Destionation $destPath -Recurse
```

20190814/DuckDuckGo powershell copy item from winrm session  
20190814/https://blogs.technet.microsoft.com/poshchap/2015/10/30/copy-to-or-from-a-powershell-session/

<!-- more -->

Please note that will only work for Windows-to-Windows copies in both
ways.  If you only want to upload from Unix to Windows, `winrmcp` will
do that for you.  However, for the reverse direction, pretty much the
only way is to run Powershell Core for Linux.  Either that, or print
out the information as text from a Powershell script, then parse it
out on the Unix side.
