# signals/daily-call/

Un file **per persona al giorno** che sintetizza le call registrate a cui quella persona ha partecipato. Ognuno nel team ha la propria voce, lead e CEO compresi. Trasversale per costruzione: un recap che copre call di due team è un solo file che li collega entrambi.

Signal trasversali a record: vedi [`signals/`](../).

Ogni persona produce il proprio recap con la skill che preferisce (di solito una skill di recap che legge lo strumento di trascrizione via MCP). In pratica il recap è **append-only**: rilanciarlo per la stessa data sovrascrive le esecuzioni precedenti, quindi le modifiche a mano non sopravvivono a una rigenerazione. I filtri di ogni team (cosa evidenziare, cosa togliere) stanno in [`canon/team/<team>.md`](../../canon/team/), che la skill legge quando produce il recap.

<!--
ESCLUSIONE OPZIONALE, valutatela prima di partire.
Alcuni team decidono che le call a due (1to1) non entrano mai qui: nessuna sezione, nessuna
decisione estratta, nessuna citazione come fonte. Se una decisione presa in un 1to1 conta per il
team, la si ridice in una call di team o in chat: si scrive con quella fonte. Se adottate la
regola, scrivetela qui come blocco in cima al file e nella skill di recap.
-->

## Struttura

```
signals/daily-call/
|-- README.md
|-- _TEMPLATE.md
\-- YYYY/
    \-- MM/
        |-- <slug-persona>_YYYY-MM-DD.md
        \-- ...
```

Nome file: `<slug-persona>_YYYY-MM-DD.md`, con la data completa così il file si riconosce anche fuori posto. Schema in [`_TEMPLATE.md`](_TEMPLATE.md).

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
related_to_projects:
  - "[[<slug-progetto>]]"
related_to_themes:
  - "[[<slug-tema>]]"
---

# Recap call · <Nome Cognome> · YYYY-MM-DD

**Persona**: [[<slug-persona>]]
**Team coinvolti**: [[<team1>]], [[<team2>]]

---
```

Il frontmatter è la fonte canonica per il routing (schema in [`signals/README.md`](../)). `teams_impacted` contiene sempre il team dell'autore, più gli altri quando le call hanno toccato lavoro trasversale. Ometti ogni `related_to_<tipo>` non toccato.

### Una sezione per call

```md
## <titolo o tema della call> · <HH:MM-HH:MM>

- **Partecipanti**: [[<slug-persona>]], <Nome esterno, ruolo @ azienda>, ...
- **Team toccati**: [[<team>]], ...
- **Punti chiave**: 3-5 punti.
- **Decisioni**: ...
- **Azioni che mi spettano**: ...
- **Rischi segnalati**: ...
- **Fonte**: <strumento di trascrizione> · <URL della trascrizione>
```

I partecipanti, interni ed esterni, diventano wikilink confrontando gli `aliases` in `people/`. Quando un esterno non ha un file, resta testo semplice e scatta la regola della prima menzione ([`canon/operations.md`](../../canon/operations.md) → "Entità esterne: si creano alla prima menzione"). Le date relative diventano assolute. Ogni call si cita con la sua trascrizione. Le trascrizioni storpiano i nomi propri: si verificano prima di scriverli. Le sale riunioni si trattano come in [`canon/anatomy.md`](../../canon/anatomy.md) → "Sale riunioni".

## Perché trasversale e non sotto un team

Un recap può coprire call di più team: quello di un CEO li copre tutti. Una cartella per team duplicherebbe il file o lo nasconderebbe a qualcuno. I wikilink lo instradano bene ovunque stia.
