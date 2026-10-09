# industries/

Un file per **verticale o segmento di mercato** in cui l'azienda vende o in cui operano i partner. È un bersaglio stabile per i wikilink:
- `companies/<X>.md` dichiara `industry: [[<slug>]]`, cioè in che verticale gioca l'azienda;
- un agente commerciale chiede "le aziende del verticale X" con un salto solo.

---

## Quando si crea un file

Quando l'azienda comincia a vendere in un verticale (o a farci prospezione attiva) oppure quando un termine di settore ricorre in almeno due fonti. Niente verticali creati "per completezza": si aspetta il primo cliente o prospect vero.

---

## Convenzione dei file

`<slug>.md`, minuscolo, con i trattini.

### Frontmatter

```yaml
---
name: <Nome del verticale>
slug: <slug-verticale>
aliases: []                      # ogni altro modo in cui si chiama il verticale. Vuoto è un bug.
companies: []                    # inverso manuale di companies.industry
                                 #   - "[[<slug-azienda>]]"
---
```

Gli `aliases` devono essere **ricchi**: sinonimi, abbreviazioni, formulazioni alternative, così la scansione delle entità aggancia una menzione a questo file invece di creare un doppione.

`companies` è un **inverso mantenuto a mano**: quando un'azienda entra in questo verticale si aggiornano entrambi i file nella stessa modifica (`companies/<X>.md → industry:` e `industries/<slug>.md → companies:`).

### Corpo

```markdown
# <Nome del verticale>

## About

1-2 frasi: cosa comprende il verticale nel vostro schema, più il contesto geografico se serve.
```

Il resto (informazioni sulle singole aziende) va nei file delle aziende e nei signal.
