---
layout: post
title: Search index information in PDF, HTML, etc.
author: quorten
date: 2017-03-06
categories: [media-prog, important]
tags: [media-prog, important]
---

Important!  For searchable information, how do you convert PDF and
HTML to plain text so that you can just do plain greps with more ease?

20170306/DuckDuckGo unix convert pdf to plain text  
20170306/https://www.cyberciti.biz/faq/converter-pdf-files-to-text-format-command/  
20170306/DuckDuckGo unix convert html to text  
20170306/http://superuser.com/questions/673878/how-to-convert-html-to-text  
20170306/https://linux.die.net/man/1/html2text  
20170306/https://ubuntuforums.org/showthread.php?t=1527895

So, these are the available tools that I could find thus far.

* `pdftotext` from `poppler-utils`
* `lynx --dump` for HTML to text
* html2text is another option
