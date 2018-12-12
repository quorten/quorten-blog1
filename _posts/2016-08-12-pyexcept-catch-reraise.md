---
layout: post
title: Notes on catching and reraising Python exceptions
author: quorten
date: 2016-08-12
categories: [python]
tags: [python]
---

VERY IMPORTANT Python notes.  How do you catch an exception, then
re-raise it as a new exception class, but still carrying the data of
the original exception?  What you need is exception chaining, a
feature that is only available in Python 3.  For Python 2, there are a
long list of caveats that achieve only in part what can be done in
Python 3, and they cannot be all combined together to get the same
effect.

Oh, and by the way, this was a long and hard search for me to summon
all of the available information.  The first Google results were
clearly inadequate, and I had to try multiple different search
strings.

20160812/http://nedbatchelder.com/blog/200711/rethrowing_exceptions_in_python.html  
20160812/http://www.ianbicking.org/blog/2007/09/re-raising-exceptions.html  
20160812/https://doughellmann.com/blog/2009/06/19/python-exception-handling-techniques/  
20160812/Google python initialize a new exception object from an
  existing exception  
20160812/http://stackoverflow.com/questions/696047/re-raise-exception-with-a-different-type-and-message-preserving-existing-inform  
20160812/https://www.python.org/dev/peps/pep-3134/

OH, and this was an interesting article linked from the Python
website.  Interesting because it crosses over from the same author of
one of the previous very-valuable articles I've linked.

20160812/http://pyfound.blogspot.com/2016/08/avoiding-curse-of-knowledge-ned-batchelder.html?utm_source=feedburner&utm_medium=twitter&utm_campaign=Feed%3A+PythonSoftwareFoundationNews+%28Python+Software+Foundation+News%29
