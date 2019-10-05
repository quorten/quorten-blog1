---
layout: post
title: Gather report on Windows like `sosreport`
date: 2019-09-25 18:55 -0500
author: quorten
categories: [windows]
tags: [windows]
---

On CentOS, `sosreport` provides a wealth of system information for
diagnosing and debugging system issues, all available by running only
a single command.  How do you get similar information on Windows?
Well, unfortunately as it turns out, there is no one single true way
to get the information on Windows.  Why not?  Although there were
several historic attempts at Microsoft to create such tools, if you
look closely into the details, you will see that none of them really
caught on and continued to be maintained.  A developer started working
on one tool, it was used for a little while, but then it got
abandoned, and a new developer wrote a new similar-but-different tool.
So, given this pattern of failure, let's walk through the tools in
chronological order.

First, there Windows Event Logs, of the Windows NT Server era.  This
is the tried-and-true, still supported method of gathering information
on Windows systems non-interactively, but, of course, it will take
more than one command to do so.  If it could be done with only one
command, then it would fit the bill perfectly.

Try creating a PowerShell script like this:

```
$log_list = Get-EventLog -List
foreach ($log_item in $log_list) {
  Get-EventLog -log $log_item.log
}
```

<!-- more -->

One trick that is particularly useful for saving the event logs is to
export them as CSV.  To do so, and for only logs backwards in time up
to a certain maximum time duration, use a Powershell code snippet
similar to the following:

```
$now = Get-Date
$startDate = $now.addDays(-7)
$ev = get-eventlog -ComputerName ... `
  -log System -After $startDate | Export-Csv mylog.csv
```

20190814/DuckDuckGo windows save event logs powershell  
20190814/https://eventlogxp.com/blog/exporting-event-logs-with-windows-powershell/  
20190814/https://social.technet.microsoft.com/Forums/scriptingcenter/en-US/de9fda2b-8083-4024-a1be-25ce71e68802/exporting-event-logs-with-powershell

In addition to saving the event logs, you probably also want to save
the list of running services.

Next, there is `msdt.exe`, of the Windows XP era, also known as
Windows Diagnostics.  The nice thing about `msdt` is that it does
provide for some means of command-line automation.  Unfortunately,
when you get into the low-down of how it works, you can pretty quickly
see that there are quite a number of things unpolished about it and it
is still clearly designed mainly for interaction with a human user.
Also, if you want to gather **all** information, then you will need to
run multiple `msdt.exe` commands, which doesn't satisfy the original
goal.

For example, to generate an "answers file" for the Windows Update
troubleshooting pack, run this Powershell:

```
Get-Troubleshooting-Pack C:\Windows\Diagnostics\System\WindowsUpdate -AnswerFile .\WUIAnswers.xml
```

Now run an answers file as follows:

```
msdt.exe /id PowerDiagnostic /af <answers-file.xml>
```

You can find a list of troubleshooting pack names here.

MSDT "man page":

20190814/https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ee424379(v=ws.11)

Please note that unfortunately, generating answers for some
troubleshooting packs includes a number of questions that only makes
sense if an interactive user is walking through it manually.  No
matter how you answer some earlier questions, you will be asked some
consistent "dummy" questions that are only relevant if you answered
the initial questions differently.

Worst of all, when you try to run `msdt.exe` on some newer versions of
Windows, you will get this error: Diagnostic troubleshooter is not
enabled on this version of Windows.

There is also System Restore, of the Windows XP era.  But this is more
of a clandestine way to collect the information, one that wasn't
designed specifically for that purpose but can be used for it
nonetheless.

https://www.windowscentral.com/how-backup-entire-registry-windows-10  
DuckDuckGo windows copy system restore  
https://smallbusiness.chron.com/copy-system-restore-points-45595.html

Next, there is `perfmon` of the Windows 7 era, also known as System
Diagnostics Report.  Run this command in an Administrator Console to
bring up a GUI that will gather and display system information.  Via
the GUI, you can export the data to an HTML file.

```
perfmon /report
```

perfmon "man page":

https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/perfmon

As you can see here, perfmon lacks command line options for
non-interactive use.  You would need to start the GUI tool and "Save
As" the result in order to get the report.  Thus, if you want to use
it within scripts, you will have to write GUI automation to control
the GUI to complete the process of exporting the logs.

That's all, folks.  Here are some more miscellaneous searches and
information references that came about from my research.  Essentially,
I've extracted the more human-friendly information from my frantic and
chaotic search efforts.

20190809/DuckDuckGo windows archive system configuration and events  
20190809/DuckDuckGo windows archive system information  
20190809/DuckDuckGo windows snapshot like sosreport  
20190809/DuckDuckGo windows collect bug report system information  
20190809/https://www.techrepublic.com/article/how-to-use-the-windows-10-system-diagnostics-report-to-gather-troubleshooting-info-on-the-fly/

20190814/DuckDuckGo perfmon report save  
20190814/https://www.thewindowsclub.com/generate-system-health-report-windows-7-8-perfmon

20190814/DuckDuckGo windows diagnostics report save from command line  
20190814/https://www.thewindowsclub.com/how-to-run-a-troubleshooting-from-the-command-line-in-windows-10

20190814/DuckDuckGo msdt answer file  
20190814/https://superuser.com/questions/871822/creating-an-answer-file-for-windowsupdatediagnostic-diagcab-in-eclipse-wtp?#1094306
