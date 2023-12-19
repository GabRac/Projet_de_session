# Platformer 2D : Bugs Slayer

## Gabriel Racine

### Introduction
Le Platformer 2D que j'ai développé offre une expérience immersive en combinant divers éléments de conception, du comportement intelligent des ennemis à la gestion de la stamina du joueur. Les joueurs exploreront des environnements dynamiques, affrontant des ennemis réactifs et utilisant stratégiquement leur stamina pour progresser.

Le projet "Bugs Slayer" est un jeu de type Platformer 2D. Il offre aux joueurs une expérience immersive dans un environnement où la stratégie, la réactivité des ennemis, et la gestion de la stamina sont des éléments clés. Un projet comparable pourrait être "Hollow Knight" pour son mélange de plateforme et d'action.

### Concepts Utilisés

#### Raycast pour le Comportement de l'Ennemi
- **Description du Concept**: L'ennemi utilise un raycast pour détecter les obstacles tels que les murs ou le vide, déterminant ainsi la direction à prendre. Cette approche offre une réactivité accrue de l'ennemi aux changements dans son environnement.
- **Comparaison avec Différentes Méthodes:** Une approche basée sur des collisions classiques aurait pu être utilisée, mais le raycast offre une réactivité accrue.
- **Avantages et Inconvénients:** Avantage - Réactivité élevée ; Inconvénient - Complexité de mise en œuvre.
- **Source de l'Information**: [Répertoire Github Godot](https://github.com/godotengine/godot-demo-projects/tree/master/2d/platformer/enemy)
![Raycast en Action](imgs/raycast.png)

---

#### Shaders pour l'Ennemi et le Texte de la Scène Win / GameOver
- **Description du Concept**: L'ennemi est doté de shaders combinés pour créer des effets visuels uniques. De plus, un shader spécifique est appliqué au texte de la scène Win et GameOver, ajoutant une esthétique particulière à la victoire ou la défaite du joueur.
- **Comparaison avec Différentes Méthodes:** Les shaders offrent une flexibilité artistique, mais d'autres approches pourraient impliquer des animations traditionnelles.
- **Avantages et Inconvénients:** Avantage - Esthétique personnalisée ; Inconvénient - Courbe d'apprentissage pour les shaders.
- **Source de l'Information**: [Introduction aux Shaders](https://github.com/nbourre/0sw_notes_cours/tree/main/shaders)
![Effets Visuels avec Shaders](imgs/enemy_shader.png)

---

#### Parallax Background
- **Description du Concept**: Un arrière-plan en parallaxe crée une illusion de profondeur, améliorant l'aspect visuel global du jeu. Cette technique consiste à déplacer des couches d'arrière-plan à des vitesses différentes pour simuler la perception de la profondeur.
- **Comparaison avec Différentes Méthodes:** Des arrière-plans fixes pourraient être utilisés, mais le parallaxe ajoute une dimension visuelle.
- **Avantages et Inconvénients:** Avantage - Illusion de profondeur ; Inconvénient - Complexité de conception.
- **Source de l'Information**: [ParallaxBackground avec Godot](https://github.com/nbourre/0sw_notes_cours/tree/main/parallaxe)
![Parallax Background](imgs/parallax.png)

---

#### Comportement de Boid dans le Menu Principal
- **Description du Concept**: Un algorithme de comportement de Boid est utilisé dans le menu principal pour simuler des entités autonomes qui évitent les autres entités du même groupe et réagissent à la position de la souris. Cette fonctionnalité ajoute une dimension interactive au menu principal.
- **Comparaison avec Différentes Méthodes:** Des animations pré-définies pourraient être utilisées, mais les Boids offrent une réactivité.
- **Avantages et Inconvénients:** Avantage - Interactivité dynamique ; Inconvénient - Complexité algorithmique.
- **Source de l'Information**: [Introduction aux Boids](https://github.com/nbourre/0sw_processing_exemples)
![Comportement de Boid](imgs/boids.png)

---

#### Machine à États (AnimationTree)
- **Description du Concept**: Une machine à états gère les différents états du joueur, tels que "walk", "run", "idle", "jump", "fall", "land", et "attack". Cette approche organise de manière efficace le flux du jeu en fonction des actions de l'utilisateur et de l'état actuel du joueur.
- **Source de l'Information**: [Documentation sur les Machines à États](https://github.com/nbourre/0sw_notes_cours/tree/main/animation_tree)
![Machine à États du Joueur](imgs/animationtree.png)

---

#### Gestion de la Stamina
- **Description du Concept**: Mise en place d'un système de stamina qui diminue lors de l'utilisation d'actions spécifiques, comme la course. La stamina se régénère avec le temps, et un timer (stamina_timer) est utilisé pour gérer ce processus de régénération, ajoutant une dimension stratégique au gameplay.
![Gestion de la Stamina](imgs/stamina_code.png)


---

### Conclusion

#### Retour sur le projet
- **J’ai aimé faire ce projet, Parce que…** : Il a été une opportunité passionnante d'explorer des concepts avancés de développement de jeux. La combinaison de l'intelligence des ennemis et jusqu'à créer une machine à états.

#### Les éléments que vous auriez aimé explorer
- J'aurais aimé explorer davantage les mécanismes de génération procédurale pour une variété accrue des environnements. La diversité des niveaux aurait pu être étendue pour offrir une expérience de jeu encore plus riche.

#### J’aurais aimé aller plus loin dans le projet
- Ajouter un système de dialogue et des quêtes aurait été une extension intéressante. Cela aurait apporté une dimension narrative plus profonde et engagé davantage les joueurs.

#### J’ai Bien Aimé Faire Mon Projet, Je N’Aurais Pas Changé de Sujet…
- Le projet a vraiment été une expérience géniale, et je ne regrette pas du tout mon choix. Bugs Slayer a été une aventure de développement vraiment stimulante, mêlant créativité, programmation avancée, et résolution de problèmes.

---
