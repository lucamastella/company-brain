#!/bin/bash
# session_context.sh: livello "ripresa" del sistema.
# Hook SessionStart di Claude Code: stampa nel contesto della sessione cosa e'
# rimasto aperto dalla volta precedente, quanto e' fresco il cervello e il
# promemoria di riconciliazione della memoria locale.
#
# Perche' un hook e non una regola scritta: lo stdout di un hook SessionStart
# entra nel contesto della sessione. Una regola in prosa e' un prompt che il
# modello puo' saltare, un hook viene eseguito ogni volta. E' l'unico modo per
# far riemergere i thread aperti senza dipendere dalla disciplina di chi apre
# la sessione. Vedi canon/operations.md -> "Protocollo di sessione".
#
# Silenzioso in caso di errore, non blocca mai, non fa rete, non scrive nulla.

# Radice del repo PRINCIPALE, anche se la sessione parte da un worktree:
# git-common-dir punta sempre al .git del checkout principale.
COMMON="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" || exit 0
[ -n "$COMMON" ] || exit 0
REPO="$(dirname "$COMMON")"
[ -d "$REPO/signals" ] || exit 0

APERTO="$REPO/signals/aperto.md"
MAX_RIGHE=12
SOGLIA_STANTIO=7

# --- thread aperti ---------------------------------------------------------
# Si legge SOLO la sezione "## Aperto", non tutto il file: altrimenti gli esempi
# dentro le istruzioni del registro finirebbero contati come thread veri.
righe=""
n=0
if [ -f "$APERTO" ]; then
  righe="$(awk '
    /^## Aperto[[:space:]]*$/ { dentro=1; next }
    /^## / { dentro=0 }
    dentro && /^- \[ \] / { print }
  ' "$APERTO" 2>/dev/null)"
  [ -n "$righe" ] && n="$(printf '%s\n' "$righe" | wc -l | tr -d ' ')"
fi

# --- freschezza: dalla data nel nome file, non dal mtime (un clone resetta i
# mtime e la freschezza risulterebbe sempre "oggi") ------------------------
ultimo="$(find "$REPO/signals" -type f -name '*_20??-??-??.md' 2>/dev/null \
  | sed -E 's/.*_([0-9]{4}-[0-9]{2}-[0-9]{2})\.md$/\1/' | sort | tail -1)"
giorni=""
if [ -n "$ultimo" ]; then
  giorni="$(python3 -c 'import sys,datetime
a=datetime.date.fromisoformat(sys.argv[1])
print((datetime.date.today()-a).days)' "$ultimo" 2>/dev/null)"
fi

# --- output ----------------------------------------------------------------
echo "## Ripresa sessione (hook SessionStart)"
echo

if [ "$n" -gt 0 ]; then
  # Il registro e' condiviso da tutto il team: prima i thread di chi apre la
  # sessione, poi il conteggio degli altri. Lo slug si ricava dal nome git
  # ("Giulia Verdi" -> "giulia-verdi", lo stesso di people/<slug>.md).
  ME="$(git config user.name 2>/dev/null | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
  mie=""
  altre=""
  if [ -n "$ME" ]; then
    mie="$(printf '%s\n' "$righe" | grep -F "@$ME" 2>/dev/null)"
    altre="$(printf '%s\n' "$righe" | grep -vF "@$ME" 2>/dev/null)"
  fi

  if [ -n "$mie" ]; then
    nmie="$(printf '%s\n' "$mie" | wc -l | tr -d ' ')"
    echo "Tuoi thread aperti: $nmie di $n (fonte: signals/aperto.md)"
    printf '%s\n' "$mie" | head -n "$MAX_RIGHE"
    [ "$nmie" -gt "$MAX_RIGHE" ] && echo "  ... e altri $((nmie - MAX_RIGHE)) tuoi."
    if [ -n "$altre" ]; then
      naltre="$(printf '%s\n' "$altre" | wc -l | tr -d ' ')"
      echo "  Nel registro ci sono anche $naltre thread di altri."
    fi
  else
    echo "Thread aperti nel registro: $n (nessuno assegnato a te)"
    printf '%s\n' "$righe" | head -n "$MAX_RIGHE"
    [ "$n" -gt "$MAX_RIGHE" ] && echo "  ... e altri $((n - MAX_RIGHE)). Apri signals/aperto.md."
  fi
else
  echo "Thread aperti: nessuno registrato in signals/aperto.md."
fi
echo

if [ -n "$giorni" ]; then
  if [ "$giorni" -gt "$SOGLIA_STANTIO" ]; then
    echo "Freschezza: ultimo signal $ultimo ($giorni giorni). Il cervello e' STANTIO:"
    echo "non dare per buono lo stato operativo, chiedi cosa e' cambiato prima di agire."
  else
    echo "Freschezza: ultimo signal $ultimo ($giorni giorni)."
  fi
  echo
fi

echo "Promemoria di sessione:"
echo "- Riconcilia la memoria locale col repo (canon/operations.md -> \"Riconciliazione della memoria locale a inizio sessione\"): sui temi aziendali vince il repo."
echo "- Per una ripresa ragionata dei thread aperti, esegui la skill session-start."
echo "- A fine blocco di lavoro esegui la skill session-end: scrive il signal e aggiorna signals/aperto.md."

exit 0
