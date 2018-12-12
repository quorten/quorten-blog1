---
layout: post
title: Exploring CopyingMock in Python
author: quorten
date: 2016-09-29
categories: [python]
tags: [python]
---

Okay, now this was an interesting exploration into CopyingMock, class
instances, and such of that.  Why is it that you can't mock the class
and have the members mocked correctly too?

    # This fails.
    with patch(__name__ + '.MyTest.get', new_callable=CopyingMock
               ) as mock_get:
        x = MyTest(1)
        x.get(TEST_URL)
        mock_get.assert_called_once_with(x, TEST_URL)

    # This works.
    with patch(__name__ + '.MyTest.get', new_callable=CopyingMock
               ) as mock_get:
        x = MyTest(1)
        x.get(TEST_URL)
        mock_get.assert_called_once_with(TEST_URL)

    # This works.
    with patch(__name__ + '.MyTest.get') as mock_get:
        x = MyTest(1)
        x.get(TEST_URL)
        mock_get.assert_called_once_with(TEST_URL)

Okay, let me explain what is going on here.  I read the source code,
so I have something to reference.  First of all, let's note that we
are making assertions on how the function is called, so we technically
don't need to setup a spec for the mocked functions because that is
the basic point of the assertions.  Second, I have to note a
peculiarity of autospecing.  Autospecing calls an internal function
named `_set_signature()` that is used to generate a lambda function
that verifies the function signature then calls the actual mock,
whereas a direct mock does not quite have the equivalent function.
That being said, I'm not exactly sure why setting the spec directly
must have different behavior than autospecing.
