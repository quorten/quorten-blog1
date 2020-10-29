---
layout: post
title: My skunkworks attempt at approximate division
date: 2020-07-12 21:00 -0500
author: quorten
categories: [unlipic]
tags: [unlipic]
---

I thought I've found out this clever trick to compute approximate
division, but it turns out I didn't really.  Well, it's an interesting
attempt anyways.

Let's start with the equation.

```
a * b = c
```

Now, make an assumption.  What if a == b?  This simplifies as follows.

```
a^2 = c
```

Now, phrase the equation as an error adjustment on that ideal
assumption.

```
(a + r) * (a + q) = c
a^2 + a*q + r*a + r*q = c
```

If we're just adjusting one factor to be ideal, this is further
simplified.

<!-- more -->

```
(a + r)^2 = c

a^2 + 2*a*r + r^2 = c
```

`a` and `c` are known in advance.  We can use the quadratic formula to
solve for `r`.  But that requires divide!  No worries, our `a`
coefficient (i.e. in front of `r^2`) is one, so it is just divide by
2, shift right.  And we can use approximate square root which is super
fast.

So, for the previous equation, that only works if `r == q`.

Now, the arcane idea.  We adjust one factor so that it is always the
square root of the product.  Then we want to solve for the other
factor?  Well, that's easy.

Now, the claim is that when this is the case, we know what additional
terms we need to add, `2*a*r + r^2`.  And we need to compute `a^2`.

```
a * w = c
(a^2 + 2*a*r + r^2) / a = w
a + 2*r + (r^2)/a = w
```

So... we still end up dividing by `a` in a term.  The bigger the
difference from a square, the bigger the error in an approximation
right there.  However... this is where computer math tricks come into
play.  We're squaring, then dividing.  That's a multiply-divide, and
we can approximate that using bit-shifting.  We know clear error
bounds on such an approximation, and we can determine if the result is
suitable for our particular application.

Really, what was this all about?  Going around in circles it seems,
you could have just done a approximate divide by power of two by
shifting.  And in the case of a square root, it really has the same
accuracy as an approximate square root.  Is this really any more
accurate for non square root cases?

And besides, why would you even you the other form to compute
difference to the square root?  Why not just compute the square root
and then the difference directly?
