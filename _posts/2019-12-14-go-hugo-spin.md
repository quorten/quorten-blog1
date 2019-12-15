---
layout: post
title: My first steps taking Go Hugo for a spin
date: 2019-12-14 01:07 -0600
author: quorten
categories: [blogging, golang]
tags: [blogging, golang]
---

For a long time (okay, 2 years), I wanted to migrate my then-fledgling
blog from Jekyll to Go Hugo in order to speed up the build time and
reduce the esoteric Ruby dependencies that were difficult to setup on
my older Trisquel (i.e. Ubuntu-based) distribution.  Well, now is the
time.

First, in the interest of preparing for Raspberry Pi, I installed Go
Hugo via downloading the source and building it.

```
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export GOPATH=$HOME/go
cd $HOME
# Make sure to clone this outside your GOPATH.
https://github.com/gohugoio/hugo.git
cd hugo
go install --tags extended
```

20191213/https://gohugo.io/getting-started/installing

That took a while to build, but once it was complete, it was all
downhill from there following the tutorial.  I picked the
`hugo-octopress` theme because it looked similar to my existing blog's
theme, but honestly I really didn't like it.  It was more like a last
resort pick, just something to get me started.

<!-- more -->

```
hugo new site quickstart
cd quickstart
git init
git submodule add https://github.com/parsiya/Hugo-Octopress.git themes/hugo-octopress
echo 'theme = "hugo-octopress"' >>config.toml
# PLEASE convert `config.toml' to `config.yaml'!
hugo new posts/my-first-post.md
hugo server -D
```

20191214/https://gohugo.io/getting-started/quick-start/  
20191214/https://themes.gohugo.io/hugo-octopress/  
20191214/https://github.com/parsiya/Hugo-Octopress

Now take a look at the overall layout and structure of the site.
You'll notice that the article format is almost exactly identical to
Jekyll, except for one limitation in the date parsing: all times must
have seconds specified, and there must not be a space between the end
of the seconds and the beginning of the timezone specification.
Nevertheless, for the purposes of my blog thus far, this is a fairly
easy conversion via a simple `sed` script.

```
find -name '*.md' -print0 | xargs -0 -n 1000 \
  sed -i -e 's/ -0\(5\|6\)00/:00-0\100/g' *.md
```

Long term, I should submit a pull request to fix this defect.

Now, you can let it rip!  You'll find that you're off to a pretty
awesome start.  I tried Go Hugo out with a test run of the article
content from this blog, and wow was it fast at converting.  I also
found there were some essential features and functions built into the
template by default such as category and tag linking.

But, the biggest failing I found os far?  First of all, the default
permalink generation is different than GitHub.  I'll have to see if I
can make it smack identical, else I'll be in for a bigger problem.
Second, the inability to expand variables within Markdown article
content.  However, this needs to be taken in context...  Hugo's URL
link management could potentially be a solid way around this.
Nevertheless, I have all my blog article content structured up one
way, and migrating over in this way is a lot more of a challenge.

20191214/DuckDuckGo hugo expand variable in markdown  
20191214/https://stackoverflow.com/questions/42023687/how-to-use-template-parameters-in-page-content-in-hugo
