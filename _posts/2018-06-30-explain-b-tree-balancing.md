---
layout: post
title: Explaining how a B-tree stays balanced
author: quorten
date: 2018-06-30 10:28 -0500
categories: [unlipic]
tags: [unlipic]
---

So, I was wondering, how exactly does a B-tree stay balanced?  So,
I'll provide my simple explanation here.  Think of a heap.  Only the
last two levels are imbalanced.  Now a B-tree has nodes that can store
a variable number of elements.  In effect, the last two levels can be
contained in a single B-tree node, therefore keeping the tree
completely level at all times.

Also, you're wondering how elements can be added while keeping the
tree balanced and within its min and max fragmentation bounds?  The
root node is allowed to be less than half full.

How about element deletes?  Here is the trick.  When you delete items,
you may have a node that is less than half full, so you try to merge
your contents with the adjacent node.  In the worst case, you need to
merge with the adjacent two nodes, and this will always work for the
following reason: each of the two adjacent nodes are between half full
and totally full.

* Worst case 1: 1 < 1/2 + 1/2 + 1/2 < 2
* Worst case 2: 1 + 1/2 < 1 + 1 + 1/2 < 3

So, it will always be possible to join nodes together correctly
considering two adjacent neighbors and stay within fragmentation
bounds.  In cases of high fullness, the solution to satisfy the
invariant will be to move elements from full nodes to the node that is
not full enough.

Also, worthy of note is that a typical B-tree stores keys and data
items not just in the leaf nodes, but in the higher level nodes too.
Yeah, when you think about this, this is practical so that you do not
need to copy updated keys all the way up the tree.

20180630/https://en.wikipedia.org/wiki/B-tree  
20180630/https://en.wikipedia.org/wiki/Self-balancing_binary_search_tree  
20180630/https://en.wikipedia.org/wiki/Order_statistic_tree

So, as it stands, it should be fairly easy for me to implement a
B-tree on top of my tree datastructure implementation, originally
written to implement filesystems.  Matter of fact, I could even write
a special abstract list implementation that dynamically switches from
a simple expandable array to a B-tree.  Likewise with memory buffers
when they grow to be huge.
