---
layout: post
title: On Panda Strike
published: true
---
## On Agile

There are topics I intuitively feel are full of bullshit, despite general agreement that they are great things. Would I take the time to really reflect on why I feel that way I could probably express it clearly, but I rarely do so. That’s why it’s a relieve to me when someone else picks up the pen to dismantle one of those topics with sensible arguments. When that happens, I feel like shouting “YES! That’s what I’ve been thinking! Exactly *that!*”.

It very recently happened with “Agile”. i always felt deeply uncomfortable using the term and so I never did. There are good things to it and I probably use part of the methodology, but I feel like most of it is and has always been bullshit. I’m not here to play fucking poker with the tasks at hand, have some respect for them. I’m glad [Giles Bowkett](https://twitter.com/gilesgoatboy) took a serious stab at the whole thing on the [Panda Strike blog](https://www.pandastrike.com/posts/20150304-agile).

If anything, it showed me again that it’s ok to follow my intuitions, even if I can’t explain them.

> What you understand well, you enunciate clearly.

or in french,

> Ce qui se conçoit bien s’énonce clairement.

Yes, [Nicolas](http://fr.wikipedia.org/wiki/Nicolas_Boileau), but you don’t understand is not necessarily wrong.

## On React & Angular

A few days later, Panda Strike published [another piece, on React this time](https://www.pandastrike.com/posts/20150311-react-bad-idea). [React](http://facebook.github.io/react/) has been on my (and many other peoples) watch list ever since [Flipboard built a whole rendering engine](http://engineering.flipboard.com/2015/02/mobile-web/) for canvas around it. This time however there are some aspects of the article I think are misinformed — no doubt due to my better understanding of the subject.

First, the main point is that Flipboard could have done what they did using standard technologies instead of using a bunch of libraries sponsored by not-so-well meaning companies. I’m not sure that’s the case. I’m not saying what they did is right, but some scrolling animations are pretty much undo-able (today).

What concerns me more is that they started drawing a comparison with [Angular](https://angularjs.org/), probably because that was the cool kid framework so far. And I’ve seen other (far worse) articles [comparing the two](https://www.airpair.com/angularjs/posts/angular-vs-react-the-tie-breaker). This makes no sense at all, it’s even written on the box:

> A JavaScript library for building user interfaces | React

> AngularJS — Superheroic JavaScript MVW Framework

React is probably better then Angular at building interface components; and Web Components are even better. But building the UI blocks is a small portion of what Angular does (they are called `directives`), and probably not the best either.

I’d just like to end by saying that while I’m a heavy Angular user these days, I’m not particularly fond of it. A couple of years ago I basically had to [pick between Angular, Backbone, Ember, Knockout, etc.](http://todomvc.com/) I ended up with Angular in good part for one reason — it was sold as "based on things that the browser will soon do natively", ie. directives for web components. But actually we’re still using polyfills and it doesn’t even look like the [much anticipated version 2](https://angular.io/) will change that, so I’m looking for opportunities to jump ship.

Anyway, I’ll keep my eye on [Panda Strike](https://www.pandastrike.com/posts/20150311-react-bad-idea) for more interesting articles.