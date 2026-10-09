# Anatomy

> La forma del grafo: cartelle, frontmatter, coppie di wikilink, fonti di verità esterne, percorsi di navigazione. Le procedure stanno in [`operations.md`](operations.md), i valori in [`company-rules.md`](company-rules.md), i fatti sull'azienda in [`profile.md`](profile.md).
>
> Quando i file sono in disaccordo, [`company-rules.md`](company-rules.md) → "Ordine di verità" decide chi vince.

<!--
COME SI COMPILA
- La mappa delle cartelle, le coppie di wikilink e le regole di asimmetria sono la struttura del
  template: tienile. Cambiale solo se aggiungi o togli una cartella, via PR.
- Da compilare: la tabella "Fonti di verità esterne" (i vostri strumenti), il glossario, le grafie
  dei nomi e le sale riunioni. Si riempiono col tempo, la prima volta che un agente sbaglia.
-->

---

## Mappa del dominio: dove vivono le cose

Ogni entità del repo vive in una cartella dedicata. Il README della cartella ne descrive lo schema.

| Cartella | Cosa contiene | Destinazione wikilink |
|---|---|---|
| [`people/`](../people/) | Ogni persona, interna o esterna (cliente, prospect, partner, fornitore, advisor). Interno o esterno si ricava da `company:` (interno = `[[<azienda>]]`). | `[[<nome-cognome>]]` |
| [`companies/`](../companies/) | Ogni organizzazione: l'azienda stessa (`is_self: true`) e ogni organizzazione esterna. | `[[<slug-azienda>]]` |
| [`canon/`](.) | I file del canon. **Ogni modifica passa da una PR.** | solo link per percorso |
| [`industries/`](../industries/) | Verticali o segmenti di mercato in cui l'azienda vende | `[[<slug-verticale>]]` |
| [`systems/`](../systems/) | Software esterni che i clienti usano nel loro stack | `[[<slug-sistema>]]` |
| [`products/`](../products/) | I prodotti dell'azienda come **puntatori** leggeri via `docs_url`; le specifiche vivono nel sistema che le possiede. | `[[<slug-prodotto>]]` |
| [`objectives/`](../objectives/) | Un file per **quarter**: Objective e KR globali, puntatore allo stato vivo su {{DOCS_SYSTEM}}. | `[[<quarter>]]` (es. `[[q1-2027]]`) |
| [`projects/`](../projects/) | Un file per **Progetto globale** (per scope: Discovery, Delivery, BAU): owner, team, KR mossi, kill-or-ship, puntatore allo stato vivo. Vedi [`operating-system.md`](operating-system.md). | `[[<slug-progetto>]]` |
| [`relationship-types/`](../relationship-types/) | I tipi di relazione, enum chiuso (`customer`, `prospect`, `partner`, `vendor`, `advisor`, `competitor`) | `[[<tipo>]]` |
| [`job-titles/`](../job-titles/) | I ruoli canonici delle persone, interne ed esterne | `[[<slug-ruolo>]]` |
| [`themes/`](../themes/) | I temi su cui l'azienda ragiona; destinazione di articoli, signal e decisioni | `[[<slug-tema>]]` |
| [`articles/`](../articles/) | Puntatore e TL;DR per le fonti esterne analizzate | nessun arco in entrata da repo esterni |
| [`signals/daily-call/YYYY/MM/`](../signals/daily-call/) | Recap delle call, un file per persona al giorno: `<slug-persona>_YYYY-MM-DD.md`. **Mai sotto `team/`.** | nessun arco in entrata; append-only |
| [`signals/email/YYYY/MM/`](../signals/email/) | Digest email, un file per persona al giorno | nessun arco in entrata; append-only |
| [`signals/manual/YYYY/MM/`](../signals/manual/) | Signal inseriti a mano (osservazioni, analisi) e signal di sessione scritti da `session-end`, che aggiungono la sezione `## Aperto` | archi solo fra signal (`related_to_signals`) |
| [`signals/aperto.md`](../signals/aperto.md) | Registro rotante dei thread non chiusi. **Cache derivata** dalle sezioni `## Aperto` dei signal: se divergono, vince il signal. | file singolo, nessun wikilink |
| [`decisions/`](../decisions/README.md) | Un file per **decisione chiusa**: decisione, alternative scartate, perché, quando riaprirla. `YYYY-MM-DD_<tema-slug>.md`. Ci entra solo dopo il sì esplicito di {{OWNER_CANON}}. | `[[<nome-file>]]` (solo per `supersedes` e `superseded_by`) |
| [`knowledge/`](../knowledge/) | (Opzionale) Area di migrazione per documenti esistenti, finché non vengono assorbiti nel canon e nelle entità. | nessuno |
| [`team/<team>/<team>.md`](../team/) | Indice di team, uno per cartella | `[[<slug-team>]]` |
| [`canon/team/<team>.md`](team/) | Regole di team, parte del canon | solo link per percorso |
| [`.claude/skills/<slug>/SKILL.md`](../.claude/skills/) | Comportamenti riutilizzabili degli agenti, nel percorso di Claude Code | `[[<slug-skill>]]` |

---

## La tassonomia delle cartelle è chiusa

La mappa qui sopra è l'**elenco completo** delle cartelle in cui un agente può scrivere. Le cartelle nuove sono rare e deliberate. Fanno parte dello schema le sottocartelle per skill in [`.claude/skills/<slug>/`](../.claude/skills/) e quelle per periodo in [`signals/<fonte>/YYYY/MM/`](../signals/). Tutto il resto passa dalla procedura in [`operations.md`](operations.md) → "Creazione di cartelle: prima si contesta, poi PR".

Due precisazioni:

- **`team/` contiene solo team funzionali** (es. `leadership`, `marketing`, `prodotto`, `engineering`, `vendite`). **Mai il nome di un'azienda** (l'azienda stessa è `companies/<azienda>.md`) e **mai una sottocartella per un cliente o un prospect** (sono entità in `companies/`, con lo stato nel CRM e i deliverable nel loro strumento).
- **Nessuna cartella per cliente, da nessuna parte.** I deliverable per un cliente (deck, brief, onboarding) li produce una skill con il cliente come input: finiscono nello strumento giusto. Il repo tiene l'entità stabile e la skill generica.

---

## Navigare il grafo per avere contesto

Quando ti chiedono qualcosa di concreto (un recap, un brief, una mail), scegli il **nodo d'ingresso** giusto e muoviti da lì:

- **Su un cliente, un prospect, un partner** → parti da `companies/<X>.md`. Leggi il frontmatter: `industry`, `relationship`, `uses_stack`, `people`. Ognuno è un wikilink: seguili e in 1-2 salti hai il contesto. Per un cliente attivo segui anche `docs_url`. Poi leggi i signal che lo citano (vista "Referenced by" dell'editor oppure `grep "companies/<X>.md" signals/`).
- **Su una persona** → parti da `people/<slug>.md`. Leggi `company` e `job_title`; per gli interni anche `team`, `reports_to`, `direct_reports`. Per un esterno segui `company` e applica il percorso dell'azienda.
- **Su un prodotto** → parti da `products/<slug>.md` per la descrizione breve e il `docs_url`, poi apri la pagina della specifica.
- **Su un tema** → parti da `themes/<slug>.md`: le liste `articles`, `signals` e `decisions` ti danno tutto quello che è stato scritto in un salto.
- **Su cosa sta succedendo** → interroga `signals/<fonte>/YYYY/MM/*.md`. Il frontmatter è la fonte del routing: `date`, `teams_impacted`, `related_to_*`. Filtra per `teams_impacted`, ordina per data, segui i wikilink.

Grazie alle coppie diretta e inversa ogni nodo sa a chi punta e chi punta a lui: entri da qualsiasi punto e raggiungi il resto in 1-3 salti.

---

## Asimmetria del corpo: stessa cartella, peso diverso

`people/` e `companies/` sono cartelle uniche per scelta: una cartella, uno schema, un piano di wikilink. Il **corpo** di un file invece cresce in base a dove vive la verità:

- **Entità esterne** (ogni azienda tranne la propria, ogni persona con `company:` diverso dall'azienda): corpo minimo, cioè `# Nome`, un breve `## About` e il link all'azienda. Lo stato vivo e il contesto ricco stanno nel CRM. Il file è un bersaglio stabile per i wikilink, niente di più.
- **Entità interne** (l'azienda stessa e le persone interne): il corpo cresce quanto serve, con scope, anti-scope, autorità decisionale, stile, voce, preferenze. Per la voce di una persona interna non esiste un CRM: la fonte è il repo.

Il principio: **il corpo riflette dove vive la verità.** Quando la verità sta in un sistema esterno, il file è un puntatore leggero. Quando sta nel repo, il corpo la porta.

**`crm_url` è obbligatorio per i file esterni, con un'eccezione.** Una persona o un'azienda esterna non esiste nel repo senza `crm_url`: è il suo certificato di nascita. **L'eccezione** sono le aziende con `relationship: [[competitor]]`: si seguono per intelligence competitiva, non stanno nel CRM, quindi niente `crm_url` e `industry` facoltativo. Le persone interne possono avere `crm_url` vuoto.

**I clienti possono avere un `docs_url`**, che punta alla loro pagina nel docs system (fase, progetti, KPI di delivery). Si compila solo per i clienti attivi.

La procedura di scrittura (quando e come si crea un file da una menzione, cosa fare quando il CRM non risponde) sta in [`operations.md`](operations.md) → "Entità esterne: si creano alla prima menzione".

---

## Glossario

Termini interni che compaiono in trascrizioni, chat e documenti e che hanno bisogno di una grafia o di una definizione canonica. Si aggiunge una riga appena un agente chiede "cosa intendevano con X?".

| Termine | Grafia canonica | Cosa vuol dire |
|------|-------------------|---------------|
| `<NomeInterno>` | `<Nome Interno>` | Nome in codice di un prodotto o di una funzione, così l'agente non inventa varianti. |
| `<ACRONIMO>` | `<ACRONIMO>` | Un acronimo interno, con l'espansione e il significato nel vostro contesto. |

*Cosa ci sta: nomi di prodotti e componenti, nomi di clienti con la maiuscola giusta, sigle interne di processi o modelli, etichette di metodo usate in call che chi legge a freddo non capirebbe.*

---

## Grafie dei nomi di clienti e aziende

*(Sezione opzionale, si riempie la prima volta che un agente sbaglia un nome.)*

| Sentito o letto come | Grafia canonica | Note |
|---|---|---|
| | | |

---

## Sale riunioni

Gli uffici hanno spesso **sale con un nome**. Quando una call parte da una di quelle sale, lo strumento di trascrizione mette tutti i presenti sotto un'unica etichetta con il nome della sala. **Un'etichetta di sala non è una persona.** In una call possono esserci dentro una persona o dieci: cambia ogni volta.

**Sale in uso**

- **<Sala A>**: sala condivisa.

**Come si tratta un'etichetta di sala in una trascrizione**

1. Non associarla a una persona fissa.
2. Ricava chi c'era in quella call (chiedi, guarda l'invito, guarda i messaggi precedenti).
3. Per ogni frase attribuita alla sala, disambigua guardando a chi si rivolge la domanda e quale scope copre l'argomento (vedi [`people/`](../people/)).
4. Se resta ambiguo, attribuisci alla sala con l'elenco dei presenti, es. `<Sala A> (<Nome1> / <Nome2>)`. Non indovinare una persona.

---

## Fonti di verità esterne

Gli agenti hanno bisogno di informazioni che non vivono nel repo. Il repo cura il contesto e **non** duplica lo stato che vive altrove: quando serve quello stato, si va nel sistema giusto.

| Dominio | Sistema che fa fede | Come ci accede l'agente |
|---|---|---|
| Clienti, deal, pipeline | {{CRM}} | MCP |
| Trascrizioni delle call | <!-- strumento di trascrizione --> | MCP |
| Roadmap, specifiche, documenti interni, OKR vivi | {{DOCS_SYSTEM}} | MCP |
| Catalogo prodotti | <!-- es. {{DOCS_SYSTEM}} o il CMS --> | MCP; `products/<slug>.md` è un puntatore via `docs_url` |
| Email con clienti e partner | <!-- es. Gmail, Outlook --> | MCP |
| Chat di team | {{CHAT_TOOL}} | MCP |
| Calendario | <!-- es. Google Calendar, Outlook --> | MCP |
| Codice, PR, issue | GitHub (`{{REPO_URL}}` e i repo di prodotto) | `gh` CLI |
| Signal a record (recap, digest, analisi) | Questo repo, [`signals/`](../signals/) | lettura diretta |

**Regole per chi legge questi sistemi:**

1. **Prima di scrivere di un cliente**, consulta il CRM (stato attuale della relazione) e l'ultimo scambio email. Se l'accesso fallisce, dichiara il buco invece di inventare.
2. **Prima di scrivere di una conversazione registrata**, leggi la trascrizione: mai parafrasare il riassunto di qualcun altro.
3. **Prima di scrivere di un prodotto o della roadmap**, controlla la versione canonica nel docs system.
4. **Il repo vince sul contesto aziendale** (regole, obiettivi, voce, convenzioni, persone). I sistemi esterni vincono sullo stato che cambia di continuo.
5. **Mai duplicare** nel repo un contenuto che vive in un sistema esterno: si linka.

Quando adottate una nuova fonte di verità, aggiungete la riga.

---

## Il grafo su due livelli: frontmatter e corpo

- **Relazioni wikilink nel frontmatter** (YAML): è il livello **canonico**. Gli agenti lo leggono, un editor Markdown locale (es. Obsidian) lo mostra come sezioni dedicate, la tabella delle coppie qui sotto ne è la forma autorevole.
- **Link nel corpo** (`[etichetta](percorso)` o `[[slug]]`): è il livello di **navigazione per le persone**. Va tenuto allineato al frontmatter quando si scrive, ma non è la fonte di verità.

Per trovare chi cita un file: la vista "Referenced by" dell'editor oppure `grep "<nome-file>"`.

---

## Relazioni wikilink nel frontmatter: coppie diretta e inversa

Il grafo vive nel frontmatter di ogni file. L'inversa automatica degli editor scatta solo sui nomi di relazione predefiniti; per i nostri campi semantici dichiariamo a mano entrambi i lati di ogni arco.

La **procedura di doppia scrittura** (ogni modifica a un arco diretto aggiorna l'inverso nella stessa scrittura) sta in [`operations.md`](operations.md) → "Wikilink: sempre doppia scrittura". Questa tabella è la **forma** che quella procedura fa rispettare.

| Diretto (dichiarato su …) | Inverso (dichiarato su …) |
|---|---|
| `people/<x>.md → team: [[<team>]]` | `team/<team>/<team>.md → people_involved: [[<persona>]]` |
| `people/<collaboratore>.md → reports_to: [[<responsabile>]]` | `people/<responsabile>.md → direct_reports: [[<collaboratore>]]` |
| `people/<x>.md → company: [[<azienda>]]` | `companies/<azienda>.md → people: [[<persona>]]` |
| `people/<x>.md → job_title: [[<ruolo>]]` | `job-titles/<ruolo>.md → people: [[<persona>]]` |
| `companies/<x>.md → industry: [[<verticale>]]` | `industries/<verticale>.md → companies: [[<azienda>]]` |
| `companies/<x>.md → relationship: [[<tipo>]]` | `relationship-types/<tipo>.md → companies: [[<azienda>]]` |
| `companies/<x>.md → uses_stack: [[<sistema>]]` | `systems/<sistema>.md → companies: [[<azienda>]]` |
| `articles/<x>.md → themes: [[<tema>]]` | `themes/<tema>.md → articles: [[<articolo>]]` |
| `signals/<fonte>/<periodo>/<x>.md → related_to_themes: [[<tema>]]` | `themes/<tema>.md → signals: [[<signal>]]` |
| `signals/manual/<periodo>/<x>.md → related_to_signals: [[<signal>]]` | `signals/<…>/<signal>.md → related_to_signals: [[<x>]]` |
| `.claude/skills/<slug>/SKILL.md → owner: [[<team-o-persona>]]` | `team/<team>/<team>.md → skills: [[<skill>]]` (o `people/<x>.md → skills:` per le skill personali) |
| `.claude/skills/<slug>/SKILL.md → creator: [[<persona>]]` | `people/<persona>.md → skills_created: [[<skill>]]` |
| `projects/<x>.md → objective: [[<quarter>]]` | `objectives/<quarter>.md → projects: [[<progetto>]]` |
| `decisions/<x>.md → related_to_themes: [[<tema>]]` | `themes/<tema>.md → decisions: [[<decisione>]]` |
| `decisions/<nuova>.md → supersedes: [[<vecchia>]]` | `decisions/<vecchia>.md → superseded_by: [[<nuova>]]` |

**Eccezione: i signal.** I signal dichiarano in avanti `author`, `teams_impacted`, `related_to_people`, `related_to_companies`, `related_to_products`, `related_to_systems`, `related_to_themes`, `related_to_projects`. Come regola generale **non** ricevono l'inverso sull'entità citata: i signal crescono senza limite e tenere gli inversi su tassonomie illimitate (persone, aziende) esploderebbe. Per quelle si usa la vista "Referenced by".

**Eccezione all'eccezione: temi e catena dei signal.** `themes/` è una tassonomia piccola e preziosa per le domande trasversali ("ogni call che ha toccato il tema X"), quindi l'inverso `themes/<tema>.md → signals:` **si dichiara** a mano. Lo stesso vale per `related_to_signals`: il filo fra un signal e i suoi predecessori si scrive su entrambi i lati, altrimenti chi parte dal signal vecchio non trova il seguito.

**Eccezione: le decisioni.** Seguono la regola dei signal: i `related_to_*` non ricevono inverso, tranne i temi. Le due facce di `supersedes` e `superseded_by` si scrivono **sempre** nella stessa operazione: è l'unica modifica ammessa a una decisione già scritta. Prima di applicare una decisione, controlla `superseded_by:`.

---

## Regola di direzione

Dal trasversale allo specifico, non viceversa.

- [`people/`](../people/), [`companies/`](../companies/), [`signals/`](../signals/), [`articles/`](../articles/) e [`.claude/skills/`](../.claude/skills/) sono le cartelle trasversali alla radice e puntano **dentro** [`team/`](../team/).
- Il file di una persona vive sempre in [`people/`](../people/), interna o esterna, mai sotto la cartella di un team, anche se lavora con un team solo.
