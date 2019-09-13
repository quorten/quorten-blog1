---
layout: post
title: Git's antiquated contributor process and nedmalloc
date: 2019-09-11 20:06 -0500
author: quorten
categories: [random-software]
tags: [random-software]
---

Many times I have looked at the Linux and Git repositories on GitHub.
Yeah, sure, they state clearly, they are mirrors for reference only,
pull requests are not accepted, those are done the alternate,
traditional Git way.  Which is what?  E-mailing patch files to the
mailing list.  Yep, they're still doing that, even in the year 2019.
Wow, that's like the raging 90's era way of doing open-source
software, and hardly even considered open at that!

Nevertheless, some daresome adventuring has shown that there actually
are pull requests on the GitHub repository ofr Git, and some review
comments at that, namely from `dscho`, i.e. the Microsoft employee on
Git for Windows.  What gives?  Basically, even though pull requests
are not officially accepted there, they are still used as a useful
staging ground for preparing Git patches, and there are in fact even
tools to help make the patch submission process easier.  Two notable
tools are GitGitGadget and submitGit.

20190911/https://github.com/git/git/pulls  
20190911/https://github.com/git/git/pull/498  
20190911/https://gitgitgadget.github.io/  
20190911/https://submitgit.herokuapp.com/

Yeah. that's an open pull request that never made it originally, but
was duplicated and merged by someone else, but what about a
successfully closed pull request?  Look here.

20190911/https://github.com/git/git/pull/632

<!-- more -->

Here is an example of what a mailing list code review looks like.
Yeah, it's ugly, but it works, and indeed it worked well when it was
one of the few and only mechanisms for open-source code review in the
90's era when better software tools were not yet available.

20190911/https://public-inbox.org/git/nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet/T/#t

I also found this interesting memory allocator specifically designed
for besting the Windows XP default memory allocator and likewise for
other operating systems, `nedmalloc`.  The idea is that you only use
it on the older operating systems as a patch mechanism to get better
performance, asa the newer operating systems all use state-of-the-art
dynamic memory allocators.

20190911/DuckDuckGo nedmalloc  
20190911/https://www.nedprod.com/programs/portable/nedmalloc/
