---
layout: post
title: Windows `.res` file format
date: 2020-02-05 02:19 -0600
author: quorten
categories: [windows]
tags: [windows]
---

What is the file format of the `.res` resource files that are emitted
by the MSVC compilers?  MSVC++ 6.0 has this really nice ability to be
able to open up the `.res` compiled resource files and browse around
the resource contents.  In one case, I saw it also able to do this no
an New Executable (NE) object format DLL.  However, it appears that
the ability does not extend to Portable Executable (PE) object code
formats, i.e. the required format for 32-bit Windows software.

Fortunately, it wasn't too hard to find information about this.  So,
here's what happens.  The `.res` file format is basically a RIFF-like
sequential-search list chunk block format **as-is**.  Then, MSVC uses
a utility called `CVTRES` to add a resource index table and pack the
whole object into a COFF object code file, which is then passed to the
linker and linked in as-is.  MinGW, by contrast, does not produce an
intermediate `.res` file but instead jumps straight to the COFF object
code file.

20200105/DuckDuckGo .res compiled windows resource file format  
20200105/http://bytepointer.com/resources/win32_res_format.htm

Unfortunately, this document did not completely specify the 32-bit
resource table/directory format.  Fortunately, there is sufficient
information inside the MinGW tools themselves, especially the
`objdump` output, for determining this information.
