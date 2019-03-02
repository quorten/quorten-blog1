---
layout: post
title: Notes on some things I've learned about Perl
date: 2019-01-17 17:35 -0600
author: quorten
categories: [perl]
tags: [perl]
---

Okay, so I've stated earlier that when I feel like I'm reading some
well-organized reference documentation, I don't feel inclined to take
notes.  But, alas, now I feel that if I _don't_ take notes, my notes
will not be an accurate reflection of the things I learn and the
things I do, so here I am taking notes on Perl, even though I don't
feel inclined to do so.

You can assign subroutines to variables in Perl.  Suppose you do so,
and then you want to execute the subroutine in that variable.  How
do you do that?  Use this syntax.

```
&{\&{$action}}();
```

20190104/DuckDuckGo perl execute function defined as variable  
20190104/https://stackoverflow.com/questions/1915616/how-can-i-elegantly-call-a-perl-subroutine-whose-name-is-held-in-a-variable

Suppose you call a command using the backticks syntax to capture its
standard output, but you also want to get its exit status.  How do you
do that?  Simple, just use the `$?` variable.  Note that you may need
to use `$? >> 8` to get the true exit status.

20190104/DuckDuckGo perl backticks exit code  
20190104/https://stackoverflow.com/questions/7819197/getting-the-return-value-of-a-command-executed-using-backticks-in-perl

<!-- more -->

Recently, I've been looking into an intermittent issue on Solaris 11.3
SPARC involving the CPAN IO::Async module.  The symptom is that a
simple process like `ifconfig -a` is executed asynchronously, but we
don't get the exit status back until hours later.  The cause appears
to be that we are listening for SIGCHLD signals to get the final exit
status, but somehow some of those signals can get missed, which would
leave us waiting longer than necessary.  Luckily, the IO::Async module
implements an alternative code path for systems that don't support
signals: there is a "polling loop" that sleeps for one second, then
checks if any child processes have exited via `waitpid()`.  This code
path is used for MSWin32.  Stating that the Solaris operating system
"does not support signals" appears to reasonably work around the
problem.

So, all that being said, I did a deep dive into the source code for
the modules IO::Async, IO::AsyncX::System, and Future.

DuckDuckGo perl IO::AsyncX System  
20190107/https://metacpan.org/pod/IO::Async  
20190107/https://metacpan.org/release/IO-AsyncX-System  
20190107/https://metacpan.org/pod/IO::AsyncX::System  
20190107/https://metacpan.org/source/TEAM/IO-AsyncX-System-0.003/lib/IO/AsyncX/System.pm  
20190107/https://metacpan.org/pod/IO::Async::Process  
20190107/https://metacpan.org/source/PEVANS/IO-Async-0.72/lib/IO/Async/Process.pm  
20190107/https://metacpan.org/source/IO::Async::Notifier  
20190107/https://metacpan.org/source/Future  
20190107/https://metacpan.org/release/PEVANS/Future-0.39  
20190107/https://metacpan.org/pod/release/PEVANS/Future-0.39/lib/Future.pm  
20190107/https://metacpan.org/source/PEVANS/Future-0.39/lib/Future.pm  
20190107/https://metacpan.org/source/PEVANS/Future-0.39/lib  
20190107/https://metacpan.org/pod/Future

I've read a bit about the simplest method to do object-oriented
programming in Perl.  Use the `bless` function to associate an object,
typically a hash, with a class, which is the name of your packge.
Then use the `->` operator galore for method function calls, and use
the `->{varname}` syntax for member variable access.  Public object
members in Perl?  I'm still not quite sure how that works.  Maybe my
code that I was writing was flawed in some other way, which is why it
didn't work for me when I tried it.

20190114/DuckDuckGo perl object public member  
20190114/https://stackoverflow.com/questions/19458785/why-cant-i-initialize-the-member-variable-inside-the-new  
20190114/DuckDuckGo perl bless public member  
20190114/https://stackoverflow.com/questions/392135/what-exactly-does-perls-bless-do/392194

How do you do signals in Perl?  In the simplest case, use the
`$SIG{ALRM'} = \&handler;` syntax.  A more tricky method is to use the
signal number directly, in which case you use the `{14} = \&handler;`
syntax.  A variation of the second method is what IO::Async uses to
assign signals.

20190109/DuckDuckGo perl signal handler  
20190109/https://stackoverflow.com/questions/27789452/signal-handling-in-perl
