# Indice · cervello di {{NOME_AZIENDA}}

> Il catalogo di tutto quello che c'è nel repo. Le persone lo usano come sommario; gli agenti entrano da [`CLAUDE.md`](CLAUDE.md) e consultano questo file per orientarsi.

---

## Modello di lettura: aperto per default

**Proprietà e scrittura sono confinate, la lettura è aperta.**

Ogni team possiede una fetta del repo (le sue regole e il suo indice) e la cambiano solo il lead del team oppure {{OWNER_CANON}}. Il canon ([`canon/`](canon/)) passa da una PR per regola. Le cartelle trasversali ([`signals/`](signals/), [`people/`](people/), [`companies/`](companies/), [`articles/`](articles/), [`.claude/skills/`](.claude/skills/)) e il livello di dominio ([`industries/`](industries/), [`systems/`](systems/), [`products/`](products/), [`themes/`](themes/), [`objectives/`](objectives/), [`projects/`](projects/), [`relationship-types/`](relationship-types/), [`job-titles/`](job-titles/)) stanno alla radice e collegano i team con i wikilink invece di stare sotto uno di loro. **Ognuno legge qualsiasi fetta gli serva**, a prescindere dal team: una skill che prepara un deck commerciale legge la voce del brand dal team che la possiede, i signal di oggi e la scheda dell'azienda cliente.

Non esiste un filtro per team in lettura. Tutto il repo è il contesto: la proprietà protegge le scritture, non le letture.

Quando due file sono in disaccordo, [`canon/company-rules.md`](canon/company-rules.md) → "Ordine di verità" decide chi vince: il **canon** (company-rules → operations → anatomy → profile → team → skill) vince sullo **stato operativo** (signals), che vince sugli **input esterni** ([`articles/`](articles/), solo citazione, mai canon).

---

## Canon · `canon/` (solo via PR)

| File | A cosa serve |
|---|---|
| [canon/company-rules.md](canon/company-rules.md) | La costituzione: identità, posizionamento, voce, valori, esclusioni, ordine di verità, dati cliente, perimetro dei file. |
| [canon/operations.md](canon/operations.md) | Come opera l'agente: postura proattiva, perimetro del repo, sync, citazioni, protocollo di sessione, decisioni, scansione delle entità, doppia scrittura dei wikilink. |
| [canon/operating-system.md](canon/operating-system.md) | Come l'azienda pianifica ed esegue: OKR → Progetto → Attività → Task. |
| [canon/anatomy.md](canon/anatomy.md) | La forma del grafo: cartelle, schemi, glossario, fonti esterne, coppie di wikilink. |
| [canon/profile.md](canon/profile.md) | I fatti sull'azienda: nome, mercato, leadership, team, integrazioni, missione, temi dell'anno. |
| [canon/icp.md](canon/icp.md) | (Opzionale) Il cliente ideale. |
| [canon/competition.md](canon/competition.md) | (Opzionale) Il panorama competitivo. |
| [canon/team/<team>.md](canon/team/) | Le regole di ogni team. Un file per team, si parte da `_TEMPLATE.md`. |

## Avvio dell'agente (radice)

| File | A cosa serve |
|---|---|
| [CLAUDE.md](CLAUDE.md) | Sequenza di avvio, smistamento della memoria, protocollo di sessione, ordine di verità. Se si adotta un agente diverso da Claude, si crea `AGENTS.md` come copia speculare. |
| [scripts/](scripts/) | Gli hook: `git_sync_pull.sh` (pull e pulizia lock a inizio sessione), `session_context.sh` (thread aperti nel contesto), `git_autosave.sh` (commit e push a fine turno, salta `canon/`), `guard_perimetro.sh` (perimetro dei file), `check_playwright_cli.sh` (controllo opzionale del browser da riga di comando). |

## Entità

| Cartella | Un file per | Si legge per |
|---|---|---|
| [people/](people/) | Ogni persona, interna o esterna. Interno o esterno si ricava da `company:`. | Scope e anti-scope, alias, autorità decisionale (interni), `crm_url` (esterni), `job_title`. |
| [companies/](companies/) | Ogni organizzazione: l'azienda stessa (`is_self: true`) e ogni cliente, prospect, partner, fornitore, advisor, competitor. | `relationship`, `industry`, `uses_stack`, `people`, `crm_url`. Lo stato vivo resta nel CRM. |

## Livello di dominio (si cura mentre si lavora)

| Cartella | Un file per | Destinazione di |
|---|---|---|
| [industries/](industries/) | Verticale in cui l'azienda vende | `companies.industry` |
| [systems/](systems/) | Software esterno che usano i clienti | `companies.uses_stack` |
| [products/](products/) | Un prodotto dell'azienda, puntatore leggero via `docs_url` | nessun arco in entrata dal frontmatter |
| [themes/](themes/) | Tema su cui l'azienda ragiona | `articles.themes`, `signals.related_to_themes`, `decisions.related_to_themes` |
| [relationship-types/](relationship-types/) | Tipo di relazione (enum chiuso) | `companies.relationship` |
| [job-titles/](job-titles/) | Ruolo canonico di una persona | `people.job_title` |
| [objectives/](objectives/) | Un quarter: Objective e KR, puntatore allo stato vivo | `projects.objective` |
| [projects/](projects/) | Un Progetto globale: owner, KR mossi, kill-or-ship | `signals.related_to_projects` |

## Signal, decisioni, articoli, skill

| Cartella | Cosa contiene |
|---|---|
| [decisions/](decisions/README.md) | Un file per decisione chiusa: decisione, alternative scartate, perché, quando riaprirla. Ci entra solo col sì esplicito di {{OWNER_CANON}}. |
| [signals/](signals/) | Sintesi datate e append-only: recap di call ([`daily-call/`](signals/daily-call/)), digest email ([`email/`](signals/email/)), note e sessioni ([`manual/`](signals/manual/)). |
| [signals/aperto.md](signals/aperto.md) | Il registro rotante dei thread non chiusi. Lo scrive `session-end`, lo leggono `session-start` e l'hook di inizio sessione. |
| [articles/](articles/) | Un file per fonte esterna analizzata: puntatore e TL;DR. |
| [knowledge/](knowledge/) | (Opzionale) Area di migrazione per i documenti esistenti, finché non entrano nel canon. |
| [.claude/skills/](.claude/skills/) | Le skill operative, nel percorso di Claude Code. |

## Team

Le regole dei team stanno in [`canon/team/`](canon/team/) (via PR). Gli indici stanno in [`team/<team>/`](team/) (push diretto). Il quadro operativo di un team non è un file: si legge dal grafo, filtrando i signal su `teams_impacted`.

| Team | Cartella | Regole |
|---|---|---|
| <!-- es. Leadership --> | <!-- team/leadership/ --> | <!-- canon/team/leadership.md --> |

---

## Come lo usa un team

1. Parti da [profile.md](canon/profile.md) e [company-rules.md](canon/company-rules.md) per capire chi siamo e come parliamo.
2. Leggi [operations.md](canon/operations.md) e [anatomy.md](canon/anatomy.md) per interpretare gli input nel modo giusto.
3. Per proprietà e autorità decisionale, guarda [people/](people/).
4. Per un cliente o un partner, apri [companies/](companies/) e segui i wikilink; lo stato vivo sta nel CRM.
5. Per il quadro operativo del tuo team, leggi i [signal](signals/) filtrati su `teams_impacted`.
6. Per i filtri e i paletti del tuo team, leggi `canon/team/<tuo-team>.md`.
7. Apri e chiudi ogni blocco di lavoro con `session-start` e `session-end`.

## Come si cerca

1. Parti da qui e scegli il file o la cartella giusta.
2. Per il contesto di altri team, scorri i [signal](signals/) per `teams_impacted`.
3. Per la ricerca libera usa `rg "<termine>"` quando l'indice non basta.
