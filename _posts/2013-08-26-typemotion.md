---
layout: post
title: Released TypeMotion
description: I wrote a boorkmarklet that helps a little with setting vertical rythm.
tags: 
- typography
- javascript
- bookmarklet
- vertical rythm
published: true
---
I just finished [TypeMotion](http://yannick-lohse.fr/TypeMotion/). When working on websites with heavy content, I found myself without a practical tool to see if my measures fall into the (roughly) 55–90 optimal length. So I wrote a small bookmarklet that gives you information about the measures of any paragraph on any website and let's you see & adjust a couple of settings like `font-size` and `line-height`.

Feedback is very welcome.

### Lessons learned

1. There are many units in which you can set a `font-size` property: `em`, `rem`, `px`… I wanted to display the same unit the author used, but it's actually a nightmare. Webkit has a `getMatchedCSSRules` function that can do that, but it's non-standart and it's unsure whether it will be around for a long time. In other browsers you'd probably have to rewrite a whole css engine so I went with the `getComputedStyle` for those ones.

2. Bookmarklets that load scripts from non https domains don't work on https websites; I had never noticed it, but yeah, cross-origin security policies.

3. The design of the tool isn't so great, but styling elements with pure js is a pain. I could have loaded a css file too, but than I would have to add classes or ids to my elements that won't collide with author names, so I decided it wasn't worth it.