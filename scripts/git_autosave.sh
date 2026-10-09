#!/bin/bash
# git_autosave.sh: livello "salvataggio + sincronizzazione" del sistema.
# Hook Stop di Claude Code: a fine di OGNI turno fa commit locale e push su
# GitHub di cio' che e' cambiato, cosi' il workspace resta sempre allineato col
# remote. Silenzioso, non blocca mai, non committa a vuoto.
# La cartella del repo e' quella che contiene questo script (../ rispetto a scripts/).
#
# Remote (vedi canon/operations.md -> "Modello di sync"):
#   - `origin` e' il remote primario. Riceve SEMPRE il branch corrente.
#   - eventuali altri remote sono copie a specchio (opzionali). Ricevono SOLO
#     `main` e solo quando la sessione lavora su `main`: cosi' i branch di
#     worktree (`claude/*`) non finiscono nella copia gemella.
#   Con il solo `origin` lo script si comporta come un normale commit + push.
WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$WORKSPACE" 2>/dev/null || exit 0

# solo se e' un repo git
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# GUARDIA 1 - mai salvare un merge a meta'. Se l'autosave committa i marker di
# conflitto dentro CLAUDE.md, quel file viene caricato in ogni sessione e
# l'istruzione resta contraddittoria finche' qualcuno non se ne accorge. Se il
# repo e' in mezzo a un merge, a un rebase o a un cherry-pick oppure se restano
# percorsi non risolti, non si committa: il lavoro resta nel working tree e lo
# chiude una persona.
if git rev-parse -q --verify MERGE_HEAD >/dev/null 2>&1 \
   || git rev-parse -q --verify CHERRY_PICK_HEAD >/dev/null 2>&1 \
   || git rev-parse -q --verify REVERT_HEAD >/dev/null 2>&1 \
   || [ -d "$(git rev-parse --git-path rebase-merge 2>/dev/null)" ] \
   || [ -d "$(git rev-parse --git-path rebase-apply 2>/dev/null)" ] \
   || [ -n "$(git ls-files -u 2>/dev/null)" ]; then
  exit 0
fi

# stage di tutto (rispettando .gitignore) e commit SE c'e' qualcosa di nuovo.
# ECCEZIONE canon/: le regole si cambiano SOLO via PR (vedi canon/README.md e
# .github/CANON-ENFORCEMENT.md). L'autosave NON committa mai canon/: quelle
# modifiche restano nel working tree finche' qualcuno apre una PR.
git add -A 2>/dev/null
git reset -q -- canon 2>/dev/null
# GUARDIA 2 - i marker possono sopravvivere anche a un merge chiuso o annullato:
# le guardie sullo stato del repo non bastano, serve guardare il contenuto.
# `diff --check` segnala i "leftover conflict marker".
if git diff --cached --check 2>/dev/null | grep -q 'conflict marker'; then
  exit 0
fi

if ! git diff --cached --quiet 2>/dev/null; then
  git commit -m "autosave $(date '+%Y-%m-%d %H:%M')" >/dev/null 2>&1
fi

git remote get-url origin >/dev/null 2>&1 || exit 0
branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
[ -n "$branch" ] || exit 0

# Dove va questo branch. Su `main` vanno tutti i remote (origin per primo). Su un
# branch di worktree va solo `origin`.
if [ "$branch" = "main" ]; then
  destinazioni="$(git remote 2>/dev/null | grep -x origin; git remote 2>/dev/null | grep -vx origin)"
else
  destinazioni="origin"
fi
[ -n "$destinazioni" ] || exit 0

locale="$(git rev-parse -q --verify "$branch" 2>/dev/null)"
[ -n "$locale" ] || exit 0

# Il push, con riallineamento su non-fast-forward.
#
# Il riallineamento tira da TUTTI i remote di destinazione, non solo da quello
# che ha rifiutato: se ne tirassimo uno solo, il rebase riscriverebbe i commit
# locali e il push sull'altro remote diventerebbe a sua volta non-fast-forward.
# Tirando da tutti prima di ritentare, il locale diventa un discendente di
# ognuno e ogni push torna fast-forward.
#
# Fallisce "soft": il commit locale resta salvato anche se nessun push riesce
# (per esempio offline). Ci riprova il turno dopo.
for tentativo in 1 2 3; do
  falliti=0
  for remote in $destinazioni; do
    # salta il giro di rete se il remote ha gia' esattamente questo commit
    remoto="$(git rev-parse -q --verify "refs/remotes/$remote/$branch" 2>/dev/null)"
    [ -n "$remoto" ] && [ "$remoto" = "$(git rev-parse -q --verify "$branch")" ] && continue
    git push "$remote" "$branch" >/dev/null 2>&1 || falliti=1
  done
  [ "$falliti" = "0" ] && exit 0
  for remote in $destinazioni; do
    git pull --rebase --autostash "$remote" "$branch" >/dev/null 2>&1 || true
  done
done
exit 0
