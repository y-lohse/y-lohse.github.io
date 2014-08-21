---
layout: post
title: Secret de dev
description: 
published: false
---
There are a couple of tricks I use in my code from time to time that come in quite handy. I don't think I've invented any single one of them, I just picked them up here and there. They are very concise ways to do simple things which seems lke a good thing, but be warned: due to lack of verbosity, someone unfamiliar with these expressions will have a harder time reading them. Use cautiously.

Also, they only apply to loosely typed languages such as javascript or php. Frown upon them as much as you want.

# Bounding a value
You have a numerical value and you need to force it into a certain range. You could write conditionnals to check that and then do a cast, but why bother?

var myValue = Math.random(),
	upperbound = .4,
	lowerBound = .2;
myValue = Math.min(Math.max(myValue, lowerBound), upperbound);

The call to Math.max forces the value to be greater than the minimum, and Math.min forces it to me smaller than the max. I know it sounds confusing. But it works.

# Boolean casting
I think this one is well known. Sometimes you need a boolean value but all you have is a bunch of things to compare. The usual way this goes down is:

if (stuff > 5) return true;
else return false;

Well, it's nonesense. you can just write

return (stuff > 5);

Derived from this, you may need a pure boolean but all you have is something that is truthy/falsy like a string or an integer. You can do some easy casting with a double bang:

return !!'lol';//returns a real true

# Optional argument
The most famous one, widely used in javascript. Sincy ou can't explicitely declare an optional argument, its just a regular argument that can be omited. And if omited, it becomes undefined which is likely to cuase some trouble. You can force it to a default value with an OR operator

function(optionnal){
	optionnal = optionnal || 'default value';
}

Be carefull though, if the argumlent is specified with a falsy value (like 0 or false), you'll run into problems. I mostly use this on arguments that are expected to be objects or arrays. Speaking of arrays…

# Single or array argument
There are times where an argument could be a *thing* or an array of *things*. You could require the argumebt to be an array but that leads to ugly function calls such as

callStuff([5]);

We can use a simialr trick than for the optionnal argument:

function callStuff(things){
	things = (things instanceof Array) ? things : [things];
}

# Comparing multiple strings
There's a string, and you cant to check if it equals one of multiple strings. You can go all verbose and be like

if (str === 'apple' || str === 'banana' || str === 'pear' || str === 'strawberry') || …)

And thats unreadbale. Go fro the array:

if ['apple', 'banana', 'pear', 'strawberry'].indexOf(str) >= 0)

This just creates an array that is dumped immediately afterwards.

# Lost instanciation
This immediate dumping can also be used when you need an instance of an object just to cal lsome specific method on it. the most common example is creating a timestamp. here's the traditionnal version:

var date = new Date();
var ts = date.getTime();

Just go two on one:

var ts = (new Date())).getTime();

Notice the extra set of parenthesis to avoid the synthax error.