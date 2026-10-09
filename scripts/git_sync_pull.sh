#!/bin/bash
# git_sync_pull.sh: livello "sincronizzazione" del sistema.
# Hook SessionStart di Claude Code: a inizio sessione allinea il workspace col
# remote, se collegato. Silenzioso, non blocca mai.
# La cartella del repo e' quella che contiene questo script (../ rispetto a scripts/),
# cosi' funziona su qualsiasi macchina, ovunque sia stato clonato il repo.
#
# Fa quattro cose, nell'ordine descritto in canon/operations.md -> "Modello di sync":
#   1. rimuove gli index.lock orfani (piu' vecchi di 1 minuto)
#   2. pull --rebase --autostash dal remote primario (`origin`) sul branch corrente
#   3. (solo se ci sono altri remote, cioe' un repo a specchio) quando la sessione
#      e' su main tira dentro anche i loro commit
#   4. se sta girando da un worktree, allinea anche il checkout principale
WORKSPACE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$WORKSPACE" 2>/dev/null || exit 0

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# 1. index.lock orfani. Una vera operazione git non tiene il lock per un minuto:
# quello che resta e' il residuo di un processo morto (sessione chiusa a forza,
# macchina sospesa a meta' scrittura) e blocca ogni scrittura successiva finche'
# non lo togli a mano. La soglia di 1 minuto protegge un git davvero attivo.
COMMON="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)"
if [ -n "$COMMON" ] && [ -d "$COMMON" ]; then
  find "$COMMON" -name index.lock -mmin +1 -delete 2>/dev/null || true
fi

# 2. pull solo se c'e' un remote configurato
if git remote get-url origin >/dev/null 2>&1; then
  branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  git pull --rebase --autostash origin "$branch" >/dev/null 2>&1 || true

  # 3. repo a specchio (opzionale): con un solo remote il ciclo non fa niente.
  # Si tirano dentro gli altri remote solo su main. Da un worktree su un branch
  # `claude/*` non si tocca main: lo fa la prima sessione che parte da main.
  if [ "$branch" = "main" ]; then
    for remote in $(git remote 2>/dev/null | grep -vx origin); do
      git pull --rebase --autostash "$remote" main >/dev/null 2>&1 || true
    done
  fi

  # 4. se siamo in un worktree, il cervello vero sta nel checkout principale:
  # allinealo in fast-forward cosi' le letture di canon/, signals/ e decisions/
  # non partono da uno stato vecchio.
  if [ -n "$COMMON" ]; then
    MAIN="$(dirname "$COMMON")"
    if [ "$MAIN" != "$WORKSPACE" ] && [ -d "$MAIN/.git" ]; then
      git -C "$MAIN" pull --ff-only >/dev/null 2>&1 || true
    fi
  fi
fi
exit 0
