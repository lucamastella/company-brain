# decisions/

Un file per **decisione chiusa**. È la memoria del giudizio dell'azienda: i `signals/` registrano cosa è successo, questa cartella registra **cosa è stato deciso, cosa è stato scartato e perché**, così nessuno (persona o agente) riapre una questione chiusa senza sapere che era chiusa.

Non sta sotto `signals/` per una ragione precisa: un signal è un flusso in entrata (call, mail, note, sessioni), una decisione è un atto deliberato di messa a record, scritto una volta quando la questione si chiude.

## Il rapporto con il canon

Le due cose si completano.

| | Dove vive | Cosa contiene |
|---|---|---|
| La **regola** | `canon/` (via PR) | cosa si fa e cosa non si fa, in forma prescrittiva |
| Il **ragionamento** | `decisions/` | perché quella regola esiste, cosa è stato scartato, quando va riaperta |

Una regola nel canon senza la decisione che la giustifica diventa dogma: tra sei mesi nessuno sa se vale ancora e nessuno osa toccarla. Una decisione senza la regola nel canon non la applica nessuno. Servono entrambe.

## Convenzioni

Cartella piatta, nome file con la data davanti, così la cartella si legge come un registro cronologico:

```
decisions/YYYY-MM-DD_<tema-slug>.md
```

La data è il giorno in cui la decisione **si è chiusa**. Quando la decisione è più vecchia della sua messa a record (recuperata da un recap, da un documento o da una correzione in chat), la data del file è quella di registrazione e il corpo lo dichiara in una riga: *"Registrata il <data>; decisione presa in <fonte>, data esatta non a record."* Le date non si inventano.

### Frontmatter

Gli stessi campi relazionali di un signal: sono loro ad agganciare la decisione al grafo.

```yaml
---
date: YYYY-MM-DD              # il giorno in cui la decisione si è chiusa (o è entrata nel registro)
author:
  - "[[<slug-persona>]]"      # chi ha preso la decisione
teams_impacted:
  - "[[<slug-team>]]"
related_to_projects:          # l'arco che conta: decisione → progetto → KR → objective
  - "[[<slug-progetto>]]"
related_to_people:
  - "[[<slug-persona>]]"
related_to_companies:
  - "[[<slug-azienda>]]"
related_to_products:
  - "[[<slug-prodotto>]]"
related_to_themes:            # bidirezionale: aggiungi la decisione anche a themes/<slug>.md → decisions:
  - "[[<slug-tema>]]"
supersedes:                   # opzionale: la decisione più vecchia che questa sostituisce
superseded_by:                # opzionale: si aggiunge alla decisione VECCHIA quando ne arriva una nuova
---
```

Ometti i campi che non hai usato, niente liste vuote. Come per i signal, l'unico inverso da scrivere a mano è quello sui temi (`themes/<slug>.md → decisions:`); gli altri `related_to_*` si leggono con la vista "Referenced by" dell'editor o con `grep`.

### Corpo

```md
# Decisione: <la decisione in una riga> · YYYY-MM-DD

## Decisione
Cosa è stato deciso, una frase.

## Alternative scartate
Cosa era sul tavolo e perché ha perso. È la metà che evita di rifare la discussione.

## Perché
Il ragionamento, corto. Se il motivo non è a record, si scrive che non lo è invece di ricostruirlo di nascosto: un razionale ricostruito va etichettato come tale.

## Quando riaprirla
La condizione o la data che legittima la riapertura. Una decisione senza condizione di riapertura è dogma, non memoria.

## Fonte
- Il signal, il documento, la call o la chat dove la decisione si è chiusa.
```

## Regole ferme

- **Non si scrive in autonomia.** Un agente propone il candidato in chat (cosa si è deciso, cosa si è scartato, quando riaprirla) e scrive solo dopo il **sì esplicito di {{OWNER_CANON}}**. Una memoria del giudizio con dentro una decisione che nessuno ha preso è peggio di nessuna memoria, perché tutto quello che sta a valle ci si fida.
- **Il candidato nasce di solito nella skill `session-end`**, che chiudendo la sessione riconosce che si è chiuso un ragionamento e lo propone.
- **Sostituzione.** Quando una decisione nuova ne sostituisce una vecchia, la nuova dichiara `supersedes:` e la vecchia riceve `superseded_by:`, nella stessa operazione. Aggiungere `superseded_by:` è **l'unica modifica ammessa** a una decisione già scritta: il corpo resta come storia. Prima di trattare una decisione come valida, **si controlla sempre `superseded_by:`**.
- **Le esclusioni del canon valgono in pieno** ([`../canon/company-rules.md`](../canon/company-rules.md) → "Cosa il sistema non deve mai fare"): decisioni su persone, compensi, equity, prezzi di un singolo deal, legale o HR non entrano qui, per costruzione.
- **L'assenza non prova niente.** Per via delle esclusioni e perché il registro nasce il giorno dell'adozione, la cartella è parziale: "non trovo una decisione" non vuol dire "non è stata presa".
- Ogni affermazione porta la sua fonte.

## Come si usa in lettura

- Prima di riaprire un tema o di proporre una meccanica, **si controlla qui**. Se la condizione di riapertura è soddisfatta, si propone di riaprire citando il file. Se non lo è, la questione è chiusa e si cita la decisione.
- Prima di scrivere una regola nuova nel canon, si controlla se esiste già la decisione che la giustifica e la si collega.
