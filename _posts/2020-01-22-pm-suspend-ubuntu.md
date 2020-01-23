---
layout: post
title: Suspend on modern Ubuntu
date: 2020-01-22 14:55 -0600
author: quorten
categories: [unix]
tags: [unix]
---

Old Ubuntu use to have the `/etc/acpi/sleep.sh` etc. power management
scripts and the `pm-suspend` command that you'd call to suspsend the
computer.  But, how do you suspend the computer in modern Ubuntu?
Easy, just use `systemctl`:

```
sudo systemctl suspend
```

Please note that the `pm-suspend` command is still available and is
part of Debian core, but the new way appears to have become more
popular, and in some distributions (i.e. Raspbian) the classic Debian
commands may even be broken in the default configuration.
