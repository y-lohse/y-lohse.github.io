In the previous entry, we left things at a single car, going around the track. The next step is to turn this into a race. The simplest race possible.

Right off the bat, we're going to ignore pit stops – while essential for the race strategist gameplay, they are too complicated for now. That means we can also ignore tire degradation.
We're also going to keep all cars equal. It'd be super easy to tweak that for a one off race, but we'll include this later along with other game mechanics.

So what we will add now are drivers. To begin, a good driver should simply do quicker laps than a bad driver. Drivers racing alone on track basically to 3 things: braking, cornering and accelerating.

To handle braking and accelerating, we can simulate a driver braking too early or accelerating too gently by reducing the car's statistics (but based on the driver, not the car itself!). The best driver will simply extract the most out of the car. Braking too late or accelerating too hard also reduces lap times, but not as much (unless you really fuck up) and mostly has impact on tire wear – which we're not dealing with yet.

For cornering, we can force worse drivers to use a sub-optimal slip ratio in the corner. This will also have the knock on effect that they will _also_ brake too early because they need to take the corner slower.

Now we have 2 drivers with different skill levels, resulting in one of them being 2s a lap faster than the other.

video
  
The next big thing we need are overtakes. Until now each car was driving like it's just them on track, but this needs to change.
  
Becaus eit's 1D, we will do it RPG style.

On overtake test will happen when:
  - the 2 cars are within 1 car length of each other
  - the velocity of the car behind higher than the one in front

The overtake test compares the offensive point of the car behind vs the defensive points of the car ahead. If the overtaking car wins, the positions are swapped. If not, they stay the same. In both cases, the offensive and defensive points are reset, and the velocity of the car behind is reduced.

The test is simply OP - DP - VelocityDifference. The result must be larger than 0 for a success.

Offensive and defensive points can be accumulated by cars when another car is within 5 car lengths. Each driver can decide to try more or less hard. The harder a driver tries, the faster they will accumulate points, but the more their pace will be penalized. The base level of points accumulation is determined by their overtaking/defensing ability.



