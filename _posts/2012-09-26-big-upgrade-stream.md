---
layout: post
title: Big upgrade for Look At Stream
description: Read about the thining behind some recent changes to our Look At Stream service.
tags:
- design
- Look AT stream
- menu
- sticky
- stream
- Websites
status: publish
type: post
published: true
---
I'm very exited to announce a new major upgrade to [Look At Stream](http://lookatstream.com/ "Streams, replays and more fun.") that will ship next week. Until now, we had 2 folks touring forums that specialize in video games where they promote our website. This works well, but is too time-consuming, so we want to find ways to engage our users.

The first solution we are going to try out is user accounts. This will allow us to provide a slightly personalized experience to our users, and the ability to send them automated information and reminders through emails. We tried to keep things as simple as possible — the sign up form is short, but we might provide openID or Facebook Connect authentication in the near future. We are really curious to see how users will react to this and if they will sign up. We have a couple of other feature ideas for registered users, and we will roll them out in the near future.

<figure>
	![Screenshot of the Look At Stream menus](http://yannick-lohse.fr/wp-content/uploads/2012/09/LASmenus.png "LoolAtSream menus")
	<figcaption>
		Above, the original menu, below, the new version
	</figcaption>
</figure>

Aside from the features, the main change is actually the design. We are iterating very quickly over the different versions of the site so we often have to readjust things on the go, and our main menu paid the price of it.

We started with no menu at all, just the links for the different games as a static sidebar. We introduced [tournament replays](http://lookatstream.com/replay/league-of-legends "League of Legends tournament replays") and the [games schedule](http://lookatstream.com/planning/league-of-legends "Upcomming League of legends tournaments") a couple of weeks ago, and with them came the first real navigation. The search form had to move up, and the link to our [twitter](https://twitter.com/LookAtStream "Follow Look At Stream on twitter") took up some of the remaining space.

Now I had to provide information about the currently logged in account, or a link to log in — and the usual place for this is, of course, inside the header.

My first thought was to remove the social links and put the user information close to the logo — not very natural, but visible. I did think of a fixed navigation bar, but wasn't really sure if it was a good idea — until I came cross [this article in Smashing Magazine](http://uxdesign.smashingmagazine.com/2012/09/11/sticky-menus-are-quicker-to-navigate/ "Sticky menus are quicker ?").

> The data from the study indicated that participants were able to find what they were looking for quicker when they didn’t have to scroll back to the top of the page. 22% might not seem like a big number, but it can have a big impact on visitors. According to this data, sticky navigation could cut 36 seconds off of a five-minute visit to a website.

I'm not sure if the testing process is really good (always showing the fixed nav menu second may flaw the results ?), but I guess the conclusion is a valid one. And navigation speed has always been one of the things we focused on, but which I think we had lost with the new menu. Since we are using [twitter bootstrap](http://twitter.github.com/bootstrap/ "THE Twitter Bootstrap") on Look At Stream, I quickly loaded the [navbar](http://twitter.github.com/bootstrap/components.html#navs "Navbar component - sticky navbar set up in a minute.")and [dropdown](http://twitter.github.com/bootstrap/javascript.html#dropdowns "The dropdown component") component and the new menu was set up quickly.

I faced some technical problems, namely the changes I made to the less files wouldn't be reflected on the site. I stumbled upon [this issue](https://github.com/cloudhead/less.js/issues/47 "Less files cached inside the localstorage"), apparently well know but unfixed for now... but the workarounds suggested didn't do the trick for me. I ended up using [winless](http://winless.org/ "Winless, a Less compile for windows with a GUI") to compile my less files on the fly — it barely slows down the progress and works just fine.

<figure>
	![Look At Stream homepage](http://yannick-lohse.fr/wp-content/uploads/2012/09/homepages.png "LAShomepages")
	<figcaption>
		Above, the first Look At Stream homepage, and the new one below.
	</figcaption>
</figure>

The other big thing in this "redesign" is the new homepage. When we launched in july, I piratically redesigned and recoded the whole site over 3 straight days I had free, except for the homepage for which we had asked a graphic designer to make a fancy design/art for us. We wanted to launch on Monday, so when we reached Sunday 9PM with still no homepage in sight, we very quickly designed and coded one ourselves. It did fairly well so far — it's very simple and highlights well what we do. But it worked well for 4 games, now we have 5 and more to come. We also really need space to advertise for our new features, so it was time for a change here as well.

The ideas behind the new homepage are quite simple ; provide links to streams for our 5 games, and try to advertise for our new features. Again, since Twitter Bootstrap was there, I pulled out the hero unit component for our advertising. The design is all right and will do for now, but we might try out other things in the new feature — I'm thinking of a facebook wall widget or something like that.
