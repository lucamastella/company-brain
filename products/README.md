# products/

Un file per **prodotto dell'azienda**: un puntatore leggero, con `docs_url`, alla scheda che vive nel sistema di riferimento del catalogo (<!-- {{DOCS_SYSTEM}}, il CMS, il gestionale -->). Le specifiche complete, i prezzi, i clienti che lo usano vivono là: qui c'è solo il nodo stabile.

Regola completa in [`canon/operations.md`](../canon/operations.md) → "Catalogo prodotti: la fonte è fuori dal repo".

## Schema

```yaml
---
name: <Nome prodotto>
slug: <slug-prodotto>
category: <categoria>            # la vostra tassonomia
docs_url: <URL della scheda>
---
```

Corpo: 1-2 frasi su cos'è e quale problema risolve. Nessun wikilink nel frontmatter: le relazioni (per chi è adatto, chi lo usa) vivono nel sistema esterno. Template: [`_TEMPLATE.md`](_TEMPLATE.md).

## Regole

- Un prodotto **nasce nel sistema esterno**, poi si crea qui il puntatore. Mai da una scansione delle entità.
- Il contenuto si cambia là, il file segue.
- Un catalogo con centinaia di voci (corsi, SKU, articoli) non si elenca qui file per file: qui stanno solo i prodotti-piattaforma stabili.
