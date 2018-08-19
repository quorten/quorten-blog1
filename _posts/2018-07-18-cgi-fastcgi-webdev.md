---
layout: post
title: CGI/FastCGI and modern web programming
author: quorten
date: 2018-07-18 18:05 -0500
categories: [tour-de-force]
tags: [tour-de-force]
---

So, you're still wondering about the future of CGI/FastCGI?  What
happened?  How does that relate to Python Django and Ruby on Rails?

So, let's put the verdict here.  There was never really a "clear"
decision in the community to migrate.  Rather, it happened kind
of... "chaotically".  Some might say "organic," but yeah, trying to
use the right words that accurately describe this.  No actual central
coordination in this decision.  What happened was that web developers
starting making increasingly more complex dynamic server-side pages,
so they needed to move to systems that were designed to leverage more
dynamic server-side patterns: create a page by programmatically
altering a template, generate a page in its entirety, create HTTP
endpoints that are merely meant to perform server-side database
actions and return "data" files in JSON, things like that.  And then
that's how we got to the more modern frameworks.  These needed to
build higher-level constructs than CGI, FastCGI, and SCGI, so WSGI and
Rack were built, albeit specific to their particular programming
languages.

<!-- more -->

Then the story stops there, the FastCGI domain stops working.

These are some very helpful "word of mouth" references from those who
were more experienced with this transition of a sort.

20180718/DuckDuckGo future of cgi django rails  
20180718/https://www.quora.com/What-is-the-difference-between-Python-CGI-and-Django-Are-they-same  
20180718/https://stackoverflow.com/questions/219110/how-python-web-frameworks-wsgi-and-cgi-fit-together  
20180718/https://stackoverflow.com/questions/1747266/is-there-a-speed-difference-between-wsgi-and-fcgi/1748161#1748161  
20180718/https://stackoverflow.com/questions/257481/whats-the-difference-between-scgi-and-wsgi/257642#257642

So, history of dynamic server-side pages web development, according to
me.

1. First came static web servers.  HTML was the standard for this
   static content.

2. Then came along CGI.  Dynamic page generators were originally
   written as C programs.  All this custom C code written led to a
   whole host of buffer overrun security vulnerabilities, leading the
   buffer overrun to be named "attack of the decade" in the 1990s.

3. Then Perl started to become very popular for writing dynamic page
   generators, due to its great text and table processing facilities.
   Web pages were particularly popular and well suited for displaying
   tables, so why not use Perl to generate them?  From here, the Perl
   CGI and FastCGI modules were born and became wildly popular.

4. Meanwhile, Python started to become increasingly popular, often
   times compared directly to Perl.  So, why substitute Perl with
   Python?  This time, Python runs up Perl as a "superior" by
   including CGI as a standard library module.  No additional work
   necessary to write Python programs in CGI.

5. Now comes the complexity.  PHP was developed in parallel with other
   later web developments and becomes popular too.  The main
   motivation for using it over the older C/Perl/Python CGI methods
   was that it made _templating_ easier: that is, you have an almost
   complete HTML page description, but you want to augment it with
   some data values determined by dynamic generation, code execution.

   At the same time, SQL databases with ACID transaction support
   built-in, such as MySQL and PostgreSQL, were becoming popular for
   server-side web development.  Integrating with these databases
   involved writing manual code to piece together SQL queries, which
   led to a whole host of SQL injection vulnerabilities on web servers
   due to incomplete SQL grammar comprehension when dynamically
   generating the SQL query language text.

   PHP, by the way, also was later discovered to have a whole host of
   security vulnerabilities built-in, not to mention performance
   analysis revealed that the PHP engine itself was tremendously
   inefficient at executing code.

   Meanwhile, Java was becoming very popular after it was reinvented
   as a web programming language.  In fact, Java was so popular, that
   the pundits and Netscape changed from their original idea of Lisp
   as an in-browser scripting language to "JavaScript", a language
   "like Java" but not really.  Java was reinvented so that it could
   either be used for server-side code or browser-side code, in both
   cases through the use of the NSAPI plugin interface.  JavaScript
   surged in popularity across all webpages and browser developers,
   while Java became modestly popular for more complex client-side
   behavior and to some extent for dynamic server-side pages and
   custom servers.

   Finally, even Java itself was later revealed to have a whole host
   of security vulnerabilities too.

   Likewise, even plain CGI scripts were discovered to open yet
   another security vulnerability: if there are bugs in the CGI script
   that can be abused, a filesystem traversal attack can be exercised
   against the server host's filesystem.  This attack can be mitigated
   by relying more on the database and less on the filesystem for data
   within CGI scripts.

   Another plugin that started becoming popular around this time:
   Flash.  First it was by Macromedia, which had a long history of
   creating basically, what you would call a simple scriptable
   animation framework software for two-dimensional games.  Well, that
   was the main use, but the technology could, of course, be used for
   other more serious applications too... it's just that other uses
   were highly obscure.  So, the developers of this originally desktop
   software for developing interactive 2D media apps ported their
   system to a browser plugin and called it Flash.  Macromedia later
   got bought by Adobe and it thus became Adobe Flash.  Of course, the
   main impetus for using this tool over the others was simply latent
   experience from past game developers: the developer-facing toolset
   was familiar, and it felt productive for creating interactive
   media, more so than the other options like Java programming that
   felt lower level, without a well established high-level engine for
   media authorship.

   Alas, even Flash has later been revealed to be a minefield of
   security vulnerabilities.

   A few more developments are worth noting on the browser-side:

   * Dynamic HTML (DHTML), the ability for JavaScript code to
     dynamically alter a page's HTML structural content.  Microsoft
     and Netscape were two notable early pundits to add these
     features.

   * New HTML & CSS standards, the two together allowing much richer
     graphical styling of web pages.  The World Wide Web Consortium
     (W3C) spear-headed this standardization work around the time of
     the 1990s and early 2000s.

   * Increased standardization on Dynamic HTML, JavaScript, and
     so-called "Web APIs", objects and functions that JavaScript
     accesses to perform routines such as Dynamic HTML and HTTP
     requests.  Inititally, the expanded Web API features and
     functions were mutually incompatible across separate browsers
     from separate browser developers.  The World Wide Web Consortium
     (W3C) spear-headed this standardization work around the time of
     the 1990s and early 2000s.

6. After web devs gained some experience with PHP, they realized they
   didn't like the overall concept.  Why use this separate language,
   PHP, for executing code within templates while your more pure
   server-side code is written in Python or Perl?  Hence, _web
   frameworks_ were born: Ruby on Rails and Python Django being the
   prominent examples.  Note: Before Ruby on Rails became popular,
   Ruby itself simply wasn't a very popular programming language.
   Later, web frameworks emerged for Lua too, as Lua is a simple and
   efficient scripting language more appropriate for some use cases
   demanding low memory footprint such as on embedded systems.

   At the same time, framework developers wrapped up libraries to
   easily integrate with database engines such as MySQL and
   PostgreSQL.

   By eliminating hand-rolling SQL query language and PHP, a whole
   host of security vulnerabilities were eliminated from newer web
   applications.

   And Java?  Well, for a short period of time, that was popular on
   the client-side, and in some cases on the server-side, but we've
   now exceeded the peak of Java popularity.  Now Java is being phased
   out for new applications in favor of JavaScript on the browser and
   Ruby, Python, or Lua on the server.

   Flash?  Flash faded in popularity as JavaScript frameworks advanced
   and matured.  Although the developer experience still had a long
   ways to go, it was good enough and the base technology itself good
   enough for many past Flash developers to make the transition.  Most
   importantly, however, Flash was banned from the very popular
   iPhone, so developers needed to transition to something quickly.

   JavaScript first had to gain a whole host of advanced features and
   functions to dethrone Java and Flash.  SVG and HTML Canvas were the
   two biggest features needed to dethrone both Java and Flash for 99%
   of use cases.  Additional JavaScript Web API features like WebGL
   eliminated the need to use plugins for Google Earth.  Heck, it's
   funny that I say it that way... I mean, why else does your average
   user need 3D in a browser?  Games?  Ah, good one... before WebGL,
   3D games simply _weren't_ available in the browser, only as native
   applications.  Up until that point, virtually all browser games
   were 2D.

7. Around the same time that JavaScript gained many new features,
   Node.js became popular, basically a means to run JavaScript outside
   the browser, especially for server-side programming.  With this
   comes NPM and Webpack.  Also, compilers become mainstream in web
   dev, for things like CoffeeScript, TypeScript, SASS, and so on.
   Or, should I say more correctly, these advancements led to a
   renewed interest in compilers in web development, but most
   importantly introduced the otherwise "new" concept to the now
   much-expanded web development community.
