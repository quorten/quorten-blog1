---
layout: post
title: Some of my first notes on Groovy Jenkins programming
date: 2019-05-31 23:22 -0500
author: quorten
categories: [ansible]
tags: [ansible]
---

Recently, I've got started with writing some Jenkins pipeline code.
Groovy, eh?  Yep, definitely Groovy.  So here I go a-searching for
information on Groovy, and here are some of my notes on the things I
needed to use.

Use `findFiles()` in Jenkins to get a list of files in the indicated
directory, matching the given regular expression.  Please note that
directories cannot be matched and returned in the file list, only
regular files.

20190531/DuckDuckGo jenkins findFiles  
20190531/https://jenkins.io/doc/pipeline/steps/pipeline-utility-steps/  
20190531/Google Jenkins findFiles does not list directories  
20190531/https://groups.google.com/forum/#!topic/jenkinsci-users/VW_5fiq-6tU

`findFiles` returns a list of `FileWrapper` objects, which you must
parse and process to convert into a list of filename strings.

20190531/Google javadoc FileWrapper  
20190531/https://javadoc.jenkins.io/plugin/pipeline-utility-steps/org/jenkinsci/plugins/pipeline/utility/steps/fs/FileWrapper.html

Use for-each syntax in Groovy like this:

```
def result = []
def wrap = findFiles(glob: '*')
wrap.each { it, i // iterator, index
  def full_path = it.getPath()
  result.add(full_path)
}
```

<!-- more -->

If you do not specify the iterator and index variable, `it` is used by
default for the iterator, and nothing is used for the index, as I
understand it.  You can also specify only a name for the iterator
variable.

20190531/DuckDuckGo groovy iterate over a list  
20190531/http://riptutorial.com/groovy/example/18003/iterate-over-a-collection  
20190531/https://stackoverflow.com/questions/9522897/groovy-how-to-iterate-a-list-with-an-index  
20190531/DuckDuckGo groovy for each  
20190531/http://docs.groovy-lang.org/latest/html/documentation/index.html#_looping_structures

* Notes on using groovy regular expressions

Groovy regular expression matching can be done using the familiar `=~`
operator as follows:

```
def m = text =~ /match/
```

20190531/DuckDuckGo groovy regex match  
20190531/http://docs.groovy-lang.org/latest/html/documentation/index.html#_regular_expression_operators

Note that you must use `def` to limit the scope of match variables.
If you do not use it, you may get weird errors like "matcher not
serializable."

20190531/DuckDuckGo jenkins regex matcher not serializable  
20190531/https://stackoverflow.com/questions/50855961/notserializableexception-in-jenkinsfile

You can index parenthetical groupings using match variables.  For
example, to index the third parenthetical grouping, use the following
syntax.

```
m[0][3]
```

20190531/DuckDuckGo groovy matcher  
20190531/https://docs.groovy-lang.org/latest/html/groovy-jdk/java/util/regex/Matcher.html
