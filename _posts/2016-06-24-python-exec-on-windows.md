---
layout: post
title: Running Python scripts on Windows
author: quorten
date: 2016-06-24
categories: [python]
tags: [python]
---

Very important for running Python on Windows.  How do you setup
Windows so that you can execute Python scripts like regular binaries?
Note that Windows needs the Python `.py` extensions to be sticking
around for this to work.  No extensionless executables, sorry.

20160624/http://stackoverflow.com/questions/9037346/making-python-scripts-run-on-windows-without-specifying-py-extension

    assoc .py=Python.File
    ftype Python.File=c:\Python27\python.exe "%1" %*

    assoc .py=Python.File
    ftype Python.File="C:\Program Files\Python35\python.exe" "%1" %*
