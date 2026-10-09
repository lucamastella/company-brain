# CLAUDE.md · Cervello di {{NOME_AZIENDA}}

<!--
Questo è il file che Claude Code carica a ogni sessione aperta dentro il repo.
Sostituisci i segnaposto {{...}} (elenco completo in GUIDA-ADOZIONE.md → "Segnaposto"),
poi cancella questo commento.
-->

Workspace condiviso del team di {{NOME_AZIENDA}}: conoscenza, regole, decisioni, memoria degli eventi e skill in un posto solo, che persone e agenti leggono allo stesso modo. Lo aprono più persone da macchine diverse, quindi **niente è hardcodato su una persona sola**: chi sta lavorando si ricava da `git config user.name` (lo stesso slug di `people/<slug>.md`), senza dare per scontato chi sia.

Il repo canonico è **`{{REPO_URL}}`** (privato). Chi possiede il canon è **{{OWNER_CANON}}**.

## Perimetro: quali file si aprono

Il perimetro è **per macchina** e lo decide chi la usa. Il default, per chi non dichiara niente, è stretto: Claude legge, scrive ed elenca solo dentro il repo, dentro `~/.claude` (skill, memoria, impostazioni di Claude Code) e nelle cartelle dichiarate in `.claude/perimetro.local`, una per riga. Fuori dal default stanno il resto della home (Download, Documenti, Scrivania, Libreria), i dischi esterni e le home di altre persone, perché sul computer di chi lavora convivono file personali e file di clienti che non riguardano l'azienda. Chi vuole aprire di più lo dichiara: una cartella di lavoro, oppure tutta la propria home.

Quando qualcuno nomina in chat un file fuori perimetro, Claude non lo apre per iniziativa propria: chiede alla persona di copiarlo dentro il repo oppure di aggiungere quella cartella al perimetro. `.claude/perimetro.local` resta sulla macchina e non entra in git (c'è un esempio in `.claude/perimetro.local.example`).

La regola non è solo scritta: la impone `scripts/guard_perimetro.sh`, hook PreToolUse registrato in `.claude/settings.json`. Ogni lettura, scrittura, ricerca o comando che punta fuori dal perimetro dichiarato viene rifiutato prima di partire. Il blocco non si aggira in autonomia: lo allarga la persona, scrivendo in `perimetro.local`. Regola completa in `canon/company-rules.md` → "Perimetro dei file".

## Memoria: le cose importanti vanno sui file giusti

Quando chi sta lavorando dice qualcosa di **durevole e importante**, salvalo subito nel file giusto senza aspettare che te lo chieda (vedi anche la parola-trigger sotto). Il grezzo non serve: la cronologia completa delle conversazioni la conserva già Claude Code. Qui si tiene solo la **sintesi curata**. Regole di smistamento:

- **Fatti sulla persona che sta lavorando, sue preferenze, feedback su come lavorare, come vuole gli output** → **memoria locale** di chi lavora, in `~/.claude/projects/<cartella-del-progetto>/memory/` (un file per fatto più una riga indice in `MEMORY.md`).
- **Identità, posizionamento, voce, regole, fatti stabili sull'azienda e sul team** → **`canon/`** (`profile.md`, `company-rules.md`, `canon/team/`) e le entità (`people/`, `companies/`). È il livello prescrittivo: si cambia con cura, via Pull Request.
- **Cosa è successo** (recap, note di call, digest email, decisioni datate, deliverable testuali durevoli) → **`signals/`** (`signals/manual|daily-call|email/YYYY/MM/…`), datati e append-only. È il posto giusto per gli output importanti: non lasciarli nella scratchpad temporanea, dove si perdono.
- **Cosa è rimasto aperto** → **`signals/aperto.md`**, il registro rotante dei thread lasciati a metà. Lo scrive `session-end`, lo leggono `session-start` e l'hook di inizio sessione. È una cache: la fonte sono le sezioni `## Aperto` dei signal.
- **Una decisione chiusa** (cosa è stato deciso, cosa è stato scartato, perché, quando si riapre) → **`decisions/`**, un file per decisione. **Non ci si scrive mai in autonomia**: si propone il candidato a {{OWNER_CANON}} e si scrive solo dopo il suo sì. La regola che nasce dalla decisione vive nel canon, il ragionamento vive qui. Prima di riaprire un tema si legge questa cartella.
- **Dettaglio di riferimento non ancora sistemato** (documenti esistenti, numeri, strategia estesa) → **`knowledge/`**, solo finché non viene assorbito in `canon/` e nelle entità. È un'area di migrazione e resta sotto il canon.
- **Fonti esterne analizzate** (un video, un podcast, un articolo, un libro, un transcript di cui si è chiesto "spiegami, riassumi, estrai le regole") → **`articles/<slug>.md`**: puntatore alla fonte, TL;DR di 3-6 righe con la tesi e i numeri che contano, `themes:` obbligatorio e i wikilink alle entità toccate. Se dall'analisi nascono azioni o decisioni, quelle vanno in un signal che punta all'article senza ripetere la sintesi. Se l'analisi serve solo a chi sta lavorando, va nella sua knowledge base personale, mai nel repo.

**Il criterio che decide fra repo e kb personale è uno solo: chi deve poterlo rileggere.** Quello che serve a più di una persona del team va nel repo. Quello che serve solo a chi sta lavorando resta fuori da git. La sintesi vive in un posto solo e gli altri posti hanno un puntatore: due copie sono una che si aggiorna e una che invecchia.

Prima di scrivere controlla se esiste già un file che copre il tema e **aggiornalo** invece di crearne uno nuovo. Correggi o elimina ciò che diventa obsoleto.

### Parola-trigger (override manuale)

Quando chi lavora scrive **"salva questo"**, **"ricorda"**, **"segna"** o **"appunta"**, salva subito l'informazione nel file giusto (regole sopra) e conferma in una riga dove l'hai messa.

Per un consolidamento profondo della memoria locale c'è la skill `consolidate-memory`.

## Sistema operativo: come si lavora su questi file

Il repo adotta il modello del cervello aziendale in Markdown e Git, letto uguale da persone e agenti. Sono regole, non burocrazia.

1. **Ordine di verità** (chi vince in caso di conflitto): (1) `canon/company-rules.md`, cioè identità, voce ed esclusioni; (2) `canon/operations.md` → `operating-system.md` → `anatomy.md` → `profile.md` → `canon/team/`; (3) le skill in `.claude/skills/`; poi lo stato operativo, cioè `knowledge/` (dettaglio in migrazione) e `signals/` (contesto fresco che non scavalca il canon); infine la memoria locale in `~/.claude/.../memory/`, fatta di preferenze personali valide solo su quella macchina. Dettaglio in `canon/company-rules.md` → "Ordine di verità".
2. **Come lavora {{NOME_AZIENDA}}.** Il modello è OKR → Progetto → Attività → Task (vedi `canon/operating-system.md`). Objective e Progetti sono **globali e per scope, mai di un team**: i team eseguono le Attività. Lo stato vivo (valori dei KR, status, avanzamento) vive su **{{DOCS_SYSTEM}}**. Il repo tiene i nodi stabili in `objectives/` (un file per quarter) e `projects/` (un file per Progetto globale) che ci **puntano** senza duplicarli. Ogni recap o piano che scrivi segue questo modello.
3. **Il grafo.** Le entità (`people/`, `companies/`, `objectives/`, `projects/`, `industries/`, `systems/`, `themes/` e le altre) si collegano con wikilink `[[slug]]` bidirezionali, scritti su entrambi i lati. L'arco che conta: signal → progetto → KR → objective. Da qualsiasi nodo si raggiunge il contesto in 1-3 salti. Schema completo in `canon/anatomy.md`.
4. **Il repo tiene conoscenza e memoria degli eventi. Si riusa prima di creare.** Prima di creare un file controlla se il tema sta già in un file esistente e **aggiornalo**. I deliverable *binari e viventi* (deck, PDF, landing, fogli, database) restano nel loro strumento. I deliverable *testuali durevoli* (recap, analisi, note) vanno in `signals/`, non in scratchpad. `canon/**` si cambia con cura perché è il livello prescrittivo.
5. **Versionamento e sync Git.** Repo canonico `{{REPO_URL}}`. Hook attivi: a inizio sessione `pull` e pulizia dei lock orfani (`scripts/git_sync_pull.sh`), digest dei thread aperti (`scripts/session_context.sh`) e controllo di playwright-cli, che se manca fa chiedere a Claude se installarlo (`scripts/check_playwright_cli.sh`); a fine turno `commit + push` che salta sempre `canon/` (`scripts/git_autosave.sh`). Il branch di lavoro è **`main`**. Per recuperare una versione basta chiedere "torna alla versione di prima".
   **Repo a specchio (opzionale).** Chi ha un solo remote non deve fare niente: `origin` è il repo del team e gli hook si comportano come descritto. Chi tiene una seconda copia del repo aggiunge un secondo remote: gli hook tirano da tutti i remote e pushano `main` su ognuno, mentre i branch di worktree (`claude/*`) vanno solo su `origin`. Dettaglio in `canon/operations.md` → "Repo a specchio".
6. **Protocollo di sessione.** Un blocco di lavoro si apre con la skill `session-start` (cosa era rimasto aperto, cosa è cambiato, cosa è già stato deciso) e si chiude con `session-end` (cosa è stato fatto, deciso, lasciato a metà → un signal in `signals/manual/YYYY/MM/` più il registro `signals/aperto.md`). È l'unico motivo per cui la sessione di domani sa dove si è fermata quella di oggi. Se una sessione non ha prodotto niente di durevole, `session-end` non scrive: meglio un `signals/` piccolo e vero.
7. **Le skill si cercano per nome.** L'elenco delle skill che Claude riceve a inizio sessione mostra la descrizione solo delle prime, delle altre dà solo il nome. Prima di un lavoro che una skill del repo potrebbe coprire, si guardano i nomi in `.claude/skills/` e si apre quella giusta anche se la descrizione non si vede.
8. **Lingua:** {{LINGUA}}.

## Stile e regole della casa

Valgono per chiunque scriva nel repo.

- Output e contenuti in {{LINGUA}}.
- Le regole di voce stanno in `canon/company-rules.md` → "Voce". Valgono anche per messaggi di commit, titoli e corpo delle PR.
- Correzioni esplicite da rispettare sempre: <!-- elenca qui i termini o le formule che l'owner ha vietato, con un rimando alla decisione in decisions/ che li giustifica -->
