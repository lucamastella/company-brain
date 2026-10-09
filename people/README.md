# people/

Un file per **persona**, interna o esterna. **Una cartella, uno schema.** Interno o esterno si ricava dal wikilink `company:` nel frontmatter:

- **Team interno** → `company: [[<azienda>]]` (la vostra, il file con `is_self: true`). Lo curano le persone. Ha `team:`, `reports_to:`, `direct_reports:` e le sezioni `## Scope`, `## Anti-scope`, `## Autorità decisionale`.
- **Esterno** (contatto di un cliente, di un prospect, di un partner, fornitore, advisor) → `company:` punta a qualsiasi altro `companies/<slug>.md`. Si crea alla prima menzione se il CRM ha un record. Ha `crm_url:`, un breve `## About` e il link all'azienda. I campi interni si omettono.

È la fonte unica per **chi è chi**, **come compare nei sistemi** (speaker nelle trascrizioni, handle in chat, email), **cosa possiede** e **cosa non possiede**.

Lo leggono tutti gli agenti. Quello che è riservato (compensi, valutazioni, piani di successione) **non** va qui.

Schema da copiare: [`_TEMPLATE.md`](_TEMPLATE.md).

---

## Asimmetria del corpo: interni ed esterni

**Stessa cartella, stesso bersaglio per i wikilink, peso diverso.**

| | Persona interna | Persona esterna |
|---|---|---|
| `company:` | `[[<azienda>]]` | qualsiasi altro `companies/<slug>.md` |
| Fonte del contesto personale | **il repo** | **il CRM** (tramite `crm_url`) |
| Sezioni del corpo | `## Azienda`, `## Team`, `## Scope`, `## Anti-scope`, `## Autorità decisionale`; facoltative `## Stile`, `## Come scrivo`, `## Come lavorare con me`, `## Contesto` | `## About` (1-2 frasi), `## Azienda`. **Nient'altro.** |
| Creazione | la curano le persone, mai da una menzione | alla prima menzione, se il CRM ha un record |

Il principio: **il corpo riflette dove vive la verità.** Il CRM è la fonte per il grafo dei clienti, quindi un file esterno è un puntatore leggero. Per la voce di una fondatrice o l'anti-scope di un ingegnere non esiste un CRM: la fonte è il repo: il corpo cresce quanto serve. Una sezione `## Come scrivo` su un file esterno è sbagliata.

---

## Perché una cartella sola

Dividere interni ed esterni in due cartelle non porta niente: stessa forma, due README, due schemi. Domande come "tutti i CEO che conosciamo" dovrebbero unire due cartelle. Con una cartella sola `company:` fa tutto il lavoro: "tutti i responsabili vendite" → `job-titles/<ruolo>.md → people:`; "tutti in `<cliente>`" → `companies/<cliente>.md → people:`; "tutti gli ingegneri interni" → filtro su `company` e `team`.

---

## Quando si crea un file qui

**Persone interne:** le curano le persone. Chi guida un team crea il file all'assunzione (o lo recupera per chi c'è già). **Mai da una menzione.**

**Persone esterne:** **alla prima menzione, se il CRM ha un record.**

1. Confronta il nome con gli alias dei file esistenti. Se corrisponde, wikilink.
2. Se il file non c'è, **interroga il CRM** per nome, email o alias.
3. Se il CRM ha un record, **crea** `people/<nome>-<cognome>.md` con `company:` e `crm_url:` compilati, poi collega la menzione.
4. Se il CRM non ha niente, la menzione resta **testo semplice**. Niente file vuoti.

**Mai un file esterno senza `crm_url`.** Un file senza collegamento al CRM finge che l'entità sia nel sistema senza dare un percorso verso lo stato vivo.

---

## Convenzione dei file

Un file per persona: `<nome>-<cognome>.md`, minuscolo, con i trattini. Lo slug coincide con `git config user.name` in minuscolo con i trattini: è così che gli hook e le skill riconoscono chi sta lavorando.

### Frontmatter per tutti

```yaml
---
name: Giulia Verdi                   # grafia canonica
short: Giulia                        # facoltativo, come la si chiama di solito
aliases:                             # ogni forma in cui compare nei sistemi, mai vuoto
  - Giulia
  - g.verdi@<dominio>
linkedin:                            # URL del profilo
company:
  - "[[<azienda>]]"                  # interna → la vostra; esterna → la sua
job_title:
  - "[[<ruolo>]]"                    # da job-titles/
---
```

### Solo interni

```yaml
founder: true                        # solo per chi ha fondato l'azienda
reports_to:
  - "[[<slug-responsabile>]]"        # si omette al vertice
direct_reports:                      # inverso manuale di reports_to
  - "[[<slug-collaboratore>]]"
start_date: YYYY-MM-DD
timezone: <fuso>                     # es. Europe/Rome
team:
  - "[[<team>]]"
external_collaborator: true          # solo per chi lavora dentro un team senza essere in organico
status: uscita                       # solo per chi ha lasciato l'azienda
end_date: YYYY-MM                    # con status: uscita
```

#### `external_collaborator: true`

Terzo stato oltre a interno ed esterno: **una persona che non è in organico ma lavora dentro un team**, come un manager a tempo parziale o un collaboratore continuativo. Usa la forma interna (`company: [[<azienda>]]`, `team`, scope) perché nei recap compare come chi è in organico; il campo serve a non spacciarla per dipendente. Per clienti, fornitori e advisor si usa la forma esterna: conta dove la persona lavora, non il tipo di contratto.

#### `status: uscita`

Una persona che ha lasciato l'azienda. **Il file non si cancella**: i signal passati la citano. Nella stessa scrittura:

1. un blocco in cima al corpo dice che non è più operativa (con la data) e che non va assegnata né indicata come referente;
2. i titoli delle sezioni vanno al passato (`## Scope, cosa possedeva`);
3. la persona esce dal roster attivo del team (`team/<team>/<team>.md → people_involved`), mentre il `team:` sul suo file resta per lo storico.

### Solo esterni

```yaml
crm_url:                             # URL del contatto nel CRM, OBBLIGATORIO
twitter:                             # facoltativo
website:                             # facoltativo
```

### Corpo

**Persona interna:**

```markdown
# Giulia Verdi

## Azienda
[[<azienda>]]

## Team
[[<team>]]

## Scope, cosa possiedo
Responsabilità concrete, espresse con verbi e non con titoli.

## Anti-scope, cosa non possiedo
Ogni voce è un'idea sbagliata che un agente potrebbe farsi.

## Autorità decisionale
Cosa firma da sola e cosa richiede un'altra firma.

## Stile (facoltativo)
Quello che aiuta un agente a scrivere nella sua voce.

## Come scrivo (facoltativo)
Ritmo delle frasi, registro, cosa evitare, per superficie (mail interna, post pubblico, messaggio).

## Come lavorare con me (facoltativo)
Asincrono o no, come preferisce discutere, cosa la sblocca.

## Contesto (facoltativo)
Percorso, ruoli precedenti, competenze.
```

**Persona esterna:**

```markdown
# Mario Neri

## About
1-2 frasi: chi è, il ruolo, eventualmente il percorso. Solo fatti stabili.

## Azienda
[[<sua-azienda>]]
```

Sui file esterni **non** si aggiungono note, contesto, coinvolgimento nei deal, preferenze, storia o prosa sulla relazione: vive nel CRM e qui invecchia in settimane.

---

## Come lo usano gli agenti

- **Riconoscere gli speaker nelle trascrizioni**: si confronta l'alias con tutti i file della cartella prima di assegnare qualcosa.
- **Validare chi possiede un'azione**: prima di scrivere "Owner: X" per una persona interna, si guarda il suo `## Anti-scope`. Se l'azione ci ricade, si segnala invece di assegnarla in silenzio.
- **Instradare un'escalation**: `reports_to` e `## Autorità decisionale`.
- **Preparare un brief su una persona esterna**: file → `company:` → scheda dell'azienda → `crm_url` per lo stato vivo.
- **Scrivere a nome di qualcuno**: si legge `## Come scrivo` (vedi [`canon/operations.md`](../canon/operations.md) → "Scrivere nella voce del soggetto").

---

## Cosa non va qui

- Compensi, valutazioni, piani di successione: niente che chi guida l'azienda non vorrebbe far leggere a ogni agente.
- Persone esterne che non stanno nel CRM.
- **Prosa lunga** sulla relazione o sulla storia di un esterno.

---

## Relazioni wikilink

| Diretto (su `people/<x>.md`) | Inverso (su …) |
|---|---|
| `company: [[<azienda>]]` | `companies/<azienda>.md → people: [[<persona>]]` |
| `job_title: [[<ruolo>]]` | `job-titles/<ruolo>.md → people: [[<persona>]]` |
| `team: [[<team>]]` (solo interni) | `team/<team>/<team>.md → people_involved: [[<persona>]]` |
| `reports_to: [[<responsabile>]]` (solo interni) | `people/<responsabile>.md → direct_reports: [[<persona>]]` |

Doppia scrittura secondo [`canon/anatomy.md`](../canon/anatomy.md) e [`canon/operations.md`](../canon/operations.md).

---

## Aggiungere o aggiornare una persona

1. Interna: crea o modifica `people/<nome>-<cognome>.md` con frontmatter comune e interno, più le sezioni del corpo.
2. Esterna: prima il CRM. Se non c'è un record, ti fermi e lasci testo semplice. Se c'è, crei il file con `crm_url`.
3. In entrambi i casi aggiorni gli inversi nei file partner **nella stessa scrittura**.
4. Commit su `main` (fuori da `canon/` non serve la PR).

Uno `## Scope` vecchio è peggio di nessuno `## Scope`: inganna gli agenti.
