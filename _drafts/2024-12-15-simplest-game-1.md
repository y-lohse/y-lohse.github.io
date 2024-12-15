# The simplest motorsport strategy game

Something I've learned over the course of many aborted games projects is that it's critical to have _something_ playable as soon as possible. What, then, is the smallest possible motorsport strategy game I could build?

The race simulation will be at the core of the game. Even though most inovations will be outside the track, a solid on-track simulation is fundamental. So the smallest game should simulate a race. We can stick to the most basic race – no pit stops, no flags. There may not even be much to play with, but we should have cars that race around a track.

We're going to start by simulating just one, generic cars driving laps. We're even going to reduce the car simulation to it's absolut minimum – we just need to know how fast it's going at any given time.

Let's start with figuring the ideal lap. We'll work with the real-life Spielberg track, because it's easy to model.

![Capture d’écran 2024-12-08 à 16.19.55.png]({{site.baseurl}}/_drafts/Capture d’écran 2024-12-08 à 16.19.55.png)

We're first going to assume our car can instantly change it's velocity. What we need to figure out now is the ideal velocity at any point in the track. In straights, that's easy – it would be the maximum speed of the car. But what about the corners?  We're looking for a formula, such as ??? + ??? = Max speed.

A corner is characterised by mainly 2 things: it's angle and it's length.

- The larger the angle is, the slower the car needs to go. A 90° corner can be taken much faster than a 180°.
- The longer the corner is, the faster the car can go. A very wide hairpin is much faster than a super tight hairpin

That gives us a part of the formula: Corner + ??? = Max speed. Next we can refine the notion of "max speed" – what is the ideal speed to take a corner at? That turns out to be the velocity at which the slip angle is _ideal_. In a corner, tires deform and provide more or less grip as the car goes through a corner – this is what makes the car turn. For a given tire, there is a slip angle at which it will provide optimal grip. With a lower slip angle, there was reserve grip and we could have gone faster. With a higher slip angle, the tires would begin sliding across the ground. Too much of that and the car spins out, but even small amounts will result in a lower than ideal grip.

Using the slip angle, we can calculate the force exerted by the tire onto the ground, and combining this value with the mass of the car and teh characteristics of the corner, we finally end up with the idea velocity for the given corner.

video_1

## Looking ahead

We can make this simulation a touch more realistic with a few simple tweaks.

First, we implement an acceleration and deceletation rate. To do this we use the previous velocity as our target velocity, and at every step of the simulation the car gradually goes closer to the ideal value.

Once we have done that, we must give the car the ability to start breaking ahead of the corner – otherwise it just starts braking as it hits the corner. While we're at it, we can also let the car accelerate out of the corner once it's past the apex. Like everything else so far, we're oversimplifying things a good deal and will need to revisit this later.

With all this in place, we have the very basis of our sim: a car driving somewhat realistically around a track!

video 2
