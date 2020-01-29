---
layout: post
title: "Puppet JSON handling, strings, and \"shell backticks\""
date: 2020-01-24 11:13 -0600
author: quorten
categories: [misc]
tags: [misc]
---

How do you parse JSON in Puppet?  Well, now that is a bit of a more
complicated question to answer.  First of all, Puppet doesn't handle
standard JSON; rather, it uses a variant called "PSON."  PSON's main
difference is that it is specified in 8-bit ASCII rather than UTF-8,
and some ASCII control characters must be escaped via an escape
sequence.  Furthermore, if you have a string parsed into Puppet with
Unicode characters, you cannot use that string as-is, else you will
get "invalid UTF-16le literal" errors.  You must first decode the
UTF-16 into UTF-8, then encode and escape and ASCII control sequences.

20200124/DuckDuckGo puppet parse json string from command  
20200124/https://stackoverflow.com/questions/43729915/parse-a-json-string-in-puppet  
20200124/https://ask.puppet.com/questions/28878/how-to-handle-json-data-in-puppet/  
20200124/https://puppet.com/docs/puppet/latest/http_api/pson.html  
20200124/https://tickets.puppetlabs.com/browse/MODULES-9195

In particular, if you are reading the output of a "shell backticks"
command, Unicode characters will be translated and represented in the
Puppet native form.  Which is what?  UTF-8... strings are just
sequences of bytes, but in the future, all strings may be required to
be valid UTF-8.

20200124/DuckDuckGo puppet string literal syntax  
20200124/https://puppet.com/docs/puppet/latest/lang_data_strings.html

<!-- more -->

Here's how to do "shell backticks" in Puppet.  You create a dynamic
template string and then evaluate it.

20200124/DuckDuckGo puppet backticks  
20200124/DuckDuckGo puppet command stdout string  
20200124/https://stackoverflow.com/questions/33800565/how-to-store-linux-command-output-into-a-variable-in-puppet

How do you print a debug string in Puppet?  Just use `notice("...")`.

20200124/DuckDuckGo puppet print debug string  
20200124/https://stackoverflow.com/questions/4135426/how-to-print-something-when-running-puppet-client
