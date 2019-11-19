---
layout: post
title: Many useful parts for building your own motor control circuit
date: 2019-11-11 20:46 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

Interesting, so the functional diagram of the L293D from
STMicroelectronics shows that an H-bridge with diode protection is
basically two buffer circuits and a diode bridge.

20191111/https://www.digikey.com/product-detail/en/stmicroelectronics/L293D/497-2936-5-ND/634700  
20191111/https://www.st.com/content/ccc/resource/technical/document/datasheet/04/ac/22/f9/20/5d/43/a1/CD00000059.pdf/files/CD00000059.pdf/jcr:content/translations/en.CD00000059.pdf

So, now the question to ask.  If I can't get the exact motor
controller that I want, maybe I can build my own.  First order of
business.  Can I get 3 V NAND logic in the through hole DIP form
factor?  Indeed I can!

<!-- more -->

20191111/https://www.digikey.com/products/en/integrated-circuits-ics/logic-gates-and-inverters/705?k=&pkeyword=&sv=0&pv16=294032&pv16=96863&pv16=107879&sf=1&FV=-8%7C705%2C247%7C378818%2C276%7C121108%2C276%7C121120%2C276%7C125356%2C276%7C128773%2C276%7C134904%2C276%7C168980%2C276%7C169006%2C276%7C169019%2C276%7C174218%2C276%7C202783%2C276%7C202787%2C276%7C202790%2C276%7C202794%2C276%7C202821%2C276%7C202873%2C276%7C34200%2C276%7C34201%2C276%7C36616%2C276%7C36636%2C276%7C38721%2C276%7C48870%2C276%7C48897%2C276%7C53178%2C276%7C53189%2C276%7C55776%2C276%7C56901%2C276%7C56916%2C276%7C57820%2C276%7C61308%2C276%7C61334&quantity=&ColumnSort=0&page=1&pageSize=25  
20191111/https://www.digikey.com/product-detail/en/texas-instruments/SN74HC03N/296-8207-5-ND/376880  
20191111/http://www.ti.com/lit/ds/symlink/sn74hc03.pdf

Okay, so that's good and great, but really I only need some inverters
to save myself one GPIO pin per motor.  Can I get a package with just
those at the 3 V logic level?  Indeed I can!

20191111/https://www.digikey.com/products/en/integrated-circuits-ics/logic-gates-and-inverters/705?k=&pkeyword=&sv=0&pv16=96863&pv16=107879&pv16=142845&sf=1&FV=247%7C359778%2C-8%7C705%2C276%7C121108%2C276%7C121120%2C276%7C128773%2C276%7C134904%2C276%7C168980%2C276%7C169006%2C276%7C169019%2C276%7C202783%2C276%7C202787%2C276%7C202790%2C276%7C202794%2C276%7C202821%2C276%7C202873%2C276%7C34200%2C276%7C36616%2C276%7C36636%2C276%7C38721%2C276%7C48870%2C276%7C48897%2C276%7C53189%2C276%7C55776%2C276%7C56901%2C276%7C56916%2C276%7C57820%2C276%7C61334&quantity=&ColumnSort=0&page=1&pageSize=25  
20191111/https://www.digikey.com/product-detail/en/texas-instruments/SN74HC04N/296-1566-5-ND/277212  
20191111/http://www.ti.com/lit/ds/symlink/sn74hc04.pdf

Okay, this is going really good.  Now let's step it up a notch.
Rather than using all my own MOSFETs, can I get an appropriate buffer
IC that can work at 3 V?  Almost.  This has an operating range from 2
V to 6 V.  And I plan on reusing some 9 V motors.  Not bad for normal
operation, it's just that if the user turns the motor on their own,
that could exceed the voltage range of the driver circuits and that
would destroy them.  So, although it works well most of the time, it's
not robust in exceptional circumstances.  But if I bought a
purpose-built 3 V or 5 V motor, that would not be an issue at all.

20191111/https://www.digikey.com/products/en/integrated-circuits-ics/logic-buffers-drivers-receivers-transceivers/704?k=&pkeyword=&sv=0&pv1291=96859&pv1291=97190&pv1291=107877&pv1291=108442&pv1291=142844&pv1291=143602&pv1291=154585&pv1291=154992&sf=1&FV=-8%7C704%2C276%7C121108%2C276%7C121120%2C276%7C128759%2C276%7C128773%2C276%7C128790%2C276%7C134895%2C276%7C134904%2C276%7C134909%2C276%7C134960%2C276%7C168980%2C276%7C169006%2C276%7C169019%2C276%7C171582%2C276%7C202783%2C276%7C202790%2C276%7C202794%2C276%7C202821%2C276%7C202873%2C276%7C34200%2C276%7C36616%2C276%7C36636%2C276%7C38721%2C276%7C45880%2C276%7C48870%2C276%7C48897%2C276%7C53178%2C276%7C53189%2C276%7C55776%2C276%7C56893%2C276%7C56901%2C276%7C56902%2C276%7C56916%2C276%7C57820%2C276%7C61308%2C276%7C61334&quantity=&ColumnSort=0&page=1&pageSize=25  
20191111/https://www.digikey.com/product-detail/en/texas-instruments/SN74HC541N/296-1594-5-ND/277240  
20191111/http://www.ti.com/lit/ds/symlink/sn74hc541.pdf

Finally, a diode bridge rectifier IC package.  Yes indeed.

20191111/DuckDuckGo digikey diode bridge  
20191111/https://www.digikey.com/products/en/discrete-semiconductor-products/diodes-bridge-rectifiers/299?k=&pkeyword=&sv=0&pv1291=227463&pv1291=227688&pv1291=228267&sf=1&FV=-8%7C299&quantity=&ColumnSort=0&page=1&pageSize=25  
20191111/https://www.digikey.com/product-detail/en/on-semiconductor/DF04M/DF04M-ND/965265  
20191111/https://www.onsemi.com/pub/Collateral/DF10M-D.pdf

----------

UPDATE 2019-11-18 I did some more searching and found a broader range
of buffer ICs that would work well.

20191118/https://www.digikey.com/products/en/integrated-circuits-ics/logic-buffers-drivers-receivers-transceivers/704?k=&pkeyword=&sv=0&pv16=96863&pv16=107879&pv16=142845&pv16=154586&pv16=154592&pv1291=96859&pv1291=97190&pv1291=107807&pv1291=107877&pv1291=108442&pv1291=142705&pv1291=142844&pv1291=143602&pv1291=154585&pv1291=154992&sf=1&FV=-8%7C704&quantity=&ColumnSort=0&page=1&pageSize=25

This one works from 3 V to 18 V.  Maximum input current = 100 mA.  Max
10 mA per input, maybe not exactly what I need.  I probably want
something that can handle 300 mA for a single motor, just to be on the
safe side, though my actual motors will not be that big.  Of course I
am designing my entire system to not consume more than 1 A of current
at 5 V, with the Raspberry Pi Zero + Camera able to consume a good 500
mA at 5 V.  Maybe I really should invest in smaller motors then.  And
although a buffer IC would be smaller, power MOSFETs are safer simply
due to their size for handling larger power and more cooling.

20191118/https://www.digikey.com/product-detail/en/texas-instruments/CD4010BE/296-2160-5-ND/67239  
20191118/DuckDuckGo how much current does a 9 v dc motor draw  
20191118/https://www.quora.com/How-much-current-can-a-12V-DC-motor-draw
