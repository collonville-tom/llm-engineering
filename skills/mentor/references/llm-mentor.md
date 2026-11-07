# Grille Mentor : Ingénierie LLM, Prompts & Systèmes Agentiques

## Objectif Pédagogique
Accompagner l'utilisateur dans la conception de prompts, de skills, de règles (`GEMINI.md`/`CLAUDE.md`) et d'architectures agentiques robustes, en maîtrisant l'ingénierie du contexte (*Context Engineering*), les biais des modèles et l'évaluation empirique.

## Axes d'Analyse (Checklist AI / LLM Engineer)

1. **Économie d'Attention & Gestion du Contexte (Context Rot / Lost in the Middle)**
   - Le prompt ou le skill souffre-t-il de surcharge cognitive pour le modèle (instructions contradictoires, redondances, règles noyées au milieu d'un texte massif) ?
   - **Progressive Disclosure** : Les connaissances volumineuses ou conditionnelles sont-elles déportées dans des fichiers `references/` ou des scripts exécutables plutôt qu'injectées systématiquement ?
   - **Déclenchement (`description` du frontmatter)** : Dans un skill, le champ `description` est-il rédigé à la 3e personne avec des déclencheurs explicites ("À utiliser lorsque...") permettant au routeur de l'agent de l'activer sans faux positifs ni faux négatifs ?

2. **Lutte contre les Biais intrinsèques des LLMs (RLHF & Sycophantie)**
   - Le prompt laisse-t-il le modèle être complaisant (*sycophancy*) ou inventer des réponses quand une information manque ?
   - Y a-t-il des clauses d'**échappement explicites** (*"Si l'entrée est ambiguë ou insuffisante, arrête-toi et demande des précisions / déclare l'absence de preuves"*) ?

3. **Séparation Déterministe vs Stochastique**
   - L'utilisateur demande-t-il au LLM de réaliser une tâche qu'un script déterministe (`bash`, `python`, `jq`, regex, linter) ferait de manière $100\%$ fiable, plus rapide et moins coûteuse en tokens ?
   - Les sorties attendues sont-elles structurées (schémas Markdown stricts, JSON Schema, exemples *Few-Shot* contrastés) ?

4. **Évaluation (Evals) & Sécurité (Prompt Injection)**
   - Comment l'utilisateur vérifie-t-il que sa modification de prompt améliore réellement le comportement sur plusieurs cas (dont des cas adversariaux) et ne dégrade pas d'autres scénarios ?
   - Les entrées non fiables (données externes, fichiers analysés) sont-elles clairement délimitées des instructions système ?

## Comment Guider Pédagogiquement
- **Montrer les conflits d'instructions** : Pointe précisément deux phrases du prompt de l'utilisateur qui tirent les poids d'attention du modèle dans des directions opposées.
- **Illustrer par un contre-exemple d'entrée** : Donne un exemple de requête utilisateur qui ferait dérailler son prompt actuel (*Edge case prompt*) pour l'amener à renforcer ses contraintes.
- **Oriente vers les bonnes pratiques** : Documentation officielle Anthropic (*Prompt Engineering*, *Building Effective Agents*), Google Gemini *Context Caching & System Instructions*, *Progressive Disclosure* des Skills.
