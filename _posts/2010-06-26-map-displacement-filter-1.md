---
layout: post
title: ! 'Map Displacement Filter #1'
description: Map displacement filters with the HTML5 canvas, an introduction.
tags:
- bubble
- canvas
- filter
- HTML5 lab
- image
- map displacement
- water
status: publish
type: post
published: true
---
[![A map displaced image of chicago](http://yannick-lohse.fr/wp-content/uploads/2010/06/chicdis-300x222.jpg)](http://yannick-lohse.fr/2010/06/map-displacement-filter-1/)
If you don't give a fuck about how this works (and I totally understand), [the demo is right there](http://code.yannick-lohse.fr/mapdisplacement/bitmap.php "Map Displacement with a canvas"). Right now this is a mere proof of concept : the technique used works, but doesn't use the full potential. Another, better demo is almost finished, I'll publish it in a few days.

If you're interested in how this works… keep on reading :)

## The Map Displacement Filter

Filtering an image is just modifying it's pixels with a given algorithm. There's a lot of image filters, Photoshop makes features quite a few of them. Blurring is a type of filter, anti aliasing too, etc. Map displacement is just one of them, that is probably used sometimes in Photoshop too.

The way it works is pretty easy : you need 2 pictures, one that will be modified, and the other that defines how it will be modified (called the map). Now for each pixel of the original picture, take the pixel at the same location on the map, analyse its RGB value and use them to change the position of the original pixel… and voila.
You'll find a few more details on [wikipedia](http://fr.wikipedia.org/wiki/Displacement_mapping "Wikipedia page on displacement mapping"), or in one of [the articles](http://docs.gimp.org/en/plug-in-displace.html "Details on map displacement") I used.

## Using javascript

Now of course to do this, you need to have access to the pixels of any picture… which was impossible to do with javascript until once more the new canvas tag made it possible. You could say \o/, but…

## Performances

[![Image used to map displace another image.](http://yannick-lohse.fr/wp-content/uploads/2010/06/bubble.png)](http://yannick-lohse.fr/wp-content/uploads/2010/06/bubble.png)Yeah, performances… they are awe full. But to be fair, it's quite understandable.
Fetching the pixels of an image returns an array containing for each pixels the red, green, blue and alpha value of the given pixel, between 0 and 255. This means that for a 300*300 pixels picture, you'll end up having an array with 360 000 values in it. And then we're going to access them and change them, perhaps several times each. Doing a 300*300 loop isn't long, but accessing values held in such a big array becomes painfull after a few hundred iterations.

## Optimization
When the filter first started working, it took around 600ms to run; after a lot of hacking and tweeking everywhere, I managed to speed it up to 60ms, allowing the app to run at 10 fps, which is enough to make it look more or less fluid.

Tweeks I used are actually pretty common :

- length caching in loops : using for (var i = 0, l = foo.length; i < l; i++) instead of for (var i = 0; i < foo.length; i++)
- avoiding object propertys access when possible : in a loop, using foo.bar is actually quite long; defining var c = foo.bar outside of the loop and using c inside speed things up.
- and when dealing with CanvasPixelArrays, the best thing is still to keep iterations down to a minimum. If you know that the part of the map causing the displacement is only 100×100px big, the just loop on these pixels and ignore the others.

## And now what?
When I started working on this, I feared the perfomance issue would make this technique impossible to use on the fly; considering the final runing time however, I believe this could be used, along with a lot of other filters. I event think my personal canvas library will get a few of these added soon enough. Especially motion blur could be cool. And then maybe even tweening filters. Or maybe not.
