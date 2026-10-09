# articles/

Un file per **fonte esterna analizzata**: un articolo, un video, un podcast, un libro, un transcript, una ricerca di cui si è chiesto "spiegami, riassumi, estrai le regole" e che **serve all'azienda o al team** (un metodo applicabile, un concorrente letto, un playbook, una tesi che cambia o rinforza una posizione). Puntatore, TL;DR e wikilink alle entità toccate. Nient'altro.

**Gli articoli si citano, non sono canon.** Un file qui è un puntatore congelato al lavoro di qualcun altro più la vostra lettura. Non ha autorità prescrittiva: le posizioni dell'azienda vivono in [`canon/`](../canon/). Un articolo si cita, un agente non gli obbedisce mai.

La fonte vive sul web. Questa cartella è **un grafo di puntatori e letture**, non una raccolta di ritagli.

---

## Quando si crea un file

Quando l'analisi serve a più di una persona del team. Se serve solo a chi l'ha fatta per capire il mondo, va nella sua knowledge base personale, fuori dal repo. Se serve solo alla conversazione, non va da nessuna parte. Se dall'analisi nascono azioni o decisioni, quelle vanno in un signal che punta a questo file, senza ripetere la sintesi.

---

## Convenzione dei file

`<prefisso-fonte>-<slug>.md`, minuscolo, con i trattini. Il prefisso è una sigla corta dell'editore o del canale, così la cartella si ordina per fonte; lo slug riassume il titolo in 3-6 parole.

### Frontmatter (obbligatorio)

```yaml
---
title: "<Titolo>"
url: https://<url>
author: <autore o autori>
published: YYYY-MM-DD                  # o YYYY-MM se non si sa il giorno
added: YYYY-MM-DD                      # quando è stato creato il file
themes:                                # OBBLIGATORIO, wikilink a themes/<slug>.md
  - "[[<slug-tema>]]"
---
```

`themes` è l'asse navigabile. Se un tema non ha ancora il suo file, lo si crea (1-2 frasi di definizione più l'inverso `articles: [[<questo-articolo>]]`). Le due direzioni si scrivono nella stessa modifica.

### Corpo

```md
# <titolo>

**TL;DR**: 3-6 righe. La tesi, i numeri che contano, cosa non regge, perché lo tenete.

**Citati**: [[<slug-azienda>]], [[<slug-persona>]]
```

È tutto il corpo. **Non** si riscrive la fonte, non si incollano citazioni lunghe, non si tiene un diario di riletture. I wikilink in "Citati" si mettono solo quando il file dell'entità esiste già: **mai creare un'entità solo per poterla collegare da un articolo**.

---

## Come lo usano gli agenti

- **Trovare le fonti su un tema**: `themes/<tema>.md → articles:`, poi il TL;DR di ognuna. La fonte completa si legge dall'`url` solo se serve.
- **Seguire i wikilink in entrata**: quando un signal o un file del canon cita un articolo, si legge il TL;DR prima di formarsi un'opinione.
- **Non spacciare il TL;DR per la tesi dell'autore**: è la lettura di chi l'ha salvato. Per la tesi vera si apre la fonte.
- **Mai trattare un articolo come canon.**

---

## Cosa non va qui

- Le fonti "solo interessanti": vanno nei segnalibri personali.
- Le fonti che parlano della vostra azienda: quei fatti vanno nel canon.
- Copie del contenuto.
- Bozze del vostro pensiero: vanno dove appartengono (canon, regole di team, un signal).
- Campi di stato (`letto`, `da leggere`): la cartella è "letto e tenuto" per costruzione.

---

## Ciclo di vita

**Revisione trimestrale.** Per ogni file: il TL;DR descrive ancora una posizione che tenete? Se sì, resta. Se no, si riscrive (aggiornando `added`) o si cancella. Niente cartelle di archivio.

**Link morti.** Se l'URL muore il file resta utile, perché il TL;DR ha catturato lo spunto. Si può segnare `url: [morto]`.

---

## Governance

Libera: chiunque aggiunge, chiunque modifica, push diretto su `main`.
