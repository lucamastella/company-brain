# projects/

Un file per **Progetto globale**: una delivery con un risultato atteso, che dura più sprint e spesso coinvolge più team. È il nodo stabile del grafo, non il database vivo.

**Lo stato vivo (status, avanzamento, contributo attuale ai KR, Attività) vive su {{DOCS_SYSTEM}}** e si aggiorna ogni settimana. Qui stanno owner, team coinvolti, scope, KR mossi, criterio kill-or-ship e il puntatore (`docs_url`). Modello completo in [`../canon/operating-system.md`](../canon/operating-system.md).

## Schema

```yaml
---
name: <Nome progetto>
objective: "[[<qN-AAAA>]]"         # il quarter a cui appartiene (inverso su objectives/<q>.md → projects:)
owner:
  - "[[<persona-o-team>]]"         # owner facilitatore
teams:
  - "[[<team>]]"                   # team coinvolti, che eseguono le Attività
scope: <discovery | delivery | bau>
tier: <1 | 2>
kr_moved: [KR1, KR3]               # quali KR spinge
status: <active | draft | done | killed>
docs_url: <URL del progetto>
---
```

Corpo: cosa si fa (a livello globale), cosa fanno i team, criterio kill-or-ship. Template: [`_TEMPLATE.md`](_TEMPLATE.md).

## Regole

- Progetti **globali e per scope**, mai "di un team". Il team è chi esegue le Attività, non il proprietario.
- Il contributo Progetto → KR è molti a molti e vive sulla tabella ponte nel docs system, non qui.
- Wikilink: `[[<slug-progetto>]]` punta a `projects/<slug-progetto>.md`. I signal si agganciano ai progetti che toccano con `related_to_projects`.
- Quando un progetto si chiude (`done` o `killed`), il file resta: i signal passati lo citano.
