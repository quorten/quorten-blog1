---
layout: post
title: Install custom gem into Bundler environment
date: 2019-07-15 20:11 -0500
author: quorten
categories: [ruby]
tags: [ruby]
---

So, you're doing some development on a Ruby gem, and now you want to
install that custom Ruby gem into a bundler environment for the sake
of testing with a larger Ruby app.  How do you do this?  Well, well,
interestingly, there are two ways of doing this.

The first way is the simplest way.  First of all, we assume you are
not using a local directory for bundler.  That is, you do a `bundle
install` directly in your larger app without specifying a directory
via the `--path` option.  When you call `bundle install` like that,
`bundler` will reuse the system/user gem directory for fetching
installed bundler dependencies.  Now, that is where the magic comes
in.  Change the version of your development gem to something unique,
simply install your development gem to your system/user gem directory
via `rake install`, then update your larger app's Gemfile to point to
your unique version.  `bundle install` and `bundle exec` will
automatically pick up and use your desired development gem version.

The second way assumes that you are using a local directory for
bundler via the `--path` option.  Here, the alternative that you
should use is to define the gem with a path in the Gemfile like this:

```
gem 'rails_admin', :path => "vendor/gems/rails_admin"
```

You would place the gem inside the indicated directory.

<!-- more -->

20190715/DuckDuckGo bundle install custom gem  
20190715/DuckDuckGo bundle install local gem  
20190715/https://stackoverflow.com/questions/6088408/gem-bundle-install-from-local-machine
