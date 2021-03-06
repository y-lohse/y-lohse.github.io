---
layout: post
title: My first jquery plugin
description: A not-so-usefull jquery plugin I wrote.
tags:
- earth
- elements
- fire
- HTML5 lab
- javascript
- jquery
- plugin
- text-shadow
- water
status: publish
type: post
published: true
---
According to the last modification date of the file, [I created this jquery plugin](http://code.yannick-lohse.fr/elemental/ "My first jquery plugin !") back in march 2011. As far as I remember, I was exploring 2 things at the same time :

- what fancy things can you do with the (at that time fairly) new text-shadow css property ?
- how do you write your own jquery plugin ?

[![Waterfall effect on text]({{ site.img_path }}/2012/09/elemental.png "elemental")](http://yannick-lohse.fr/wp-content/uploads/2012/09/elemental.png)
So I very naturally combined both things into one, creating this elemental plugin. I don't see any real use cases except if you want to create a web page that looks like it was made in the 90's.

On the css part, it's quite simple. I just stack a couple of text shadows on top of each other; the change in size and color gives the impression of a gradient.

On the JS side, it's worth noting that it's really easy to create a jQuery plugin. You need to make sure your plugin stuff doesn't leak into the global space, but apart from that, it's just good old javascript. If you want to take a look at it, I used it as my hello world [repo on GitHub](https://github.com/y-lohse/smoke).
