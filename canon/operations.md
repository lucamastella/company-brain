# Operations

> Come agenti e persone lavorano dentro questo repo: procedure di scrittura, workflow, sync, disciplina sulle entità. I valori stanno in [`company-rules.md`](company-rules.md), la forma del grafo in [`anatomy.md`](anatomy.md), i fatti sull'azienda in [`profile.md`](profile.md).
>
> Quando i file sono in disaccordo, [`company-rules.md`](company-rules.md) → "Ordine di verità" decide chi vince. Questo file sta in alto nell'ordine, sotto `company-rules.md`.

<!--
COME SI COMPILA
- Quasi tutto il file è procedura generica e funziona così com'è: tienila.
- Da adattare: "Date e orari" (fuso), "Lingua", la tabella di "Caricamento delle regole per task"
  (i vostri team), "Catalogo prodotti" (dove vive il catalogo) e i nomi degli strumenti.
- Se non usate un CRM, le regole sulle entità esterne restano valide con un'altra fonte che fa da
  "certificato di nascita" (un foglio clienti, un gestionale): scrivetelo qui.
-->

---

## Postura dell'agente: proattiva, non rinunciataria

Il repo è un livello di contesto che **cresce**, non un inventario chiuso. La prossima frase dell'utente può nominare un'entità (un'azienda, una persona, un sistema, un prodotto, un tema, un articolo) o una capacità (una skill) che nel repo non c'è ancora. La mossa giusta **non** è concludere "non esiste" o "non è il posto". È:

1. **Controllare la fonte canonica prima di concludere che manca.** Per aziende e persone esterne la fonte è il CRM via MCP. Per le tassonomie (`themes/`, `industries/`, `job-titles/`, `systems/`, `products/`, `articles/`) valgono le euristiche in "Scansione delle entità". Per le skill, la cartella `.claude/skills/` più la possibilità di crearne una.
2. **Proporre l'azione (crea, collega, aggiungi alias), poi procedere.** Il grafo cresce per proposta e conferma, mai per salto silenzioso e mai per creazione silenziosa.
3. **Rifiutare perché "non lo vedo nel repo" è un bug.** Il repo riflette solo quello che qualcuno ci ha già portato. L'assenza è un segnale per controllare la fonte, non una conclusione.

Questa postura vale per **ogni interazione**: rispondere a una domanda, scrivere un file, proporre un piano.

### Come si vede in pratica

| Situazione | Mossa sbagliata | Mossa giusta |
|---|---|---|
| Lavoro su un'azienda senza `companies/<slug>.md` | "Quell'azienda non c'è nel repo." | Interroga il CRM. Se c'è, proponi di creare il file con `crm_url` e procedi. Se non c'è, procedi in testo semplice e segnala il buco. |
| Lavoro su una persona senza `people/<slug>.md` | "Quella persona non è tracciata." | Esterna: stesso schema, CRM e proposta. Interna: chiedi all'utente, mai creare da una menzione. |
| Un task che nessuna skill copre | "Non c'è una skill per questo." | Controlla `.claude/skills/`. Se niente calza, **proponi di crearla** con `skill-creator`, con `owner:` e `creator:` espliciti: si procede alla conferma. Improvvisare in silenzio una pipeline che dovrebbe essere una skill è un bug. |
| L'utente incolla il link di un articolo | Nessun commento. | Se la fonte serve al team, proponi `articles/<slug>.md` con TL;DR e temi. |
| Un sistema, tema, verticale, ruolo, prodotto nuovo citato di passaggio | Salto silenzioso. | Applica "Scansione delle entità": proponi crea, aggiungi alias o salta. |
| Un'osservazione da fuori dalle fonti tracciate (un podcast di un concorrente, un comunicato, una ricerca, uno screenshot) che tocca posizionamento, clienti o strategia | Una riga in chat e via. | Proponi di salvarla come signal manuale in `signals/manual/YYYY/MM/`, con la stessa disciplina di ogni signal. |

L'unico enum che **non** riceve mai voci nuove è `relationship-types/`.

---

## Perimetro del repo: solo conoscenza

Il repo tiene **conoscenza**. Non deliverable per un pubblico, non binari. Prima di creare un file o una cartella l'agente fa un controllo in due passaggi, che non si salta. Se uno dei due fallisce, l'agente lo dice in chat invece di scrivere.

### Passaggio 1: classifica il contenuto

| Tipo | Destinazione | Esempi |
|---|---|---|
| **Conoscenza.** Regole canoniche, definizioni stabili, signal append-only, voci di tassonomia, comportamenti riutilizzabili. | Questo repo. | `canon/`, entità, `signals/`, `.claude/skills/`. |
| **Documento per un pubblico.** Una pagina scritta per essere letta da persone: recap per tutta l'azienda, one-pager, testo di un deck, annuncio interno. | {{DOCS_SYSTEM}}, via MCP. | FAQ di team, brief per un partner. |
| **File binario.** xlsx, pdf, docx, pptx, immagini, video. | L'archivio file dell'azienda (es. Drive). | Fogli, export, deck, screenshot, loghi. |

Le bozze di email vanno nel client di posta, gli eventi nel calendario, le note sui clienti nel CRM (vedi "Bozze in uscita: nello strumento").

Se il contenuto **non è conoscenza**, non si scrive nel repo: si dice all'utente dove va e si procede solo dopo la sua conferma. L'utente può forzare con una ragione esplicita.

### Passaggio 2: se è conoscenza, prima si riusano gli spazi esistenti

Il default è estendere un file esistente. L'ordine:

1. **Canon aziendale.** Ci sta come sezione nuova in `company-rules.md`, `operations.md`, `anatomy.md` o `profile.md`?
2. **Canon di team.** Ci sta in un `canon/team/<team>.md` esistente?
3. **Corpo di un'entità.** Estende una definizione che vive già in un file di `people/`, `companies/`, `themes/` e simili? (rispettando l'asimmetria del corpo in [`anatomy.md`](anatomy.md))
4. **Signal.** È un'osservazione datata legata a una call, una mail, un evento, una sessione? Va in [`signals/`](../signals/).
5. **Skill.** È un comportamento che un agente deve poter richiamare? Va in [`.claude/skills/<slug>/SKILL.md`](../.claude/skills/).

Solo se nessuno di questi spazi va bene si propone un file **nuovo**. Le cartelle nuove seguono la procedura più sotto. Prima di scrivere si dice il ragionamento: *"questo va come sezione nuova di `canon/operations.md`, ok?"*.

**Perché due passaggi.** Il primo impedisce al repo di riempirsi di bozze pronte per la pubblicazione che appartengono allo strumento in cui escono. Il secondo impedisce che la stessa regola finisca riscritta in tre file diversi. Il repo resta piccolo, interrogabile e autorevole.

---

## Date e orari

- **Formato:** ISO, `YYYY-MM-DD`. Niente formati ambigui come "04/05/2026".
- **Fuso:** `{{FUSO_ORARIO}}` (es. `Europe/Rome`). I timestamp in ingresso si convertono a questo fuso.
- **Quarter:** Q1 gennaio-marzo, Q2 aprile-giugno, Q3 luglio-settembre, Q4 ottobre-dicembre.
- **Date relative:** quando una trascrizione dice "entro giugno", "fine Q2", "giovedì", si risolve in una data assoluta in base alla data della call. Nei deliverable scritti non restano date relative.

---

## Lingua

**{{LINGUA}}.** Ogni file del repo è scritto in questa lingua: prosa, titoli, messaggi di commit, corpo dei signal. Gli slug e i nomi dei campi restano in inglese (`objective`, `related_to_projects`, `kill-or-ship`) perché sono struttura, non contenuto.

- Fonte in un'altra lingua → sintesi in {{LINGUA}}.
- Valgono le regole di voce di [`company-rules.md`](company-rules.md) → "Voce".

---

## Citazioni: ogni affermazione porta alla sua fonte

Ogni blocco fattuale in un signal, un recap o qualsiasi output prodotto da un agente porta un **link alla fonte originale** (trascrizione, record del CRM, documento, message-id di una mail, PR, link a un messaggio in chat). Le affermazioni senza fonte non sono ammesse.

Quando due fonti si contraddicono, **la contraddizione si segnala** invece di risolverla in silenzio.

Quando una fonte manca o non è accessibile, si dichiara il buco invece di inventare.

---

## Peso delle fonti

Quando un agente genera un'**affermazione** (un fatto, un numero, uno stato, un'attribuzione), le fonti pesano così:

| Priorità | Fonte | Peso |
|---|---|---|
| 1 | Dati oggettivi (CRM, codice, trascrizioni letterali, sistemi di analytics) | Massimo |
| 2 | Decisioni formalizzate (documenti approvati, `decisions/`) | Alto |
| 3 | L'interpretazione del modello | Solo quando un prompt la chiede |

Quello che non ha una fonte oggettiva può comparire come "segnale debole", mai come fatto.

> **Non è l'ordine di verità.** L'ordine di verità decide **quale file vince** quando due file del repo sono in disaccordo. Il peso delle fonti decide **quanto è sicuro** un agente quando genera una singola affermazione da prove esterne. Valgono entrambi.

---

## Modifiche: push su main, con un'eccezione

Workflow di default: **commit e push diretto su `main`**. Niente pull request per default.

Il motivo: il repo è un livello di contesto per un team piccolo. Una scrittura sbagliata costa poco (si annulla un commit), l'attrito di una PR per ogni correzione costa molto. Il prossimo lettore fa da revisore.

**Le istruzioni di branch dell'ambiente non cambiano la regola.** Un ambiente che apre la sessione su un branch dedicato (un worktree `claude/<…>`, un wrapper che dice "lavora solo su questo branch") è uno strato secondario rispetto al repo. Il lavoro fuori da `canon/**` deve arrivare su `main`. Da un worktree non si fa `checkout main` (è già occupato dal checkout principale): si porta la punta del branch su `main` del remote, come descritto nella skill `session-end`, passo "Chiudi su Git".

**L'unica eccezione ferma: `canon/**` passa solo da PR.**

Ogni modifica a un file sotto [`canon/`](.) passa da una pull request. Nessun push diretto su `main`, owner compreso. Così ogni modifica alle regole del gioco ha un secondo paio d'occhi per costruzione. Il canon si committa **da solo, sul suo branch `canon/<scopo>`, mai insieme ad altro**: separarlo dopo è doloroso.

**PR facoltativa fuori da `canon/`.** Si apre quando l'autore vuole un secondo parere, di solito per modifiche importanti a `.github/**`, `.claude/skills/**`, `README.md`, `index.md`, `CLAUDE.md`.

Anche nel push diretto, le esclusioni di [`company-rules.md`](company-rules.md) → "Cosa il sistema non deve mai fare" valgono per **messaggi di commit** e **titoli e corpo delle PR**: sono visibili a tutti. Frase di default per il contenuto filtrato: *"dettaglio fuori dal record per scelta"*.

---

## Creazione di cartelle: prima si contesta, poi PR

La forma del repo è canonica. La tassonomia in [`anatomy.md`](anatomy.md) → "Mappa del dominio" è l'elenco completo delle cartelle in cui un agente può scrivere. Creare una cartella fuori schema è il modo più veloce di rompere il grafo.

**Routine, senza contestazione:** le sottocartelle per skill in [`.claude/skills/<slug>/`](../.claude/skills/) e quelle per periodo in [`signals/<fonte>/YYYY/MM/`](../signals/).

**Ovunque altro, prima si contesta.** Un `mkdir` silenzioso è un bug. La sequenza:

1. **Contesta.** *"Stai proponendo una cartella nuova in `<percorso>`. La struttura del repo è canonica e le cartelle nuove sono rare: capiamo prima cosa vuoi fare."*
2. **Chiedi finché l'intento è chiaro.** Cosa ci andrà dentro? Riguarda un'azienda, una persona, un prodotto, un tema (allora è un file nella cartella esistente)? È lavoro per un cliente specifico (allora va nello strumento giusto, mai nel repo)? È una skill (allora va in `.claude/skills/<slug>/`)? È un'area di lavoro temporanea (allora no: le osservazioni vanno in `signals/manual/`, il resto resta sul computer di chi lavora)?
3. **Porta al percorso standard.** Quasi sempre la risposta è una cartella esistente.
4. **Se una cartella nuova serve**, confermata dopo la contestazione, l'agente non fa push diretto: crea la cartella su un branch e apre una PR.

   ```
   git switch -c structure/<scopo-breve>
   mkdir -p <percorso-nuovo>
   <aggiungi almeno un file tracciato, di solito un README.md con lo schema>
   git add <percorso-nuovo>
   git commit -m "structure: add <percorso-nuovo>"
   git push -u origin structure/<scopo-breve>
   gh pr create --title "structure: add <percorso-nuovo>" \
     --body "<cosa conterrà, quale cartella esistente è stata scartata e perché, che schema seguiranno i file>"
   ```

**Errori comuni.**

| Tentazione | Dove va invece |
|---|---|
| `team/<nome-azienda>/` | Da nessuna parte. `team/` è solo per team funzionali; l'azienda è `companies/<azienda>.md` con `is_self: true`. |
| `team/<qualsiasi>/clienti/<X>/`, `team/vendite/deal/<X>/` | Da nessuna parte. Un'azienda esterna è `companies/<X>.md`, lo stato del deal sta nel CRM, i deliverable nel loro strumento. |
| `<cliente>-demo/`, `<cliente>-onboarding/` | Da nessuna parte. I deliverable per un cliente li produce una skill con il cliente come input. |
| `note/`, `bozze/`, `wip/`, `inbox/` | Da nessuna parte. Le osservazioni vanno in `signals/manual/YYYY/MM/`, il lavoro di prova resta in locale. |
| `clienti/`, `prospect/`, `partner/`, `fornitori/` | Da nessuna parte. Tutti in `companies/<X>.md`, distinti da `relationship:`. |

Nel dubbio la risposta è **nessuna cartella nuova**.

---

## Controllo dei link (opzionale)

Se attivate un controllo dei link in CI, fatelo girare anche in locale prima del push: un link rotto introdotto in un commit fa fallire tutti i push successivi, anche quelli di altri. Con [lychee](https://github.com/lycheeverse/lychee):

```bash
lychee --offline --no-progress --exclude '<[^>]+>' './**/*.md'
```

Il template non lo attiva di default.

---

## Modello di sync

`origin/main` su GitHub è **l'unica fonte di verità**. Ogni computer ha una copia di lavoro locale. Il modello è volutamente minimo, così un team non tecnico lavora in parallelo senza imparare Git.

### Chi scrive

Due canali di **scrittura**:
- **Claude Code**: skill e modifiche dirette. È il canale principale.
- **Un editor Markdown locale** (es. Obsidian): le persone possono modificare i file e fare commit **in locale**. Quello che l'editor non fa è il push.

Un solo canale di **push**: Claude Code. Ogni sessione parte con `git pull --rebase --autostash` (hook SessionStart). Due meccanismi rimandano il lavoro su GitHub: ogni skill che scrive chiude con il suo push; l'hook `Stop` fa commit e push di quello che il turno ha cambiato. I commit fatti nell'editor arrivano su `origin` alla prossima sessione di Claude Code.

Perché il push resta centralizzato:
- Le persone non tecniche non fanno pull, rebase e push a mano in modo affidabile. Gli hook lo fanno ogni volta, senza contare sulla disciplina di nessuno: una regola in prosa è un prompt che il modello può saltare, un hook viene eseguito.
- Si toglie la corsa fra due persone che pushano nello stesso momento da strumenti diversi.

**Il pulsante Push dell'editor locale non si usa.** Le modifiche fatte nell'editor e **non committate** rischiano di essere sovrascritte dal pull della sessione successiva: prima di allontanarsi si committa in locale.

### Il giro universale

Ogni scrittura che arriva su `main` ha la stessa forma:

```
git pull --rebase --autostash origin main   # prima guarda cosa hanno scritto gli altri
<fai la modifica>
git add <file specifici>                    # mai -A o .
git commit -m "<messaggio>"
git push origin main
# su non-fast-forward (qualcuno ha pushato nel frattempo):
#   git pull --rebase --autostash e riprova il push, massimo 3 volte
# su un conflitto vero durante il rebase:
#   annulla il rebase, lascia la copia pulita, segnala l'errore
```

### I tre punti in cui gira

**Hook SessionStart** ([`scripts/git_sync_pull.sh`](../scripts/git_sync_pull.sh)). A ogni avvio:
1. Toglie gli `index.lock` orfani più vecchi di un minuto. Una vera operazione git non tiene il lock così a lungo: quello che resta è il residuo di un processo morto e bloccherebbe ogni scrittura successiva.
2. `git pull --rebase --autostash` sul branch corrente; se la sessione gira da un worktree, allinea in fast-forward anche il checkout principale. Fallisce senza bloccare (rete, autenticazione).

**Skill che scrivono.** Ogni skill che scrive file chiude con il giro universale, mettendo in stage i file specifici che ha scritto. Obbligatorio.

**Hook Stop** ([`scripts/git_autosave.sh`](../scripts/git_autosave.sh)). A fine di ogni turno fa commit e push di quello che è rimasto nella copia di lavoro, così una modifica fatta senza skill non resta in sospeso. È l'unico punto in cui `git add -A` è voluto. Le guardie:
- **salta `canon/`** (resta nel working tree finché qualcuno apre la PR);
- **non committa mai a metà di un merge, rebase o cherry-pick**, né se trova marker di conflitto nel contenuto;
- **riprova il push su non-fast-forward** (pull con rebase, poi push), fino a tre volte;
- fallisce senza bloccare: il commit locale resta anche se il push non riesce.

### Repo a specchio (opzionale)

Qualcuno può voler tenere una seconda copia del repo (una copia personale, un repo di un'altra organizzazione). Basta aggiungere un secondo remote: gli script iterano sui remote che esistono. Con il solo `origin` si comportano come sopra.

Con più remote:
- **SessionStart** fa `pull` da `origin` sul branch corrente e, **solo quando la sessione è su `main`**, anche dagli altri remote. È il verso di ritorno: porta a casa i commit di chi ha pushato sull'altra copia.
- **Stop** pusha il branch corrente su `origin` e, **solo su `main`**, pusha `main` anche sugli altri remote.

Due conseguenze:
1. **I branch di worktree (`claude/*`) vanno solo su `origin`**, così la copia gemella non si riempie di rami di lavoro.
2. **Il riallineamento avviene solo dalle sessioni su `main`.** Una sessione in un worktree non specchia niente: lo fa la prima sessione che parte dal checkout principale.

Le impostazioni di GitHub (protezione dei branch, CODEOWNERS) **non** si sincronizzano coi commit: vanno configurate su ogni repo, vedi [`../.github/CANON-ENFORCEMENT.md`](../.github/CANON-ENFORCEMENT.md).

### Eccezione `canon/`

```
git switch -c canon/<scopo-breve>
<modifica e commit sul branch>
git push -u origin canon/<scopo-breve>
gh pr create
# approvazione dell'owner, poi merge con "Create a merge commit"
```

Il workflow [`canon-guard`](../.github/workflows/canon-guard.yml) fallisce se un commit non di merge su `main` tocca `canon/**`.

### Guasti tipici

| Sintomo | Cosa vuol dire | Cosa fare |
|---|---|---|
| La sessione parte senza aver tirato giù il lavoro altrui | L'hook non ha raggiunto GitHub (offline, autenticazione) | Controlla `gh auth status`, poi `git fetch` a mano. |
| Una skill si ferma con "push rifiutato dopo 3 tentativi" | Molte scritture nello stesso momento | Rilancia fra un minuto. Se insiste, chiedi a chi cura il repo. |
| Una skill si ferma con "conflitto durante il rebase" | Due persone hanno modificato le stesse righe nello stesso momento | Lo risolve a mano chi cura il repo. |
| La copia locale è indietro di molti commit | Qualcuno è stato offline a lungo | Non pushare dalla macchina vecchia prima di riallinearla. |
| L'editor dice "Sync failed" o git dice "another git process seems to be running" | `index.lock` orfano | Lo toglie l'hook al prossimo avvio. Subito: `find <repo>/.git -name index.lock -mmin +1 -delete`. |

### Cosa manca di proposito

- **Nessun demone in background** (launchd, cron): gli hook coprono apertura e scrittura.
- **Nessun lock sui file**: la concorrenza ottimistica con pull, rebase e retry basta per un team piccolo.
- **Nessun push dall'editor locale.**

### Installazione per persona

1. Clona il repo dove preferisci.
2. Configura l'autenticazione: `gh auth login`.
3. Installa Claude Code e aprilo nella cartella: gli hook di `.claude/settings.json` si caricano da soli.
4. (Facoltativo) Apri l'editor Markdown sulla stessa cartella.

---

## Riconciliazione della memoria locale a inizio sessione

La memoria locale di Claude Code (`~/.claude/projects/.../memory/` più gli equivalenti di altri agenti) è per persona e per macchina: non arriva mai a un collega ed è sempre secondaria al repo. L'unico livello che il team condivide è il repo, quindi un'abitudine personale salvata in locale non deve peggiorare il lavoro aziendale. A inizio sessione l'agente riconcilia la memoria col repo, senza distruggere e toccando solo il necessario:

1. **Semina la base, se manca.** La memoria locale deve contenere tre fatti che la tengono subordinata: (a) sul lavoro aziendale il repo è la fonte di verità e in caso di conflitto vince, quindi si rilegge il repo invece di fidarsi della nota; (b) le skill si scrivono nel repo in `.claude/skills/<slug>/`, mai in `~/.claude/skills/`; (c) gli artefatti seguono la voce del canon ([`company-rules.md`](company-rules.md) → "Voce").
2. **Risolvi i conflitti.** Cerca note locali che contraddicono il canon (un'abitudine di stile che va contro una regola di voce, un fatto aziendale superato). Vince il canon: correggi la nota o segnala che è superata, poi di' all'utente cosa è cambiato. Una preferenza che è solo diversa, senza contraddire, si lascia stare.

La memoria puramente personale (stile, chi è la persona, come vuole lavorare) resta com'è: è il suo scopo.

L'hook [`scripts/session_context.sh`](../scripts/session_context.sh) stampa questo promemoria a ogni avvio, così la regola scatta senza dipendere dalla memoria dell'agente.

---

## Protocollo di sessione: aprire e chiudere il blocco di lavoro

Senza questo livello il repo sa **cosa è successo** (i signal) ma non **da dove ripartire**: ogni sessione riparte da zero e quello che non è stato finito evapora.

**Apertura.** La skill `session-start` (sola lettura) fa riemergere i thread aperti da [`signals/aperto.md`](../signals/aperto.md) con la loro fonte, controlla la freschezza del cervello (se il signal più recente ha più di 7 giorni lo dichiara), controlla in [`decisions/`](../decisions/README.md) che il tema non sia già chiuso, riconcilia la memoria locale col repo e carica le regole del team che possiede il task. Non scrive niente.

**Chiusura.** La skill `session-end` separa quattro cose (fatto, deciso, feedback, aperto), le smista secondo [`CLAUDE.md`](../CLAUDE.md), scrive un signal in `signals/manual/YYYY/MM/<slug-persona>_sessione-<slug-tema>_YYYY-MM-DD.md` con la sezione `## Aperto`, aggiorna il registro e chiude col giro Git. **Se la sessione non ha prodotto niente di durevole, non scrive.**

**Il registro è una cache.** [`signals/aperto.md`](../signals/aperto.md) si ricostruisce dalle sezioni `## Aperto` dei signal degli ultimi 60 giorni. Le righe hanno una forma fissa (`- [ ] <cosa> · @<persona> · dal <data> · [signal](<percorso>)`) perché l'hook le cerca con quel pattern: una riga fuori forma è invisibile.

**Perché un hook.** Lo stdout di un hook SessionStart entra nel contesto della sessione. Una regola in prosa il modello la può saltare, un hook gira ogni volta.

**Il feedback si registra, non si applica di nascosto.** Quando l'utente corregge un output, la correzione non va fatta in silenzio nel file: si capisce il perché e lo si scrive nel livello che lo renderà persistente (memoria locale per le preferenze personali, la skill per le regole di produzione, `canon/` via PR per le regole aziendali, `decisions/` per il ragionamento). Correggere senza registrare la ragione equivale a dare un feedback a una persona e poi rifare il lavoro da soli: la volta dopo l'errore torna.

---

## Decisioni: come una decisione entra a record

Una decisione chiusa vive in [`decisions/`](../decisions/README.md), non nei signal e non solo nella storia dei commit. Lo schema sta nel README della cartella; qui la regola procedurale.

- **L'agente non scrive in `decisions/` in autonomia.** Propone il candidato in chat (cosa si è deciso, cosa si è scartato, quando si riapre) e scrive solo dopo il **sì esplicito di {{OWNER_CANON}}**. Una memoria del giudizio con dentro una decisione che nessuno ha preso è peggio di nessuna memoria, perché tutto quello che sta a valle ci si fida.
- **Il candidato nasce di solito in `session-end`**, che chiudendo la sessione riconosce il ragionamento chiuso.
- **Regola nel canon, ragionamento in `decisions/`.** Quando una decisione diventa una regola operativa, la regola entra nel canon via PR e cita la decisione.
- **Prima di riaprire un tema, si legge la cartella.** Se la condizione di riapertura è soddisfatta si propone di riaprire citando il file, altrimenti la questione è chiusa. Si controlla sempre `superseded_by:`.
- **Le esclusioni valgono in pieno**: decisioni su persone, compensi, equity, prezzi di un singolo deal, legale o HR non entrano, per costruzione. Quindi **l'assenza non prova niente**.

---

## Caricamento delle regole per task

**Oltre al canon, l'agente carica le regole del team che possiede il *task*, non solo quelle del team di chi chiede.**

Chi chiede risponde a *chi sta chiedendo*, non a *cosa si sta facendo*. Se il CEO chiede un preventivo per un cliente, sta facendo lavoro commerciale: le regole di quel preventivo stanno nel file del team vendite, non in quello della leadership. Leggere solo il team di chi chiede e improvvisare il resto è un bug.

**La regola.** Prima di rispondere o di scrivere, l'agente riconosce il **tipo di task** e carica `canon/team/<team-che-possiede>.md`. Se il task tocca più team, li carica tutti.

**Tabella di instradamento** (da compilare con i vostri team):

| Tipo di task | Team che lo possiede |
|---|---|
| <!-- es. Deal, preventivi, conversazioni commerciali --> | <!-- [`team/vendite`](team/vendite.md) --> |
| <!-- es. Bug, infrastruttura, sito, code review --> | <!-- [`team/engineering`](team/engineering.md) --> |
| <!-- es. Voce del brand, copy pubblico, social --> | <!-- [`team/marketing`](team/marketing.md) --> |
| <!-- es. Strategia trasversale, OKR, hiring --> | <!-- [`team/leadership`](team/leadership.md) --> |

Quando l'instradamento è ambiguo, si caricano **tutti** i team plausibili: due letture costano poco, una lettura sbagliata fa perdere un vincolo.

**Non è una regola di permessi.** È una regola di contesto: l'agente legge le regole che governano il lavoro che sta per produrre, così non le viola per ignoranza.

---

## Disciplina dei tag in scrittura

Prima di salvare un file con prosa (signal, articoli, recap, qualsiasi cosa che nomini entità esterne), si scorre il testo e ogni menzione di entità diventa un wikilink quando possibile.

| Tipo | Risoluzione |
|---|---|
| **Persone interne** | Confronta con gli alias in [`people/`](../people/). Wikilink se il file esiste. **Mai creare** un file interno da una menzione: quella parte la curano le persone. |
| **Persone esterne** | Confronta con gli alias. Se il file esiste, wikilink. Se no, **interroga il CRM**: se c'è un record, crea il file con `crm_url` e collega; se no, testo semplice. |
| **Aziende** | Stesso schema. L'azienda stessa (`is_self: true`) la curano le persone. |
| **Team** | Confronta con [`team/`](../team/). Wikilink se la cartella esiste. |

Vale per **ogni scrittura**, compresi gli output generati: la skill fa le ricerche nel CRM da sola, il revisore umano non deve inseguire i link mancanti dopo.

---

## Wikilink: sempre doppia scrittura

Il grafo vive nel frontmatter di ogni file, con relazioni come `team: [[<team>]]` o `industry: [[<verticale>]]`. L'inversa automatica degli editor scatta solo sui nomi predefiniti; per i nostri campi semantici si dichiarano entrambi i lati.

**Regola.** Ogni volta che aggiungi o togli un wikilink diretto in un file, aggiungi o togli l'inverso nel file partner **nella stessa scrittura**. Le mezze coppie rompono la sezione inversa nell'editor e le domande "fammi vedere tutti gli X" degli agenti.

La tabella completa delle coppie sta in [`anatomy.md`](anatomy.md) → "Relazioni wikilink nel frontmatter". Lì stanno anche le eccezioni: i signal non ricevono inversi sulle entità, tranne i temi e la catena `related_to_signals`.

---

## Regola trasversale

Se un contributo tocca più team, **un solo file**, in una cartella trasversale ([`signals/`](../signals/) per i signal, [`people/`](../people/) per le persone), con i link a ogni team coinvolto. Non si duplica sotto ogni team e non si sceglie un "team principale".

---

## Entità esterne: si creano alla prima menzione

Il repo tiene **file leggeri** per le entità esterne in [`companies/`](../companies/) e [`people/`](../people/). Il loro unico compito è essere **bersagli stabili per i wikilink**: un `grep "companies/<slug>.md"` su `signals/` restituisce ogni recap che ha toccato quell'azienda, senza che il CRM debba conoscere il repo e senza che il repo duplichi il CRM.

**Postura: si tende a creare.** Ogni conversazione che nomina un cliente, un prospect, un partner, un fornitore, un advisor o un contatto esterno reale è l'occasione per aggiungere un nodo stabile. Il default davanti a un nome che manca è "interroga il CRM, proponi di creare", non "annota e passa oltre".

**Cosa fa scattare la regola**: qualsiasi task che nomina un'entità esterna, non solo la scrittura di un file. Scrivere un signal, preparare una mail a quella persona, rispondere a una domanda su un deal, pianificare un lavoro che dipende da quell'azienda, leggere una trascrizione in cui compare.

Quando scatta, **si controlla il CRM**. Se c'è un record, **si crea** subito `people/<slug>.md` (con `company: [[<loro-azienda>]]`) o `companies/<slug>.md` con `crm_url` compilato, si rende la menzione come wikilink e si procede. Se il CRM non ha niente, la menzione resta **testo semplice**, si segnala il buco e non si crea un file vuoto.

**Le persone interne sono diverse: mai create da una menzione.** Quella parte di `people/` la curano le persone. Se il file esiste si risolve l'alias, altrimenti si lascia testo semplice e si chiede.

**`crm_url` è obbligatorio** per i file esterni, tranne i competitor (vedi [`anatomy.md`](anatomy.md) → "Asimmetria del corpo"). Se chi scrive non riesce a ricavarlo (niente accesso al CRM in quella sessione), lascia la menzione in testo semplice e segnala il buco: niente file a metà.

---

## La relazione è uno stato che cambia: si allinea al CRM

Il campo `relationship:` su `companies/<slug>.md` è **uno stato, non un'etichetta data una volta**. I prospect firmano e diventano clienti, i clienti se ne vanno, i partner diventano clienti. Le transizioni avvengono prima nel CRM, il repo segue.

**Fonte di verità: la fase del record aziendale nel CRM**, mappata sull'enum di [`relationship-types/`](../relationship-types/). Prima di ogni scrittura che dipende da quel valore (creare un file azienda, un signal che afferma una relazione, un'automazione che dipende dal tipo), l'agente interroga il CRM, confronta col file e lo aggiorna se è cambiato. Una deriva silenziosa è un bug del grafo.

**Ogni cambio porta con sé gli inversi.** Quando `relationship: [[prospect]]` diventa `[[customer]]`, nella stessa scrittura si toglie l'azienda da `relationship-types/prospect.md` e la si aggiunge a `relationship-types/customer.md`.

**Quando lo stato non ha uno spazio nell'enum** (clienti persi, prospect persi, account dormienti), si segnala il buco e si propone di estendere l'enum con una PR sul canon, invece di parcheggiare l'azienda sotto un tipo sbagliato. Il trattamento dei clienti persi è descritto in [`relationship-types/README.md`](../relationship-types/README.md).

---

## Catalogo prodotti: la fonte è fuori dal repo

Il catalogo dei prodotti ha il suo sistema di riferimento: <!-- {{DOCS_SYSTEM}}, il CMS, il gestionale -->. È un'eccezione voluta: per i prodotti **vince il sistema esterno sul contenuto**.

`products/<slug>.md` è **un puntatore, non una copia**, come `companies/<slug>.md` lo è verso il CRM:

- ogni file ha un `docs_url` che punta alla pagina del prodotto;
- il file è sottile: `name`, `slug`, `category`, `docs_url` e un breve `## About`, senza relazioni nel frontmatter;
- il contenuto si cambia nel sistema esterno, il file segue. Un prodotto nuovo nasce là, poi un agente crea il file puntatore.

---

## Disciplina del corpo delle entità: fatti stabili e controllo di freschezza

### Solo fatti stabili

Il corpo di ogni entità (temi, prodotti, sistemi, verticali, ruoli, tipi di relazione, aziende e persone esterne) contiene **solo contenuto definitorio e stabile**. Il `## About` risponde a *"cos'è questa cosa nel nostro schema"*, in 1-2 frasi, con fatti che non si muovono di settimana in settimana.

È **vietato** nel corpo di un'entità:
- lo stato operativo ("MVP il mese prossimo", "in beta", "deal in trattativa");
- lo stato di progetti e iniziative, che sta nei signal o nel sistema esterno;
- la prosa sulla relazione ("stiamo proponendo X", "hanno disdetto a marzo"), che è stato del CRM;
- tutto quello che un lettore fra sei mesi dovrebbe verificare prima di fidarsi.

Le eccezioni sono quelle dell'asimmetria del corpo: le persone interne e l'azienda stessa possono crescere con scope, voce, stile, perché lì la fonte è il repo.

### Controllo di freschezza in lettura

Quando un agente legge un'entità durante un task, cerca nel corpo il contenuto che **potrebbe essere invecchiato**: definizioni diventate più strette o più larghe, righe che accennano a uno stato in corso nel frattempo concluso, descrizioni precedenti a un cambio di rotta noto.

Se trova una riga sospetta, **lo dice all'utente in chat** (testo attuale e perché sembra vecchio) e chiede se vale ancora. Se l'utente conferma che è cambiata, l'agente aggiorna il file nello stesso giro. Se conferma che vale, si va avanti senza toccare niente.

Lasciar passare in silenzio un contenuto sospetto è un bug. Riscriverlo in silenzio è un bug peggiore. La disciplina è: **leggi, sospetta, chiedi, scrivi solo dopo la conferma**.

---

## Scansione delle entità

**Ogni testo letto si scansiona per voci nuove; ogni conversazione si scansiona per entità mancanti.** Quando un agente legge una fonte (trascrizione, mail, chat, documento, export del CRM) **oppure** risponde a un messaggio che nomina un'entità, la prima domanda è: *questa entità sta nel grafo? Se no, qual è l'azione giusta?* Vale per tutte le tassonomie di [`anatomy.md`](anatomy.md) → "Mappa del dominio". `relationship-types/` è un enum fisso: **mai voci nuove**.

### Gli alias sono di prima classe

Il campo `aliases:` è l'unico controllo che impedisce al grafo di riempirsi di doppioni.

- **Ogni file nasce con alias ricchi**: diminutivi, combinazioni di nome e cognome, dominio, handle, errori di grafia noti. **Alias vuoti sono un bug.**
- **Gli alias si aggiungono mentre si lavora.** Quando la scansione trova un termine che dovrebbe corrispondere a un file esistente ma non lo fa perché manca l'alias, l'azione canonica è `aggiungi alias X a <file>`, non `crea un file nuovo`.
- **L'indice degli alias è globale.** Il confronto gira sugli alias di tutti i file di tutte le cartelle.

### Confronto approssimato prima di creare

Prima di creare un'entità si confronta il candidato con l'indice globale degli alias:

1. **Alias esatto** → wikilink al file esistente.
2. **Somiglianza forte** (grafia vicina, diminutivo, stesso dominio email) → proponi `aggiungi alias`. Mai fondere in silenzio.
3. **Nessuna corrispondenza, entità legata al CRM** (persone esterne, aziende) → interroga il CRM: se c'è, proponi di creare con `crm_url`; se no, testo semplice.
4. **Nessuna corrispondenza, tassonomia** (`themes/`, `industries/`, `job-titles/`, `systems/`) → proponi di creare se l'euristica sotto è soddisfatta, altrimenti testo semplice. `products/` resta fuori: nasce nel sistema esterno.

### Euristiche di creazione per tipo

| Tipo | Quando proporre la creazione |
|---|---|
| `themes/` | Un concetto nominato in modo esplicito e trattato come *cosa*, oppure ricorrente in almeno due call, thread o documenti. |
| `people/` esterne | Il CRM ha un record. Altrimenti testo semplice. |
| `people/` interne | **Mai da una menzione.** |
| `companies/` (cliente, prospect, partner, fornitore, advisor) | Il CRM ha un record. |
| `companies/` (competitor) | Quando lo si segue come concorrente. Nessun record nel CRM richiesto. |
| `industries/` | Un verticale in cui l'azienda vende o fa prospezione oppure un termine di settore ricorrente in almeno due fonti. |
| `relationship-types/` | **Mai.** |
| `job-titles/` | Un ruolo che una persona esterna ricopre e che manca, quando ricorre o pesa. |
| `systems/` | Un software esterno che un cliente usa, alla prima menzione confermata. |
| `products/` | **Mai da una scansione**: nasce nel sistema esterno. |

### Collegare quello che esiste; la ricorrenza fa scattare la creazione

1. **Un termine che corrisponde a un file esistente va collegato, ogni volta**, nel frontmatter e con il suo inverso. Gli archi dimenticati più spesso sono quelli di tassonomia: `uses_stack`, `industry`, `related_to_systems`, `related_to_themes`.
2. **La ricorrenza è di per sé un motivo per creare.** Per le tassonomie, un termine che ricorre (almeno due volte nel testo oppure in due fonti) entra nella lista dei candidati.

### Prima il triage, poi la scrittura

Le skill che producono una scrittura (signal, recap, articoli) **raccolgono i candidati e li presentano a chi le ha invocate prima di scrivere il file**:

> Leggendo le trascrizioni di oggi ho trovato candidati che non sono nel grafo:
>
> - **`<candidato A>`**: molto simile a [[<entità-esistente>]]. Aggiungo l'alias?
> - **`<candidato B>`**: il CRM ha un record. Creo `companies/<candidato-b>.md`?
> - **`<candidato C>`**: trattato come metodo in quattro call. Creo `themes/<candidato-c>.md`?
> - **`<candidato D>`**: nessun record nel CRM. Lo lascio in testo semplice?
>
> Dimmi le azioni (alias, crea, salta) e scrivo il recap con i tag giusti.

Dopo il triage lo scrittore applica le scelte e produce il file. Indovinare, creare o saltare in silenzio è vietato: il grafo evolve per scelta esplicita.

---

## Bozze in uscita: nello strumento, non nel repo

Quando l'utente chiede una mail ("scrivi a X", "rispondi a Y"), l'agente **crea la bozza nel client di posta** via MCP. L'utente la rivede e la invia da lì. In chat basta una riga ("bozza creata, oggetto: ...") più il testo per la revisione.

**Vietato salvare la bozza come file del repo.** Una mail è un deliverable, non conoscenza: esce dallo strumento e vive lì. Vale per ogni documento per un pubblico preparato insieme alla mail.

Stessa regola per le altre uscite, quando lo strumento è collegato:
- mail → MCP della posta;
- evento → MCP del calendario;
- pagina per un pubblico → MCP di {{DOCS_SYSTEM}};
- nota sul cliente → MCP del CRM (vedi sotto).

**Se l'MCP non è collegato** nella sessione, lo si dice ("il connettore della posta non è attivo, ti do il testo da incollare") e solo allora si ripiega sul testo in chat. Mai ripiegare in silenzio su un file `.md`.

---

## Scrivere nella voce del soggetto

Ogni testo che l'agente prepara a nome di una persona porta **la voce di quella persona**: post, mail, messaggi, le parti narrative di un deck che escono col suo nome.

**La voce si legge dal file del soggetto**, nel corpo di [`people/<slug>.md`](../people/), sezione "Come scrivo" o "Stile". Per una persona interna non esiste un sistema esterno che ne tenga la voce: la fonte è il repo.

**La voce la decide il soggetto, non chi chiede.** Quando un collega chiede "scrivi un post per la fondatrice", il post si scrive nella voce della fondatrice, non in quella del collega e non in una voce generica. È quello che permette a chiunque di preparare testi per chiunque senza appiattire tutti sullo stesso tono.

**La voce cambia per superficie.** Una mail interna, un post pubblico e un messaggio a un collega sono tre registri diversi della stessa persona.

**Se manca la sezione sulla voce**, la si ricava dai testi passati della persona, si scrive in quella voce e si propone di aggiungere "Come scrivo" al suo file. Per una persona esterna si resta prudenti.

**Il pavimento aziendale resta.** La voce personale si appoggia sulle regole di [`company-rules.md`](company-rules.md) → "Voce" senza scavalcarle.

---

## Scritture nel CRM

### Nota sulla timeline, non campo descrizione

Quando l'utente chiede di "mettere una nota", "loggare la call", "aggiungere contesto" su un deal o un'azienda, l'agente crea una **nota sulla timeline** associata al deal **e** all'azienda nella stessa scrittura. **Il testo libero non va nel campo descrizione**: sta in un pannello laterale che nessuno guarda, mentre la timeline è dove il team legge.

### Il ruolo vale per il contatto, non per l'azienda associata

Il campo ruolo di un contatto riflette come la persona è stata registrata la prima volta e può riferirsi a un'altra azienda (un'attività personale, un ruolo precedente). **Non si ricava il ruolo nell'azienda associata da quel campo.** Prima di affermare un ruolo preciso in un'azienda precisa, si conferma con l'utente o con un'altra fonte.

---

## Spec di output e filtri di contenuto: dove vive ciascuna regola

- **Spec di output.** *Come* appare l'output: sezioni, formato, ordine, nomi dei file. Vive in [`.claude/skills/<slug>/SKILL.md`](../.claude/skills/): ogni skill possiede la forma dei propri artefatti.
- **Filtro di contenuto.** *Cosa* può o non può comparire in qualsiasi output di un team: commenti di tipo HR, equity, raccolta fondi, performance individuali, contenuti sotto NDA. Vive in [`canon/team/<team>.md`](team/): le regole di team portano la policy, le skill la ereditano.

Test rapido: *la regola limita cosa può comparire (qualunque skill produca l'output) oppure come appare l'artefatto (qualunque sia la policy)?* Nel primo caso va nelle regole di team, nel secondo nella skill.

---

## Skill: creazione proattiva

Le skill vivono in [`.claude/skills/<slug>/SKILL.md`](../.claude/skills/), il percorso di Claude Code.

**Si propone, non si rifiuta.** Quando l'utente chiede un task per cui non esiste una skill, l'agente controlla `.claude/skills/`, conferma che niente calza e **propone** di crearla con `skill-creator`. Improvvisare a mano una pipeline che dovrebbe essere una skill è un bug: la prossima persona che incontra lo stesso task non trova niente.

**Invocazione.** Quando l'utente chiama una skill per nome, si apre il file e si segue. Se il task appartiene a un altro team, si caricano anche le regole di quel team.

**Le skill stanno nel repo, non nella cartella utente.** Ogni skill, di team o personale, esperimenti compresi, sta in `.claude/skills/` **dentro il repo**, così tutto il team la riceve al prossimo pull. Mai in `~/.claude/skills/`, che non arriva a nessun altro.

**Il feedback su una skill si chiude nella skill.** Quando arriva una correzione su come una skill produce l'output, la correzione si scrive nel file della skill nella stessa sessione, non solo nella memoria locale: altrimenti la skill continua a sbagliare per tutti gli altri.
