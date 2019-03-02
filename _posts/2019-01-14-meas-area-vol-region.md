---
layout: post
title: Measure surface area and volume of regions
date: 2019-01-14 16:27 -0600
author: quorten
categories: [3d-scanning, 3d-scanner]
tags: [3d-scanning, 3d-scanner]
---

If you have a region enclosed by a boundary contour, sure one easy way
to compute the area inside of it is to do a "scan-fill" of the region
and count the total number of pixels or voxels, but what about a
resolution-independent vector computation approach?  The obvious first
step would be to tesselate down the region into triangles or
tetrahedrons, for which the area can be computed trivially in a vector
manner.  But how do you get there?  One approach that I thought of is
by progressive convex hull determination.  First you determine the
convex hole of the entire region, calculate the area of that, then you
subtract convex hulls that cut into it to make a concave region.  If
you have additional cuts on each of those, you add back the area of
those convex hulls.  Keep doing this until you recurse down to the
last convex sub-shapes.

Another, purportedly more popular, alternative is to compute the
Delaunay triangulation of the region, then simply add up the area or
volume of those triangles.  Except for the triangulation part, it is
otherwise easy and simple, conceptually speaking.

20190114/https://en.wikipedia.org/wiki/Delaunay_triangulation  
20190114/https://en.wikipedia.org/wiki/Constrained_Delaunay_triangulation  
20190114/https://en.wikipedia.org/wiki/Chew%27s_second_algorithm  
20190114/https://en.wikipedia.org/wiki/File:LakeMichiganMesh.png
