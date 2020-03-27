---
layout: post
title: Decisions on choosing a supercapacitor
date: 2020-03-22 17:21 -0500
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Okay, so now that I understand how a capacitor works better, let's try
my hand at selecting a supercapacitor.  How do you know what
parameters are needed when selecting a supercapacitor?  Remember, the
capacitance is an indicator of how long your capacitor can supply a
particular voltage before the voltage sag becomes too great for your
computer to keep operating off of the remaining power.  For
simplicity, rather than using a boost switched-mode power supply and a
smaller value supercapacitor, we can just use a larger value
supercapacitor.  Besides, it's rechargeable and it's short-term
charge, so it's not as essential to maximize the running time on a
single battery or charge.

```
C = Q / V
V = Q / C
Q = C * V

C = 1 F
V = 5 V
Q = 5 C

C = 1 F
V = 3 V
Q = 3 C
```

<!-- more -->

Okay.. so what does that mean?  It means I can drain 2 C of charge
before the supercapacitor's output voltage sags to 3 V.  How much time
is that in terms of Raspberry Pi Zero + Camera current draw, 600 mA?

```
I = 0.6 A
Q = I * t
t = Q / I = 2 / 0.6 = 3.333 sec.
```

And that is a maximum time... because of the buck switched-mode power
supply, we will draw more current as the voltage sags.

Minimum time, compute effective current draw at 3 V.

```
P = V * I = 5 * 0.6 = 3 W
I = P / V = 3 / 3 = 1 A
t = Q / I = 2 / 1 = 2 sec.
```

So if we want to run 10 times as long, we want a 10 F supercapacitor.
That allows us 10 times more time to be lazy in winding our manual
winding charging coil.  50 times as long would be nicer.  So now
you're talking a 50 F supercapacitor.

Alas, I look at the prices... and I say hey, a 40 F supercapacitor
would be nice, but gosh that is relatively expensive.  I can still
live with a 25 F supercapacitor, 1 minute of Raspberry Pi runtime is
plenty.  Also, the fact is that getting supercapacitors capable of
putting out 5 V is a lot harder than looking for the supercapacitors
with a maximum voltage of 3.3 V, 2 V, or even lower.

Okay, another thing to remember... the larger the capacitance, the
more you _have to_ charge it in order to get up to the higher
voltages.
