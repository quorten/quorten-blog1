---
layout: post
title: "Status of Trisquel, `sysvinit`, and some reflection on my tech
        learning path"
date: 2020-05-25 22:21 -0500
author: quorten
categories: [unix]
tags: [unix]
---

Here again is another discussion of why Trisquel is based off of
Ubuntu rather than Debian, but there is some important key information
about the `systemd` versus `sysvinit` argument in here.

Wow, this is a really interesting story here, the whole of it.  What
happened after Debian switched from `sysvinit` to `systemd`?  Of
course, we know some developers were outright mad.  But, here's the
key.  `sysvinit` became broken in Debian, so developers had to make a
fork, one of which is called Devuan, that restored `sysvinit` back to
functioning.  In the meantime, they partnered with Debian to bring
`sysvinit` back into working condition in Devian.  But then, the
Devuan community came to an abrupt end when one of the lead developers
pulled an April Fool's joke that the Devuan website was hacked.  This
made a significant number of people upset, chaos, arguing, apologies,
and frustration ensued, that lead developer resigned, followed by
another, and another, and pretty soon, things just fell apart.  With
Debian `sysvinit` back into operation, folks switched almost
seamlessly from Debian to Devuan, and that was the end of it.

20200525/https://trisquel.info/en/forum/why-are-we-based-ubuntu-and-not-debian  
20200525/https://lwn.net/Articles/786593/  
20200525/https://web.archive.org/web/20190331191212/https://www.devuan.org/pwned.html

<!-- more -->

----------

Other than that, unfortunately, the reason why I came to the Trisquel
forums, there is not much activity over there.  I remember I came to
ThinkPenguin first by sight of it mentioned on the Trisquel website in
a sort of side banner ad.  And that's how I got my ThinkPenguin
network equipment.  Alas, they are no longer mentioned on the side of
the Trisquel website like they use to be, and to be honest, their site
and store looks quite inertial at the moment, is it slowly falling
into ruin?  How did I get to Trisquel?  I came from the GNU website,
and there is where they listed fully free GNU/Linux distributions.
How did I pick Trisquel from the site?  Well, I already started using
Ubuntu, and it was based off of Ubuntu, so I felt it would be a safe
and easy-to-use choice.  How did I start using Ubuntu?  I found it was
the basis of my Sage virtual machines.  How did I start using Sage?  I
saw it advertised as being used to make a particular graph image in a
math Wikipedi article I was reading to learn more about advanced math.
And besides, I also heard most recent passing mentions of Linux from
the GNU Emacs internal essays by Richard Stallman and the Doom Legacy
source code.  And that is, after all, how I got into GNU Emacs, first
from installing DJGPP on behalf of building Doom Legacy for MS-DOS.

And of course, I was using Doom Legacy because that was what was
required by the Ultimate Chex Quest, itself having been inspired due
to my family getting the Chex Quest game many years earlier in a
cereal box promotion, and therefore having an interest to search the
Internet for things related to it.  The website went down just too
soon, but eventually my brother was able to find ChexCentral.net, and
from there The Ultimate Chex Quest.

And, of course, MS-DOS itself, I learned through way of it being
mentioned in Windows 98, and of course those two MS-DOS computer games
I've interacted with, Chex Quest and NASCAR Racing 2.

From Doom Legacy I also learned of SourceForge.net, since that was
where the source code was hosted.  From there I searched out and found
Inkscape.  From Inkscape I learned of Blender.

And of course, at the same time, from learning GNU Emacs, I learned
about the Free Software Foundation and the Free Software Directory.
SourceForge.net and the Free Software Directory combined, I had my
next new move on finding tons of free, libre, open-source software,
rather than stupid proprietary shareware like WinZip (mentioned by way
of Doom Legacy as a way to open up the source code tarball I
downloaded) and Anvil Studio (just a generic Google web search for a
MIDI editor).  So those got deleted from my personal software archives
and I have no other record of them existing other than this story
retelling.
