---
name: osint-fact-checker
description: Mène une investigation OSINT et un fact-checking de niveau expert (méthodologie IFCN et pyramide des preuves) sur une assertion textuelle ou visuelle. À utiliser lorsque l'utilisateur demande de vérifier une affirmation, analyser la véracité d'une information ou d'une image, faire du fact-checking, débunker une rumeur ou évaluer la fiabilité d'une source.
---
# OSINT Fact Checker

Conduit une investigation rigoureuse en un seul coup (one-shot) pour vérifier la véracité factuelle d'une assertion (texte ou image) selon les standards de l'International Fact-Checking Network (IFCN) et l'analyse scientifique des preuves.

## When to Use

- L'utilisateur soumet une citation, une statistique, une rumeur, un post ou un article et demande de vérifier si c'est vrai ("fact-check", "vérifie cette info", "est-ce vrai que...").
- L'utilisateur partage une image pour vérifier son authenticité, son contexte d'origine ou détecter une manipulation / utilisation hors contexte.
- L'utilisateur souhaite une évaluation de la fiabilité d'une affirmation avec un rapport sourcé et hiérarchisé destiné à un public exigeant.

## Méthodologies de Référence

### 1. Principes de l'IFCN

- **Impartialité et Équité :** Appliquer les mêmes standards critiques à toutes les assertions, quelle qu'en soit l'origine.
- **Transparence des Sources :** Citer explicitement les sources clés qui soutiennent le verdict pour permettre la reproductibilité.
- **Transparence de la Méthodologie :** Expliquer comment l'investigation a permis d'aboutir au verdict.

### 2. Hiérarchisation des Sources (Pyramide des Preuves)

Classifier chaque preuve trouvée selon cette échelle. Une preuve de niveau supérieur l'emporte systématiquement sur plusieurs preuves de niveau inférieur :

- **Niveau A (Très Fiable) :** Méta-analyses, revues systématiques, données brutes d'agences gouvernementales ou internationales reconnues (ex. INSEE, GIEC, OMS, Eurostat).
- **Niveau B (Fiable) :** Études scientifiques évaluées par les pairs (essais contrôlés, études de cohorte), rapports d'experts institutionnels publiés.
- **Niveau C (Moyennement Fiable) :** Enquêtes journalistiques de médias de référence citant des sources primaires, analyses d'experts reconnus dans leur domaine.
- **Niveau D (Peu Fiable) :** Anecdotes, blogs non sourcés, publications sur les réseaux sociaux, ouï-dire, déclarations politiques sans preuves à l'appui.

### 3. Protocole OSINT pour les Images

Lorsque l'assertion inclut ou repose sur une image :

1. **Analyse du Contenu (Vision) :** Décrire factuellement les éléments visuels pertinents (lieux, personnes, objets, météo, architecture).
2. **Extraction du Texte (OCR) :** Relever tout texte, panneau, filigrane ou sous-titre visible.
3. **Analyse de Provenance :** Rechercher l'origine de l'image pour identifier sa première publication et son contexte initial.
4. **Analyse d'Intégrité :** Repérer les indices de manipulation (artefacts d'IA générative, montage photo, recadrage trompeur) ou de détournement (vraie photo utilisée hors contexte).

## Steps (Workflow d'Investigation Interne)

Exécuter l'intégralité de cette démarche en une seule passe (sans poser de questions intermédiaires à l'utilisateur) et sans afficher les étapes de brouillon dans la réponse finale :

1. **Déconstruction :** Isoler le ou les faits vérifiables principaux (Sujet, Prédicat, Valeur, Date, Lieu) à partir du texte ou de l'image fournie.
2. **Planification :** Identifier les sources primaires (Niveau A ou B) capables de valider ou d'infirmer le fait et formuler les requêtes de recherche nécessaires.
3. **Exécution :** Utiliser les outils de recherche web pour collecter les données officielles, études et articles de vérification existants.
4. **Graphe de Preuves (Évaluation) :** Attribuer un niveau de fiabilité (A, B, C ou D) à chaque source trouvée et cartographier les convergences et contradictions.
5. **Synthèse Critique :** Écarter les preuves de Niveau D lorsqu'elles contredisent des preuves de Niveau A ou B. Déterminer la nuance exacte du verdict et l'intention probable. Si aucune source de Niveau A, B ou C n'est disponible, conclure obligatoirement à "INVÉRIFIABLE".

## Format de Sortie Final

Présenter le rapport final en respectant strictement la structure Markdown suivante :

---

### 1. VERDICT

**(VRAI / FACTUELLEMENT VRAI / PARTIELLEMENT VRAI / TROMPEUR / PARTIELLEMENT FAUX / FAUX / INVÉRIFIABLE)**

- **Interprétation :** (ex. Manipulatoire, Pédagogique, Satirique, Hors contexte, Erreur de bonne foi)

### 2. SCORE DE FIABILITÉ DE L'ASSERTION

**(TRÈS FIABLE / FIABLE / PEU FIABLE / TRÈS PEU FIABLE / NON ÉVALUABLE)**

- **Basé sur :** (Synthèse de la qualité des preuves, ex. "Basé sur des données institutionnelles de Niveau A" ou "Basé sur des sources contradictoires de Niveau C et D")

### 3. ANALYSE DÉTAILLÉE

#### A. Le Fait Vérifié

- (Reformulation neutre, claire et précise du ou des faits soumis à l'investigation)

#### B. Méthodologie de Vérification

- (Explication concise de la démarche : croisement des bases de données consultées, rapports analysés, ou étapes de vérification visuelle/contextuelle pour une image)

#### C. Analyse Contextuelle et Rétablissement des Faits

- (Développement principal : présentation détaillée des faits établis par les sources de haut niveau, explication des mécanismes rendant l'assertion vraie, fausse ou trompeuse, et remise en contexte complète)

#### D. Principales Sources Consultées

- **(Source 1) :** [Titre de la source, Média/Organisation] - **(Fiabilité : Niveau A/B/C/D)**
- **(Source 2) :** [Titre de la source, Média/Organisation] - **(Fiabilité : Niveau A/B/C/D)**

## Gotchas

- **Biais de fausse équivalence :** Ne pas mettre sur un pied d'égalité un consensus scientifique (Niveau A) et une opinion isolée (Niveau D).
- **Chiffres vrais, conclusion fausse :** Lorsqu'une statistique exacte est utilisée pour soutenir une corrélation fallacieuse ou hors contexte, utiliser le verdict **TROMPEUR** plutôt que VRAI.
- **Absence de preuves :** Ne jamais spéculer si les données manquent. Appliquer la clause de sécurité et prononcer le verdict **INVÉRIFIABLE**.
