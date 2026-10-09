#!/bin/bash
# guard_perimetro.sh: livello "confine" del sistema.
# Hook PreToolUse di Claude Code: blocca ogni tool che prova a leggere, scrivere
# o eseguire qualcosa FUORI dal perimetro di lavoro (il repo del team, la
# cartella ~/.claude e le cartelle dichiarate a mano).
#
# Perche' esiste: sul computer di chi lavora ci sono file personali e file di
# clienti che non c'entrano con l'azienda. Basta un "aprimi quel file nei
# Download" detto a meta' per far leggere a Claude qualcosa che non doveva. Il
# perimetro va imposto, non chiesto per cortesia.
#
# Perche' un hook e non solo una regola scritta: una regola in prosa e' un prompt
# che il modello puo' saltare, l'hook viene eseguito a ogni chiamata di tool e
# risponde no. Vedi canon/company-rules.md -> "Perimetro dei file".
#
# Cosa e' consentito:
#   - la radice del repo (e i suoi worktree)
#   - ~/.claude (skill, memoria, impostazioni di Claude Code)
#   - i percorsi elencati in .claude/perimetro.local (uno per riga, fuori da git);
#     il file si cerca prima nel checkout corrente, poi in quello principale del
#     repo, cosi' i worktree ereditano il perimetro della macchina
#   - tutto cio' che sta fuori dalle home e dai dischi montati: /tmp, /usr, /opt,
#     /Applications e simili, cioe' sistema e scratchpad, non dati di persone
# Cosa e' vietato salvo dichiarazione:
#   - il resto della propria home, le home di altre persone (/Users, /home), i
#     dischi esterni e le condivisioni (/Volumes, /media, /mnt)
#   - qualsiasi cartella `privato/` (knowledge base personale di chi lavora):
#     si apre solo se sta sotto un percorso dichiarato in perimetro.local, cioe'
#     sulla macchina di chi la possiede; il suo contenuto non si copia mai nel
#     repo ne' altrove
#
# Il perimetro e' per macchina: chi vuole aprire tutto il proprio computer scrive
# la propria home in perimetro.local (vedi .claude/perimetro.local.example).
#
# Esce 0 e sta zitto quando va bene; esce 2 con il motivo su stderr per bloccare.
# In caso di errore proprio non blocca mai il lavoro (exit 0).

PAYLOAD="$(cat)"
[ -n "$PAYLOAD" ] || exit 0

PROJ="${CLAUDE_PROJECT_DIR:-$PWD}"
COMMON="$(cd "$PROJ" 2>/dev/null && git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)"
if [ -n "$COMMON" ]; then REPO="$(dirname "$COMMON")"; else REPO="$PROJ"; fi

# Percorsi consentiti in piu', dichiarati da chi usa la macchina: una riga per
# cartella. Il file non va in git: e' per macchina.
EXTRA_FILE="$PROJ/.claude/perimetro.local"
[ -f "$EXTRA_FILE" ] || EXTRA_FILE="$REPO/.claude/perimetro.local"

# --- 1. Da dove guardare i percorsi -----------------------------------------
# Con python3 si leggono solo i campi che indicano un file o un comando: il
# CONTENUTO scritto (content, new_string, prompt...) non conta, altrimenti un
# documento che nomina una cartella vietata verrebbe scambiato per un accesso.
# Dentro i comandi si tolgono gli heredoc, che sono testo e non percorsi.
TESTO=""
if command -v python3 >/dev/null 2>&1; then
  TESTO="$(GUARD_PAYLOAD="$PAYLOAD" python3 -c '
import json, os, re
salta = {"content", "new_string", "old_string", "prompt", "description", "instructions", "text", "body", "message", "title"}
fuori = []
def cammina(v, k=None):
    if isinstance(v, dict):
        for kk, vv in v.items(): cammina(vv, kk)
    elif isinstance(v, list):
        for vv in v: cammina(vv, k)
    elif isinstance(v, str):
        if k in salta: return
        if k == "command":
            v = re.sub(r"<<-?\s*[\"\x27]?(\w+)[\"\x27]?[\s\S]*?\n\1", " ", v)
        fuori.append(v)
try:
    d = json.loads(os.environ.get("GUARD_PAYLOAD", "{}"))
except Exception:
    raise SystemExit(0)
cammina(d.get("tool_input") or {})
print("\n".join(fuori))
' 2>/dev/null)"
fi
# Senza python3 si guarda tutto il payload: piu' grezzo, qualche falso positivo,
# ma chiuso dalla parte giusta.
[ -n "$TESTO" ] || TESTO="$PAYLOAD"

# --- 2. Candidati: solo i percorsi che possono uscire dal perimetro ----------
SEP='[:space:]"'"'"'`,;:|&()<>'
CAND="$(printf '%s\n' "$TESTO" | grep -oE "(~|\\\$HOME|/Users/[^/${SEP}]+|/home/[^/${SEP}]+|/Volumes|/media|/mnt)(/[^${SEP}]*)*" 2>/dev/null)"
REL="$(printf '%s\n' "$TESTO" | grep -oE "(\.\./)+[^${SEP}]*" 2>/dev/null)"
CAND="$(printf '%s\n%s\n' "$CAND" "$REL")"
[ -n "$(printf '%s' "$CAND" | tr -d '[:space:]')" ] || exit 0

# --- 3. Normalizzazione (~, $HOME, relativi, . e ..) -------------------------
normalizza() {
  local p="$1" out="" seg
  case "$p" in
    "~") p="$HOME" ;;
    "~/"*) p="$HOME/${p#\~/}" ;;   # \~ evita che bash espanda la tilde nel pattern
    '$HOME') p="$HOME" ;;
    '$HOME/'*) p="$HOME/${p#\$HOME/}" ;;
  esac
  case "$p" in /*) : ;; *) p="$PWD/$p" ;; esac
  local IFS=/
  for seg in $p; do
    case "$seg" in
      ""|".") : ;;
      "..") out="${out%/*}" ;;
      *) out="$out/$seg" ;;
    esac
  done
  printf '%s' "${out:-/}"
}

consentito() {
  local p="$1"
  # 1. i percorsi dichiarati da chi usa la macchina vincono su tutto, kb
  #    personale compresa: sono suoi, li apre solo lui e solo qui
  if [ -f "$EXTRA_FILE" ]; then
    local riga
    while IFS= read -r riga; do
      case "$riga" in ""|"#"*) continue ;; esac
      riga="$(normalizza "$riga")"
      case "$p" in "$riga"|"$riga"/*) return 0 ;; esac
    done < "$EXTRA_FILE"
  fi
  # 2. la kb personale non si apre senza dichiarazione, nemmeno dentro il repo
  case "$p" in */privato|*/privato/*) return 1 ;; esac
  case "$p" in
    "$REPO"|"$REPO"/*) return 0 ;;
    "$PROJ"|"$PROJ"/*) return 0 ;;
    "$HOME/.claude"|"$HOME/.claude"/*) return 0 ;;
  esac
  case "$p" in
    "$HOME"|"$HOME"/*) return 1 ;;   # resto della home: personale
    /Users/*|/home/*) return 1 ;;    # home di altre persone
    /Volumes/*|/media/*|/mnt/*) return 1 ;;  # dischi esterni, condivisioni, backup
  esac
  return 0                            # sistema e scratchpad
}

while IFS= read -r raw; do
  [ -n "$raw" ] || continue
  raw="${raw%/}"
  p="$(normalizza "$raw")"
  if ! consentito "$p"; then
    cat >&2 <<MSG
Bloccato dal perimetro del repo: $p sta fuori dalle cartelle di lavoro.
Su questo computer ci sono file personali e file di clienti che non riguardano
il lavoro del team, quindi non si leggono, non si scrivono e non si elencano.
Perimetro consentito: il repo del team, ~/.claude e le cartelle elencate in
.claude/perimetro.local. Le cartelle chiamate privato/ si aprono solo se dichiarate.
Cosa fare: chiedi alla persona di copiare il file dentro il repo, oppure di
aggiungere la cartella (o tutta la sua home) a .claude/perimetro.local. Non
aggirare questo blocco da solo. Regola: canon/company-rules.md -> "Perimetro dei file".
MSG
    exit 2
  fi
done <<< "$CAND"

exit 0
