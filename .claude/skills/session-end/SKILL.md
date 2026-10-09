---
name: session-end
description: Chiude una sessione di lavoro nel cervello aziendale. Trigger quando l'utente dice "session end", "chiudi la sessione", "chiudiamo qui", "salva quello che abbiamo fatto", "fine sessione", "metti a posto prima di chiudere", "cosa resta aperto", "logga questa sessione". Trigger anche in modo proattivo quando un blocco di lavoro sostanzioso si sta chiudendo (un'analisi finita, una decisione presa, un deliverable consegnato) e nessuno ha ancora scritto niente nel repo. La skill riassume cosa è stato fatto, deciso e lasciato a metà, smista ogni pezzo nel posto giusto (signal, canon via PR, la skill stessa quando il feedback riguarda come produce l'output, memoria locale, candidato decisione), scrive un signal in signals/manual/YYYY/MM/ con la sezione "Aperto", lo aggancia ai signal precedenti sullo stesso tema, aggiorna il registro signals/aperto.md e lo pota quando supera le 40 righe, poi committa, pusha e, se la sessione gira su un branch di worktree, porta il lavoro su main senza aspettare che glielo si chieda. NON usare per aprire una sessione (session-start) né per il punto della giornata (focus).
---

# Session end · chiudere la sessione nel cervello

Il valore di questa skill non è archiviare. È fare in modo che **la sessione di domani sappia dove si è fermata quella di oggi**, senza che nessuno se lo debba ricordare. Vale per chiunque nel team: il registro dei thread aperti è condiviso, quindi quello che scrivi oggi lo legge anche chi apre la sessione dopo di te. Il pezzo che conta di più è quello che di solito nessuno scrive: **cosa è rimasto aperto**.

## Quando si attiva

- Su richiesta esplicita (vedi i trigger nella description).
- **Proattivamente**, quando la sessione ha prodotto qualcosa di durevole e sta finendo: proponi in una riga ("chiudo la sessione nel repo?") e procedi al sì.

## Quando non scrivere niente

Se la sessione non ha prodotto niente di durevole (una domanda secca, una ricerca senza conclusione, un giro di prova), **non scrivere il signal**. Dillo in una riga e chiudi. Un `signals/` pieno di rumore vale meno di un `signals/` piccolo e vero.

Non scrivere mai, in nessun file e nemmeno nei messaggi di commit: compensi, valutazioni di persone, candidati in selezione, salute o vita privata, credenziali, valori di contratto o clausole NDA (vedi [`canon/company-rules.md`](../../../canon/company-rules.md) → "Cosa il sistema non deve mai fare").

## Procedura

### 1. Ricostruisci la sessione

Ripercorri la conversazione e separa quattro cose. Se una casella è vuota, lasciala vuota invece di riempirla.

| Cosa | Domanda a cui risponde |
|---|---|
| **Fatto** | Cosa è stato prodotto o cambiato, con i riferimenti (file, URL, ID nei sistemi esterni). |
| **Deciso** | Cosa è stato scelto e cosa è stato scartato. |
| **Feedback** | Le correzioni di chi sta lavorando su come lavorare o su come vuole gli output, con il perché. |
| **Aperto** | Cosa è rimasto a metà, cosa serve da qualcun altro, cosa è stato rimandato. |

### 2. Smista prima di scrivere

Ogni pezzo ha un solo posto giusto. Le regole complete stanno in [`CLAUDE.md`](../../../CLAUDE.md); qui la versione operativa.

| Tipo di contenuto | Dove va | Come |
|---|---|---|
| Cosa è successo, deliverable testuali durevoli, analisi | `signals/manual/YYYY/MM/` | questa skill, passo 3 |
| Cosa resta aperto | `signals/aperto.md` | questa skill, passo 4 |
| **Feedback su come una skill produce l'output** | **il file della skill**, `.claude/skills/<slug>/SKILL.md` | **si modifica nella stessa sessione**, vedi sotto |
| Preferenze personali di chi sta lavorando (stile, abitudini, come vuole le risposte) | memoria locale della sua macchina, in `~/.claude/projects/<cartella-del-progetto>/memory/` | un file per fatto più una riga in `MEMORY.md` |
| Identità, voce, regole, fatti stabili | `canon/**` | **mai push diretto**: proponi la PR, non committare il canon |
| Decisione chiusa (con alternative e perché) | `decisions/` | **solo dopo il sì esplicito dell'owner del canon**, vedi passo 5 |
| Stato vivo di OKR, KR, Attività, campagne | il docs system | si cita, non si duplica |
| Numeri di prodotto e di ricavi | il sistema che li possiede | si cita con il link, non si copia nel repo |

Prima di creare un file nuovo, **cerca se il tema sta già in un file esistente e aggiornalo**. Un secondo file sullo stesso tema è un bug.

**Il feedback sulle skill si chiude subito.** Se in sessione è arrivata una correzione su *come una skill produce l'output* (il formato di un titolo, cosa non deve mai entrare in un deliverable, un pattern da smettere di usare), quella correzione **si scrive dentro la skill in questa sessione**, non solo nella memoria locale. Le skill non sono canon: vanno dritte su `main`, senza PR.

La distinzione: la **memoria locale** tiene chi è la persona e come le piace lavorare, resta sulla sua macchina e il team non la vede. La **skill** tiene la regola di produzione, che vale per chiunque la invochi. Mettere una regola di produzione solo in memoria vuol dire che la skill continuerà a sbagliare per tutti gli altri. Se il feedback è di entrambi i tipi, si scrive in entrambi i posti.

### 3. Scrivi il signal

Percorso e nome file: `signals/manual/YYYY/MM/<slug-persona>_sessione-<slug-tema>_YYYY-MM-DD.md`

Un signal per sessione, non per turno. Se esiste già un file con lo stesso autore, tema e data, **aggiornalo** invece di crearne un secondo.

**L'autore non è mai fisso.** È la persona che sta lavorando: ricava lo slug da `git config user.name` ("Giulia Verdi" → `giulia-verdi`, lo stesso schema di `people/<slug>.md`) e verifica che il file esista. Se non c'è corrispondenza, **chiedi chi sta scrivendo** invece di indovinare.

Frontmatter (è il livello canonico per il routing, il corpo deve restare coerente):

```yaml
---
date: YYYY-MM-DD
author:
  - "[[<slug-persona>]]"       # ricavato da git config user.name
teams_impacted:
  - "[[<slug-team>]]"          # ogni team che deve accorgersene, non solo quello di chi scrive
related_to_people:
  - "[[<slug-persona>]]"
related_to_companies:
  - "[[<slug-azienda>]]"
related_to_products:
  - "[[<slug-prodotto>]]"
related_to_projects:
  - "[[<slug-progetto>]]"      # l'arco che conta: signal → progetto → KR → objective
related_to_themes:
  - "[[<slug-tema>]]"          # OBBLIGATORIO, almeno uno. Bidirezionale: aggiungi il signal
                               # anche a themes/<slug>.md → signals:
related_to_signals:
  - "[[<slug-signal>]]"        # OBBLIGATORIO se il tema ha una storia. Il filo: i signal
                               # precedenti sullo stesso tema. Bidirezionale, vedi sotto.
---
```

Ometti i campi `related_to_*` che non hai usato, niente liste vuote. **Fanno eccezione `related_to_themes` e `related_to_signals`**, vedi il passo 3b. I team disponibili sono le cartelle in [`team/`](../../../team/), i progetti sono in [`projects/`](../../../projects/).

Corpo:

```md
# <Titolo della sessione> · <Nome Cognome> · YYYY-MM-DD

**Autore**: [[<slug-persona>]]
**Team coinvolti**: [[<team1>]], [[<team2>]]

---

## Contesto

Cosa si è lavorato in sessione, quando, partendo da cosa. 1-3 frasi, con la fonte.

## Signal

- 2-6 punti con la sostanza: cosa è stato prodotto, cosa è stato deciso, cosa è stato scartato e perché.

## E quindi

- **[[<team>]]**: perché conta e chi deve muoversi.

## Aperto

- [ ] <cosa manca> · @<slug-persona> · dal YYYY-MM-DD
- [x] <cosa era aperto e in questa sessione si è chiuso> · chiuso YYYY-MM-DD

## Fonte

- <titolo> · <URL o percorso locale>
```

La sezione `## Aperto` è propria dei signal di sessione (le altre sono lo schema standard di [`signals/manual/`](../../../signals/manual/README.md)). Le righe hanno **la stessa forma** di quelle in [`signals/aperto.md`](../../../signals/aperto.md), così il registro si può ricostruire dai signal.

### 3b. Aggancia il filo, prima di committare

Un signal che punta solo a persone e progetti è una foglia: dice cosa è successo un giorno e non dice **come ci si è arrivati**. Questo passo trasforma l'archivio in una rete.

**1. Cerca i precedenti.** Sul tema della sessione, cerca in `signals/` i signal che l'hanno preceduta:

```bash
grep -ril "<parola chiave del tema>" signals/manual/ | sort | tail -20
```

Guarda anche `related_to_themes` dei candidati e la riga di `signals/aperto.md` da cui è nato il lavoro di oggi: il signal che ha aperto un thread è quasi sempre il predecessore giusto.

**2. Collega da 1 a 3 predecessori**, non di più: quello che ha aperto il thread, quello che ha preso la decisione applicata oggi, quello che aveva provato la stessa strada. Se il tema è nuovo, il campo si omette e nel corpo si scrive che è il primo.

**3. Scrivi il link inverso.** Su ognuno dei predecessori aggiungi questo signal al loro `related_to_signals`. Se lo scrivi da una parte sola, chi parte dal signal vecchio non trova il seguito.

**4. Il tema è obbligatorio.** Ogni signal dichiara almeno un `related_to_themes`; il tema riceve il signal nella sua lista `signals:` ([`themes/README.md`](../../../themes/README.md)). Se il tema giusto non esiste, **crealo**: bastano frontmatter, alias ricchi e due frasi di definizione stabile.

Il criterio per fermarsi: da questo signal si deve poter risalire al primo della catena in tre salti, senza cercare.

### 4. Aggiorna il registro dei thread aperti

**Cosa entra nel registro e cosa no.** Il registro serve a una cosa sola: far riprendere a Claude, nella prossima sessione, un lavoro rimasto a metà. Ci entra solo ciò che **Claude può eseguire o verificare** dal repo o dagli strumenti collegati (una skill da correggere, un file da portare su `main`, una misura da rifare fra tre giorni). Non ci entrano: le **decisioni che spettano alle persone** (si propongono in chat; se valgono oltre la settimana diventano un candidato per `decisions/`, passo 5), i **task** che una persona del team deve fare (vivono nello strumento del team; nel signal si scrive dove sono finiti), le **idee** senza un prossimo passo concreto. Tutto questo resta a record nella sezione `## Aperto` del signal, che è la fonte: il registro è il sottoinsieme che serve a riprendere. Un registro pieno di decisioni e task altrui smette di essere letto.

**Prima di toccare il registro, aggiorna `main`.** Il registro e le liste `signals:` dei temi sono i file che ogni sessione scrive, quindi sono quelli su cui due sessioni in parallelo si pestano i piedi. Prima di scrivere le righe nuove:

```bash
for r in $(git remote); do git fetch "$r" main; done
git merge origin/main        # porta dentro le righe scritte dalle altre sessioni
```

Se il merge dà conflitto su `signals/aperto.md` o su un `themes/*.md`, è quasi sempre un'aggiunta da entrambe le parti nello stesso punto: **si tengono entrambe le righe**, mai una sola. Poi si scrivono le proprie.

Su [`signals/aperto.md`](../../../signals/aperto.md):

1. **Aggiungi** una riga per ogni nuovo thread aperto **che passa il filtro qui sopra**, con il link al signal appena scritto.
2. **Chiudi** le righe risolte in questa sessione: spostale in `## Chiuso di recente` con `- [x]` e la data.
3. **Non riscrivere** le righe altrui e non riordinare il file. Le più vecchie stanno in alto.

**Sopra le 40 righe aperte il registro va potato, non solo segnalato.** Prima di scrivere le righe nuove:

```bash
awk '/^## Aperto[[:space:]]*$/{d=1;next} /^## /{d=0} d && /^- \[ \] /' signals/aperto.md | wc -l
```

Se il numero supera 40, presenta a chi sta lavorando una **lista di potatura**: le sue righe più vecchie di 21 giorni, raggruppate per signal di origine, **una riga a testa e tre opzioni secche** (fatto / muore / diventa un task nello strumento del team). Niente prosa intorno, deve poter rispondere in blocco.

Poi applica le risposte: le righe "fatto" vanno in `## Chiuso di recente` con `- [x]` e la data, quelle "muore" si tolgono dal registro (**restano nel signal di origine**, quindi non si perde niente), quelle che diventano task si tolgono dal registro e nel signal di oggi si scrive dove sono finite.

Il criterio, da dire a voce quando presenti la lista: un thread aperto da tre settimane o si fa o si chiude. Un registro che cresce e basta non fa ricordare niente. Se chi lavora non risponde, le righe nuove si scrivono lo stesso: la potatura è una domanda da rifare finché il numero non rientra, non un blocco.

### 5. Candidati decisione (mai in autonomia)

Se in sessione si è chiuso un ragionamento che vale oltre la settimana (una meccanica scartata, una metrica scelta, una regola nuova), **non scrivere in `decisions/`**. Proponi il candidato in chat, in tre righe: cosa si è deciso, cosa si è scartato, quando andrebbe riaperto. Si scrive solo dopo il sì esplicito dell'owner del canon (vedi [`CLAUDE.md`](../../../CLAUDE.md)), con lo schema di [`decisions/README.md`](../../../decisions/README.md). Se la sessione non è dell'owner, il candidato resta in chat e nel signal: in `decisions/` si scrive quando arriva il sì.

La **regola** che nasce da una decisione vive nel canon (via PR), il **ragionamento** vive in `decisions/`. Una regola nel canon senza il perché è dogma.

### 6. Chiudi su Git

Segui il giro di scrittura del canon ([`canon/operations.md`](../../../canon/operations.md) → "Modello di sync"):

```bash
git pull --rebase --autostash origin main
git add signals/aperto.md signals/manual/<anno>/<mese>/<file>.md   # file specifici, mai -A
git commit -m "session end: <tema in tre parole>"
git push origin main
```

Se `git remote` elenca **più di un remote**, il repo è tenuto a specchio: pusha `main` anche sugli altri (`git push <altro-remote> main`). L'hook `Stop` lo fa da solo a fine turno; questo passo serve a non lasciare il signal in attesa del turno dopo.

**Se la sessione gira su un branch di worktree (`claude/*`), c'è un passo in più, da fare senza che nessuno lo chieda.** L'hook `Stop` pusha il branch corrente su `origin` e si ferma lì: per disegno non tocca mai `main`. Il risultato è che il lavoro resta invisibile a tutti finché non lo si porta su `main`. Una skill corretta in un worktree e mai portata su `main` è una correzione che nessuno vedrà, compresa la prossima sessione.

```bash
for r in $(git remote); do git fetch "$r" main; done
git merge-base --is-ancestor origin/main HEAD   # se passa, è un fast-forward
for r in $(git remote); do git push "$r" HEAD:main; done
```

Da un worktree non serve (e non si può) fare `git checkout main`: `main` è già preso dal checkout principale. Si spinge la punta del branch su `main` del remote: il checkout principale si allinea al suo prossimo `SessionStart`.

Se il fast-forward non passa perché `main` è andato avanti, si fa `git merge origin/main` dentro il worktree, si risolvono i conflitti a mano e si riprova. Mai `--force`.

**Se il branch contiene un commit che non deve andare su `main`** (di solito il canon finito per sbaglio nello stesso commit di altro), non si riscrive la storia del branch: si crea un ramo d'appoggio da `main` e ci si riapplicano solo i commit buoni.

```bash
git fetch origin main
git switch -c sync/<data> origin/main     # sempre un ramo nuovo
git cherry-pick <sha-buono-1> <sha-buono-2>
for r in $(git remote); do git push "$r" HEAD:main; done
git switch -                              # si torna sul branch di lavoro
```

Perché non si riscrive la storia: l'hook `Stop` fa `pull --rebase` del branch dal remote a ogni fine turno. Se si separa un commit con `reset --soft` dopo che l'hook l'ha già pushato, al turno successivo l'hook ripesca il commit vecchio dal remote e lo riapplica sopra ai nuovi. La prevenzione a monte: **il canon si committa da solo, sul suo branch `canon/<scopo>`, mai insieme ad altro**.

Cosa si porta su `main`: skill, signal, entità, deliverable testuali durevoli. Cosa resta fuori: `canon/**`, che passa sempre dalla PR. Se la sessione ha lasciato a metà qualcosa che da solo non regge, lo si lascia sul branch e lo si dice in chat.

Su non-fast-forward: `git pull --rebase --autostash`, riprova, massimo tre volte. **Il canon non si committa mai qui**: se serve una modifica a `canon/**`, lasciala nel working tree e proponi la PR (`git switch -c canon/<scopo>`, commit, `gh pr create`).

### 7. Riepilogo in chat

Massimo dieci righe, in questo ordine: cosa hai scritto e dove (percorsi cliccabili), quanti thread aperti ci sono ora, i candidati decisione che aspettano un sì, cosa hai deliberatamente **non** scritto e perché.

## Regole di scrittura

- Lingua e voce di [`canon/company-rules.md`](../../../canon/company-rules.md) → "Voce".
- Ogni affermazione fattuale porta la sua fonte. Se una fonte non c'è, scrivi che non c'è invece di riempire il buco.
- I contenuti sensibili si omettono con la frase standard "dettaglio fuori dal record per scelta", senza riformulare cosa è stato filtrato.
