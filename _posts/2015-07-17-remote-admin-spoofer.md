---
layout: post
title: "This nice HTML snippet to attempt to communicate with remote
        desktop admin spoofers"
author: quorten
date: 2015-07-17 11:01
categories: [misc]
tags: [misc]
---

Do you feel like someone is remotely jittering your mouse?  Well, for
one time that I felt like that, I created this HTML page to try to
communicate with them, which they would purportedly see through their
remote desktop access to my work computer.  Note that this works well
with high school computers, but in the end, there probably wasn't
anyone on the other end with remote desktop access to my work
computer.  What I now learned that was probably happening was due to
the particulars of my hardware setup.  I had monitors connected via
DisplayPort/Thunderbolt plugs.  Thunderbolt is a high-performance
DMA-based protocol.  This means that glitches on the wiring and
interface can mess around quite a bit with the state of the computer
itself.  Or, even more likely was that the Mac's touch pad design has
a tendency to glitch up due to sub-optimal thermal design eventually
causing random glitches on the touch pad.

But, anyways, here is the HTML that I've written that you might take
interest in reusing.  A nice snippet to start with, I must say.

`notifier.html`:

<!-- more -->

```
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <title>Notification Screen</title>
  <style type="text/css">
    #flasher { font-family: monospace; font-size: 42pt; }
    #flasher p { margin: 0px; }
  </style>
</head>
<body>

  <div id="flasher">
  <p>ISSUE: The mouse pointer jerks around the screen even when the
  mouse is not plugged in.</p>
  <p>&nbsp;</p>
  <p>I've filed this issue with ServiceExchange, so stop jerking the
  mouse!</p>
  </div>

  <p><span id="activator" style="border-style: solid; border-width: 1px">
  &nbsp;Activate&nbsp;</span></p>

  <script type="text/javascript">
  counter = 0;

  function invertCols(obj)
  {
    obj.style.color = 'white';
    obj.style.backgroundColor = 'black';
  }

  function uninvertCols(obj)
  {
    obj.style.color = 'black';
    obj.style.backgroundColor = 'white';
  }

  function invertThis(event)
  { return invertCols(this); }
  function uninvertThis(event)
  { return uninvertCols(this); }

  function triggerInvert()
  {
    invertCols(this);
    counter = 6;
    countDown();
  }

  function countDown()
  {
    counter -= 1;
    if (counter % 2 == 0)
      uninvertCols(document.getElementById('flasher'));
    else
      invertCols(document.getElementById('flasher'));
    if (counter > 0)
      return window.setTimeout(countDown, 250);
  }

  document.getElementById('activator').onmousedown = triggerInvert;
  document.getElementById('activator').onmouseup = uninvertThis;
  </script>

</body>
</html>
```
