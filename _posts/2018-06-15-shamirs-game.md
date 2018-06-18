---
layout: post
title: Shamir's Game
published: true
---

While most of us at [Cozy Cloud](https://cozy.io) work remotely, we have a team day every 6 weeks in Paris. On top of regular work meetings, we make sure there's always a team-building activity going on, and these [have become more and more elaborate](https://twitter.com/y_lohse/status/1004377312366944256). This week, it was my turn to run the day and here's what we came up with.

Part of our team is working on a technique called [Shamir's secret](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing), where you transform a secret into several fragments. Those fragments hold no information, but reunite enough of them, and you can reconstruct the initial secret. Ever since I heard about it, I thought it'd be interesting to incorporate that into a treasure hunt type of game, so we did that.

# Phase 1 : find you team

Every participant was given a little card containing the name of a character, a link to their personnal fragment, and another link to a webpage that they could use to reconstruct a secret. We announced the teams were composed of 4-5 players, and… that's it.

Here's the list of all characters — can you guess who's with who?

- Benjamin Gates 
- Cedric Villani  
- Helmut Kohl 
- Sherlock Holmes 
- Ada Lovelace 
- Ibn Séoud 
- Grace Hopper 
- Pythagore 
- Katherine Johnson
- Diana Prince
- Evariste Galois
- Jean Moulin 
- Simón Bolívar
- Edward Snowden 
- Margareth Hamilton 
- Mata Hari
- Edsger Dijkstra
- Eugène-François Vidocq 
- Alan Turing
- Robert Langdon 
- Veronica Mars
- Nelson Mandela 
- Philippe Charuel
- Abraham Lincoln 
- Thales

The teams were randomized and the point was to give everyone a reason to chat with everyone, and ultimately work together on the riddles. And also teach everyone about Shamir's secret.

In hindsight, we should *not* have given out the cards just before starting the first round of meetings, since everyone became much more interested in finding their team mates than starting actual work :D.  
Other than that, it worked realtively well — people shared their identities and started forming theories about how they could be related. If you haven't figured out the teams yet, here they are:

### Mathematicians

 - Katherine Johnson 
 - Cedric Villani 
 - Pythagore 
 - Evariste Galois 
 - Thales
 
### Computer scientists

- Ada Lovelace 
- Margareth Hamilton 
- Alan Turing 
- Grace Hopper 
- Edsger Dijkstra

### Secret holders

- Diana Prince 
- Jean Moulin 
- Edward Snowden 
- Philippe Charuel 
- Mata Hari

### Secret breakers

- Benjamin Gates 
- Sherlock Holmes 
- Eugène-François Vidocq 
- Robert Langdon 
- Veronica Mars

### Unifiers

- Nelson Mandela 
- Helmut Kohl 
- Ibn Séoud 
- Abraham Lincoln 
- Simón Bolívar

There were some traps in there which mostly worked out. Most computer scientists were also pretty good at math, so that was a challenge. The spy section of the secret holders got together quickly, but had more trouble finding the non-spy members. One funny moment was (I think) Margareth Hamilton loudly proclaming "Maybe we are women in CS?" and a minute later Alan Turing saying "I think we are computer scientists..?", but it took both of them another 10 minutes to talk to each other.

# Phase 2 : Solving the riddle

Anyway, someone in each team started collecting the cards, and trying to de-shamirize their secret. Each team's secret was the URl of a cozy instance, and hints for the password. Here are the different combinations (not the real URls though):

- Math : numbers.cozy.cloud / MERGETOY
- CS : cpu.cozy.cloud / 53 52 45 54 55 50 4d 4f 43
- Secret holders : hidden13.cozy.cloud / FRPERGF
- Secret breakers : investigate.cozy.cloud / [the bear riddle](https://io9.gizmodo.com/think-you-know-the-solution-to-this-classic-riddle-thi-1648069908)
- Unifiers: unity.cozy.cloud / [this file](https://gist.github.com/y-lohse/b40feccf2b1ce6272ba253d94ed8ba91/archive/8948f616e339a50d85ebb935ee3e01502c2fc4b7.zip)

One bit of game design that worked exactly as we hoped was that some teams tried to use their password hint as the actual passwords. They had just (finally!) combined their fragments, found the URL and felt really close to the goal… only to be told the password was wrong. In hindsight again, it would have been better if all hints were made to look like actual passwords.

Some teams did actually work together on the riddle, as intended. The unifiers most notably quickly recognized it was morse code, and after trying to automatically decypher it, eventually just pulled up a convertion table and started transcribing the message together, which really was the point.
But in about half the teams, the person who had combined the fragments worked on the riddle nearly alone. Sometimes teammates were busy, or uninterested, or just not around, but that's something that clearly didn't work out as we had planned. We had also feared that someone might have heard the riddle before, or would google the answer, which is what sadly happened. ANotehr thing to change.

So now, the solution to the riddles:

- MERGETOY is the anagram of GEOMETRY
- 53 52 45 54 55 50 4d 4f 43 is little endian hexadecimal for COMPUTERS
- FRPERGF is SECRETS put through a ROT13 cypher — the name `hidden13` was a clue
- The riddles answer, and thus the password, was WHITE
- The morse code spelled REUNION

Once logged in, players would find a text file in the Cozy, instructing them to tell an organizer that they would pursue a thesis in blockchain — and that was it!

# Department of dropped ideas

A few things we considered, and then removed from the game:

- Various more layers of encryption, such as the secret being a base64 encoded image instead of plain text. Would have made the game unnecessairly complicated and impractical.
- We made the secrets solvable with 4 fragments, but wanted to give a bonus to teams using all 5. I really liked the idea of giving players a tradeoff between speed and reward, but we didn't have tiem to work it out. This actually turned out to be a good thing, since some teams were really just 4 people.

Finally, we considered given teams another hint, which would have been this:

Œ<ç∫ —ç ®<$ç ∞^î— ¡$—¡ îç &<çî<ç¡ `£ç• ◊£®£∫ >ª<£∫ ¥$—∫ ±$—îø Œ— ≤‹^$⌇Ÿ$çîº
&$ç ⌇<—¥ªî øî∞— <ç◊‹^$∫î `Ÿ$•—î Œî—≤ >$£∫ ¡$ç ®<~$ç ±<—çî
¥$¡ªî î&<£^ î∫¡ ¡$~î¡Ÿîª≠‹$⌇&<£^º`$&

∫Ÿ<&£ª çî ¥$—∫ <£Œîª< ⌇<∫º
Shamir ne vous aidera pas.

It's just a substitution code, and I think people would have figured that out quickly. And then hopefully collaborate on transcribing the whole hint.
The last line would have given them the email adress associated with their Cozy instance — a junkmail service wher eyou don't need a password. If they were clever, they could then use the pasword recovery feature to log into the Cozy. We liked the idea of giving an alternative way into the Cozy, but felt that it would, again, be too complicated for what it was. And that wa a good call, since the passwords were easy enough to guess.

If you're curious, here's [the program I wrote to encode / decode things](https://repl.it/repls/BurlywoodFirsthandExperiments).

_____

The whole thing ended up being a lot of work, but quite fun to organize. And most people seemed to be into it, so that's enough for me :-)

