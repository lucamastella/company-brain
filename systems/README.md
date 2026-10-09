# systems/

Un file per **software o piattaforma esterna** che le aziende usano nel proprio stack (e-commerce, gestionali, pagamenti, CRM, marketplace e simili). È un bersaglio stabile per i wikilink: le aziende dichiarano `uses_stack: [[<sistema>]]` e un agente chiede "quali clienti usano X?" con un salto solo.

Non è un catalogo di ogni strumento di cui avete sentito parlare: solo i sistemi che **compaiono negli stack veri dei clienti** o con cui l'azienda si integra.

---

## Quando si crea un file

Quando un recap, un signal o la scheda di un'azienda nomina un software che un'azienda usa (o un ecosistema di partner a cui vi collegate) e il file non esiste ancora. Un sistema che ricorre (almeno due menzioni o due fonti) è un candidato anche se la prima volta è stato saltato.

Non si creano:
- i prodotti dell'azienda, che vivono in [`products/`](../products/);
- i software che nessun cliente usa;
- versioni o varianti minori: un file per famiglia di prodotto.

---

## Convenzione dei file

`<slug>.md`, minuscolo, con i trattini.

### Frontmatter

```yaml
---
name: <Nome del sistema>
slug: <slug-sistema>
category: <categoria>            # es. ecommerce | gestionale | pagamenti | crm | marketplace | analytics
vendor: <Azienda che lo produce>
website: https://<dominio>
aliases: []                      # soprannomi, abbreviazioni, nomi dei sottoprodotti. Vuoto è un bug.
companies: []                    # inverso manuale di companies.uses_stack
                                 #   - "[[<slug-azienda>]]"
---
```

### Corpo

```markdown
# <Nome del sistema>

## About

1-2 frasi: cos'è e dove è forte.
```

**Niente note di integrazione**: cambiano per cliente e per versione, qui invecchiano subito. La documentazione delle integrazioni vive nella documentazione tecnica.

---

## Chi lo usa

`companies` è l'**inverso mantenuto a mano** di `companies/<X>.md → uses_stack:`. Quando un'azienda aggiunge questo sistema al suo stack si aggiornano entrambi i file nella stessa modifica.
