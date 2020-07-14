---
layout: post
title: "Digi-Key article about safety circuits, and Texas Instruments
        article a bout power supply ideal diodes"
date: 2020-07-11 23:42 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

This is a very basic article on safety circuits, somehow I thought it
would be more in-depth on first sight.  Well, I guess I would... with
that dream I had and all.

20200711/https://www.digikey.com/en/articles/basic-understanding-of-safety-circuits?utm_medium=email&utm_source=aut&utm_campaign=69370_AUT2006A&utm_content=featured1learnmore_US&utm_cid=12399633&mkt_tok=eyJpIjoiWWprNU5XSmtNRGMzT1RZdyIsInQiOiJ0MThvWWY5cnd1N0JyMlQ3QzVIcXdLb21CdG9YY3RFcmVqZUVsZGRCanFiMVdhS2QxTmFNV3Q2Mk9lS2dsSVhzQkwxaTd3SVQrYVZYQkNGZWdTOHdiUjZzeGhQOXJvUE1hZ1VaT0FMWVZPS0pmdENWNnF4ekRia1c1bUpHTjA3WSJ9

This is a really good article about ideal diodes.  Schottky diodes in
power supplies for polarity protection or OR-ing together multiple
power sources, like battery backup and AC line power?  Sure, that
works okay for low-current (and low-voltage) systems, but for high
current systems, considerable energy is lost inside the Schottky diode
due to forward conduction power loss and this can create considerable
heat dissipation issues.  Hence, this is the motivation for using
"ideal diode" integrated circuit controllers since they have lower
energy losses for switching high current loads.

20200711/https://www.ti.com/lit/an/slvae57/slvae57.pdf?HQS=app-psil-psw-discretes2020_slvae57-exah-mc-emada-wwe&ts=1594513676720
