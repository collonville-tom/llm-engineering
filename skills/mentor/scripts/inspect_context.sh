#!/usr/bin/env bash
# Script d'inspection rapide et itérative du contexte de travail pour le skill Mentor.
# Conçu pour fonctionner dans une boucle (Modif -> Analyse -> Conseil -> Rebouclage) :
# 1. Détecte les fichiers sauvegardés depuis le dernier passage du mentor (via fichier témoin).
# 2. Extrait l'état Git, les commits récents et le diff des fichiers suivis (sans crash SIGPIPE 141).
# 3. Inspecte les nouveaux fichiers non suivis (untracked) en filtrant les fichiers binaires.

set -euo pipefail

PROJECT_ROOT=$(pwd)
PROJECT_HASH=$(printf "%s" "$PROJECT_ROOT" | shasum | cut -c1-8)
MARKER_FILE="/tmp/.mentor_last_run_${PROJECT_HASH}"

echo "=== 1. RÉPERTOIRE COURANT ==="
echo "$PROJECT_ROOT"
echo ""

echo "=== 2. DELTA D'ITÉRATION (DEPUIS LE DERNIER PASSAGE DU MENTOR) ==="
if [ -f "$MARKER_FILE" ]; then
    LAST_RUN_TIME=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$MARKER_FILE" 2>/dev/null || date -r "$MARKER_FILE" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "inconnu")
    echo "Dernier passage du mentor : $LAST_RUN_TIME"
    RECENT_FILES=$( (find . -maxdepth 4 -not -path '*/.*' -type f -newer "$MARKER_FILE" 2>/dev/null || true) | head -n 30 )
    if [ -n "$RECENT_FILES" ]; then
        echo "Fichiers modifiés et sauvegardés depuis le dernier conseil :"
        echo "$RECENT_FILES"
    else
        echo "⚠️ AUCUN fichier n'a été sauvegardé sur le disque depuis le dernier passage du mentor."
    fi
else
    echo "Premier passage du mentor sur cette session (aucun témoin précédent)."
fi
echo ""

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "=== 3. BRANCHE & STATUT GIT ==="
    git status -sb
    echo ""

    echo "=== 4. DERNIERS COMMITS (INTENTION HISTORIQUE RÉCENTE) ==="
    (git log -n 5 --oneline --decorate || true)
    echo ""

    echo "=== 5. STATISTIQUES DES MODIFICATIONS (TRACKED : UNSTAGED & STAGED) ==="
    git diff --stat
    git diff --cached --stat
    echo ""

    echo "=== 6. APERÇU DU DIFF DES FICHIERS SUIVIS (MAX 200 LIGNES) ==="
    (git diff HEAD || true) | head -n 200
    echo ""

    echo "=== 7. NOUVEAUX FICHIERS NON SUIVIS (UNTRACKED - APERÇU TEXTE SÉCURISÉ) ==="
    UNTRACKED_FILES=$( (git ls-files --others --exclude-standard || true) | head -n 20 )
    if [ -n "$UNTRACKED_FILES" ]; then
        COUNT=0
        while IFS= read -r file; do
            [ -z "$file" ] && continue
            COUNT=$((COUNT + 1))
            if [ -f "$file" ] && grep -Iq . "$file" 2>/dev/null; then
                LINE_COUNT=$(wc -l < "$file" | tr -d ' ')
                if [ "$COUNT" -le 5 ]; then
                    echo "--- [NOUVEAU FICHIER TEXTE] $file (${LINE_COUNT} lignes, aperçu 12 premières) ---"
                    (head -n 12 "$file" || true)
                    echo ""
                else
                    echo "--- [NOUVEAU FICHIER TEXTE] $file (${LINE_COUNT} lignes - aperçu omis pour compacité) ---"
                fi
            else
                echo "--- [FICHIER BINAIRE OU VIDE IGNORÉ] $file ---"
            fi
        done <<< "$UNTRACKED_FILES"
    else
        echo "Aucun nouveau fichier non suivi."
    fi
else
    echo "=== 3. HORS DÉPÔT GIT : FICHIERS RÉCEMMENT MODIFIÉS ==="
    (find . -maxdepth 3 -not -path '*/.*' -type f -exec ls -lt {} + 2>/dev/null || true) | head -n 15
fi

# Mise à jour du témoin pour le prochain tour de la boucle itérative
touch "$MARKER_FILE"
