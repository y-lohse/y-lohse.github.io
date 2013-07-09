---
layout: post
title: Dynamic light simulation with canvas
tags:
- canvas
- html5
- HTML5 lab
- javascript
- light
- raycasting
status: publish
type: post
published: true
---
## Without further introduction…

Click anywhere to start — move with the arrow keys.

<iframe src="http://code.yannick-lohse.fr/raycasting/integrated.html" width="482" height="362"> </iframe>

## How it works

[![beams of light](http://yannick-lohse.fr/wp-content/uploads/2013/01/beqs.jpg)](http://yannick-lohse.fr/wp-content/uploads/2013/01/beqs.jpg)
Credits mostly go to [Emanuel Feronato](http://www.emanueleferonato.com/) who wrote [this very nice tutorial](http://www.emanueleferonato.com/2007/09/26/create-a-survival-horror-game-in-flash-tutorial-part-1/). Basically I just ported it to javascript. There is a [gist here](https://gist.github.com/4462395) with all the code.

No need for much explanation here. The light bulb in the center projects beams of light that stop as soon as they hit a wall. I mostly built this because a) I wanted to test masking inside the canvas and b) it's cool. Cannon makes things easy again, the lighted area is a [simple shape](https://github.com/y-lohse/Cannon/wiki/Cannon.Display.Shape), and the masking is handled by [adding a mask](https://github.com/y-lohse/Cannon/wiki/Cannon.DisplayObject#wiki-addMask) to the background object.

As always, a picture is worth a thousand words so here is the same thing, but you can tweak some parameters around and enable/disable masking.

<iframe src="http://code.yannick-lohse.fr/raycasting/raycasting.html" width="582" height="562"> </iframe>
