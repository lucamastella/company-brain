# Cervello aziendale · template

Lo scheletro di un cervello aziendale in Markdown e Git: un repo che le persone del team e gli agenti AI (Claude Code in primis) leggono allo stesso modo. Dentro trovi la struttura delle cartelle, le regole, gli hook che tengono il repo sincronizzato e protetto, le skill per aprire e chiudere le sessioni di lavoro. Il contenuto lo metti tu.

## Cosa c'è

| Percorso | A cosa serve |
|---|---|
| [`GUIDA-ADOZIONE.md`](GUIDA-ADOZIONE.md) | Per chi adotta il template: filosofia, ordine di popolamento, hook, errori comuni, checklist della prima settimana. **Parti da qui.** |
| [`ONBOARDING.md`](ONBOARDING.md) | Per chi entra nel team dopo l'adozione: setup, regole, giro di una giornata, troubleshooting. |
| [`CLAUDE.md`](CLAUDE.md) | Il file che Claude Code carica a ogni sessione: smistamento della memoria, ordine di verità, protocollo di sessione. |
| [`index.md`](index.md) | L'indice di tutto il repo. |
| [`canon/`](canon/) | Il livello prescrittivo: identità, regole, procedure, forma del grafo, fatti sull'azienda. Si cambia via PR. |
| `people/`, `companies/`, `themes/` e le altre cartelle entità | I nodi del grafo, collegati con wikilink. Ogni cartella ha il suo README e un `_TEMPLATE.md`. |
| [`signals/`](signals/) | Cosa è successo: recap, note, digest. Append-only. Più il registro dei thread aperti. |
| [`decisions/`](decisions/) | Una decisione chiusa per file, con alternative scartate e condizione di riapertura. |
| [`scripts/`](scripts/) e [`.claude/settings.json`](.claude/settings.json) | Gli hook: sync Git, perimetro dei file, ripresa di sessione. |
| [`.claude/skills/`](.claude/skills/) | Le skill di base: `session-start`, `session-end`, `focus`, `consolidate-memory`, `skill-creator`. |
| [`.github/`](.github/) | CODEOWNERS e il workflow che segnala i push diretti sul canon. |

## Partenza in quattro passi

1. Clona o copia questa cartella in un repo **privato** della tua organizzazione.
2. Cerca e sostituisci i segnaposto `{{...}}` (elenco in [`GUIDA-ADOZIONE.md`](GUIDA-ADOZIONE.md) → "Segnaposto").
3. Compila `canon/profile.md` e `canon/company-rules.md`, poi segui l'ordine della guida.
4. Apri Claude Code dentro la cartella, riavvialo una volta (hook e skill si caricano all'avvio) e lancia `/session-start`.

## Ispirazione

La struttura (canon, signals, entità collegate da wikilink, canon modificabile solo via PR) si ispira al modello "AI-Native Company". Questa versione aggiunge il protocollo di sessione, il registro dei thread aperti, la cartella delle decisioni, il perimetro dei file per macchina e le regole di scrittura in italiano.

Nato dal cervello di [Learnn](https://learnn.com), che lo usa ogni giorno per far lavorare insieme il team e Claude Code.

## Licenza

Il template è distribuito con licenza MIT (file `LICENSE`).
La skill `skill-creator` in `.claude/skills/skill-creator/` è distribuita con licenza Apache 2.0: il file `LICENSE.txt` va tenuto insieme alla skill.
