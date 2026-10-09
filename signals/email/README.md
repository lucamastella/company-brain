# signals/email/

Un file **per persona al giorno** che sintetizza i thread email in cui quella persona è stata coinvolta (inviati, ricevuti o letti) in quella data. Trasversale per costruzione: un digest che tocca due clienti è un solo file che li collega entrambi.

Signal trasversali a record: vedi [`signals/`](../).

Ogni persona produce il proprio digest con la skill che preferisce, leggendo la posta via MCP. In pratica il digest è **append-only**: rilanciarlo per la stessa data sovrascrive le esecuzioni precedenti. I filtri dei team stanno in [`canon/team/<team>.md`](../../canon/team/).

## Struttura

```
signals/email/
|-- README.md
|-- _TEMPLATE.md
\-- YYYY/
    \-- MM/
        |-- <slug-persona>_YYYY-MM-DD.md
        \-- ...
```

Nome file: `<slug-persona>_YYYY-MM-DD.md`. Schema in [`_TEMPLATE.md`](_TEMPLATE.md).

## Formato

### Intestazione obbligatoria

```md
---
date: YYYY-MM-DD
author:
  - "[[<slug-persona>]]"
teams_impacted:
  - "[[<slug-team>]]"
related_to_people:
  - "[[<slug-persona>]]"
related_to_companies:
  - "[[<slug-azienda>]]"
related_to_products:
  - "[[<slug-prodotto>]]"
related_to_systems:
  - "[[<slug-sistema>]]"
related_to_themes:
  - "[[<slug-tema>]]"
---

# Digest email · <Nome Cognome> · YYYY-MM-DD

**Persona**: [[<slug-persona>]]
**Team coinvolti**: [[<team1>]], [[<team2>]]

---
```

### Una sezione per thread

Una sezione per ogni thread rilevante. Tutte le risposte dello stesso thread stanno insieme: un thread da dodici messaggi non diventa dodici sezioni. I thread di rumore (notifiche, inviti senza contenuto) si tolgono del tutto.

```md
## <oggetto del thread> · <controparte o cliente>

- **Controparte**: <Nome esterno, ruolo @ azienda> (oppure [[<slug-persona>]] quando il file esiste)
- **Partecipanti interni**: [[<slug-persona>]], ...
- **Team toccati**: [[<team>]], ...
- **Punti chiave**: 3-5 punti.
- **Decisioni e impegni**: ...
- **Azioni che mi spettano**: ...
- **Rischi segnalati**: ...
- **Fonte**: <URL del thread o message-id>
```

I partecipanti diventano wikilink tramite gli `aliases` in `people/`; per gli esterni senza file scatta la regola della prima menzione. L'azienda della controparte si collega tramite [`companies/`](../../companies/). Le date relative diventano assolute. Ogni thread si cita con un URL o un message-id. Valori di contratto e clausole NDA restano fuori, per regola del canon.

## Perché trasversale e non sotto un team

Come per [`signals/daily-call/`](../daily-call/): un digest tocca più team e i wikilink lo instradano ovunque stia.
