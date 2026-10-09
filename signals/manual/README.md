# signals/manual/

Signal inseriti a mano: tutto quello che una persona del team vuole mettere nel grafo e che non arriva da una fonte tracciata (call, email). Esempi: un cambio di posizionamento di un concorrente sentito in un podcast, un segnale di mercato da un comunicato, una frase di un cliente letta in giro, un risultato di ricerca, un'osservazione interna che serve ad altri team, un'analisi fatta con Claude. Qui finiscono anche i **signal di sessione** scritti dalla skill `session-end`.

Signal trasversali a record: vedi [`signals/`](../).

Valgono le regole di ogni signal: ogni blocco fattuale porta la sua fonte (URL, trascrizione, PDF, percorso di uno screenshot); le esclusioni del canon valgono per corpo, frontmatter, messaggi di commit e titoli delle PR; la scansione delle entità con i wikilink si fa in scrittura. Procedura completa in [`canon/operations.md`](../../canon/operations.md) → "Citazioni", "Disciplina dei tag in scrittura", "Scansione delle entità".

A differenza di `daily-call/` ed `email/`, prodotti da skill che leggono fonti tracciate con una cadenza, `manual/` raccoglie tutto il resto. È organizzato per tema, non per giorno: lo stesso autore può scrivere più signal nella stessa data se toccano temi diversi.

## Struttura

```
signals/manual/
|-- README.md
|-- _TEMPLATE.md
\-- YYYY/
    \-- MM/
        |-- <slug-persona>_<slug-tema>_YYYY-MM-DD.md
        \-- ...
```

Nome file: `<slug-persona>_<slug-tema>_YYYY-MM-DD.md`, cioè autore, tema e data completa. La data nel nome rende il file riconoscibile anche se finisce nel posto sbagliato e permette all'hook di misurare la freschezza del cervello. Il tema evita collisioni fra signal dello stesso autore nello stesso giorno. Lo schema sta in [`_TEMPLATE.md`](_TEMPLATE.md).

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
related_to_signals:
  - "[[<slug-signal>]]"
---

# <Titolo del tema> · <Nome Cognome> · YYYY-MM-DD

**Autore**: [[<slug-persona>]]
**Team coinvolti**: [[<team1>]], [[<team2>]]

---
```

Il frontmatter è la fonte canonica per il routing (schema completo in [`signals/README.md`](../)). Il corpo ripete autore e team come link per la navigazione: i due devono restare allineati.

`teams_impacted` contiene ogni team che deve accorgersi del signal, non solo quello dell'autore. Ometti ogni `related_to_<tipo>` non toccato.

Due campi **non** sono facoltativi, perché impediscono al signal di essere una foglia isolata:

- **`related_to_themes`**: almeno uno. Scrivi l'inverso in `themes/<slug>.md → signals:` (vedi [`themes/README.md`](../../themes/README.md)). Se il tema giusto non esiste ancora, crealo.
- **`related_to_signals`**: da 1 a 3 signal precedenti che servirebbe rileggere per capire questo: quello che ha aperto il thread, quello che ha preso la decisione applicata oggi, quello che aveva provato la stessa strada. **Bidirezionale**: aggiungi questo signal al loro `related_to_signals` nella stessa scrittura. Si omette solo quando il tema non ha storia: in quel caso lo si dice nel corpo.

Senza questi due campi i link alle entità formano una stella: ogni signal punta a persone e nessuno punta a un altro signal. La storia di un tema allora si recupera solo con grep. La procedura sta nella skill `session-end`, passo 3b.

### Corpo

Prosa libera. Forma suggerita:

```md
## Contesto

Cosa è stato osservato, dove, quando. 1-3 frasi, con la fonte.

## Signal

I 2-5 punti che ne catturano la sostanza, ognuno con la sua fonte se non è già nel contesto.

## E quindi

Perché conta per l'azienda. 1-3 punti con i link ai team, temi, aziende, prodotti che dovrebbero muoversi. Chi scrive segnala, chi legge decide l'azione.

## Fonte

- [<titolo dell'artefatto>](<URL o percorso>)
```

`E quindi` è la sezione propria di `manual/`: chi scrive ha scelto di mettere l'osservazione nel grafo, quindi deve dire perché.

## Signal di sessione: la sezione `## Aperto`

I signal scritti dalla skill [`session-end`](../../.claude/skills/session-end/SKILL.md) seguono lo schema qui sopra e aggiungono **una sola** sezione, dopo `E quindi`:

```md
## Aperto

- [ ] <cosa manca> · @<slug-persona> · dal YYYY-MM-DD
- [x] <cosa era aperto e si è chiuso in questa sessione> · chiuso YYYY-MM-DD
```

Nome file: `<slug-persona>_sessione-<slug-tema>_YYYY-MM-DD.md`. Il prefisso `sessione-` li rende riconoscibili a colpo d'occhio e con un `find`.

Un signal normale registra cosa è successo; un signal di sessione registra anche **cosa non è finito**. Le righe hanno la stessa forma di quelle in [`../aperto.md`](../aperto.md), il registro letto a inizio sessione, che è una cache di queste sezioni: se divergono, vince il signal.

## Perché trasversale e non sotto un team

Un signal manuale tocca spesso più team: la mossa di un concorrente riguarda prodotto, marketing e vendite. Il campo `teams_impacted` lo instrada bene ovunque stia il file. Metterlo sotto un team lo duplicherebbe o lo nasconderebbe agli altri.
