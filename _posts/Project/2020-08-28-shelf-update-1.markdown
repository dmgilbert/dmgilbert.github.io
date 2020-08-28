---
layout: post
title:  "Shelf Update 1"
date:   2020-08-28 12:35:41 +1000
subtitle: "A Little Bit Tilted"
tags: "Projects Desk Update R"
categories: "Project"
---

After a little more thinking about the design, I went out to the local hardware store and picked up some materials for the supports, leaving some choices about the actual shelf bit for later. After getting sent back and forth between a couple of stores, I had the steel pipes and flanges- only to find the flanges had some, er, “slight” fabrication errors. The flanges were pretty horribly bent but all in different ways, some convex and some concave, but I couldn’t bend them into shape because I chose thick steel flanges for an industrial aesthetic, *sigh*. Time to start fixing the problem…

Trying to fix these flanges, I clamped one down to my workbench and gave it a couple good whacks with a hammer to no avail. I also considered heating up the steel in my foundry and forging it into shape, but I didn’t have anything that could be used as an anvil. Just before heading back to the shops to get a refund, I thought I might as well see if I could combine the flanges in a way that was good enough, trying different combinations on either ends of the pipes while using a plank of wood with a bubble level to check how flat it was. To my surprise, I managed to get the plank relatively level, being straight along the length of the plank and only a little tilted along its width. Wanting to test this further, I took an old chipboard shelf and attached the flanges to it, standing this on top of my desk to get a better idea of what it would look like.
<div style="text-align: center"><img src="/assets/shelf prototype.jpg" alt="Prototype shelf for my desk" width="70%" /></div>

<br/>

I was really happy with how this looked! Despite having not painted the supports yet and using a rather dirty shelf, I was pleased with how this came out, although I think I’d prefer the shelf to go the whole length of the desk. Spanning the desk might be an issue, as the hardware store only has lengths of 1200mm with the width I’m looking for, or 1800mm lengths that are too wide, adding extra costs for more material and for getting the shelf cut down.

<br/>

__Calculations:__
Modelling the shelf as a simply supported beam holding 10kg of objects uniformly distributed over its length and taking the weight of the shelf to be 6.7kg, I found that there would be around a 30.67 Nm maximum moment at the midspan of the shelf. I then calculated the maximum stress this would induce at the top/bottom fibre of the beam, σmax = 3 MPa. This was well within the strength of wood using <a href="https://www.engineeringtoolbox.com/wood-beams-strength-d_1480.html"> these</a>  values, giving a decent factor of safety while already using an overestimate for the shelf load.

Shelf properties for calculation: 1500&times;240&times;16 Oak 
<br/>
Second moment of area: 0.24 &times; 0.008^3/12 = 81.92e-9 Nmm^4
<br/>
Max stress = 30.67 &times; 0.008/81.92e-9 = 2.995e6 N/m^2 = 2.995 MPa
