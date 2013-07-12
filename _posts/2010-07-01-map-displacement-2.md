---
layout: post
title: ! 'Map Displacement Filter #2'
description: Offer the Mona Lisa a little lifting with map displacement filters.
tags:
- canvas
- filter
- HTML5 lab
- image
- interactive
- manipulation
- map displacement
- pixel
status: publish
type: post
published: true
---
[![Mona Lisa - now with a different head.]({{ site.img_path }}/2010/07/mon-242x300.png)](http://yannick-lohse.fr/2010/07/map-displacement-2/)
And [here comes the other Map Displacement filter demo](http://code.yannick-lohse.fr/mapdisplacement/bitmap3.php "Map Displacing Mona Lisa"). To apply the filter, click anywhere on the picture, move the mouse around and release the click… tadaaa! Be gentle with Mona' thought.

The filter isn't real time applied because of performance issues. It takes about half a second to calculate the displacement, where it would have to take 10 times less to consider doing it in real time. But it could be done, I just didn't think it was worth the effort for this demo.

Another note on the performance issue : the amount of time it takes is mainly due to the canvas pixel array accessing stuff. And apparently, things get a lot better with Firefox 4, and I wouldn't wonder if Chrome wasn't putting some effort into this too… which means we'll see more and more of this kind of effects \o/