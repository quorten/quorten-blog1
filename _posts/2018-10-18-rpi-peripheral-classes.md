---
layout: post
title: Raspberry Pi peripheral classifications
author: quorten
date: 2018-10-18 20:00 -0500
categories: [home-network, 3d-scanner, 3d-scanning, raspberry-pi, important]
tags: [home-network, 3d-scanner, 3d-scanning, raspberry-pi, important]
---

Let's discuss the Raspberry Pi hardware that makes general measurement
of a house not only possible, but accurate.  It's clear that what it
comes down to for this use is using JST connectors to (1) make things
easy to plug and remove in different combinations and (2) allow using
arbitrary wire ends that are easy to solder together.

Okay, so new definitions for my Raspberry Pi sensor array.  Okay,
fine, I'll list this in order, and try to group various sensors into
practical applications, sorted by some order of their technical
complexity and cost.

Tiny core sensor pod:

1. JST connectors for GPIO push buttons
2. PWM buzzer
3. Weight sensor, force sensor, motor resistance sensor
4. Microphone
5. Environment temperature sensor (Raspberry Pi GPU temperature)
6. Environment humidity sensor
7. Temperature probe sensor

Barcode reader:

8. Laser line illuminator
9. Optical line sensor, 1D image sensor... where to get these?

Robot:

10. Motor control IC
11. Motors
12. Rotation speed sensor, "resolver"

Camera:

13. Optical viewfinder
14. NoIR camera
15. IR cut switch
16. Visible and infrared illumination LEDs

<!-- more -->

Mobile device:

17. Battery power
18. Laser range finder (phase shift preferred, else time-of-flight).
    Also doubles as a laser pointer.
19. Accelerometer
20. Gyroscope
21. Magnetic compass

User interface:

22. PCM audio output
23. Indicator LEDs
24. digital LED/LCD screen with switchable backlight, passive matrix
25. Keyboard
26. Graphics touchscreen
27. Mouse

* Raspberry Pi optical viewfinder
* Raspberry Pi multimeter

Remote control:

* Infrared transmitter
* Infrared receiver

Networking:

* Serial communications: CMOS serial, RS-232, RS-422, RS-455
* Ethernet
* Wi-Fi
* Blutooth
* Cellular communications
* Satellite communications

Field work devices:

* Metal detector
* Electric field detector, stud finder, live wires
* Multimeter, electrical conductivity, resistance, diode polarity,
  voltage, current
* Thermal conductivity
* Electronic nose, photosensitive chemical detector
* NEXT GEN: Electronic tongue, sense chemical surfaces by touch.  A
  multimeter is kind of like this, but only electronics.

Scientific:

* Thermal camera
* UV camera
* Radar imager
* LIDAR imager
* X-ray imager
* Scanning by heating
* Sonar imager
* Ultrasound imaging, underwater
* Geiger counter, radioactivity sensor
* UV light sensor
* Colorimetry, spectral sensor
* DNA scanner
* Neutrino detector

Electronic interfaces:

* Composite video
* SCSI
* Apple Desktop Bus
* PS/2
* USB

Internal computer electronic interfaces:

* ISA
* PCI
* PATA
* SATA

Electronic media:

* Phonograph record
* Movie film reel
* Audiocassette
* VHS videocassette
* Magnetic stripe
* Floppy disk
* Optical disc

Vehicles/avionics:

* GPS receiver
* Air pressure sensor
* Wind speed sensor

Okay, this is bordering on science fiction to include some of these
sensors.

Important!  So why would you want to use a calculator-style LCD screen
and keypad in preference to a full graphical touchscreen?  For battery
powered devices, the answer is obvious: a calculator-style LCD screen
and keypad consumes less energy than a full graphical touchscreen.
That means more battery life for your mobile device.
