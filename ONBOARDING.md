# Onboarding · il cervello di {{NOME_AZIENDA}}

Questo repo è il **cervello condiviso di {{NOME_AZIENDA}}**: conoscenza, regole, decisioni e skill in un posto solo, che le persone e Claude leggono allo stesso modo. Apri il repo con Claude Code e parti con tutto il contesto sull'azienda più le skill del team, sincronizzato via GitHub.

Questa guida ti porta da zero a operativo in una mattina.

---

## 1. Cosa ti serve (una volta)

- **Claude Code** installato (terminale, app desktop o estensione dell'editor).
- **Git** e **GitHub CLI** (`gh`). Su Mac: `brew install git gh`. Su Linux usa il gestore di pacchetti della distribuzione.
- **Python 3** (lo usano gli hook; sui Mac recenti c'è già).
- **Accesso al repo privato** `{{REPO_URL}}`: te lo dà {{OWNER_CANON}} o chi amministra l'organizzazione su GitHub.
- (Facoltativo) un **editor Markdown** come Obsidian, per navigare il grafo dei wikilink.

---

## 2. Setup (cinque minuti)

```bash
cd <cartella-dove-tieni-i-progetti>
git clone {{REPO_URL}}.git {{CARTELLA_REPO}}
cd {{CARTELLA_REPO}}
gh auth login
#   rispondi: GitHub.com → HTTPS → Yes → Login with a web browser
git config user.name "Nome Cognome"
```

Il nome in `git config user.name` conta: gli hook e le skill lo trasformano nel tuo slug (`nome-cognome`) per riconoscere i tuoi thread aperti e firmare i tuoi signal. Deve corrispondere al tuo file in `people/`. Se il file non c'è, chiedi a chi guida il tuo team di crearlo.

Poi apri Claude Code dentro la cartella e **riavvialo una volta**: skill e hook si caricano all'avvio.

### 2.1 Perimetro dei file

Per default Claude legge, scrive e cerca solo dentro il repo e dentro `~/.claude`. Download, Documenti, Scrivania e il resto del tuo computer restano fuori, insieme ai file dei tuoi clienti e alle tue cose personali. Se vuoi aprire di più, copia `.claude/perimetro.local.example` in `.claude/perimetro.local` e scrivi le cartelle, una per riga, fino a tutta la tua home se ti va bene così. Il file resta sul tuo computer e non finisce in git. A imporlo è un hook (`scripts/guard_perimetro.sh`): non devi ricordartelo tu e Claude non può allargarlo da solo.

### 2.2 Connettori MCP (sul tuo account, non nel repo)

Diverse skill leggono da strumenti esterni. I connettori sono legati al **tuo** account Claude, quindi li abiliti tu, in claude.ai → Impostazioni → Connettori oppure con `/mcp` in Claude Code.

| Connettore | Serve per |
|---|---|
| {{DOCS_SYSTEM}} | stato vivo di OKR, progetti, card settimanale, documenti |
| {{CHAT_TOOL}} | recap, ricerca di cosa è stato detto, skill `focus` |
| {{CRM}} | creare le schede di clienti e contatti (`crm_url`), note sui deal |
| Posta e calendario | digest email, bozze, skill `focus` |
| Archivio file (es. Drive) | fogli, PDF, deck |
| Analytics | numeri di prodotto e funnel |
| <!-- altri --> | |

Senza il connettore, la skill che lo usa si ferma al primo passo e te lo dice. Abilita quelli che ti servono.

### 2.3 Credenziali (mai nel repo)

Chiavi, token e password non entrano in git, per regola ([`canon/company-rules.md`](canon/company-rules.md) → "Cosa il sistema non deve mai fare"). Se una skill ha bisogno di un token, lo legge da un file `*.local.md` o da una variabile d'ambiente sulla tua macchina: quei file sono esclusi da `.gitignore`. Il token te lo crei tu coi permessi minimi: in chat non si incolla.

---

## 3. Com'è fatto il cervello

| Cartella | Cosa contiene |
|---|---|
| `canon/` | Il livello prescrittivo: identità, voce, regole, come lavora l'azienda, i team. Si cambia solo via PR. |
| `signals/` | Cosa è successo: recap, note di call, digest email, analisi. Datati, si aggiungono e non si riscrivono. |
| `signals/aperto.md` | Il registro dei thread lasciati a metà, per persona. |
| `decisions/` | Una decisione chiusa per file: cosa è stato deciso, cosa scartato, perché, quando si riapre. |
| `objectives/`, `projects/` | I nodi stabili di OKR e progetti globali, che puntano al docs system per lo stato vivo. |
| `people/`, `companies/`, `themes/`, `industries/`, `systems/` e le altre | Le entità, collegate con wikilink `[[slug]]`. |
| `articles/` | Le fonti esterne analizzate, con un TL;DR. |
| `.claude/skills/` | Le skill del team, richiamabili come `/nome`. |
| `scripts/` | Gli hook: sync Git, perimetro dei file, ripresa di sessione. |

### Ordine di verità

Quando due file dicono cose diverse vince, nell'ordine:
1. `canon/company-rules.md` (identità, voce, esclusioni)
2. `canon/operations.md` → `operating-system.md` → `anatomy.md` → `profile.md` → `canon/team/`
3. le skill in `.claude/skills/`
4. lo stato operativo: `signals/` (contesto fresco, non scavalca il canon)
5. la tua memoria personale, che resta sul tuo computer

### Come lavora {{NOME_AZIENDA}}

Il modello è **OKR → Progetto → Attività → Task**. Objective e progetti sono globali e per scope, mai di un team: i team eseguono le Attività. Lo stato vivo (valori dei KR, status, avanzamento) sta su {{DOCS_SYSTEM}}, il repo tiene i nodi stabili che ci puntano. Dettaglio in `canon/operating-system.md`.

---

## 4. Il giro di una giornata

- **Apri con `/session-start`**: ti dice cosa era rimasto aperto, cosa è cambiato, cosa è già stato deciso. È di sola lettura.
- **(Facoltativo) `/focus`**: il punto della giornata, con le due o tre cose a ritorno più alto nel tempo che resta.
- **Lavori.** Chiedi contesto ("qual è la strategia commerciale di questo quarter?"), usi le skill, produci deliverable.
- **Chiudi con `/session-end`**: scrive un signal in `signals/manual/AAAA/MM/` con cosa è stato fatto, deciso e lasciato a metà, poi aggiorna `signals/aperto.md`. Senza questo, la sessione di domani non sa dove ti sei fermato.
- **Salvare al volo:** scrivi "salva questo: ..." (oppure "ricorda", "segna", "appunta") e Claude lo mette nel file giusto, dicendoti dove.

### Sync automatico

- A **inizio sessione** un hook fa `git pull --rebase`: ricevi il lavoro degli altri.
- A **fine di ogni turno** un hook fa commit e push: quello che produci finisce subito su GitHub. Se nel frattempo ha pushato qualcun altro, si riallinea da solo.
- L'autosave **non committa mai `canon/`**: quelle modifiche restano sul tuo computer finché non apri una PR.

---

## 5. Le regole che contano

1. **Il canon si cambia via Pull Request.** `canon/` ha un proprietario (`.github/CODEOWNERS`): se una regola va cambiata, apri una PR e falla revisionare. Il workflow `canon-guard` segnala i push diretti.
2. **Le decisioni non si scrivono in autonomia.** In `decisions/` entra solo ciò che {{OWNER_CANON}} ha confermato. Claude propone il candidato, la persona dice sì.
3. **Riusa prima di creare.** Prima di aprire un file nuovo, controlla se il tema sta già in uno esistente e aggiornalo.
4. **Ogni affermazione con la sua fonte.** Se una fonte manca, si dice che manca.

---

## 6. Cosa non fare

- Niente **credenziali** nel repo: chiavi, token e password stanno fuori, anche dai messaggi di commit e dai nomi dei branch.
- Niente **valori di contratto, clausole NDA o prezzi personalizzati** di un cliente negli output.
- Niente **dati personali** di nessuno: salute, vita privata, valutazioni, compensi.
- Niente **grezzo**: chat e trascrizioni restano nei loro strumenti, qui va la sintesi curata.
- Niente **deliverable binari** (deck, PDF, fogli): restano nel loro strumento. I deliverable testuali durevoli vanno in `signals/`.
- Niente **skill in `~/.claude/skills/`**: le skill del team stanno in `.claude/skills/` dentro il repo, così le ricevono tutti.
- Non usare la **chat normale di Claude** per far girare il sistema: senza Claude Code non ci sono hook, file e sync.
- Il repo è privato e contiene informazioni aziendali: **non condividerlo** fuori dal team.

---

## 7. Se qualcosa non va

- **Una skill `/nome` non si trova** → riavvia Claude Code, le skill si leggono all'avvio.
- **Non vedi la cartella `.claude` nel Finder** → `Cmd + Shift + .` mostra i file nascosti.
- **Il lavoro degli altri non arriva oppure il tuo non arriva su GitHub** → controlla `gh auth status`; se serve, rifai `gh auth login`.
- **Claude dice "Bloccato dal perimetro del repo"** → il file sta fuori dal perimetro: copialo nel repo oppure aggiungi la cartella a `.claude/perimetro.local`.
- **I tuoi thread aperti non compaiono a inizio sessione** → `git config user.name` non corrisponde allo slug usato nel registro (`@nome-cognome`).
- **Git dice "another git process seems to be running"** → c'è un lock orfano: lo toglie l'hook al prossimo avvio, oppure `find .git -name index.lock -mmin +1 -delete`.
- **Una skill si blocca dicendo che manca uno strumento** → ti manca il connettore MCP, torna al punto 2.2.
- **Dubbi** → chiedi a Claude Code "come funziona questo workspace?", oppure a {{OWNER_CANON}}.
