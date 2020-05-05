---
layout: post
title: Some good Golang vector math libraries to look at
date: 2020-05-04 23:45 -0500
author: quorten
categories: [media-prog, golang]
tags: [media-prog, golang]
---

When writing my application-specific integer vector math library, I
was looking around at some Golang math libraries.  Indeed they have
some good things for me to keep in mind about adding to my own
library.  This is a tough space in terms of apparent duplication of
effort... but if you must create a new library, if you can provide a
familiar interface to most other libraries, that's the most you can
ask for.

20200504/DuckDuckGo go vector math library  
20200504/https://github.com/atedja/go-vector  
20200504/DuckDuckGo go linear algebra  
20200504/https://github.com/skelterjohn/go.matrix  
20200504/https://github.com/skelterjohn/go.matrix/blob/go1/dense.go  
20200504/https://github.com/skelterjohn/go.matrix/blob/go1/arithmetic.go  
20200504/DuckDuckGo golang integer vector math  
20200504/https://github.com/golang/image/blob/master/vector/vector.go

20200504/https://en.wikipedia.org/wiki/Kronecker_product

This provides familiar features and functions from BLAS/LAPACK.

20200504/https://github.com/gonum/gonum
