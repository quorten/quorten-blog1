---
layout: post
title: "Long way to delete a file with a lock on it in Windows,
        without restarting"
date: 2019-08-29 16:14 -0500
author: quorten
categories: [windows]
tags: [windows]
---

When working on Windows, I had a problem with being unable to delete a
file because it was being used by another process.  Okay, but I really
needed to delete that file, so how could I do that?  Ideally, I could
just run some PowerShell commands to identify which process was using
the file, but I could not find such commands.  So, I resorted to
downloading a great Process Explorer utility by Mark Russinovich, then
using that to find the culprit process and terminate it.  The method
on how to do that is documented here:

20190829/DuckDuckGo windows unlock file  
20190829/https://www.howtogeek.com/128680/HOW-TO-DELETE-MOVE-OR-RENAME-LOCKED-FILES-IN-WINDOWS/  
20190829/https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer

Unfortunately, I also needed to do this is a restricted computer
environment, on a minimal Windows core installation that did not have
a web browser.  Okay, so I can download a file in PowerShell.  But
additionally, I needed to do this behind a firewall, and with custom
security certificates.  In the end, I simply disabled security
certificates, which can be done using this command:

```
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
```

<!-- more -->

20190829/DuckDuckGo windows powershell download file with certificate  
20190829/DuckDuckGo windows powershell do not verify ssl certificate  
20190829/DuckDuckGo powershell webclient ignore certificate  
20190829/https://bhargavs.com/index.php/2014/03/17/ignoring-ssl-trust-in-powershell-using-system-net-webclient/

Configuring the firewall is easy, you just add another few lines of
code to your standard PowerShell HTTP GET to set up the firewall URL
and, if necessary, credentials.

```
$source = "http://site.com/file.txt"
$dest = "C:\file.txt"
$WebClient = New-Object System.Net.WebClient
$WebProxy = New-Object System.Net.WebProxy("http://myproxy.com:1111",$true)
$Credentials = New-Object Net.NetworkCredential("user,"","domain.local")
$Credentials = $Credentials.GetCredential("http://myproxy.com","1111", "KERBEROS");
$WebProxy.Credentials = $Credentials
$WebClient.Proxy = $WebProxy
$WebClient.DownloadFile($source,$dest)
```

20190829/DuckDuckGo windows powershell download file through proxy  
20190829/https://social.technet.microsoft.com/Forums/windows/en-US/1a05b90b-ce12-4974-b578-0c1e22d03f10/download-file-through-proxy-server
