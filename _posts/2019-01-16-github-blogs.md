---
layout: post
title: Interesting blog posts from GitHub blog
date: 2019-01-16 23:02 -0600
author: quorten
categories: [random-software]
tags: [random-software]
---

Wow, now here I am, I've come full circle... I'm blogging about GitHub
blog on my GitHub pages site.  (Well, at least for now, until I end up
migrating to something else in the future.)

Filament, yet another raytracing rendering engine?  Yes, but this
time, their main advantage they're touting for their new code base is
Android support.  So, of course it's made by Google.

20190116/https://blog.github.com/2018-12-21-release-radar-november-2018/  
20190116/https://github.com/google/filament  
20190116/https://developers.google.com/ar/develop/java/sceneform/

Now, this is an interesting addition.  Download all your GitHub data.
One, yes they're making changes to comply with GDPR.  Two, they're
recognizing that people want to move off of GitHub to other services
and take their projects with them, so they're making all of that
project data available in a machine-readable format.

20190116/https://blog.github.com/2018-12-19-download-your-data/

Interesting, this is GitHub's status page... well, they're new status
page.  They'll be phasing out the old status page.

20190116/https://blog.github.com/2018-12-11-introducing-the-new-github-status-site/  
20190116/https://www.githubstatus.com/

<!-- more -->

Very interesting, GitHub generated a data report on how project
activity is affected by the daily rhythm and by breaks and holidays.
Notably, private (i.e. "proprietary") repositories have steeper peaks
and valleys, whereas public and open-source repositories maintain more
of a steady state throught the day, the night, and the weekends, but
are still affected to some extent by the same peaks and valleys..

20190116/https://blog.github.com/2018-11-20-breaks-and-holidays/

Now, this was an interesting failure that has happened here.  GitHub
had some database failover infrastructure configured to act
automatically, and it did when there was an accidental network
partition during routine replacement of failing 100G optical links at
one of their datacenters.  Unfortunately, the automatically taken
action would have had drastic performance degradation that would make
their service unusable for many purposes, so they decided to shut down
access for some time for them to reconcile the issue.

20190116/https://blog.github.com/2018-10-30-oct21-post-incident-analysis/

GitHub token scanning?  Remember those news articles about people
uploading cloud access keys to GitHub repositories?  Well, in light of
that, GitHub implemented a generalized automatic token scanning on
push mechanism inside their server-side Git.  It works at high
performance for matching all found tokens by using the Hyperscan
library.

20190116/https://blog.github.com/2018-10-17-behind-the-scenes-of-github-token-scanning/  
20190116/https://github.com/intel/hyperscan/releases/tag/v5.0.0

GitHub applying machine intelligence for security alerts on repository
dependencies.  Sometimes it may get false positives.

20190116/https://blog.github.com/2018-10-09-applying-machine-intelligence-to-security-alerts/

Semantic code search!  Ah, yes, finally someone is getting to this,
but not Google: GitHub is getting there first.  How do they do it?
For now, they're not using really precise definitions like they could,
but they are doing vector field associations between the natural
language description and the code itself.  Importantly, this doesn't
need to match any text as shown in the comments around the code.

20190116/https://blog.github.com/2018-09-18-introducing-experiments-an-ongoing-research-effort-from-github/  
20190116/https://githubengineering.com/towards-natural-language-semantic-code-search/
