# Projet de Platformer 2D

## Gabriel Racine

### Introduction
Le Platformer 2D que j'ai développé offre une expérience immersive en combinant divers éléments de conception, du comportement intelligent des ennemis à la gestion de la stamina du joueur. Les joueurs exploreront des environnements dynamiques, affrontant des ennemis réactifs et utilisant stratégiquement leur stamina pour progresser.

### Concepts Utilisés

#### Raycast pour le Comportement de l'Ennemi
- **Description du Concept**: L'ennemi utilise un raycast pour détecter les obstacles tels que les murs ou le vide, permettant une navigation intelligente.
- **Source de l'Information**: [Répertoire Github Godot](https://github.com/godotengine/godot-demo-projects/tree/master/2d/platformer/enemy)
- **Capture d'Écran**: ![Raycast en Action](lien_vers_capture_raycast)

---

#### Shaders pour l'Ennemi et le Texte de la Scène Win
- **Description du Concept**: L'utilisation de shaders combinés sur l'ennemi et un shader spécifique sur le texte de la scène Win ajoute des effets visuels distinctifs.
- **Source de l'Information**: [Introduction aux Shaders](https://github.com/nbourre/0sw_notes_cours/tree/main/shaders)
- **Capture d'Écran**: ![Effets Visuels avec Shaders](lien_vers_capture_shaders)

---

#### Parallax Background
- **Description du Concept**: L'effet de parallaxe crée une illusion de profondeur en déplaçant des couches d'arrière-plan à des vitesses différentes.
- **Source de l'Information**: [ParallaxBackground avec Godot](https://github.com/nbourre/0sw_notes_cours/tree/main/parallaxe)
- **Capture d'Écran**: ![Parallax Background](lien_vers_capture_parallax)

---

#### Comportement de Boid dans le Menu Principal
- **Description du Concept**: L'algorithme de comportement de Boid simule des entités autonomes réagissant les unes aux autres et à la position de la souris.
- **Source de l'Information**: [Introduction aux Boids](https://github.com/nbourre/0sw_processing_exemples)
- **Capture d'Écran**: ![Comportement de Boid](lien_vers_capture_boid)

---

#### Machine à États (AnimationTree)
- **Description du Concept**: Une machine à états gère les différents états du joueur, organisant le flux du jeu en fonction des actions et de l'état actuel.
- **Source de l'Information**: [Documentation sur les Machines à États](https://github.com/nbourre/0sw_notes_cours/tree/main/animation_tree)
- **Capture d'Écran**: ![Machine à États du Joueur](lien_vers_capture_states)

---

#### Gestion de la Stamina
- **Description du Concept**: Mise en place d'un système de stamina pour le joueur avec régénération gérée par un timer.
- **Capture d'Écran**: ![Gestion de la Stamina](lien_vers_capture_stamina)
