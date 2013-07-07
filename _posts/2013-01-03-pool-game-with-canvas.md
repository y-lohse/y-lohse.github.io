---
layout: post
title: Building a simple pool game with the HTML5 canvas
tags:
- billiard
- cannon
- canvas
- collision
- html5
- HTML5 lab
- physics
- pool
- SAT
- vectors
status: publish
type: post
published: true
---
I've finally done it — I documented my [Cannon framework](https://github.com/y-lohse/Cannon "Object oriented js framework"). For those unfamiliar with it, it's the js libraby I build and use in most of my demos. It makes drawing 2D stuff into a canvas a breeze — and handles a lot of other things.The documentation is inside the [GitHub wiki](https://github.com/y-lohse/Cannon/wiki). There are still a few things missing, but I'm working on it.

I wrote a little [quick start guide](https://github.com/y-lohse/Cannon/wiki/Getting-started), but a couple of days ago I also wrote a simple pool game simulation to test a collision detection mechanism. So in this post, I'll show you how you can use Cannon to do the same.

I won't include all the code at every step, only relevant excerpts. If you get lost at some point, I created [a gist here](https://gist.github.com/4439108) that contains the final code.


## Setting up the document


The start is essentially the same as in the getting started guide. We create a simple HTML document, import the library and create a canvas.

The HTML file: 


    <html>
    <head>
    <title>Pool</title>
    <script type="text/javascript" src="lib/cannon.js"></script>
    <script type="text/javascript" src="game.js"></script>
    </head>
    <body>
    	<div id="canvas" style="width: 500px; height: 300px; border: 1px solid black;"></div>
    </body>
    </html>

The game.js file:

    Cannon.include('lib/math.js');
    Cannon.include('lib/display.js');
    Cannon.include('lib/misc.js');
    Cannon.include('lib/SAT.js');

    var canvas;

    Cannon.onReady = function(){
    	Cannon.use('*');

    	canvas = new Cannon.Canvas('canvas');
    };

So far nothing fancy. In order to check that everything is fine, we'll add a simple rectangle that will serve as background.

    Cannon.onReady = function(){
    	Cannon.use('*');
    
    	canvas = new Cannon.Canvas('canvas');
    	
    	var background = new Rectangle(0, 0, canvas.width, canvas.height);
    	canvas.addChild(background);
    	background.fillStyle = "#00cc00";
    };

You should now have a green background to your canvas. Time to get serious.

## Creating a custom object

Ok, there are no classes in javascript — but Cannon objects are pretty much as close as it gets. We're going to capitalize on that and create our own objects.
The first thing we'll need is balls. Since we're going to keep things simple, balls will simply be represented by a circle. We could use the [Circle object](https://github.com/y-lohse/Cannon/wiki/Cannon.Display.Circle), but our balls will also need to move and collide with each other. We'll start by adding just the movement part.

Movements are easy to represent codewise: they are just vectors. If the cue balls vector is 1;-1, then at each frame we just add 1 to it's x position and substract 1 to it's y position. Here's out Ball object :

    Ball = Cannon.Display.Circle.extend({
    	__construct: function(x, y, radius){
    		this._super(false);
    		this.x = (x || 0);
    		this.y = (y || 0);
    		this.radius = (radius || 50);
    
    		this.direction = new Cannon.Math.Vector2D(0, 0);
    	},
    });

Note that for this to work, the Ball object must be defined after the Cannon.Display package is loaded (makes sense). So you'll have to either put it in a separate js file and [include it](https://github.com/y-lohse/Cannon/wiki/Cannon#wiki-include), or define it at the start of the Cannon.onReady() function.
Let's add our cue ball right away :


    var canvas, cue;

    Cannon.onReady = function(){
    	Cannon.use('*');
    	init();
    
    	canvas = new Cannon.Canvas('canvas');
	
    	var background = new Rectangle(0, 0, canvas.width, canvas.height);
    	canvas.addChild(background);
    	background.fillStyle = "#00cc00";
	
    	cue = new Ball(canvas.width/2, canvas.height/2, 10);
    	canvas.addChild(cue);
    	cue.fillStyle = '#ffffff';
    	cue.direction.x = 1;
    };

Since we're going to use the cue ball in other places, it goes into the global scope. Right now you should see the cue ball sitting in the middle of the satge, not moving. We *did* set the x direction to 1, but we're not telling the ball to move yet. We'll add this now. This is part of the routines that will have to be run on every frame — we're going to set this up with the [canvas:render](https://github.com/y-lohse/Cannon/wiki/Cannon.Canvas#wiki-canvasrender) event.

    Cannon.onReady = function(){
    	Cannon.use('*');
    	init();

    	canvas = new Cannon.Canvas('canvas');
	
    	var background = new Rectangle(0, 0, canvas.width, canvas.height);
    	canvas.addChild(background);
    	background.fillStyle = "#00cc00";
	
    	cue = new Ball(canvas.width/2, canvas.height/2, 10);
    	canvas.addChild(cue);
    	cue.fillStyle = '#ffffff';
    	cue.direction.x = 1;
	
    	canvas.on('canvas:render', onRender);
    };

    function onRender(){
	    cue.x += cue.direction.x;
	    cue.y += cue.direction.y;
    }

Now you should seethe cue ball moving away like in the example below (click anywhere to start).

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=3" width="510" height="310"></iframe>

## Adding interactivity

[![pool](http://yannick-lohse.fr/wp-content/uploads/2013/01/pool.jpg)](http://yannick-lohse.fr/wp-content/uploads/2013/01/pool.jpg)
Before we start handling collisions and shit, let's add the single piece of interactivity there will be. We want a shooting mechanism, and we want it easy. The pointer of the mouse shall represent the tip of the cue — when the user clicks the cue ball, he start a shot, he then moves his mouse away from the cue ball as he would move the cue away. When he releases the mouse, the shot fires, proportionally to the distance he moved.

That may sound a bit complex, but it really isn't. We just need to watch for a mousedown followed by a mouseup event, and calculate the difference between both.

    var canvas, cue;
    var shooting = false, 
	    shootStart;

    Cannon.onReady = function(){
	    /*
    	* Stuff we've seen before
    	*/
	
    	cue.on('mousedown', function(event){
    		shooting = true;//track the start of a shot
    		shootStart = new Point2D(canvas.mouseX, canvas.mouseY);//position of the initial click
    	});
    	canvas.on('canvas:mouseup', function(){
    		if (shooting){
    			var end = shootStart.substract(new Point2D(canvas.mouseX, canvas.mouseY));//computes the difference between the 2 mouse positions
    			cue.direction = new Vector2D(Math.max(Math.min(end.x/5, 10), -10), Math.max(Math.min(end.y/5, 10), -10));//sets the new ball direction
    		}
    	});
    };

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=4" width="510" height="310"></iframe>

When setting the new direction of the ball, we could have just done:

    cue.direction = new Vector2D(end.x, end.y);

But we solved 2 other problems right away, both related to the speed of the ball. Since we're running the animation at 60 frames per second, we're updating the balls position 60 times a second. This means that a velocity of say x:5;y:0 is already huge. At that speed, the ball would cross the whole play area in a single second. And when the player drags the mouse, he'll often move way more than 5 pixels, resulting in always-high-speeds.

So we made sure the velocity of the ball can never exceed 10 pixels par render, no matter what direction, and we also divided the mouse position difference by 5 — not very clean, but it makes things far easier for the player to control.

## Let's build a rail

Ok, time to mix in some boundaries. We'll add some rails on the sides of the stage, so the ball can bounce off against them.
Again, rails are just rectangles — and we have a [rectangle object standing by](https://github.com/y-lohse/Cannon/wiki/Cannon.Display.Rectangle). We'll apply the same process as with the ball to create a generic rail object.

    Rail = Cannon.Display.Rectangle.extend({
    	__construct: function(x, y, width, height){
    		this._super(false);
    		this.x = (x || 0);
    		this.y = (y || 0);
    		this.width = (width || 50);
    		this.height = (height || 50);
		
    		this.center = [this.width/2, this.height/2];
    	},
    });

And we'll add a rail right away

    Cannon.onReady = function(){
    	//do stuff
    	cue.fillStyle = '#ffffff';
	
    	var rail = new Rail(0, 0, 10, canvas.height);
    	canvas.addChild(rail);
    	rail.fillStyle = '#cc3333';
	
    	//do more stuff
    };

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=5" width="510" height="310"></iframe>

## Collision detection : Ball vs Rail


We are now going to start handling collisions between objects — that's quite a bit more complicated than adding and moving objects in the scene.

Cannon can detect collisions for you thanks to the built-in Separate Axis Test (SAT). If you want to know more about how SAT works, I mostly used [this nettuts tutorial](http://gamedev.tutsplus.com/tutorials/implementation/collision-detection-with-the-separating-axis-theorem/) and a bit of [this one](http://www.metanetsoftware.com/technique/tutorialA.html).

The collision response is not built in, so we'll need to write it — but it's just math. A bit of trigonometry and lots of vectors.

### Bounding boxes and circles

If we want to use the Cannon SAT package, everything that needs to be checked for collisions needs to be either a BoundingBox or a BoundingCircle. We can just add this to our Ball and Rail objects. Since balls are moving around, we'll also create a shortcut to keep the BoundingCircle at the same spot than the actual circle.

    Ball = Cannon.Display.Circle.extend({
    	__construct: function(x, y, radius){
    		this._super(false);
    		this.x = (x || 0);
    		this.y = (y || 0);
    		this.radius = (radius || 50);

    		this.direction = new Cannon.Math.Vector2D(0, 0);
    		this.boundingCircle = new Cannon.SAT.BoundingCircle(this.x, this.y, this.radius);		
    	},
    	updateBounding: function(){
    		this.boundingCircle.x = this.x;
    		this.boundingCircle.y = this.y;
    		this.boundingCircle.radius = this.radius;
    	},
    });

    Rail = Cannon.Display.Rectangle.extend({
    	__construct: function(x, y, width, height){
    		this._super(false);
    		this.x = (x || 0);
    		this.y = (y || 0);
    		this.width = (width || 50);
    		this.height = (height || 50);
		
    		this.center = [this.width/2, this.height/2];
    		this.boundingBox = new Cannon.SAT.BoundingBox(this.x, this.y, this.width, this.height, this.rotation);	
    	},
    });

### Checking for collision

*That* is the easy part — Cannon does it for you.

    function onRender(){
    	cue.updateBounding();
	
    	var col = CollisionSolver.solveCollsion(cue.boundingCircle, rail.boundingBox);
    	if (col.colliding){
    		cue.direction = new Vector2D(0, 0);
    	}
	
    	cue.direction.multiply(.97);
    	cue.x += cue.direction.x;
    	cue.y += cue.direction.y;
    }

We added a call to the newly defined updateBounding() function, and checked for a rail-ball collision. When one is detected, we stop the ball.
You may also wonder why we suddenly multiply the direction vector by 0.97. This is to make the ball gradually slow down and corresponds to the friction of the ball with the table, making it loose momentum. The 0.97 value is arbitrary.

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=6" width="510" height="310"></iframe>

### Collision response

The tricky part comes here, but again, it's just math. When the ball collides with a wall, we want it to bounce off in a realistic manner. The basic idea is to combine 2 vectors, one parallel to the collision axis, one perpendicular to it. Again,the principle is [explained here](http://www.metanetsoftware.com/technique/tutorialA.html). In our case, we won't apply any friction and the bounce factor = 1.

	if (col.colliding){
		var parallel = cue.direction.clone();
		var perpendicular = cue.direction.clone();
		var parAxis = col.collisions[0].clone().normalize();
		var perAxis = col.collisions[0].clone().normalize();

		var parallelDP = parallel.dotProduct(parAxis);
		parallelDP *= -1;

		var perpendicularDP = perpendicular.dotProduct(perAxis.rightNormal());

		perAxis = perAxis.rightNormal();
		
		parAxis.multiply(parallelDP);
		perAxis.multiply(perpendicularDP);
		
		var escapeVector = parAxis.clone().add(perAxis);

		cue.direction = escapeVector;
		cue.x += col.collisions[0].x;
		cue.y += col.collisions[0].y;
	}

Hey look, it already works !

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=7" width="510" height="310"></iframe>

## Scaling up

Before we add more balls and add collision detection and response to them, we'll wrap this part up by adding the missing rails. To do this, we'll add them to an array and loop through it at each render.

	var canvas, cue;
	var shooting = false, shootStart;
	var rails = [];
	var WALL_SIZE = 10;

	Cannon.onReady = function(){
		//blabla

		var rail = new Rail(0, 0, WALL_SIZE, canvas.height);
		canvas.addChild(rail);
		rail.fillStyle = '#cc3333';
		rails.push(rail);

		var rail = new Rail(canvas.width-WALL_SIZE, 0, WALL_SIZE, canvas.height);
		canvas.addChild(rail);
		rail.fillStyle = '#cc3333';
		rails.push(rail);

		var rail = new Rail(0, 0, canvas.width, WALL_SIZE);
		canvas.addChild(rail);
		rail.fillStyle = '#cc3333';
		rails.push(rail);

		var rail = new Rail(0, canvas.height-WALL_SIZE, canvas.width, WALL_SIZE);
		canvas.addChild(rail);
		rail.fillStyle = '#cc3333';
		rails.push(rail);
	
		//blabla
	};

And the collision detection loop : 


	function onRender(){
		cue.updateBounding();
	
		for (var i = 0; i < rails.length; i++){
			var rail = rails[i];

			var col = CollisionSolver.solveCollsion(cue.boundingCircle, rail.boundingBox);

			if (col.colliding){
				var parallel = cue.direction.clone();
				var perpendicular = cue.direction.clone();
				var parAxis = col.collisions[0].clone().normalize();
				var perAxis = col.collisions[0].clone().normalize();

				var parallelDP = parallel.dotProduct(parAxis);
				parallelDP *= -1;

				var perpendicularDP = perpendicular.dotProduct(perAxis.rightNormal());

				perAxis = perAxis.rightNormal();
			
				parAxis.multiply(parallelDP);
				perAxis.multiply(perpendicularDP);
			
				var escapeVector = parAxis.clone().add(perAxis);

				cue.direction = escapeVector;//the new ball direction
				cue.x += col.collisions[0].x;//moving ball out of collision before proceeding to anything else
				cue.y += col.collisions[0].y;//same thing
			}
		}
	
		cue.direction.multiply(.97);
		cue.x += cue.direction.x;
		cue.y += cue.direction.y;
	}

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=8" width="510" height="310"></iframe>

## Ball vs Ball collision

The process is the same as with the rails.
We start by adding a new ball to the scene :

	ball = new Ball(250, 50, 10);
	canvas.addChild(ball);
	ball.fillStyle = '#cc0000';


Next, we check for a collision :

	var col = CollisionSolver.solveCollsion(cue.boundingCircle, ball.boundingCircle);
	if (col.colliding){
		cue.direction.multiply(0);
	}

This time, we are going to scale things up before responding to collision. We're going to create an array containing all balls, and loop through it to update positions, bounding circles, etc.


	var rails = [], balls = [];
	var WALL_SIZE = 10, BALL_SIZE = 10;

	Cannon.onReady = function(){
		//blabla

		cue = new Ball(canvas.width/2, canvas.height/2, 10);
		canvas.addChild(cue);
		cue.fillStyle = '#ffffff';
		balls.push(cue);
		
		//blabla
	
		ball = new Ball(250, 50, 10);
		canvas.addChild(ball);
		ball.fillStyle = '#cc0000';
		balls.push(ball);
	
		//blabla
	};

And the collision part :

	for (var i = 0; i < balls.length; i++){
		var ball1 = balls[i];

		for (var j = i+1; j < balls.length; j++){
			var ball2 = balls[j];

			var col = CollisionSolver.solveCollsion(ball1.boundingCircle, ball2.boundingCircle);
			if (col.colliding){
				ball1.direction = new Vector2D(0, 0);
			}
		}

		ball1.direction.multiply(.97);
		
		ball1.x += ball1.direction.x;
		ball1.y += ball1.direction.y;
	}

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=9" width="510" height="310"></iframe>

Note that at this point, the cue vs rail collisions behaves oddly — that's because we moved the call to updateBounding(). We'll fix that soon.

### Collision response

Again, math. For the ball vs ball response, we'll use [elastic collisions](http://en.wikipedia.org/wiki/Elastic_collision).


	if (col.colliding){
		var nx = (ball2.x - ball1.x)/(2*ball1.radius);
		var ny = (ball2.y - ball1.y)/(2*ball1.radius);
		var gx = -ny;
		var gy = nx;

		var v1n = nx*ball1.direction.x + ny*ball1.direction.y;
		var v1g = gx*ball1.direction.x + gy*ball1.direction.y;
		var v2n = nx*ball2.direction.x + ny*ball2.direction.y;
		var v2g = gx*ball2.direction.x + gy*ball2.direction.y;

		ball1.direction = new Vector2D(nx*v2n +  gx*v1g, ny*v2n +  gy*v1g);
		ball2.direction = new Vector2D(nx*v1n +  gx*v2g, ny*v1n +  gy*v2g);
		
		//out of collision
		ball1.x += col.collisions[0].x;
		ball1.y += col.collisions[0].y;
	}

Well, that's all there is to it.

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=10" width="510" height="310"></iframe>

## More scalling

Now that all this works fine, we need to fix the bug we introduced by moving the updateBounding() call, and make every ball bounce off walls. We can do 2 in 1 by looping through the balls array inside the rail array:

	for (var i = 0; i < rails.length; i++){
		var rail = rails[i];

		for (var j = 0; j < balls.length; j++){
			var ball = balls[j];
			ball.updateBounding();
			
			var col = CollisionSolver.solveCollsion(ball.boundingCircle, rail.boundingBox);
	
			if (col.colliding){
				var parallel = ball.direction.clone();
				var perpendicular = ball.direction.clone();
				var parAxis = col.collisions[0].clone().normalize();
				var perAxis = col.collisions[0].clone().normalize();
	
				var parallelDP = parallel.dotProduct(parAxis);
				parallelDP *= -1;
	
				var perpendicularDP = perpendicular.dotProduct(perAxis.rightNormal());
	
				perAxis = perAxis.rightNormal();
				
				parAxis.multiply(parallelDP);
				perAxis.multiply(perpendicularDP);
				
				var escapeVector = parAxis.clone().add(perAxis);
	
				ball.direction = escapeVector;
				ball.x += col.collisions[0].x;
				ball.y += col.collisions[0].y;
			}
		}
	}

Again, no need for more. At this point, we're almost done.

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=11" width="510" height="310"></iframe>

## Adding pockets

To complete our little pool game, we're going to add pockets in which we can sink the balls. We could create a Pocket object, but a pocket is again just a circle, with a BoundingCircle for collisions. It doesn't need a direction vector, be can just use our Ball object and leave the direction vector alone.

Since you're probably starting to get how it works, I'll add the 6 pockets right away :

	var POCKET_SIZE = BALL_SIZE*1.7
	var pockets= [];

	var pocket = new Ball(10, 10, POCKET_SIZE);
	canvas.addChild(pocket);
	pocket.fillStyle = '#000000';
	pockets.push(pocket);
	var pocket = new Ball(canvas.width/2, 5, POCKET_SIZE);
	canvas.addChild(pocket);
	pocket.fillStyle = '#000000';
	pockets.push(pocket);
	var pocket = new Ball(canvas.width-10, 10, POCKET_SIZE);
	canvas.addChild(pocket);
	pocket.fillStyle = '#000000';
	pockets.push(pocket);
	var pocket = new Ball(10, canvas.height-10, POCKET_SIZE);
	canvas.addChild(pocket);
	pocket.fillStyle = '#000000';
	pockets.push(pocket);
	var pocket = new Ball(canvas.width/2, canvas.height-5, POCKET_SIZE);
	canvas.addChild(pocket);
	pocket.fillStyle = '#000000';
	pockets.push(pocket);
	var pocket = new Ball(canvas.width-10, canvas.height-10, POCKET_SIZE);
	canvas.addChild(pocket);
	pocket.fillStyle = '#000000';
	pockets.push(pocket);

Now we add the ball vs pocket collision, just after our ball vs ball loop.

	for (var i = 0; i < balls.length; i++){
		var ball1 = balls[i];
		ball1.updateBounding();

		for (var j = i+1; j < balls.length; j++){
			var ball2 = balls[j];

			var col = CollisionSolver.solveCollsion(ball1.boundingCircle, ball2.boundingCircle);
			if (col.colliding){
				var nx = (ball2.x - ball1.x)/(2*ball1.radius);
				var ny = (ball2.y - ball1.y)/(2*ball1.radius);
				var gx = -ny;
				var gy = nx;

				var v1n = nx*ball1.direction.x + ny*ball1.direction.y;
				var v1g = gx*ball1.direction.x + gy*ball1.direction.y;
				var v2n = nx*ball2.direction.x + ny*ball2.direction.y;
				var v2g = gx*ball2.direction.x + gy*ball2.direction.y;

				ball1.direction = new Vector2D(nx*v2n +  gx*v1g, ny*v2n +  gy*v1g);
				ball2.direction = new Vector2D(nx*v1n +  gx*v2g, ny*v1n +  gy*v2g);
		
				//out of collision
				ball1.x += col.collisions[0].x;
				ball1.y += col.collisions[0].y;
			}
		}
		
		for (var j = 0; j < pockets.length; j++){
			var col = CollisionSolver.solveCollsion(ball1.boundingCircle, pockets[j].boundingCircle);
			if (col.colliding && col.collisions[0].length() > 3){//we don't only check for collision, the overlap should be big enough for the ball to fall inside the pocket
				//collision response
			}
		}

		ball1.direction.multiply(.97);
		
		ball1.x += ball1.direction.x;
		ball1.y += ball1.direction.y;
	}

### Collision resp… oh, wait

What we want to do here is remove the ball that was just sinked — except if it's the cue ball, then we'll reset it. The only thing to consider is we're looping through the balls array — if we remove one in the middle of the loop, things will start to break apart. Instead, we'll keep track of the sinked balls and remove them once we're done with the loop. 

	var removeMe = [];
	for (var i = 0; i < balls.length; i++){
		var ball1 = balls[i];
		ball1.updateBounding();

		for (var j = i+1; j < balls.length; j++){
			var ball2 = balls[j];

			var col = CollisionSolver.solveCollsion(ball1.boundingCircle, ball2.boundingCircle);
			if (col.colliding){
				var nx = (ball2.x - ball1.x)/(2*ball1.radius);
				var ny = (ball2.y - ball1.y)/(2*ball1.radius);
				var gx = -ny;
				var gy = nx;

				var v1n = nx*ball1.direction.x + ny*ball1.direction.y;
				var v1g = gx*ball1.direction.x + gy*ball1.direction.y;
				var v2n = nx*ball2.direction.x + ny*ball2.direction.y;
				var v2g = gx*ball2.direction.x + gy*ball2.direction.y;

				ball1.direction = new Vector2D(nx*v2n +  gx*v1g, ny*v2n +  gy*v1g);
				ball2.direction = new Vector2D(nx*v1n +  gx*v2g, ny*v1n +  gy*v2g);
		
				//out of collision
				ball1.x += col.collisions[0].x;
				ball1.y += col.collisions[0].y;
			}
		}
		
		for (var j = 0; j < pockets.length; j++){
			var col = CollisionSolver.solveCollsion(ball1.boundingCircle, pockets[j].boundingCircle);
			if (col.colliding && col.collisions[0].length() > 3){
				removeMe.push(ball1);
			}
		}

		ball1.direction.multiply(.97);
		
		ball1.x += ball1.direction.x;
		ball1.y += ball1.direction.y;
	}
	
	for (var i = 0; i < removeMe.length; i++){
		if (removeMe[i] === cue){
			cue.direction = new Vector2D(0, 0);
			cue.x = canvas.width/2;
			cue.y = canvas.height/2;
		}
		else{
			canvas.removeChild(removeMe[i]);
			balls = Cannon.Utils.arrayWithout(balls, removeMe[i]);
		}
	}

# We're done!

<iframe src="http://code.yannick-lohse.fr/pool/pool.php?v=12" width="510" height="310"></iframe>

That's it, our pool works. [In the final gist](https://gist.github.com/4439108), I added 9 more balls and placed them randomly. There are more things that could be done, like adding effects (way more math and physics) or a scoring system (way more code), but we kept it simple here. You can play [a standalone version here](http://code.yannick-lohse.fr/pool/pool.php?v=12).
