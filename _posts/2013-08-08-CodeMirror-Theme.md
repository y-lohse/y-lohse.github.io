---
layout: post
title: A Theme for CodeMirror
description: I wrote a theme for CodeMirror/Brackets with some css trickery in it.
tags:
published: false
---
With my recent job change I switched from writting lots of PHP to writting lots of html, css and js. ZendStudio needed to make room for a better suited code editor, so I first gave Light Tables a shot and while I'm sure it's the next generation of IDE and it will be awesome, it is too much of a beta right now for me.

I ended up adopting Adobe Brackets, which is beta too but stable enough for me. It comes with lots of awesome features, but at the end of the day I missed the Ligh Table theme which I foudn not only beautifull but also increadibily legible. Brackets runs on CodeMirror, so I wrote a new theme for CodeMirror which basicaly mimics Code Mirror. Here's how it looks like:

## Special features

It's not only makes code good looking and very readable, it also comes with some special features that I believe no other CodeMirror has — because I had to hack them together.


### Current line highlighting

The line on which the carret is currently positionned stands out from the rest with its light background.


### Decent scroll bars

Scrollbars on the web generally don't look so good, and you can"t do much about it. I don't like the js solutions, but only webkit supports custom css for scrollbars and not for the main frame... and that's cool in my case, because brackets runs on Chromium and the code frame is not the main one.