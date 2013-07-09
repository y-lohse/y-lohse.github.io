---
layout: post
title: SymphoTweet
description: A (now broken) experiment generating music from tweets.
tags:
- HTML5 lab
status: publish
type: post
published: true
---
[![Symphotweet screenshot](http://yannick-lohse.fr/wp-content/uploads/2010/06/symphotweet-300x133.jpg "symphotweet")](http://yannick-lohse.fr/2010/06/symphotweet/)
Ever wondered what your twitter account would sound like if it got converted to music? Well now you can find it out, with [SymphoTweet](http://code.yannick-lohse.fr/symphotweet/ "Twitter Symphony") \o/ !

## Update (13-7-7)

Due to severall changes to the Twitter API, symphotweet doesn't work anymore and I don't think it's worth porting it to the new API.

## Initial article

Of course I encourage you to share your very own symphotweet with whoever wants to hear it. The base link is [http://code.yannick-lohse.fr/symphotweet/](http://code.yannick-lohse.fr/symphotweet/), but you can link to a specific account user the user parameter : [http://code.yannick-lohse.fr/symphotweet?u=user_name](http://code.yannick-lohse.fr/symphotweet?u=user_name) (obviously replacing user_name with whatever you want).

## How this works

### Music

The technique used for the sounds is fairly well known; I'm using sounds that are within the same scale (from a musical point of view), which makes it impossible to play false notes. I tried to download sounds, then recorded my owns, and since none of the previous solutions gave acceptable results, I ended up using Andre Michels Tonematrix sounds.

As for the timing, each note is just one beat away from the other; I may change this in future versions but it's easier to make it sound crappy with different timings.

### Technology

The sound is rendered using the HTML5 audio tag. In a few month this app could be using webM format, but right now it relies on wav and mp3 format. The fancy graphics are rendered using a canvas, and again my custom library. I'll really try to post something about soon.

### Coding

So how do you convert a tweet to a sound? The process takes several steps :
Get the 10 or so latest tweets from an user.
Split each word of each tweet apart. Since the Twitter Search API doesn't return tweets that are older than about a week, results for an not too active users usually don't feature a lot of tweets, splitting them allows to have a decent amount of notes to play.
Now each word is taken individually and hashed using the md5 algorithm, which outputs a hexadecimal value. this means the word 'RT' will become 705610ed3e5ec724f5cb0d76a5fd3aa1.

Next I'm doing a recursive addition of this value, until it's only one digit long.

    705610ed3e5ec724f5cb0d76a5fd3aa1 = 7+0+5+6+...+a+1 = ... = 3

Since it's an hexadecimal value, this algorithm comes up with one of 16 values, between 0 and f. And Oh Look!, there are 16 possible sounds that can be played.

That's basically it. No random, which means a tweet will always sound the same. Which also means you could control what is played, but this would require a certain amount of patience.

### *My latest tweet doesn't show up in your app :( / your app  tells me there are no tweets from me :'(*

This may, or may not be my fault. I'm using the Twitter API to retrieve the tweets, and cache them for half an hour, which means you have to wait a bit before new tweets show up. But Twitter does some caching as well, so this might be a reason too. And if the app isn't finding any of your tweets, they are probably too old to be found by the API.

But hey, to solve this, you can just tweet something new like… wait…  about symphotweet?
