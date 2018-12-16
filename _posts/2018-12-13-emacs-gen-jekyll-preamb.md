---
layout: post
title: Emacs macro to generate Jekyll preamble
date: 2018-12-13 12:27 -0600
author: quorten
categories: [blogging]
tags: [blogging]
---

Now that I'm getting my blog writing underway, I realized that I've
got to have a pain-free way to set up the preamble for my blog posts.
So, here I have it.  A simple Emacs interactive function to fill in
the parts of the preamble that can be automatically generated to get
you up and running on your blog writing fast!

```
(defun blog-new-post (tags)
  "Generate the preamble for a new blog post."
  (interactive "MTags: ")
  (setq cur-date (decode-time))
  (setq pick-date (cdr (cdr (cdr (reverse (cdr (decode-time)))))))
  (setq tz-sec (nth 8 cur-date))
  (setq tz-min (% (/ tz-sec 60) 60))
  (setq tz-hr (/ tz-sec 3600))
  (setq tz-num (+ (* tz-hr 100) tz-min))
  (princ tz-num)
  (setq fmt-date (append pick-date (list tz-num)))
  (insert "---\n"
          "codename: \n"
          "layout: post\n"
          "title: \n"
          "date: "
          (apply 'format "%d-%02d-%02d %02d:%02d %+05d\n" fmt-date)
          "author: quorten\n"
          "categories: [" tags "]\n"
          "tags: [" tags "]\n"
          "---\n"
          "\n"))
```

My experience using this code in practice for blog article authoring?
Wow, it sure makes the process super-slick!
