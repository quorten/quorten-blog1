---
layout: post
title: Home network rules, observations, survey, tech plans
date: 2018-05-11 21:00 -0600
author: quorten
categories: [home-network]
tags: [home-network]
---

The rules of the home network as stated:

* The home network must be _totally libre_.  That is, anyone can set
  up their own devices in any way they please on the network, so long
  as it does not interfere with the rest of the network.

    * If someone wants their own DHCP/DNS server, they can setup their
      own NAT to do that.

    * Likewise, everyone gets unimpeded Internet access.  Standard
      firewall configurations are used on the router.

    * If anyone needs special firewall configuration, they can get
      that with ease, thanks to our libre software router.

* Anyone can learn how the home network works.

* There exists a local dedicated home server that anyone can use, so
  long as they share the resource fairly.

* The dedicated home server provides a local, shared repository of
  libre software that anyone can use.

* Anyone who asks to have direct access to the router/server and obeys
  system administration best practices can have it.

<!-- more -->

The rules of the home network as observed:

* Most devices on the network are mobile devices.  That is, tablets
  and smartphones, _not_ desktops and laptops.

* Most traffic on the network comes from mobile devices.

* Most traffic from mobile devices routes out to the Internet, rather
  than taking a local communication path.

* Most of the time from most peoples' _libre_, free-choice use of
  computers happens on mobile devices.

* For most people, the _only_ significant use of desktops and laptops
  is for work or school use.

* Subject-based division of people's _libre_, free-choice use of
  computers.

    * _Technical_ time: Virtually zero, the bare minimum necessary to
      keep the device working.  Technical time is time spent learning
      how computer devices work and administering the device itself.

      For example, most people do not care to learn the details of
      present-day computer networking protocols, i.e. the protocols
      used by modern tablets and smartphones, despite the fact that
      they have not changed in decades.

      Another example.  Most people care very little about the
      software that their particular mobile device runs.  Hence, there
      is a random smattering of different software running on the
      devices, even though the hardware is predominantly identical.
      Also, consequentially, the home server's repository of software
      is largely unused by potential users.  The potential users have
      expressed no interest in that piece of infrastructure.
      Therefore, the infrastructure is technically over-provisioned.

      For the software running on the mobile devices, major components
      are identical, but there are minor variations in configuration
      and patch versions, some of which render some vulnerable to
      major security flaws, whereas others are unaffected.

    * Non-technical time: Virtually 100%.  For the purposes of this
      analysis, non-technical time is essentially time spent relating
      to everything that is not relevant to maintaining the device
      itself.

----------

So wait, what exactly does the home server provide?

Nowadays we split up such computers into a few parts:

1. Broadband Modem
2. Combined Firewall and Router
3. Switches
4. Wireless access point(s)
5. Server(s)
6. Client computers

Okay, that was a little too complicated, now let's go for the common
home case.

1. ISP-leased box.  Combination of a broadband modem, firewall,
   router, switch, and wireless access point.
2. Client computers

So, the question is.  What does the home server provide beyond the
common home network case?

1. User accounts
2. Networked storage
3. A host to run servers on
   * Especially in the modern era, this may include containers.
     Virtual machines can be supported, but aren't preferred due to
     their high overhead.
4. Some default system-wide servers

So, yeah, the point here is, that due to the general lack of interest
in the home server in modern computing environments, it should be
scaled down.  People merely log in to access the Internet, then they
log into their Internet account from there.

Nowadays if you want a shared computer, you just create a global guest
account with no local storage.  If you want access control to the
computer, then you can create user accounts who don't have a personal
home.  Their home folder is merely copied into RAM and temporary.

Okay, now this is really interesting.  All of that said, any such
devices connected to the home network can be made to network boot,
thus they need virtually no local storage.

Suffice it to say, the device can be setup this way.  The device is
network booted.  If applicable, boot program checks the local
read-only volume checksum.  If it matches, booting continues locally.
Otherwise, a network boot is initiated, and if applicable, the booted
OS will cache itself to the relevant local storage for faster booting
in the future.  That way, the local storage is merely a cache that
doesn't need specific system administration on it.

Then, of course, you setup your network boot image to mainly feature a
browser.  Well... what else do you use to access the Internet?  Again,
we don't want people doing too much work locally, the whole point is
so that they can log into their favorite Internet services.  Local
files are only provided since some services require download-upload as
local files.

----------

Home computer survey!

1. What is your name?

2. First, some statements of fact.

   * Virtually all modern electronic devices contain a computer
     embedded within them.  Often times laypeople are not aware of
     most of these, while the small minority of devices with very
     powerful computers within them such as smartphones, tablet
     computers, laptops, and desktops, get the lion's share of
     attention to the fact that they are "computers."

   * All people use computers because they are more convenient than
     the alternatives.

   * Some people use computers because they are cheaper than the
     alternatives.

   * Some people use computers because they are faster than the
     alternatives.

   * Some people use computers because they provide higher quality
     results than the alternatives.

   * Some people use computers because they are "early adopters."
     These people use primitive computer technology early on in its
     development mainly to start learning about the technology.  These
     people are especially rewarded when the computer technology
     exponentially grows to become more convenient, cheaper, and/or
     faster than the alternatives.

   * A minority of people only use computers because they are required
     by the business processes or communication preferences of other
     communities of people.

   * Some people use computers to do things that were never done
     before not because it wasn't possible, but because of the
     economic ramifications of the older technology and the lack of
     shared motivations in the historic communities of people caused
     it to never happen historically.

   Are there any other reasons why you use computers?  If so, explain
   in text.

3. How much do you want to be able to understand the computer devices
   you use?

   A. The bare minimum required to use the device for your own
      convenience.
   B. The bare minimum required to use the device for your own
      convenience, and to keep the device working.
   C. A high-level, abstract, and partially incorrect overview of how
      the device works.
   D. A more advanced, in-depth understanding of the device.

4. Do you currently physically own a computer device?  Alternatively,
   are you the primary person found using at least one computer
   device?  In other words, are you the "majority user" of at least
   one computer?

   A. Yes, I physically own a computer device.
   B. No, but there is at least one computer device that I am the
      majority user of.
   C. No, I do not physically own a computer device, nor am I the
      majority user of any computers.

TODO: Shared users, work.  Of course there can only be one physical
owner at any given time, even if they are borrowing.  There is still
only one physical owner, even though there may be more than one
"logical" or legal owner.  Mututally exclusive computer use, when only
one person can use a computer in a certain way at a time.
Administration being a classic.  So, what are your ideas on
administration?  It's only locked down because it is a mutually
exclusive form of computer use, where only one choice can be made at a
time.

* So, rule of thumb.  All computers have multiple users.  But nowadays
  computers are increasingly more mobile, under the physical control
  of a particular person much more than was in the past.  And all
  computers are increasingly more frequently shared by means of remote
  access, rather than sequential physical access.

TODO: Who should pay for the manufacture of new computers?  Is it
acceptable for the government to regulate and limit the total number
of new computers manufactured within a year?  Do you think there are
negative consequences of a very high computer manufacturing rate, even
if these computers are being produced in line with market demand?

5. Do you want to physically own a computer device?

   A. Yes.
   B. No.

6. How much do you want to be able to logically control the computer
   devices that you physically own?

   A. It doesn't matter who controls the computer's logic to me.  It's
      all fair game, I only physically own the device for my own
      personal convenience.

   B. The physical owner should have basic control over the device
      like being able to switch the device off, remove its battery,
      disable its telecommunications, etc., but they don't need to
      fully understand how it works.

   C. The physical owner should have basic control plus some
      intermediate control that may be more complicated.

   D. The physical owner should be the logical owner.  A computer
      device physically owned by someone should not be able to do
      anything that the physical owner wouldn't expect the device to
      do.

7. How much do you think other people should logically control the
   computer devices that they physically own?

   Same answers as above.

8. How much do you think people should be held responsible (TODO) for
   the computer devices that they physically own?

   A. None.  If they failed to administer it, it should be perfectly
      acceptable for someone else to remotely manage the device.

      Therefore, the physical owner should not be held responsible
      (TODO) for any questionable use that happens on the device that
      is ultimately caused by a remote user.

   B. Therefore, the physical owner should also have basic
      responsibility (TODO) for any questionable use that happens on
      the device that is ultimately caused by a remote user.

   C.

   D. Therefore, the physical owner should be held responsible (TODO)
      for all activities that happen on the device.  Even if it was
      initiated by a remote user, the physical owner should still
      share responsibility.

9. Do you think it is acceptable for the logical owner of a computer
   (the person/company responsible for directing and controlling a
   computer's decisions) to not coincide with the legal owner, the
   person held responsible for activities initiated by a computer?

   Yes.  Google and Facebook should be free to hire a third-party
   legal defense to represent themselves in court.

   No.  The "custodians," the people who direct and program computers
   to cause their actions, need to appear in court too.  After all,
   the custodians of a physical building must do their part to lock it
   down and prevent intruders.

MAKE SURE to provide space for additional comments on each question,
beyond simply answering the question itself.  Also, every question
must have an alternative free-form answer too.

----------

CUT.  These advanced questions are only to be answered if you answered
that you want to learn more about computers.  Or, if you have answered
that you want great amounts of control over your device.

Because great power and control requires great knowledge if you want
to control such a complex device like a computer.

AND here's a twist.  Not only can we skip these questions based off of
the results mentioned above, we can also recommend answers to the
following questions, should someone be wondering about them.

The rule here is, someone needs to change their attitude toward the
first few questions before any of the following thoughts can become
relevant.

5. How much time do you want to spend learning about, administering,
   optimizing, and enhancing the computer technology that you use?
   Note that this will be called "technical time" for the remainder of
   questions.

   A. The bare minimum required to keep the device working.
   B. 10 minutes every day.
   C. 1 hour on weekends.
   D. Other, please specify in text.

6. How much time do you actually spend on "technical time"?

   A. The bare minimum required to keep the device working.
   B. 10 minutes every day.
   C. 1 hour on weekends.
   D. Other, please specify in text.

7. Suppose there was some maintenance/improvement you wanted in your
   computer systems but attaining it in your desired time frame would
   require you to spend more time than you normally desire to spend on
   such "technical time."  How would you approach this problem?

   A. You would give up the idea and stop trying.

   B. You would change your expectations to have your desired
      improvement at a later date, and keep working at it at your
      desired pace.

   C. You would try to spend more time than you normally desire to
      meet your desired time frame.

   D. Other, please specify in text.

8. What are areas you want to learn more about in computing?

9. What are tasks you want to have more practice doing with computers?

----------

Important!  Power over Ethernet does work with Gigabit Ethernet, by
transmitting both data and power over the same wires.

20180511/https://en.wikipedia.org/wiki/Power_over_Ethernet

RESOLVED:

Can you use a simple, non-smart switch to pass through VLAN tagged
packets?  Answer: It depends.  Suffice it to say, if you want to be
sure that VLAN tagged packets will pass through, you need something
smarter.

20180511/DuckDuckGo can a simple switch route vlan tagged packets
  correctly  
20180511/https://community.spiceworks.com/topic/119788-will-vlan-tags-pass-through-a-basic-simple-switch

----------

Important!  So you're wondering about 10 GbE?  Good news, 10 GbE can
travel over Cat 6 cables too.

20180511/https://en.wikipedia.org/wiki/10_Gigabit_Ethernet

Use Cat6a cables to reach 100 meters distance rather than only 55
meters?

20180511/https://en.wikipedia.org/wiki/Category_6_cable#Category_6A  
20180511/https://en.wikipedia.org/wiki/ISO/IEC_11801#Category_8
