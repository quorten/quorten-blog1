---
layout: post
title: Tricks on using Chef Inspec
date: 2019-09-10 20:22 -0500
author: quorten
categories: [ruby]
tags: [ruby]
---

Useful Chef inspec hacks!

```
result = command(...).result
# Do this to make sure the command actually gets run.
x = result.exit_code

fconts = file(...).contents
```

You can use these for remote system management and receiving files.
Why?  Because... business reasons.

You don't have to use all of Chef Inspec's (RSpec's) full
DSL that they give in the examples, after all.  The commands on
their own, despite freeling undocumented and hacky, work just fine.

Do you want to print information to standard output when running
Inspec?  I don't know of a sure way of doing this, but one way that
worked well for me is this:

```
describe my.stderr do
  its('content') should be ''
end
```

Then if your standard error (for example) is not zero, then you will
get the standard error messages printed out when running Inspec.

20190910/DuckDuckGo inspec expect  
20190910/DuckDuckGo chef inspect expect  
20190910/https://www.inspec.io/docs/  
20190910/https://www.inspec.io/docs/reference/profiles  
20190910/DuckDuckGo rspec expect  
20190910/DuckDuckGo rspec reference  
20190910/http://rspec.info/documentation/  
20190910/http://rspec.info/documentation/3.8/rspec-expectations/  
20190910/http://rspec.info/documentation/3.8/rspec-expectations/#Truthiness  
20190910/DuckDuckGo chef inspec print information  
20190910/DuckDuckGo chef inspec info message  
20190910/https://www.inspec.io/  
20190910/https://www.inspec.io/docs/  
20190910/https://www.inspec.io/docs/reference/dsl_inspec/
