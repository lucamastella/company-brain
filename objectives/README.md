# objectives/

Un file per **quarter**: l'Objective globale e i suoi Key Result. È il nodo stabile del grafo, non il database vivo.

**Lo stato vivo (valore attuale dei KR, status) vive su {{DOCS_SYSTEM}}** e si aggiorna ogni settimana. Qui stanno i valori obiettivo, la struttura e il puntatore (`docs_url`). Modello completo in [`../canon/operating-system.md`](../canon/operating-system.md).

## Schema

```yaml
---
quarter: <q1-2027>
period: <gen-mar 2027>
status: <active | draft | closed>
business_owner: "[[<slug-persona>]]"
docs_url: <URL della pagina o del database OKR>
projects:                            # i Progetti globali che spingono questo Objective
  - "[[<slug-progetto>]]"            # inverso di projects/<x>.md → objective:
---
```

Corpo: l'Objective in una riga, poi i KR (valore obiettivo e cosa misurano, con il sistema da cui si leggono). Niente valore attuale: vive su {{DOCS_SYSTEM}}. I Progetti che muovono ogni KR si leggono dai file in [`../projects/`](../projects/). Template: [`_TEMPLATE.md`](_TEMPLATE.md).

## Regole

- Un solo Objective globale per quarter, con i suoi KR. Nessun team ne possiede uno.
- Ogni KR dichiara **dove si legge** (quale sistema, quale definizione): senza, due persone misurano due cose diverse.
- I numeri interni non curati restano fuori: solo i valori obiettivo dei KR.
- Wikilink: `[[q1-2027]]` punta a `objectives/q1-2027.md`.
