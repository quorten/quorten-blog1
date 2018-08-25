---
layout: post
title: "Multi-licensing on GitHub, and how to increase the polling rate
        of your mouse"
author: quorten
date: 2018-08-24 21:51 -0500
categories: [license, random-software]
tags: [license, random-software]
---

Multi-licensing you ask?  What is the most elegant way to do this?
Answer: Use "SPDX notation" in your README file to specify that any
one of multiple licenses may be chosen, and only that license needs be
carried over into a duplicate repository.  In regard to whether there
is a specific notation that is well-recognized on GitHub, apparently
there isn't, but do use the SPDX notation as your next best
alternative.

20180824/https://en.wikipedia.org/wiki/Multi-licensing  
20180824/DuckDuckGo github multi-licensing  
20180824/https://softwareengineering.stackexchange.com/questions/304874/declaring-multiple-licences-in-a-github-project  
20180824/https://en.wikipedia.org/wiki/Software_Package_Data_Exchange  
20180824/https://spdx.org/

No explicit mention of "public domain" as an indicator of its own,
just the corresponding dedication + fallback licenses.

20180824/https://spdx.org/licenses/  
20180824/https://www.gnu.org/licenses/identify-licenses-clearly.html

Any updates on Linus Torvald's position on GPLv3?  It doesn't look
like it, most of the references are old here.

20180824/DuckDuckGo linus torvalds gpl 3  
20180824/https://www.quora.com/Why-does-Linus-Torvalds-hate-GPL-v3-0  
20180824/https://opensource.stackexchange.com/questions/7020/what-exactly-is-tivoization-and-why-did-linus-torvalds-not-like-it-in-gplv3

Now this is really interesting.  Linus Torvalds commenting on the
GPLv2?  He likes the license, but he hates how it is being enforced.
Specifically, the use of lawyers.  He agrees with Greg Kroah-Hartman,
another leading Linux kernel developer, who stated that it is not
necessary to use lawyers to convince people to comply by the license.
Yes, even when they may say outright to your face that they don't
think it's necessary to obey the law.  However, using a lawyer, a
lawsuit, and suing as a means to this end always ended in regret, both
for the defendent and the plaintiff.  Using lawyers only results in
distrust and others viewing you as a bully.

Now, this has been a problem with the Software Freedom Conservancy,
SFC, in more recent years:

> In the last 10 years brought something that never occurred before
> with any other copylefted code. Specifically, with Linux, we find
> both major and minor industry players determined to violate the GPL,
> on purpose, and refuse to comply, and tell us to our faces: "you
> think that we have to follow the GPL? OK, then take us to Court. We
> won't comply otherwise."

And that's the viewpoint that has caused such a strong backlash.
Nope, you don't need lawyers suing.

20180824/https://www.zdnet.com/article/linus-torvaldss-love-hate-relationship-with-the-gpl/

Okay, that's all nice and all, but now I must ask specifically.  Can
public domain code be relicensed as MIT licensed code?  Does this work
perfectly fine in jurisdictions that recognize the public domain, if
someone other than the original author relicenses it on their behalf
and then distributes the result to a jurisdiction that doesn't
recognize the public domain?

Failed search.

20180824/DuckDuckGo can public domain code be licensed as mit  
20180824/https://blog.codinghorror.com/pick-a-license-any-license/

On the other hand, I found some interesting information about how to
increase the polling rate of your mouse.

20180824/https://blog.codinghorror.com/mouse-dpi-and-usb-polling-rate/  
20180824/https://web.archive.org/web/20071230134947/http://www.linux-gamers.net:80/modules/wiwimod/index.php?page=HOWTO+USBPolling

----------

In regards to all this about the GNU General Public License version 3.
The namesake of "tivoization" comes from TiVo.  So what is that
exactly?  It's an early line of DVRs.

20180825/https://en.wikipedia.org/wiki/TiVo  
20180825/https://en.wikipedia.org/wiki/Tivoization

TiVo's response to the GPLv3?  They made an SEC filing stating that
they may not be able to upgrade to future GNU/Linux versions.

Another interesting thing about the article is the mention of the
controversy and issues with commercial skipping and pop-up ads.  Well,
my verdict is that it sure is rough to run a business in "consumer
entertainment."  The fundamental problem is that you can't really have
high-quality customers in that sector.  Yes, it's like Facebook, the
party where everyone is invited, and having a number of bad
parties/persons coming in inevitable.  The question then comes down to
what to do with these parties/persons?
