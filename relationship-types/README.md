# relationship-types/

Un file per **tipo di relazione** che l'azienda ha con un'entità esterna. È un bersaglio per i wikilink: `companies/<X>.md` dichiara `relationship: [[<tipo>]]` e un editor Markdown può navigare, filtrare e mostrare la vista inversa per tipo. "Fammi vedere tutti i partner" diventa una domanda da un clic.

---

## È un enum chiuso

L'insieme qui sotto è l'**elenco completo**:

- **Mai una voce nuova** perché un'azienda "sembra diversa".
- **Niente `_TEMPLATE.md`**: non c'è niente da modellare, l'enum è completo.
- **Estendere l'enum è lavoro di canon**: serve una PR con la motivazione, mai un push diretto.

I cinque tipi **commerciali**:

- **[[customer]]**: paga per il prodotto o il servizio.
- **[[prospect]]**: in trattativa attiva, non ha ancora firmato.
- **[[partner]]**: vende o consegna insieme a voi (integratori, rivenditori, alleanze tecnologiche).
- **[[vendor]]**: fornisce beni o servizi che l'azienda usa (freelance, strumenti, agenzie).
- **[[advisor]]**: dà consiglio (advisory board, mentori).

Più un tipo **non commerciale**:

- **[[competitor]]**: un'azienda seguita per intelligence competitiva. Nessun `crm_url`, `industry` facoltativo (vedi [`../canon/anatomy.md`](../canon/anatomy.md) → "Asimmetria del corpo").

Un cliente perso resta `relationship: [[customer]]` con una nota nel corpo: storicamente è stato cliente. `churned` non è un tipo a parte, per evitare contabilità in più. Se la distinzione vi serve, estendete l'enum con una PR.

---

## Convenzione dei file

Gli slug sono fissi: `customer.md`, `prospect.md`, `partner.md`, `vendor.md`, `advisor.md`, `competitor.md`.

```yaml
---
name: <Nome del tipo>
slug: <slug-tipo>
aliases: []                      # formulazioni alternative
companies: []                    # inverso manuale di companies.relationship
---
```

Corpo: `## About` con 1-2 frasi su cosa implica la relazione.

---

## Vista inversa

`companies` è l'**inverso mantenuto a mano** di `companies/<X>.md → relationship:`. Quando un'azienda cambia tipo (un prospect firma, un partner diventa cliente) si toglie dal vecchio file e si aggiunge al nuovo nella stessa scrittura. Vedi [`../canon/operations.md`](../canon/operations.md) → "La relazione è uno stato che cambia".
