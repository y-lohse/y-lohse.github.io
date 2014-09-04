---
layout: post
title: The phonegap touch responsiveness trap
description: 
---
I'm building an app for every major platform with web technologies, and the way I port it to Android and iOS is using cordova / phonegap. From the outside, it looks like it simply wraps your web stuff in more stuff you don't understand and boom, you have a native app. And as long a you don't need anything more it works well but as soon as you dive into plugins and configuration and shit, it's a mess.

Anyway, that's not what this post is about. I had this issue on some parts of the UI on my iPad where the response to a tap seemed painfully slow. If you start googling this problem, everyone points to FastClick which is cool except it was already running in my case so it had to be something else. To be precise, what happened is that sometimes the first tap would trigger the hover effect and the second wuld trigger the actual tap event. Soemtimes it worked on the first touch.

Turns out the solutiion is in the problem; if an element is listening for `mouseenter` & similar events, the first touch triggers that event. i removed the event listeners on touch devices because I didn't really needed them. If you *do* need them, well, at least now you know where to look.