# team/

Una cartella per **team funzionale**. Ogni cartella contiene un solo file indice, `team/<team>/<team>.md`.

- Le **regole del team** (prescrittive: ambito, paletti, esclusioni, escalation) stanno in [`canon/team/<team>.md`](../canon/team/), via PR come tutto il canon.
- L'**indice del team** (descrittivo: chi c'è, di cosa si occupa, quali skill possiede) sta qui, in push diretto.
- Il **quadro operativo** di un team non è un file: gli agenti lo leggono dal grafo, filtrando i [`signals/`](../signals/) su `teams_impacted` e seguendo le entità collegate.

`team/` è **solo per team funzionali** (es. leadership, vendite, marketing, prodotto, engineering). Mai il nome di un'azienda, mai una sottocartella per un cliente o un prospect: quelli sono file in `companies/`. Vedi [`canon/anatomy.md`](../canon/anatomy.md) → "La tassonomia delle cartelle è chiusa".

## Schema di `team/<team>/<team>.md`

Il frontmatter tiene gli inversi, mantenuti con la doppia scrittura:

```yaml
---
aliases: []
people_involved: []   # inverso di people/<x>.md → team: [[<team>]]
skills: []            # inverso di .claude/skills/<slug>/SKILL.md → owner: [[<team>]]
---
```

Corpo: un paragrafo su cosa possiede il team ogni giorno e il rimando alle sue regole. Sottile: le regole sono canon, il quadro operativo è il grafo.

## Aggiungere un team

1. Crea `team/<team>/<team>.md` da [`_TEMPLATE/_TEMPLATE.md`](_TEMPLATE/_TEMPLATE.md).
2. Crea le regole in `canon/team/<team>.md` da [`../canon/team/_TEMPLATE.md`](../canon/team/_TEMPLATE.md), con una PR.
3. Aggiungi il team a [`../canon/profile.md`](../canon/profile.md) → "Team lead" e alla tabella di instradamento in [`../canon/operations.md`](../canon/operations.md) → "Caricamento delle regole per task".
4. Imposta `team: [[<team>]]` su ogni persona in `people/` e scrivi l'inverso in `people_involved`.
