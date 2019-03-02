---
layout: post
title: Looking for switches and devices resistant to static electricity
date: 2019-02-07 12:49 -0600
author: quorten
categories: [home-network, raspberry-pi]
tags: [home-network, raspberry-pi]
---

So, indeed, as I've stated, the problem with my smart switch hanging
is due to static electricity.  Static electricity from Ethernet cable
ends rubbing against floors, carpet, tabletops, or other surfaces.
Static electricity discharged to computers and conducted through
cables.  You walk across the carpet, you touch a computer, you get a
shock, and the smart switch is hung with all lights but the system
light illuminated to indicate this.

So, now I'm looking for products that are either switches designed to
be resistant to static electricity or devices to protect against it.
Essentially, "surge protectors" are the devices you use to protect
against static electricity, in addition to other power surges that
could go through Ethernet wires.  However, good such devices are not
cheap, which indeed does explain why such functions may be removed
from a network device in order to cut costs.  The switches that have
documented specifications against static electricity resistance appear
to be almost all larger enterprise-class style switches.


20190206/Google ethernet switch protect static electricity from port

Here is one switch that can withstand static electricity up to 6 kW.
Alas, this is a "metro switch" rather than a conventional one of its
size, so it may not be right for me.

20190206/https://www.dlinkmea.com/index.php/product/details?det=VWx4cGxNa21HS211a3g1RVJlQnVTUT09  
20190206/https://en.wikipedia.org/wiki/Metro_Ethernet

<!-- more -->

8-port Ethernet surge protectors do exist, but they are expensive.

20190206/DuckDuckGo 8 port ethernet surge protector  
20190206/http://www.l-com.com/surge-protector-indoor-8-port-med-power-10-100-base-t-cat5-lightning-surge-protector#  
20190206/DuckDuckGo 8 port ethernet static electricity surge protector

This is a good PDF detailing the particulars of static electricity and
surge protection for Ethernet equipment, and it talks a little bit
about an integrated circuit designed to protect an Ethernet PHY driver
chip from static electricity on the port of a device.  Interestingly,
it notes another source of static electricity is bending an Ethernet
cable back and forth, which creates a static electric charge within
the cable that gets discharged to the equipment when plugged in.
November 2007 is the date of the paper.

Notably, an unprotected Ethernet PHY has some degree of static
electricity resistance, some more than others of course.

20190206/http://akrossilicon.com/home/admin/files-doc-s/finish/3-whitepapers/29-ethernet-esd-compliance-w-as1602-wp12-rev1-3-pdf  
20190206/https://www.ebay.com/itm/24-port-separate-Ethernet-RJ45-surge-protectors-all-8-pins-rack-19-PoE-support-/251367419365

Here is a single-port surge protector device.  Again, it's fairly
expensive.  D-Link is looking to be a pretty good brand for providing
network devices designed to tolerate static electricity.

20190206/http://us.dlink.com/products/business-solutions/dpe-sp110i/  
20190206/DuckDuckGo DPE-SP110I  
20190206/https://www.officedepot.com/a/products/6860764/D-Link-Gigabit-Ethernet-POE-RJ45/  

20190206/DuckDuckGo netgear static electricity protection

Here is a pretty good article discussing some of the general numbers
for static electric buildup from humans in an indoor environment, and
how this relates to the sensitivity of electronic devices.  Variations
in relative humidity, of course, can have a **huge** impact on the
static electric voltages that can build up.  Also, it's interesting
that in an anti-static work area, you can setup meters to show the
amount of static electricity present.

20190206/https://www.minicircuits.com/app/AN40-005.pdf  

Wikipedia article on Netgear?  Indeed, like I thought, Netgear
outsources manufacturing of its own equipment.  Curiously, there can
be considerable quality variations in their equipment based off of
which manufacturer it comes from.

20190206/https://en.wikipedia.org/wiki/Netgear
