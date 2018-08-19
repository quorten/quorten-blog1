---
layout: post
title: ReFS and reflections on engineering
author: quorten
date: 2018-07-25 18:31 -0500
categories: [random-software]
tags: [random-software]
---

ReFS?  Is that going anywhere?

I'm still not sure.  However, if plans to not only include it in the
"consumer" Windows versions, but also make it the default, pan out,
then that means we should for sure start seeing third party GNU/Linux
filesystem tools start rolling out.

Now, this is interesting.  WinFS and Cairo are failed filesystem
projects by Microsoft of times past.  The problem?  Microsoft wanted
to make the filesystem like an "object store" or "a database," but in
the end the traditional filesystem was always there, and the
database-like features and functions were merely an additional
software layer added to the mix.

<!-- more -->

20180725/https://en.wikipedia.org/wiki/ReFS  
20180725/https://en.wikipedia.org/wiki/WinFS  
20180725/https://www.theguardian.com/technology/2006/jun/29/insideit.guardianweeklytechnologysection

So, the conclusion on the ill-fated WinFS?  Naturally, it was to merge
most of the features and functions into Microsoft SQL Server.  The
proposition here was a significant one in difference.

The old idea: Microsoft will roll out a new Windows API for advanced
filesystem features, and individual application software developers
will one-by-one adopt the new API.  Eventually, in a system where a
user acquires multiple independently developed applications and merely
aggregates them together without a concerted central software
development effort on their part, the system will "just work" in an
integrated fashion, all because the individual component technologies
adhere to the new standard.

Why it doesn't work: The reality, here, of course, is that such a "de
facto" adoption cannot be relied on if it doesn't already exist.  And
that's just the problem: getting enough adoption for a technology that
only works well as a "standard" to be in place.  That old concept
never panned out.  As it turned out, WinFS never did get adopted by a
sufficiently critical mass of desktop software developers, much less
any other similar standard.

The new idea: Merge WinFS features and functions into Microsoft SQL
Server.

Why it does work: Microsoft SQL Server is deliberately sold as this
back-end components that primarily software developers interact with,
who then build a front-end interface that is presented to individual
users.  In practice, in the kinds of software development environments
that use a database, SQL or otherwise, it is assumed that there must
be software developers in-the-loop who will pick up independently
developed components, then write additional software to tie them all
together into an integrated system.  Suffice it to say, there is no
need for a unifying assumption that component parts will "just work"
in an integrated manner when merely aggregated together: all the work
of making that happen is deliberately assigned to an accountable
software developer party who has the technical skills to wire together
components that weren't designed to work together.

----------

Incidentally, this analysis also predicts why commercially sold
"Internet-connected" home appliances such as HVAC control thermostats,
refrigerators, washing machines, Internet router, and so on, simply
don't work well in practice.  Nope, you can't just assume that you can
buy these individual component parts, drop them into a single system,
and have them all work together in a nice, integrated fashion.  Not
going to happen.

However, if there is a deliberate engineer in-the-loop when building
such an integrated system, it _can_ be made to work well.  Of course,
the whole point here is that a technically skilled and intelligent
party is needed when assembling any larger system from discrete
component parts.  Yes, you can't even fill a home with home appliances
without an engineer in-the-loop!

Likewise, this same explanation is the reason why smartphones work so
well for consumers: because the device is bought whole, there is no
need to "engineer" any system on the side of the user.  Well...  about
the external Internet side.  The point here is that we've developed a
well-working "plug-in system" where the rest of the integration
engineering can be done by external parties.  Now, the points here
with the Internet that we've just covered previously are crucial:

* The base standards of the Internet, TCP/IP, HTTP, graphical web
  browsers, HTML, CSS, JavaScript, HTML 5 Web APIs, WebAssembly, and
  so on, are already proven to have _de-facto adoption_.  Therefore,
  it _is_ possible for independent development to happen, and the
  resulting products will simply plugin to the network and "just
  work."

* All of the base standards of the Internet are bundled onto
  the physical smartphone device as sold as a product.

* The remainder of the complexity that needs to be integration
  engineered can be done by independent third parties scraping
  existing data from the Internet, hiring their own "integration
  engineers" and integration software developers, building their own
  websites and servers, and plugging it in to the Internet.  If the
  new service is really well liked, it will spread through "word of
  mouth," either literally or through Internet communication channels.
  When the user community grows big enough, eventually the new service
  will be listed in official indexes such as web search engine front
  page results.

* There are also many ways for changes to the base product standards
  to be pushed.

    1. Software updates, provided by the device vendor.

    2. Purchasing a newly packaged product as a replacement.  As a
       smartphone is usually carried very close to the user's body, it
       is easy to dispose of and replace with a new one on a whim.
       The small size of the device really helps here too.  Other
       products such as embedded IoT sensors, by contrast, may require
       unusual physical effort to navigate to the device location for
       a replacement.  Other products such as desktop PCs require a
       more concerted effort to replace simply due to their physical
       size, even though they are still in easy to reach locations.
