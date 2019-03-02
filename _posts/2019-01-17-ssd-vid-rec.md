---
layout: post
title: SSD capacities and longevity for video camera recording
date: 2019-01-17 11:21 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Do you want to setup a nature camera, a surveillance camera, or some
other camera, but you are worring about writing 24/7 video data to an
SSD or SD card will wear it out?  Sure, you can try using larger SSD
storage to delay the onset of failure, but will this really be
adequate?  Indeed, it will be.

20190117/DuckDuckGo how long does solid state storage last for security camera  
20190117/http://www.tomshardware.com/forum/281343-32-cameras-system

Here are some calculations to back this up.

Suppose writing video data for 30 minutes consumes 1.4 GB of storage.

    1.4 GB/30 min * 2 * 24 = 67.2 GB/day
    67.2 GB/day * 7 = 470.4 GB/week

So, how long will your SSD last at a write durability of 100,000
cycles?

    100,000 / 365.25 rewrites/year = 273.785 years
    100,000 / (365.25 / 7) rewrites/year = 1916.496 years

So, if you can store up a full week's worth of footage on a
solid-state footage, you have no need to worry about wearing it out
too quickly.  That being said, you definitely want to go for the
larger storage if you can.  It's far easier to keep administrative
decisions for keep/delete/archive data to be fully completed at the
end of a week, although some initial data entry may be done throughout
the week.

<!-- more -->

So yeah, go for at least 512 GB of solid-state storage if you want to
do 24/7 video footage.  Then from there, you can copy what you want to
keep to a hard disk drive at the end of the week.

How much storage would you need to save 5 years worth of video footage
from a single camera recording at 1.4 GB per 30 minutes?  Note that
gigabytes and terabytes here are base 1000, not base 1024.

67.2 GB/day * 365.25 days/year * 5 years = 122.724 TB per 5 years

Well, that's a doosey.  As of 2019, I've drawn the line at 6 TB of
offline storage.  Furthermore, I might only allocate a maximum of 1 TB
for surveillance footage.  Assuming most of the footage is practically
"duplicates," that means we can only save 0.815% of footage in terms
of time.  From my manual push-button "for dummies" around-the-house
activity logs I've been keeping, in terms of human actions versus full
time, this appears to be a correct amount to save.  And yes, this also
assumes we're only working with one camera.  Each additional camera
added divides down the available storage.

And, if you only leep 1% of the data, how much time is that?

     5 years * 1% = 18.262 days

And if you are only willing to watch 3 hours of that video data per
day, how long will it take you to watch it all?

    18.262 days = 438.3 hrs
    438.3 hrs / 3 hrs-to-watch/day = 146.1 days-to-watch
    = 40% of-year-to-watch

So, to manually review 5 years worth of video data, you might spend
half of one year in total days reviewing it?  And we're only talking
the remainder of the 1% of time-data saved out of the 99% of time-data
discarded!
