---
layout: post
title: Set up Windows for SSH-style access
author: quorten
date: 2018-10-25 21:00 -0500
categories: [random-software]
tags: [random-software]
---

Suppose you need to run some command-line only software on a remote
Windows machine and you do not want to run a full Windows remote
desktop session just to do this simple task.  How do you go about
doing this?  This is my recommendation.

    # Install chocolatey, so that you can complete the remaining
    # installations via a console (possibly via EMS/SAC) rather than a
    # GUI.
    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

    # Install OpenSSH for Windows, with the server-mode enabled.
    choco install openssh -params '"/SSHServerFeature /KeyBasedAuthenticationFeature"'

    # Install vim so that you have a console-only text editor.
    choco install vim

    # If Perl is required, install strawberryperl.
    choco install strawberryperl

    # Use refreshenv to pickup environment PATH updates.
    refreshenv

Also note that `nano` is available for Windows too, if that is your
preference over `vim`.

<!-- more -->

20181025/https://chocolatey.org/install  
20181025/DuckDuckGo windows console text editor  
20181025/https://stackoverflow.com/questions/11045077/edit-a-text-file-on-the-console-in-64-bit-windows#19314955  
20181025/https://superuser.com/questions/53175/which-are-the-non-x-text-editors-in-powershell  
20181025/https://www.nano-editor.org/download.php  
20181025/DuckDuckGo windows remote text console  
20181025/https://superuser.com/questions/840739/gnu-screen-tmux-equivalent-for-windows-for-remote-text-console-not-gui-connect#840749  
20181025/https://serverfault.com/questions/429426/how-can-i-connect-to-a-windows-server-using-a-command-line-interface-cli  
20181025/https://social.technet.microsoft.com/wiki/contents/articles/1474.how-to-set-up-server-core-for-windows-server-2008-to-be-managed-via-ssh.aspx  
20181025/https://chocolatey.org/packages/openssh  
20181025/DuckDuckGo windows choco install ssh server  
20181025/https://mangolassi.it/topic/9954/installing-openssh-on-windows-via-chocolatey/2
