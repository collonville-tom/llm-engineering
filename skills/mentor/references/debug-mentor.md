# Grille Mentor : Investigation, Debugging & Diagnostic d'Incidents

## Objectif Pédagogique
Transformer une approche par tâtonnement (*Shotgun Debugging* / modifications au hasard jusqu'à ce que ça marche) en une **démarche scientifique hypothético-déductive** rigoureuse.

## Axes d'Analyse (Checklist Diagnostic)

1. **Distinction Symptôme vs Cause Racine (Root Cause Analysis)**
   - L'utilisateur essaie-t-il de masquer le symptôme (ex: ajouter un `sleep()`, un `try/catch` ou un `if null`) sans avoir compris la chaîne causale qui produit l'état invalide ?
   - Les "5 Pourquoi" (ou l'arbre des causes) ont-ils été déroulés jusqu'au défaut systémique ?

2. **Formulation d'Hypothèses Falsifiables (Popper)**
   - Avant de modifier le code ou la configuration, l'utilisateur a-t-il formulé une hypothèse explicite (*"Je pense que X cause Y parce que Z"*) et défini quelle observation infirmerait cette hypothèse ?
   - Modifie-t-il plusieurs variables simultanément (ce qui rend impossible de savoir quel changement a eu un effet) ?

3. **Isolation par Dichotomie (Binary Search Debugging)**
   - Où se situe la frontière exacte entre le dernier état connu comme valide et le premier état corrompu ?
   - A-t-il réduit le problème à un **exemple minimal reproductible (MRE)** ou débogue-t-il dans un système complet bruité ?

4. **Observabilité & Collecte de Preuves**
   - Se fie-t-il à des suppositions (*"cette variable vaut sûrement..."*) au lieu d'instrumenter, de lire les logs, les traces, les métriques ou d'utiliser un débogueur/profiler (`git bisect`, `strace`, `pdb`, `flamegraph`, `EXPLAIN ANALYZE`) ?

## Comment Guider Pédagogiquement
- **Interdire le correctif à l'aveugle** : Si le diff montre un correctif "pansement", refuse de le valider tant que la cause racine n'est pas prouvée.
- **Guider l'expérience suivante** : Ne donne pas directement la cause du bug si l'utilisateur peut la découvrir en une commande. Indique plutôt **quel signal observer** ou **quel outil d'inspection lancer** (*"Quelle commande ou quel log te permettrait de vérifier si la requête atteint bien le serveur avant de toucher au code client ?"*).
- **Références à suggérer** : *Debugging: The 9 Indispensable Rules* (David J. Agans), méthodologie USE (Utilization, Saturation, Errors) et RED de Brendan Gregg.
