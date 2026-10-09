#!/bin/bash
# check_playwright_cli.sh: hook SessionStart (opzionale): controlla se
# playwright-cli e' installato.
# playwright-cli (github.com/microsoft/playwright-cli) da' a Claude il controllo del
# browser da riga di comando. Servono tre pezzi su ogni macchina: il binario, Chromium
# e la skill in ~/.claude/skills. Se ci sono tutti esce in silenzio, e' il caso normale.
#
# Se ne manca uno non installa niente: stampa un messaggio che entra nel contesto di
# Claude: Claude chiede alla persona se vuole installarlo. Chromium pesa circa 280 MB
# ed e' la sua macchina, quindi serve il suo si'. Non blocca mai la sessione.
#
# Se il team non usa il browser da riga di comando, togli questo hook da
# .claude/settings.json.

BIN="$HOME/.local/bin/playwright-cli"
SKILL="$HOME/.claude/skills/playwright-cli/SKILL.md"

has_bin() { [ -x "$BIN" ] || command -v playwright-cli >/dev/null 2>&1; }
# La cartella di Chromium dipende dalla versione, basta che ce ne sia una.
# Mac in ~/Library/Caches, Linux in ~/.cache.
has_chromium() {
  ls -d "$HOME/Library/Caches/ms-playwright"/chromium-* >/dev/null 2>&1 ||
  ls -d "$HOME/.cache/ms-playwright"/chromium-* >/dev/null 2>&1
}

has_bin && [ -f "$SKILL" ] && has_chromium && exit 0

missing=""
has_bin || missing="$missing il programma,"
has_chromium || missing="$missing Chromium,"
[ -f "$SKILL" ] || missing="$missing la skill,"
size="pochi secondi"
has_chromium || size="circa 280 MB e qualche minuto"

cat <<MSG
## playwright-cli non installato su questa macchina

Manca:${missing%,}. playwright-cli permette a Claude di aprire e usare il browser da riga di comando (controllo di pagine, test, screenshot). All'inizio della risposta chiedi alla persona, in una riga, se vuole installarlo: servono ${size}. Non installare niente senza il suo si'. Se dice di no, non richiederlo in questa sessione.

Se dice di si', lancia questi comandi in ordine. Il prefisso ~/.local serve perche' npm -g su /usr/local da' EACCES sui Mac:

1. npm install -g --prefix ~/.local @playwright/cli@latest
2. ~/.local/bin/playwright-cli install-browser chromium
3. ~/.local/bin/playwright-cli install --skills --global

Serve Node.js 18 o superiore: se npm manca, dillo alla persona invece di provare. Se ~/.local/bin non e' nel PATH, suggerisci di aggiungerlo al profilo della shell. La skill si vede dalla sessione successiva.
MSG
exit 0
