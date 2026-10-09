# Guida all'adozione

Per il team che prende questo template e lo trasforma nel proprio cervello aziendale. L'onboarding delle persone che arrivano dopo sta in [`ONBOARDING.md`](ONBOARDING.md); qui c'è quello che serve a chi lo mette in piedi.

---

## 1. Cos'è

Un cervello aziendale in Markdown e Git: un repo privato in cui vivono le regole, i fatti, le decisioni e la memoria degli eventi dell'azienda, scritti in file di testo che le persone e gli agenti AI leggono allo stesso modo. Claude Code lo apre come cartella di lavoro e, grazie a `CLAUDE.md` e agli hook, parte ogni sessione con il contesto giusto: chi siete, come parlate, cosa è stato deciso, cosa è rimasto aperto ieri.

La struttura si ispira al modello **"AI-Native Company"**: canon prescrittivo modificabile solo via PR, signal append-only, entità collegate da wikilink, il repo come unico contesto condiviso fra persone e agenti. Questa versione nasce dall'uso quotidiano in un team reale e aggiunge:

- il **protocollo di sessione** (`session-start` e `session-end`) con il registro dei thread aperti;
- la cartella **`decisions/`**, separata dal canon;
- il **perimetro dei file** per macchina, imposto da un hook;
- l'autosave con le guardie contro i merge a metà e i marker di conflitto;
- le regole di scrittura per i testi in italiano.

---

## 2. La filosofia in cinque principi

1. **Un solo contesto per persone e agenti.** Se una regola sta in una chat, in una nota personale o nella testa di qualcuno, l'agente non la conosce. Se sta nel repo, la conoscono tutti. Il repo è il posto dove il contesto aziendale esiste.
2. **Ogni cosa ha un posto solo.** La regola nel canon, il ragionamento in `decisions/`, l'evento in `signals/`, lo stato vivo nel suo strumento. Due copie della stessa cosa sono una che si aggiorna e una che invecchia.
3. **Le regole importanti passano da un secondo paio d'occhi.** Il canon si cambia solo via PR. Tutto il resto va su `main` in push diretto, perché la velocità conta più del controllo.
4. **Quello che deve succedere sempre lo fa un hook.** Una regola in prosa è un prompt che il modello può saltare; un hook gira ogni volta. Sync, perimetro, ripresa dei thread aperti sono hook per questo motivo.
5. **Il cervello vale quanto è fresco.** Un repo che smette di ricevere signal diventa un archivio. Il protocollo di sessione esiste per far entrare il presente senza che qualcuno debba ricordarsene.

---

## 3. Perché esiste ogni livello

| Livello | A cosa serve | Cosa succede se manca |
|---|---|---|
| `canon/` | Le regole che governano ogni output: identità, voce, esclusioni, procedure. | Ogni sessione improvvisa tono e paletti: due persone ottengono risposte diverse alla stessa domanda. |
| Entità (`people/`, `companies/`, `themes/` e le altre) | Nodi stabili a cui agganciare tutto il resto, con alias per riconoscere i nomi. | Gli agenti sbagliano nomi e ruoli; nessuno ricostruisce cosa è successo con un cliente. |
| `signals/` | La memoria degli eventi, datata e con la fonte. | Il cervello sa le regole ma non sa cosa sta succedendo. |
| `signals/aperto.md` | La lista dei fili lasciati a metà, letta a ogni avvio. | Quello che non è stato finito evapora fra una sessione e l'altra. |
| `decisions/` | Il perché delle regole e la condizione per riaprirle. | Le stesse discussioni si rifanno ogni trimestre, oppure le regole diventano dogmi che nessuno osa toccare. |
| `objectives/`, `projects/` | L'aggancio fra il lavoro di ogni giorno e gli obiettivi del quarter. | I signal restano isolati e nessuno vede quale lavoro muove quale KR. |
| `articles/` | Le fonti esterne lette e tenute, con il TL;DR. | Lo stesso articolo si riassume tre volte da tre persone. |
| `.claude/skills/` | Le procedure ripetibili, condivise da tutto il team. | Ognuno scrive il proprio prompt e le correzioni non arrivano agli altri. |
| Memoria locale (`~/.claude/...`) | Le preferenze personali di chi lavora, sulla sua macchina. | Va bene così: è personale. Il rischio è l'opposto, cioè che contenga regole aziendali che il resto del team non vede. |
| `knowledge/` (opzionale) | Parcheggio temporaneo per i documenti che avete già. | Niente di grave: serve solo nei primi mesi. |

---

## 4. Segnaposto

Cercate e sostituite in tutto il repo (es. `grep -rl "{{" .`):

| Segnaposto | Cosa ci va | Esempio |
|---|---|---|
| `{{NOME_AZIENDA}}` | Il nome dell'azienda | Fornace |
| `{{OWNER_CANON}}` | Nome e cognome di chi possiede il canon e approva le decisioni | Giulia Verdi |
| `{{OWNER_CANON_GITHUB}}` | Il suo handle GitHub, per `CODEOWNERS` | @giuliaverdi |
| `{{REPO_URL}}` | L'URL del repo privato | github.com/fornace/cervello |
| `{{CARTELLA_REPO}}` | Il nome della cartella locale suggerita | cervello |
| `{{DOCS_SYSTEM}}` | Lo strumento dei documenti e degli OKR vivi | Notion, Confluence, Coda |
| `{{CHAT_TOOL}}` | La chat del team | Slack, Google Chat, Teams |
| `{{CRM}}` | Il CRM | HubSpot, Pipedrive, Attio |
| `{{FUSO_ORARIO}}` | Il fuso di riferimento | Europe/Rome |
| `{{LINGUA}}` | La lingua di lavoro del repo | italiano |

I commenti HTML `<!-- ... -->` e le righe in corsivo dentro i file del canon sono istruzioni: si cancellano quando la sezione è compilata.

---

## 5. Come si popola, in ordine

L'ordine conta: ogni passo si appoggia su quello prima. Non serve finire tutto in un giorno, serve partire dal punto giusto.

### Passo 0. Il repo (mezz'ora)

1. Create un repo **privato** nell'organizzazione GitHub e copiateci questa cartella.
2. Sostituite i segnaposto (sezione 4).
3. Configurate la protezione del canon su GitHub ([`.github/CANON-ENFORCEMENT.md`](.github/CANON-ENFORCEMENT.md)).
4. Aprite Claude Code nella cartella, riavviatelo e controllate che a inizio sessione compaia il blocco "Ripresa sessione": vuol dire che gli hook girano.

### Passo 1. `canon/profile.md` e `canon/company-rules.md` (la prima settimana)

Sono il fondamento: ogni altro file e ogni output ci si appoggia. Li scrive chi possiede il canon, perché sono identità e non procedura.

- **`profile.md`**: i fatti. Nome, mercato, leadership, team lead, strumenti, missione, temi dell'anno.
- **`company-rules.md`**: identità, posizionamento, voce, valori, esclusioni. Le sezioni su esclusioni, ordine di verità, dati cliente e perimetro arrivano già compilate: leggetele e adattatele, non svuotatele.

Un trucco che funziona: fate un'intervista con Claude ("fammi le domande per compilare `profile.md`, una alla volta") e poi rivedete il testo a mano.

### Passo 2. `canon/operating-system.md` e i team (seconda settimana)

- Decidete se il modello OKR → Progetto → Attività → Task vi va bene. Se lavorate in un altro modo, riscrivete il file tenendo la struttura.
- Per ogni team: `canon/team/<team>.md` da [`canon/team/_TEMPLATE.md`](canon/team/_TEMPLATE.md) (lo scrive il lead) e `team/<team>/<team>.md` da [`team/_TEMPLATE/_TEMPLATE.md`](team/_TEMPLATE/_TEMPLATE.md).
- Compilate la tabella di instradamento in `canon/operations.md` → "Caricamento delle regole per task".
- Compilate la tabella "Fonti di verità esterne" in `canon/anatomy.md`.

### Passo 3. Le entità (seconda e terza settimana)

1. **`companies/<azienda>.md`** con `is_self: true`.
2. **`people/`**: una scheda per ogni persona interna, con scope, anti-scope e autorità decisionale. Lo slug del file deve coincidere con `git config user.name` di quella persona (in minuscolo con i trattini). Per chi scrive a nome dell'azienda, la sezione "Come scrivo".
3. **`objectives/`** del quarter in corso e **`projects/`** dei progetti attivi, con il puntatore al docs system.
4. Le tassonomie (`themes/`, `industries/`, `systems/`, `job-titles/`) **non si pre-popolano**: nascono quando un signal, un articolo o un cliente ne ha bisogno. Fanno eccezione i temi su cui sapete già di lavorare: tre o quattro bastano.
5. Le aziende e le persone esterne nascono alla prima menzione, dal CRM.

### Passo 4. Le prime decisioni

Quando scrivete il canon emergono regole che hanno una storia ("niente sconti a gennaio", "la metrica di attivazione è X"). Per ognuna, una decisione in `decisions/` con le alternative scartate e la condizione di riapertura; il canon poi la cita. Non serve ricostruire il passato: partite dalle tre o quattro regole su cui la gente discute di più. Se la data esatta non è nota, il file la dichiara ("registrata il <data>, decisione presa in <fonte>").

### Dal giorno uno: i signal

Non aspettate che il canon sia finito. Dal primo giorno ogni blocco di lavoro con Claude si chiude con `/session-end`: ogni call o analisi che conta diventa un signal. Il cervello comincia a valere quando contiene il presente, non quando le regole sono perfette.

### Dopo il primo mese

- `canon/icp.md` e `canon/competition.md`, quando avete dati veri (interviste, conversioni, analisi dei concorrenti).
- Le prime skill del team con `skill-creator`, partendo dai compiti che qualcuno fa ogni settimana.
- Lo svuotamento di `knowledge/`, se l'avete usato.

---

## 6. Gli hook: cosa fanno

Registrati in [`.claude/settings.json`](.claude/settings.json), script in [`scripts/`](scripts/).

| Momento | Script | Cosa fa | Se lo togliete |
|---|---|---|---|
| Prima di ogni strumento (PreToolUse) | `guard_perimetro.sh` | Blocca letture, scritture e comandi fuori dal perimetro dichiarato. | Claude può aprire qualsiasi file del computer. |
| Inizio sessione | `git_sync_pull.sh` | Toglie i lock orfani, fa `pull --rebase`, allinea il checkout principale se si lavora da un worktree. | Si lavora su una copia vecchia. |
| Inizio sessione | `session_context.sh` | Stampa i thread aperti di chi lavora, la freschezza del cervello e i promemoria di sessione. | La ripresa dipende dalla memoria delle persone. |
| Inizio sessione | `check_playwright_cli.sh` | (Opzionale) Se manca playwright-cli, fa chiedere a Claude se installarlo. | Niente: se non vi serve il browser da riga di comando, toglietelo. |
| Fine di ogni turno (Stop) | `git_autosave.sh` | Commit e push di quello che è cambiato, `canon/` escluso; non committa a metà di un merge o con marker di conflitto. | Il lavoro resta sul computer di chi l'ha fatto finché qualcuno non pusha a mano. |

Le permission `deny` sulle chiavi (`~/.ssh`, `~/.aws`, `~/.gnupg`) sono una seconda barriera per tutti.

Requisiti sulle macchine: `bash`, `git`, `python3` (gli hook funzionano anche senza, con controlli più grezzi). Testati su macOS; su Linux il perimetro tratta `/home` e `/media`, `/mnt` come `/Users` e `/Volumes`.

---

## 7. Personalizzare il perimetro

Il perimetro è **per macchina** e lo decide chi la usa:

- **Default**: il repo, `~/.claude`, le cartelle di sistema e temporanee. Tutto il resto della home è chiuso.
- **Allargamento**: si copia [`.claude/perimetro.local.example`](.claude/perimetro.local.example) in `.claude/perimetro.local` e si scrivono le cartelle, una per riga. Il file è in `.gitignore`.
- **Tutto il computer**: basta scrivere la propria home. Ha senso per chi usa Claude Code anche per il lavoro personale e vuole che apra ogni file che nomina.
- **`privato/`**: qualsiasi cartella con questo nome resta chiusa finché non sta sotto un percorso dichiarato. È pensata per la knowledge base personale di chi lavora, che non deve mai finire nel repo.

Se volete cambiare il comportamento per tutti (per esempio aprire di default una cartella condivisa del team), cambiate `scripts/guard_perimetro.sh` con una PR: è una regola del canon.

---

## 8. Opzioni avanzate

### Repo a specchio

Se qualcuno vuole una seconda copia del repo (per esempio una copia personale con una storia più lunga), aggiunge un secondo remote sul proprio computer. Gli hook se ne accorgono da soli: tirano da tutti i remote e pushano `main` su ognuno, mentre i branch di worktree vanno solo su `origin`. Chi ha un solo remote non nota niente. Dettaglio in [`canon/operations.md`](canon/operations.md) → "Repo a specchio".

### Altri agenti

Il cervello non dipende da Claude: è Markdown e Git. Per un altro agente si crea `AGENTS.md` come copia speculare di `CLAUDE.md`. Gli hook però sono di Claude Code: con un altro agente sync e perimetro vanno ricostruiti con i suoi meccanismi.

### Editor Markdown

Obsidian (o un editor simile) aperto sulla cartella del repo mostra il grafo dei wikilink e i campi del frontmatter come sezioni. Le persone possono modificare e committare in locale; il push lo fa Claude Code alla sessione successiva. Il pulsante Push dell'editor non si usa.

---

## 9. Cosa si adatta e cosa no

**Si adatta liberamente**: il contenuto di tutto il canon, i team, la tabella delle fonti, il modello operativo, le skill, le regole di voce, la lingua.

**Si cambia solo con una ragione forte, via PR**: la tassonomia delle cartelle, il formato del frontmatter dei signal, la forma delle righe di `signals/aperto.md` (l'hook le cerca con quel pattern), i nomi dei campi di relazione (le skill li leggono).

**Non si toglie**: la regola "canon solo via PR", le esclusioni sui dati personali e sulle credenziali, il vincolo "decisioni mai in autonomia". Sono quelle che rendono il repo affidabile per chi ci lavora sopra.

---

## 10. Errori comuni

- **Riempire il canon di stato operativo.** Numeri della settimana, stato di una campagna, pipeline: invecchiano in giorni. Il canon tiene regole e fatti stabili, lo stato sta nei signal o nel suo strumento.
- **Pre-popolare le tassonomie.** Trenta temi creati il primo giorno, nessuno usato. I nodi nascono quando servono.
- **Saltare `session-end`.** È il passo che costa di più ricordarsi e quello che rende il cervello vivo. Se il team lo salta, dopo tre settimane l'hook dirà "cervello stantio" a ogni avvio.
- **Un registro dei thread aperti che diventa un backlog.** Ci vanno solo le cose che Claude può riprendere. Task delle persone e decisioni stanno altrove; sopra le 40 righe si pota.
- **Decisioni scritte dall'agente da solo.** Una decisione che nessuno ha preso avvelena tutto quello che sta a valle. Il sì dell'owner è obbligatorio.
- **Skill nella cartella personale.** Una skill in `~/.claude/skills/` la vede solo chi l'ha scritta. Le skill del team stanno in `.claude/skills/` nel repo.
- **Correggere un output senza correggere la skill.** Il feedback su come una skill produce l'output va nella skill, nella stessa sessione, altrimenti l'errore torna per tutti.
- **Deliverable nel repo.** Deck, PDF, bozze di email e pagine per un pubblico vivono nel loro strumento. Nel repo va la conoscenza.
- **`git config user.name` diverso dallo slug in `people/`.** I thread aperti non compaiono a chi li possiede e i signal non si firmano bene.
- **Protezione del branch troppo stretta.** "Require a pull request" su tutto `main` blocca l'autosave. Serve solo lo status check del canon (vedi `.github/CANON-ENFORCEMENT.md`).

---

## 11. Checklist della prima settimana

**Giorno 1**
- [ ] Repo privato creato, template copiato, segnaposto sostituiti
- [ ] Protezione del canon configurata su GitHub e `CODEOWNERS` compilato
- [ ] Claude Code aperto nel repo, hook verificati (compare "Ripresa sessione")
- [ ] `git config user.name` impostato per chi adotta

**Giorni 2-3**
- [ ] `canon/profile.md` compilato
- [ ] `canon/company-rules.md` compilato: identità, posizionamento, voce, valori, esclusioni rilette
- [ ] `companies/<azienda>.md` con `is_self: true`
- [ ] Primo `/session-end` con un signal vero

**Giorni 4-5**
- [ ] `canon/operating-system.md` confermato o riscritto
- [ ] Un `canon/team/<team>.md` e un `team/<team>/<team>.md` per ogni team
- [ ] `people/` con le persone interne, slug coerenti con `git config user.name`
- [ ] `objectives/` del quarter e `projects/` attivi, con i puntatori al docs system
- [ ] Tabella delle fonti in `canon/anatomy.md` e di instradamento in `canon/operations.md`
- [ ] Le prime due o tre decisioni in `decisions/`, citate dal canon
- [ ] `ONBOARDING.md` rivisto e mandato alle prime persone del team
- [ ] Connettori MCP abilitati da chi li usa

**Alla fine della settimana**
- [ ] Almeno un signal al giorno in `signals/manual/`
- [ ] `/session-start` restituisce i thread aperti giusti a chi apre la sessione
- [ ] Una persona diversa da chi ha adottato ha aperto il repo e ha ottenuto una risposta corretta su "come parliamo ai clienti?"

---

## 12. Come capire se sta funzionando

- Una persona nuova chiede a Claude "come lavoriamo?" e la risposta è quella che darebbe chi guida l'azienda.
- A inizio sessione l'hook non dice "cervello stantio".
- Le discussioni già chiuse si chiudono citando un file di `decisions/`.
- Le correzioni a un output compaiono come commit su una skill, non solo come messaggi in chat.
- Il registro dei thread aperti resta sotto le 40 righe.
