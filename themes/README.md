# themes/

Un file per **tema** su cui l'azienda scrive, che segue all'esterno o su cui vuole che i suoi agenti ragionino. È un bersaglio stabile per i wikilink:

- `articles/<slug>.md` dichiara `themes: [[<tema>]]`;
- i signal dichiarano `related_to_themes: [[<tema>]]`;
- le decisioni dichiarano `related_to_themes: [[<tema>]]`;
- un agente che chiede "cosa abbiamo detto e deciso sul tema X?" apre `themes/<tema>.md` e trova tutto in un salto.

I temi sono il collante del grafo: è da qui che si ricostruisce la storia di un argomento.

---

## Quando si crea un tema

Quando un argomento compare in un articolo, un signal o una decisione e il file non esiste ancora. Un argomento che ricorre (almeno due menzioni o due fonti) è un candidato. La skill `session-end` lo crea se manca, perché ogni signal di sessione deve avere almeno un tema.

Non si creano temi speculativi: si aspetta il primo articolo, signal o decisione che ne ha bisogno.

---

## Convenzione dei file

`<slug>.md`, minuscolo, con i trattini.

### Frontmatter

```yaml
---
name: <Nome del tema>
slug: <slug-tema>
aliases: []              # sinonimi e formulazioni alternative. Vuoto è un bug.
articles: []             # inverso di articles.themes
signals: []              # inverso di signals.related_to_themes
decisions: []            # inverso di decisions.related_to_themes
---
```

### Corpo

```markdown
# <Nome del tema>

## About

1-2 frasi di **definizione stabile**: cosa vuol dire questo tema nel vostro schema.
```

**Non** lo stato dei progetti legati al tema (vive nei signal) e non un deposito di conoscenza (il contenuto profondo sta negli articoli e nei signal collegati). Le posizioni dell'azienda sul tema vivono nel canon. Vedi [`canon/operations.md`](../canon/operations.md) → "Disciplina del corpo delle entità".

---

## Coppie diretta e inversa

I temi partecipano a tre relazioni bidirezionali, da scrivere sempre su entrambi i lati nella stessa modifica:

- `articles/<x>.md → themes: [[<tema>]]` ↔ `themes/<tema>.md → articles: [[<articolo>]]`
- `signals/<fonte>/<periodo>/<x>.md → related_to_themes: [[<tema>]]` ↔ `themes/<tema>.md → signals: [[<signal>]]`
- `decisions/<x>.md → related_to_themes: [[<tema>]]` ↔ `themes/<tema>.md → decisions: [[<decisione>]]`

La coppia sui signal è un'eccezione voluta alla regola "i signal non ricevono inversi" (vedi [`canon/anatomy.md`](../canon/anatomy.md)): i temi sono pochi, la lista resta gestibile e la domanda "tutte le call che hanno toccato il tema X" vale molto.

---

## Come lo usano gli agenti

- **Chi scrive contenuti** parte dal tema per vedere cosa è già stato letto e detto.
- **Chi vende** usa gli articoli collegati come prove quando un cliente solleva l'argomento.
- **Chi riprende un lavoro** risale ai signal e alle decisioni sul tema invece di ripartire da zero.
