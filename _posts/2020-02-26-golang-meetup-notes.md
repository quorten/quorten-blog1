---
layout: post
title: All my Golang Meetup notes not written
date: 2020-02-26 22:49 -0600
author: quorten
categories: [golang]
tags: [golang]
---

I've went to a number of Golang Meetups, but I haven't had a clear and
formal way to keep track of my notes as well as I should have.  Well,
now I do, I'll keep up with putting things in blog articles.

First of all, using kernel level system calls and routines from Go to
build your own containers implementation from scratch, like a simpler
Docker.

20200226/https://www.meetup.com/Minneapolis-Golang/events/259934939/  
20200226/https://github.com/jackspirou/toycontainer  
20200226/DuckDuckGo liz rice containers from scratch  
20200226/https://github.com/lizrice/containers-from-scratch/blob/master/main.go

Next, flowgraph, a flow-based programming system that works well with
concurrency in Go.

20200226/https://www.meetup.com/Minneapolis-Golang/events/259276080/  
20200226/https://github.com/vectaport/flowgraph

A presentation on how package management and Go modules work.

20200226/https://www.meetup.com/Minneapolis-Golang/events/261677345/  
20200226/https://github.com/jesselang/presentations  
20200226/https://github.com/jesselang/go-module-example

Play around with TinyGo: microcontrollers, web assembly, yes, new
targets for TinyGo.

<!-- more -->

20200226/https://www.meetup.com/Minneapolis-Golang/events/263837717/  
20200226/https://tinygo.org/  
20200226/https://gist.github.com/jesselang/acae8cebfafba51bef3810089541112d

Oak, a pure Go Game Engine.

20200226/https://www.meetup.com/Minneapolis-Golang/events/264766385/  
20200226/https://github.com/oakmound/oak

October 2019 Golang Meetup.  Ask questions about Golang garbage
collection, stack, pointer, and heap behavior, play around with
compiler explorer.

```
package main

import (
	"fmt"
)

type Point struct {
	a int
	b int
}

func main() {
	p := Point{10, 20}
	pp := &p

	fmt.Printf("%v", p)
	fmt.Println("")
	fmt.Printf("%p %v", pp, pp)
	fmt.Println("")

	pp.a = 20

	fmt.Printf("%v", p)
	fmt.Println("")
	fmt.Printf("%p %v", pp, pp)
	fmt.Println("")

	(*pp).a = 30



	fmt.Printf("%v", p)
	fmt.Println("")
	fmt.Printf("%p %v", pp, pp)
	fmt.Println("")
	fmt.Printf("%v", *pp)
	fmt.Println("")
}
```

20191016/https://golang.org/pkg/fmt/  
20191016/https://play.golang.org/  
20191016/DuckDuckGo compiler explorer  
20191016/https://dave.cheney.net/2017/04/29/there-is-no-pass-by-reference-in-go

Go Concurrency Explored.  You can do a switch on a channel?  Yes, that
was one of the many great things demoed.

20200226/https://www.meetup.com/Minneapolis-Golang/events/266416397/  
20200226/https://github.com/rvauradkar1/goutil/tree/master/concurrent

Fuzzing and Property-Based Testing in Go.  A really great talk here
about fuzzing and property-based testing in general, along with
specifics applicable to Go.

20200226/https://www.meetup.com/Minneapolis-Golang/events/267948853/  
20200226/https://github.com/mgritter/fuzzing-talk

> The article I mentioned from Coverity is this one:
>
> "A Few Billion Lines of Code Later: Using Static Analysis to find Bugs in the Real World". https://dl.acm.org/doi/10.1145/1646353.1646374
>
> ...
>
> Or some slides from one of the authors, Dawson Engler: https://www.usenix.org/legacy/events/sec08/tech/slides/engler_slides.pdf

> The quote I wanted to refer to this this one:

>> ---
Companies buy bug-finding tools because they see bugs as bad. However, not everyone agrees that bugs matter. The following event has occurred during numerous trials. The tool finds a clear, ugly error (memory corruption or use-after-free) in important code, and the interaction with the customer goes like thus:
"So?"  
"Isn't that bad? What happens if you hit it?"  
"Oh, it'll crash. We'll get a call." [Shrug.]  
If developers don't feel pain, they often don't care. Indifference can arise from lack of accountability; if QA cannot reproduce a bug, then there is no blame.  
---

> I have to say, writing tools for Go is a *lot* easier than tackling C or C++. A good argument for keeping the language simple, even if it's perhaps more simple than I would like.
