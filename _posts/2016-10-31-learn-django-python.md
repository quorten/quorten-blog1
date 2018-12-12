---
layout: post
title: Learning about Django Python
author: quorten
date: 2016-10-31
categories: [python]
tags: [python]
---

Cool, learning about django:

20161031/http://stackoverflow.com/questions/21069950/how-to-extend-the-django-user-model#21070846  
20161031/https://docs.djangoproject.com/en/1.10/topics/auth/  
20161031/https://docs.djangoproject.com/en/1.10/ref/models/instances/#django.db.models.Model.save  
20161031/https://docs.djangoproject.com/en/1.10/topics/db/models/  
20161031/https://docs.djangoproject.com/en/1.10/ref/models/options/#table-names  
20161031/https://docs.djangoproject.com/en/1.10/ref/databases/  
20161031/https://docs.djangoproject.com/en/1.10/ref/models/fields/

Create an object only once, after another object gets created:

20161031/http://stackoverflow.com/questions/21623061/django-create-object#21623796

Basically, you modify the `save()` method with the appropriate hooks.
If the object does not exist, create it.  Else, do nothing.
