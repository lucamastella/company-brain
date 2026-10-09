# companies/

Un file per **azienda** che conta nel vostro contesto. Ci stanno due tipi:

- **L'azienda stessa**: un solo file, con `is_self: true`. È l'ancora del grafo: le persone interne ci puntano con `company: [[<azienda>]]`. Il corpo può essere ricco (posizionamento, voce).
- **Le aziende esterne** che ricorrono: clienti, prospect, partner, fornitori, advisor, competitor. Il compito del file è essere un **bersaglio stabile per i wikilink**, con nome canonico, alias e puntatore al CRM. **Nient'altro.**

Lo stato vivo delle aziende esterne (fase del deal, pipeline, owner, storia, ultimo contatto) vive nel **CRM**. Un agente che ne ha bisogno lo interroga via MCP. I file esterni sono corti per scelta.

Schema da copiare: [`_TEMPLATE.md`](_TEMPLATE.md).

---

## Perché esiste

Perché una skill (o una persona) possa cercare `"companies/<slug>.md"` in `signals/` e trovare ogni recap che ha toccato quell'azienda, senza che il CRM debba sapere del repo e senza che il repo duplichi il CRM.

---

## Quando si crea un file qui

**Alla prima menzione, se il CRM ha un record.**

1. Confronta il nome con gli alias dei file esistenti. Se corrisponde, wikilink.
2. Se il file non c'è, **interroga il CRM** per nome, dominio o alias.
3. Se il CRM ha un record, **crea** `companies/<slug>.md` con `crm_url` compilato e collega la menzione.
4. Se il CRM non ha niente, la menzione resta **testo semplice**.

**Mai un file senza `crm_url`**, competitor esclusi.

---

## Convenzione dei file

Un file per azienda: `<slug>.md`, minuscolo, con i trattini, senza spazi.

### Frontmatter

```yaml
---
name: Esempio Srl                     # grafia canonica
is_self: true                         # SOLO sul file della vostra azienda
aliases:                              # ogni grafia e dominio che compare in trascrizioni, chat, mail
  - Esempio
  - esempio.it
linkedin:                             # URL della pagina aziendale
crm_url:                              # URL del record nel CRM
industry:                             # OBBLIGATORIO (facoltativo per i competitor)
  - "[[<verticale>]]"
relationship:                         # OBBLIGATORIO
  - "[[<tipo>]]"                      # customer | prospect | partner | vendor | advisor | competitor
uses_stack:                           # software esterni che usano, quando si sa
  - "[[<sistema>]]"
docs_url:                             # facoltativo, pagina dell'azienda nel docs system
people:                               # persone di questa azienda che hanno un file
  - "[[<slug-persona>]]"
---
```

- **`is_self`** sta su un solo file: la vostra azienda.
- **Campi obbligatori**, senza segnaposto: `industry` (se il verticale non esiste, **crealo prima**; facoltativo per i competitor) e `relationship`.
- **`crm_url`** obbligatorio per gli esterni, tranne `relationship: [[competitor]]`.
- **Consigliati quando ci sono prove**: `uses_stack` (porta su [`systems/`](../systems/) e permette domande come "quali clienti usano X?") e `docs_url`. Non si compilano a intuito.
- **`aliases`** è il campo critico: è quello che permette di riconoscere una menzione. Mai vuoto.

### Corpo

**Azienda esterna:** una descrizione di 1-2 frasi. Solo fatti stabili (settore, modello, area geografica).

```markdown
# Esempio Srl

## About

Catena di ferramenta con 40 punti vendita nel nord Italia e un e-commerce proprio.
```

**La vostra azienda (`is_self: true`):** il corpo può portare posizionamento e voce, perché è la dichiarazione canonica di chi siete.

```markdown
# <Azienda>

## About
Cosa fa l'azienda, in una o due frasi.

## Posizionamento
Chi servite, cosa vendete, in che categoria giocate.

## Voce
Il tono che ogni agente usa quando parla per l'azienda.
```

**Competitor:** niente `crm_url`, `industry` facoltativo, corpo minimo (una riga su cosa offrono e dove si sovrappongono a voi).

Sulle aziende esterne **non** si aggiungono "perché ci interessa", note, contesto, stato del deal, rischi, date dell'ultimo contatto o prosa sulla relazione.

---

## Come lo usano gli agenti

- **Riconoscere le aziende nelle trascrizioni** tramite nome e alias.
- **Passare al CRM per lo stato**: seguono `crm_url` o interrogano il CRM. Il corpo di un file esterno non si legge per lo stato, non c'è.
- **Ancorare l'identità interna**: il file `is_self: true` è quello a cui puntano le persone interne.

---

## Wikilink

In entrata: da `people/<persona>.md` (`company:`) e dai signal che citano l'azienda. In uscita: `industry:`, `relationship:`, `uses_stack:`. Tabella completa in [`canon/anatomy.md`](../canon/anatomy.md).

---

## Cosa non va qui

- Una sottocartella per cliente o prospect. Un file piatto per azienda.
- Aziende che non stanno nel CRM (competitor esclusi).
- **Prosa** sulla relazione di un'azienda esterna.

---

## Aggiungere o aggiornare un'azienda

1. Interroga il CRM. **Se non c'è un record, ti fermi** (competitor esclusi) e lasci testo semplice.
2. Crea `companies/<slug>.md` con frontmatter (compreso `crm_url`), titolo e `## About` di 1-2 frasi.
3. Aggiorna gli inversi (`industries/`, `relationship-types/`, `systems/`) nella stessa scrittura.
4. Commit su `main` con `companies: add <nome>` o `companies: update <nome>, <cosa cambia>`.
