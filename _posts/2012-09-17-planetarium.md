---
layout: post
title: Planetarium
tags:
- asteroids
- attraction
- canvas
- debug
- gravity
- HTML5 lab
- math
- visualization
status: publish
type: post
published: true
---
**Update:** I turned the planetarium [into a gist](https://gist.github.com/4447634), and updated it to work with the latest version of [Cannon](https://github.com/y-lohse/Cannon).

A couple of month ago, I built an asteroid field simulator with my friend [Matthieu](http://urls.fr/pms). Inside an html5 canvas, we set up a couple of circles that behaved like bodies in outer space, getting attracted to each other, eventually colliding and thus forming new, bigger bodies. The whole attraction/orbit process is quite accurate, the absorbing isn't — in reality, past a certain speed, it's more likely that the 2 bodies would explode rather than melt.

[Here is the simulator](http://code.yannick-lohse.fr/planetarium/planetarium.html "Planetarium simulator"); you can click to add a new asteroid — the longer you keep the mouse button down, the bigger the new asteroid gets. When you release the button, your new planet will start interacting with the others. You can also give it a speed and direction by releasing the mouse in a different location from where you started the click.

<iframe src="http://code.yannick-lohse.fr/planetarium/planetarium.html" width="710" height="700"></iframe>

## Behind the scenes

I'm still working on new demos, but none of them are actually ready yet, so I keep posting older stuff that I hadn't released yet. As often, I had to tidy things up a bit before the release, since I usually leave my code in a mess when I suddenly stop working on a demo. You can see [a legacy version of the simulator here](http://code.yannick-lohse.fr/planetarium/legacy/) — it used an old version of my cannon framework and was a bit uglier. When I started finalizing it a week ago, I just planned on changing the colors and add interactivity.

But when I was done, I had another idea : why shouldn't I explain how things work behind the scenes — and the best way to explain it would be to show it, rather than explaining the maths. To me everything was clear (that's what I thought), but people may not *see* the attractions and orbits as I do for having coded it. So here is another version of the very same simulator, except it shows a lot more information.

<iframe src="http://code.yannick-lohse.fr/planetarium/debugplanetarium.html" width="710" height="720"></iframe>

The small black circles are just the same as on the original, the representation of asteroids. They have a red, semi transparent circle around them : this represents their field of attraction. Every other asteroid located within this field will be attracted to the source, the force of the attraction being based on the relative masses of the planets. The masses are in scale with the radiuses of the circles and you can see how quickly the attraction fields grows as the asteroid gains in mass.

[![A schema of an asteroid in debug mode](http://yannick-lohse.fr/wp-content/uploads/2012/09/explain.png "planetarium explanation")](http://yannick-lohse.fr/wp-content/uploads/2012/09/explain.png)
Each asteroid also has a green line pointing away from it ; this represents the current direction and speed of the asteroid. I use vectors in my code to calculate the movements, and the green lines are simply the visual representation of these vectors : the longer the line, the more momentum the asteroid has.

Finally, you'll notice light grey squares all over the place : this is the representation of the tile map I use. During every rendering loop, I have to look up every asteroid in the field of attraction of every asteroid, check whether they collide or not, and if not change their direction and speed.

I call this process is called the close range lookup, and the computing time for this scales exponentially with the number of asteroids. In order to simplify the lookups, each tile on the screen keeps track of the asteroids that are inside of it. This allows me to do a large range lookup first, quickly excluding asteroids that are out of range. then I only need to do the close range lookup for a smaller number of asteroids. The computing effort it takes to keep track of the asteroids inside the tilemap is very minimal, but the speed you get from it is quite noticeable.

## Inventing (or debugging) on principle

Things quickly became **very** interesting — for me. Turns out I didn't actually visualized what the asteroids were doing at all. I suddenly could **literally see** how tweaking a constant affected the attraction field of the planets. I began noticing bugs I hadn't even a clue of before, because everything was so hidden. I realized I could adjust a lot of things in my code to exactly match the desired behavior, without having to do guesswork as I usually do. Guesswork isn't necessarily bad, I think we all more or less do it — but with the ability to quickly visualize the impact, I could iterate much faster over  different values and solutions. Next time I'll make sure I'll start with building me this kind of tools.

This very problem of programmers not visualizing what they actually do is being studied and tackled by the brilliant mind of [Bret Victor](http://worrydream.com). I had watched this talk of him a couple of month ago, but while I couldn't refrain laughing of excitement when I saw it, it's the first time I actually *apply* the concept he speaks of to one of my own projects. It's awesome.

<iframe src="http://player.vimeo.com/video/36579366?byline=0" frameborder="0" width="500" height="281"></iframe>

[Bret Victor — Inventing on Principle](http://vimeo.com/36579366) from [CUSEC](http://vimeo.com/cusec) on [Vimeo](http://vimeo.com).

I'm really pleased to actually understand and feel what a difference this process makes, and not just imagining it — I won't push this asteroid demo much further, but I'm impatient to use this technique on other projects.

If you liked Bret's talk, you may also want to read his article "[Up and down the ladder of  abstraction](http://worrydream.com/LadderOfAbstraction/)". It's quite a long read, but incredibly interesting.
