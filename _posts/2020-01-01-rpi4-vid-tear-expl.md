---
layout: post
title: Raspberry Pi 4 video tearing explained
date: 2020-01-01 15:04 -0600
author: quorten
categories: [raspberry-pi]
tags: [raspberry-pi]
---

So, I've found the explanation to the Raspberry Pi 4 video tearing
problem.  The new VideoCore VI is fundamentally architecturally
different than VideoCore IV, so the work on the old drivers cannot be
brought forward to the new drivers and some things simply need to be
redone.  That being said, the VC6 drivers are still under development
and incomplete in comparison, so we are going to have to suffer until
this fix is pushed into a newer version of these drivers.

20200101/DuckDuckGo raspberry pi screen tearing  
20200101/https://www.reddit.com/r/raspberry_pi/comments/e9k0u3/screen_tearing_solutions_for_the_4b/  
20200101/https://www.raspberrypi.org/blog/vc4-and-v3d-opengl-drivers-for-raspberry-pi-an-update/

But, the good news, it looks like a fix is coming soon.  Purportedly,
the upstream Mesa driveof time until the fix makes its way into the
official drivers in the Raspbian repository.

20200101/DuckDuckGo raspberry pi 4 tearing  
20200101/https://www.raspberrypi.org/forums/viewtopic.php?p=1541490  
20200101/https://www.reddit.com/r/RetroPie/comments/edi44v/raspberry_4_i_managed_to_remove_the_screen/

To try out the latest drivers yourself:

<!-- more -->

```
mkdir build
cd build
git clone --depth=1 https://gitlab.freedesktop.org/mesa/mesa
sudo apt-get install git python3.7 python3-mako wayland-protocols \
  libwayland-egl-backend-dev meson libxrandr-dev gettext
cd mesa
meson ..
cd ..
sudo ninja install
# then reboot, and try a video or game!
```

ledow wrote:

> Does it improve anything else? The guy on the Raspberry Pi forums
> says he won't get to bundling it into Raspbian until mid-Jan.
