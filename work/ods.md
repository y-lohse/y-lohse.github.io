---
layout: work
title: Office des Sports de Strasbourg
description: Redesigning the website for a local organisation.
---
The [Office des Sports](http://ods67.com/) de Strasbourg is an organisation that manages everything related to sports in Strasbourg. They have a couple of part time employees and a lot of volunteers, and they run the big events such as the annual marathon.

In 2013, they decided their [old website](https://web.archive.org/web/20080818020325/http://www.ods67.com/?) had to go; they spoke to a few teams and ultimately decided to entrust my friend [Loïc](http://herrloc.fr/) and myself the task to redesign it from the ground up. Now if you've seen the project dates (2013 to 2016), you're probably wondering how the heck it can take 3 years to build a single website. Well, let me tell you.


## Year One : Hatch a Plan

Upon their request, the first phase of the project was to be theoretical only. We went through the usual process of analyzing the current website, the competitors, etc. We created a few personas and identified what the new website should achieve, and concluded with a recommended page list and organisation.

<figure>
![A wireframe view of the new homepage]({{ site.img_path }}/2016/09/ods-wire.png)
<figcaption>
A wireframe view of the new homepage
</figcaption>
</figure>

This went all very well and everything was approved after 3 months. And then... we waited. The problem with an organisation that has no full time employee and runs a few big events is that they have about 3 month every year where they can do actual work. The rest of the time, they are either knee deep into event management, or on holliday. This would become a recuring theme during the project, with more than a few month were absolutely nothing happened.

## Year Two : Actually…

So we eventually get the green light to start working on the new website. We delivered a design, based on pre-approved mockups.
But the new design was using the old style guide, which hadn't aged very well. Realising the problem, the Office decided it was time for a global rebrand. We sat on the sidelines watching them change their logo and every collateral for over a year.

## Year Three : Getting Shit Done

Once the new brand identity completed, things went a lot smoother. Loïc revised the design, got it approved, and I went to the coding furnace.

<figure>
![The new Office des Sports website]({{ site.img_path }}/2016/09/ods-1.png)
<figcaption>
The final design
</figcaption>
</figure>

The whole website is based on WordPress, a platform I knew [quite well](/work/tdf.html) by then. It has about 10 different page models and the home page can switch between 3 different layours based on what needs to be currently advertised. Most things were relatively easy to do, with the sole exception of [the search engine for the clubs](http://ods67.com/faire-du-sport/).

THE main reason why people visit this website is to find clubs they can send their kids (or tehsmelves) to. THis alone represents about 90% of all visits, and the database lists over 250 clubs with every possible information about them. The built-in search engine is good when it comes to indexing article titles and contents, but it is absolutely clueless when it comes to meta-information. This meant I had to roll my own search engine that can handle queries about sports, localisation, age, and a lot more.

The database itself had to be imported from an Access file. The Office used the file to generate all sorts of collateral during the year, but of course needing to update both the Access file *and* the website was out of question. So the website database includes a lot more information than what is publicly available, and a bespoke exporting feature allows them to keep their existing workflow in that regard.