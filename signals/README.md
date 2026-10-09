# signals/

I **signal** sono sintesi a record, trasversali e append-only, che danno contesto agli agenti: cosa è successo, quando, con quale fonte.

| Sottocartella | Origine | Cardinalità |
|---|---|---|
| [`signals/daily-call/`](daily-call/) | Trascrizioni delle call (dallo strumento di trascrizione) | Un file per persona al giorno |
| [`signals/email/`](email/) | Thread email | Un file per persona al giorno |
| [`signals/manual/`](manual/) | Inserimento manuale di chiunque nel team (tutto ciò che non arriva da una fonte tracciata) e signal di sessione scritti da `session-end` | Un file per tema, per autore, al giorno |
| [`aperto.md`](aperto.md) | Registro rotante dei thread non chiusi, cache delle sezioni `## Aperto` dei signal di sessione | File singolo |

Sono trasversali per costruzione: un file può collegare qualsiasi team, prodotto, persona. Non stanno mai sotto la cartella di un team, anche quando un recap riguarda soprattutto un team. I wikilink nel corpo servono alla navigazione delle persone; il **frontmatter** (sotto) è quello che le skill interrogano per il routing.

Il formato di ogni sottocartella sta nel suo README. Qualsiasi agente o persona scriva qui deve produrre quel formato: al repo interessa la forma del file, non lo strumento che l'ha prodotto.

## Frontmatter (obbligatorio per ogni signal)

```yaml
---
date: YYYY-MM-DD            # il giorno coperto dal signal
author:                     # la persona che scrive o possiede il signal
  - "[[<slug-persona>]]"    # → people/<slug>.md
teams_impacted:             # ogni team toccato → team/<slug>/<slug>.md
  - "[[<slug-team>]]"
related_to_people:          # persone citate nel corpo, interne ed esterne, autore escluso
  - "[[<slug-persona>]]"
related_to_companies:       # aziende esterne citate → companies/<slug>.md
  - "[[<slug-azienda>]]"
related_to_products:        # prodotti dell'azienda, solo se discussi come argomento
  - "[[<slug-prodotto>]]"
related_to_systems:         # sistemi esterni, solo se discussi come argomento
  - "[[<slug-sistema>]]"
related_to_projects:        # progetti globali toccati: signal → progetto → KR → objective
  - "[[<slug-progetto>]]"
related_to_themes:          # temi trattati come concetto, non citati di passaggio. Bidirezionale:
  - "[[<slug-tema>]]"       # aggiungi il signal anche a themes/<slug>.md → signals:
---
```

Ogni campo di relazione è una lista di wikilink, così un editor Markdown locale (es. Obsidian) mostra ogni campo come sezione separata e l'autore e ogni entità collegata vedono il signal nella loro vista "Referenced by".

La divisione di `related_to` per tipo è voluta: chi legge vede le relazioni raggruppate e un agente che cerca "tutti i signal sul prodotto X" legge un solo campo.

`related_to_themes` è bidirezionale: l'inverso sta in `themes/<tema>.md → signals:` e si scrive nella stessa operazione. In `signals/manual/` è bidirezionale anche `related_to_signals` (vedi il README della sottocartella). Gli altri campi si appoggiano alla vista "Referenced by". Motivazione completa in [`canon/anatomy.md`](../canon/anatomy.md) → "Relazioni wikilink nel frontmatter".

Ometti ogni `related_to_<tipo>` che il signal non ha toccato. Niente liste vuote.

`teams_impacted` è anche il **campo di routing**. Un agente che compone il quadro di un team filtra i signal leggendo lo YAML. **Il routing non si fa sui wikilink nel corpo**: cercare stringhe nel Markdown è fragile e lento.

Il corpo riporta gli stessi team e l'autore come link cliccabili. **Il frontmatter è canonico**: se corpo e frontmatter divergono, vince il frontmatter. L'autore non si ripete in `related_to_people`.

## Perché esiste questa cartella

Il repo distingue:
- **Contesto stabile**: `canon/`, [`people/`](../people/), [`team/`](../team/). Cambia di rado, lo curano le persone.
- **Stato operativo**: questa cartella, letta dal grafo insieme alle entità che collega. Non esiste un riepilogo per team da mantenere a parte.

Tenere i signal fuori da `team/` risolve un problema: chi partecipa a call di più team (un CEO, un PM trasversale, un account) non avrebbe una casa onesta per il proprio recap sotto un solo team. Qui il recap collega i team toccati.

## Aggiungere una nuova sottocartella

Le fonti di partenza sono `daily-call/`, `email/`, `manual/`. Quando una fonte nuova diventa un input abituale per gli agenti (digest delle PR, report di supporto, letture periodiche di una piattaforma), si crea la sottocartella **via PR**, mai in push diretto. Serve:
1. un `README.md` con nome file, cardinalità, formato e filtri per team;
2. una riga nella tabella in cima a questo README;
3. le regole dei wikilink in [`canon/anatomy.md`](../canon/anatomy.md).

Non si creano sottocartelle vuote in anticipo.

## Cosa non va qui

- L'**artefatto grezzo** (la trascrizione, la mail, la PR, il deal): resta nel suo sistema, vedi [`canon/anatomy.md`](../canon/anatomy.md) → "Fonti di verità esterne".
- Il **contesto stabile** (regole, profili, obiettivi, convenzioni, persone).

## Governance

Leggera e append-only. Chiunque produce una voce, con la skill che preferisce. I file esistenti non si modificano a mano: se un recap è sbagliato, si rilancia la skill che lo produce o si scrive un file nuovo che lo supera. Fanno eccezione gli inversi del frontmatter (`related_to_signals`, `signals:` sui temi), che si aggiornano per costruzione.
