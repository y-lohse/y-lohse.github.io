---
layout: post
title: Secret de dev episode 1
description: Comment devenir plutot bon en programmation
published: false
---
Ces dernières années, j'ai passé pas mal d'heures à aider des gens autour de moi à coder; camarades de promo, collègues, amis... Des personnes qui n'aiment pas fondamentalement coder mais qui savent se démmerder un peu. J'ai vu plusieurs de ces personnes essayer de se dépasser, de vraiment apprendre à coder. Et j'en ai vu tout autant arrêter rapidement, frustré.

Alors voila un "secret" pour vous, un truc qui est inné chez certains, absent chez d'autre, qu'on ne vous apprend pas à l'école et rarement dans les tutos.

{{ site.prettify_js }}
    tu.fais(ceQueJeVeux);

Ca c'était pour l'effet dramatique. En vrai c'est pas ça du tout; le secret c'est d'apprendre à débuger.

> Jm'en fou de savoir débuger, je veux apprendre à coder SANS bugs

Ouais ouais, c'est ce qu'on veux tous. Il y a cette règle qui dit [qu'il faut pratiquer quelque chose pendant 10 000 heures](http://en.wikipedia.org/wiki/Outliers_%28book%29) avant de la maitriser vraiment. Eh ben comptez ca pour apprendre à coder sans bug. Par langage. +2 000 heures par nouvelle librairie. Autant dire que vous n'y êtes pas encore, alors autant rendre ces heures moins frustrantes en apprenant à débuger correctement.

Habituellement, quand votre code produit quelque chose d'innatendu (ie. un bug), vous avez tendance à appliquer la méthodologie suivante :

1. Regarder l'écran dubitativement pendant 30 secondes
2. Relire le code rapidement
3. S'exclamer "J'comprend pas, ca devrait marcher !"
4. Relancer le code, voir si l'erreur est partie toute seule
5. S'exclamer "Putain mais ca devrait marcher !"
6. Frustration
7. Passer à autre chose

Mais en vrai, on fais pas comme ça. C'est plus comme enquête policière — et moi j'aime bien l'approche Sherlock Holmes.

> Eliminate all other factors, and the one which remains must be the truth.

Commencons par régler un malentendu; le but d'une enquête n'est pas de découvrir des motifs mais un coupable. Pareil ici; arretez de vous demander *pourquoi* votre programme merde et cherchez plutôt quelle partie est responsable de ce disfonctionnement. Quand vous l'aurez identifiée, vous trouverez les raisons bien assez vite. Dès qu'un bug surviens, essayez de trouver toutes les origines possibles et immaginables — puis eliminez les une par une.

## Identifier le type de bug

### Erreur de syntaxe

Un point virgule qui manque, une faute de frappe, ce genre de merdes. Le symptome est très simple à voir puisqu'il ne se passe rien du tout; le code ne s'éxécute pas.

Cette catégorie de bug est assez simple à détecter alors avant de passer à la suite ca vaux le coup d'exclure cette possibilitée. Tous les langages de programmation signalent des erreurs de syntaxe d'une façon ou d'une autre — ayez ces signalements toujours sous les yeux. PHP écrit les erreurs dans la page que vous affichez; javascript écrit dans le console d'erreur du navigateur; les langages compilé écrivent dans la sortie du compilateur. Trouvez l'endroit ou ces erreurs sont affichés et ne le lâchez plus.

Méfiez-vous, la plupart des langages ont des options pour que ces erreurs ne s'affichent pas. Trouvez ces options et faites en sorte que le langage crache absolument TOUT ce qui lui semble suspect.

### Erreur de logique

Votre code ne plante pas, mais il ne fais pas non plus ce qu'il devrait; c'est donc une erreur de logique quelque part. C'est la variante la plus chiante, mais pas de panique.

### La batarde

La batarde, c'est une erreur de logique qui aboutie à une erreur de syntaxe. Elles se détectent comme les erreurs de syntaxe, mais se débugent comme une erreur de logique.

## Reproduire le bug

Pour débuger l'esprit tranquille, il faut absolument que vous puissiez reproduire le bug autant de fois que vous le voulez. Les erreus de syntaxes sont simple à reproduire, elles ont normalement lieu à chaque éxécution. Pour les erreurs de logique, essayez de répéter les quelques actions qui ont précédé l'apparition du bug. Si le bug ne réaparait pas ce n'est pas que le problème est réglé, c'est que vous n'avez pas fait les bonnes actions. Essayez de remonter encore plus loin dans le temps; reproduisez les conditions exactes dans lequel le bug ets apparu la première fois. Les bugs qui apparraissent aléaoirement sont les plus dures à corriger.

Ou presque. Ls pires sont ceux des jeux vidéo. Quand vous avez un bug qui n'apparait que quand vous tuez le boss de fin à la dernière seconde du niveau avec l'arme la plus moisie, c'est la merde.

## Supprimer des facteurs

Une fois que vous savez reproduire le bug à volonté, il est temps de le réduire à l'essentiel. Cette partie est assez simple en fait; si vous avez besoin de 5 actions pour reproduire le bug, essayez avec seulement les 4 dernières. Et après les 5, mais sans la 2ème. Ou en inversant la 3 et la 4.

En faisant ca, vous visez deux choses :

1. Isoler les facteurs qui déclechent le bug. Chaque facteur inutile risque d'entrainer d'autres bugs ou de produire des effets indésirables. Dans le meilleur des cas, ils vont juste vous ralentir.
2. Trouver des indices. Si vous avez trouvé 2 manières différentes de reproduire votre bug, vous pouvez trouver les facteurs communs aux 2 façons et en déduire quelque chose. Sérieux, c'est comme une partie de Cluedo.

## Correction time #1 — erreurs de syntaxe

A ce stade, vous pouvez corriger les erreurs de syntaxe sans problème normalement. Le langage doit vous fournir un numéro de ligne et un message auquel vous ne comprenez pas grand chose.

> Error T_PAAMAYIM_NEKUDOTAYIM

Merci PHP. Relisez la ligne, essayez de trouver une erreur manifeste (faute de frappe dans les variables, symbole manquant...). Normalement c'est easy.

Si vous ne voyez rien de suspect, vous êtes probablement confronté à une erreur batarde. Vous pouvez faire une tentative de résolution rapide — plus vous ês proche de la 10 000<sup>ème</sup> heure, plus ca va résir... donc ne vous faites pas trop d'espoir au début.

Comme vous ne bitez rien au message d'erreur, demandez à google ce qu'il en pense. Copiez collez le message d'erreur en enlevant les portions qui sont spécifiques à votre code, mettez le nom du langage devant, et regardez ce que vous trouvez. Essayez les différentes solutions qui sont proposées en ligne, mais **évitez de rendre votre code plus complexe**. Si une solution ne marche pas, remettez votre code comme il était et passez à la solution suivante.

Si une des solutions fonctionne, associez dans un coin de votre tête le message d'erreur et la solution. Quand vous rencontrerez à nouveau ce message d'erreur il y a des chances pour que la même solution vous sauve à nouveau.

> Most people, if you describe a train of events to them, will tell you what the result would be. They can put those events together in their minds, and argue from them that something will come to pass.  
> There are few people, however, who, if you told them a result, would be able to evolve from their own inner consciousness what the steps were which led up to that result. This power is what I mean when I talk of reasoning backwards, or analytically.

Autre conseil, faites vos recherches en anglais. Quinze fois plus de résultats.

Ne passez pas trop de temps la dessus, c'est une partie qui gonfle vite. Si après 3-4 essais l'erreur est encore la, il est temps de sortir la grosse artilerie.

## Changer de perspective

Pour continuer à simplifier le problème et éliminer des facteurs qui ne contribuent pas au bug, Il faut commencer à voir ce que vois l'ordinateur. S'il y a une chose à retenir de ce guide, c'est ça; mettez vous à la place de l'ordinateur, vous devez voir aux travers ses yeux. Façon de parler.

La méthode la plus classique pour ca est de relire son code en gardant en tête les valeurs de toutes les différentes variables qui entrent en jeu et en en devinant une demi-douzaine. Autant dire que cette méthode atteint vite ses limites.

### Ajoutez des messages d'erreur

Encore une fois, tous les langages vous permettent d'écrire vous même à l'endroit ou le langage signale les erreurs de syntaxe. Profitez en pour y écrire un maximum d'informations. Des résultats de calculs, des marqueurs vous indiquant qu'une portion de code à été éxécutée... tout ce qui vous passe par la tête. Vous ne devez pas juste comprendre ce que fais votre programme, vous devez le **voir**.

### *Mieux* voir

J'ai essayé de rester agnostique en terme de langage jusqu'ici, mais permettez-moi de donner quelques exemples concrets pour illustrer ce point. Beaucoup de langages ont des subtilités qui permettent de mieux voir ce que l'on fais. En PHP par exemple, beaucoup de personnes utilisent l'instruction *echo* pour afficher le contenu d'une variable... sauf que ca fonctionne mal. Echo ne permet pas d'afficher des structures cemplexes comme les objets ou les tableaux et pire encore, une variable valant *false* n'affichera rien du tout. Utilisez plutôt *var_dump* qui est fait pour ça.

De la même façon, le *alert* de javascript est une mauvaise aide. D'une part parce qu'il faut cliquer sur *chaque* putain de message pour le faire disparaitre, d'autre part parce qu'il convertis tout en chaêne de caractère et empêche ainsi de voir le contenu d'un objet. Utilisez *console.log* à la place, qui est livré avec plein de goodies dans les navigateurs modernes.

### Ne faire qu'un avec le code source (rien à voir avec le Bouddhisme)

Parfois, çaa ne suffis pas. Quand après 15-20 minutes à ajouter des mesages d'erreur un peu partout on ne comprend toujours pas ce qu'il se passe il faut passer à des méthodes plus pointues.

Beaucoup d'éditeurs de code offrent un méchanisme de point d'arrêt — des machines à voyager dans le temps. Vous définissez à partir de quel endroit dans votre code l'éxécution doit se mettre en pause, et une fois ce point atteint c'est vous qui êtes aux commandes. Vous décidez quand il faut passer à l'instruction suivante, vous pouvez voir toutes les variables et leurs valeurs, vous pouvez les modifier à volonté. Rien de mieux pour **tout** voir.

*Au passage, les outils de développement des navigateurs web embarquent ces fonctionnalitées pour javascript.*

## Simplifier²

A ce stade, vous devriez commencer à voir ce qui cloche. C'est la que l'on diverge de l'enquête policière; vous pouvez maltraiter les suspects autant que vous voulez, vos variables ne sont pas protégées par la loi. Alors allez y, commencer à les bidouiller pour vérifier vos théories, éliminer des hypothèses.

<hr />

Il se peux que même maintenant il y ai encore trop de sources d'erreurs possibles pour y voir clair. C'est le moment de recommencer à supprimer des facteurs, mais en modifiant le code cette fois-ci. Sortez votre tronconeuse et commencez à supprimer des pans entier de code (plus sérieusement, mettez les en commentaire) — et regardez si le problème persiste. En procédant ainsi, vous devriez non seulement éminer des sources possibles d'erreurs mais aussi former de nouvelles hypothèses sur l'origine du problème.

Ici vous devriez être ne mesure de venir à bout de toutes les erreurs batardes et même de la plupart des erreurs logiques. Ne restent plus que les coriaces. Continuez la démarche. Simplifier le code, rentrez dedans, regarderz tout ce qui se passe.

## En cas de blocage

Il arrive que l'on soit à cours d'hypothèses; voici quelques techniques pour s'en sortir, il y en a certainement d'autres. Ce sont les techniques de dernier recours; si après les avoir toutes appliquées vous ne vous en sortez toujours pas je ne sais plus quoi vous conseiller.

### L'inversion

L'inversion consiste à faire le cheminement inverse de ce que j'ai décrit avant : au lieu de simplifier par étape, on complexifie par étape. Partez d'un document vierge et créez une version minimaliste mais fonctionnelle de ce que vous voulez faire. Puis ajoutez les différents bouts de code que vous n'aviez pas encore innocenté, un par un. Et surveillez tout; dès que vous repérez quelque chose qui cloche, explorez — c'est peut-êe le début d'une piste.

### J'me casse

Changer vous les idées; faites une pause ou travaillez sur autre chose. Le but est de jeter un regard neuf sur le problème quand vous revenez. Si vous travaillez dans le design, c'est quelque chose que vous savez faire — le moment ou vous jetez toutes les contraintes éxistantes pour repenser quelque chose depuis le début.

Mais attention, pour résoudre un problème complexe, il faut s'immerger dedans — et cette immersion prend du temps. Dès que vous passez à autre chose, vous vous obligez à recommencer le processus d'immersion plus tard.

### L'appel à un ami

Si vous avez quelqu'un sachant coder sous la main, asseyez le devant votre problème. Il ne va pas aimer, ca va lui prendre du temps... mais parfois c'est la seule option restante. Observez sa façon de faire, comprenez comment il pense — apprenez de lui. Au pire allez demander de l'aide en ligne.

## Évitez le point de rupture

Quand vous aurez trouvé l'origine du problème, la raison vous apparaitras très vite. Mais une fois corrigé, ne sautez pas de joie. En fait, ne vous attendez même pas à ce que ca fonctionne — les fausses joies de ce genre sont particulièrement décourageantes. Si tout fonctionne, parfait, affaire résolue. Mais souvent, ce que vous venez de corriger n'est qu'un maillon d'une chaîne. Apès une heure en immersion dans ce bug, vous aviez complétement oublié que vous vouliez juste le résoudre parce qu'il causait un *autre* bug. Ou maintenant que l'éxécution de votre programme ne s'arrête plus à ce bug, elle s'arrête quatres lignes plus loin.

Comptez deux heures de bugs pour une heure de code au dét, mais à mesure que les 10 000 heures s'écouleront cette proportion se réduira. Et quand pour la première fois vous écrirez 200 lignes d'une traite et que tout fonctionnera parfaitement du premier coup, vous regarderez à nouveau l'écran d'un air dubitatif — mais plus pour la même raison.