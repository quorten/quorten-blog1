---
layout: post
title: "More info on virtual machines, kernel same-page merging, row
        hammer, and Google Project Zero"
author: quorten
date: 2018-12-04 18:13 -0600
categories: [random-software, security]
tags: [random-software, security]
---

Virtual machines.  Oh, sure, some types of virtualization have become
massively popular, whereas most remain relatively obscure.  What does
Wikipedia have to say on this?

20181204/https://en.wikipedia.org/wiki/Virtual_machine

So, related to the popular form of virtualization.  Kernel same-page
merging (KSM), this is interesting.  Purportedly Red Hat ran 52
virtual instances of Windows XP with 1 GB of memory via KSM.  Alas,
there's going to be a big problem if changes in the OS workload mean
that all OSes will need all of their requested memory.

20181204/https://en.wikipedia.org/wiki/Kernel_same-page_merging

Row hammer?  Now, this is interesting.  Early on in the history of
DRAM, memory corruption caused by specific access patterns was a
recognized issue, and memory vendors worked to mitigate it.  However,
market demands for highly dense memory in recent years have caused a
counter-trend for this issue to start cropping up once again.  But,
this time through, we have a much bigger software development world at
hand compared to the hardware world, and security researchers got to
work to see how they could turn this hardware issue into a security
vulnerability.  Then they published an official academic-style
research paper on the subject.  Now, the ongoing challenge in
mitigating this issue revolves around the energy consumption of the
mitigation technique.  The motivations on how modern DRAM evolved to
be vulnerable are obvious: higher density, lower heat dissipation,
lower energy consumption, lower cost.  So, it took a while longer for
mitigations to come back this time through, but for newer
architectures and DRAM modules, they are now available, so the row
hammer issue is a non-issue on the right hardware.

20181204/https://en.wikipedia.org/wiki/Row_hammer

Wow, and they've made yet another mention of Google Project Zero.
Again, I reiterate, because this is important!  So, why the name
Project Zero?  The name Project Zero was chosen because the task was
to find a number of zero-day vulnerabilities.  Also, the original
motivation for Project Zero came in light of the Heartbleed
vulnerability.

20181204/https://en.wikipedia.org/wiki/Project_Zero

Interesting and unfortunate that the process of plugging security
vulnerabilities must follow this route.  First of all, third parties
must make a big deal about them by developing working exploits,
publishing them, and describing their effects, then we can see the
originating companies getting to work at fixing these.  Sometimes the
process is slighly modified to notify the originators first before the
wider publication, but generally speaking, the _de facto_ process that
must be obeyed to get any progress is to develop working exploits, not
simply warn about the existence of such vulnerabilities that must be
fixed.
