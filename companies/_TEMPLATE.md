---
# companies/<slug>.md
# Un file per azienda. La vostra azienda ha is_self: true; tutte le altre sono esterne.
# Cancella i commenti e i campi che non ti servono prima di salvare.

name: <Nome azienda>
is_self: true                         # SOLO sulla vostra azienda. CANCELLA questa riga per ogni esterna.
aliases: []                           # OBBLIGATORIO, mai vuoto. Ogni grafia, handle, dominio visti in
                                      # trascrizioni, chat, posta. es. ["<NomeBreve>", "<dominio>.it"]
linkedin: <https://www.linkedin.com/company/...>
crm_url: <URL del record nel CRM>     # OBBLIGATORIO per le esterne. Vuoto per la vostra azienda e
                                      # per i competitor.
industry:                             # OBBLIGATORIO per le esterne (facoltativo per i competitor)
  - "[[<verticale>]]"                 # wikilink a industries/<slug>.md
relationship:                         # OBBLIGATORIO per le esterne
  - "[[<tipo>]]"                      # customer | prospect | partner | vendor | advisor | competitor
uses_stack: []                        # facoltativo, software esterni che usano. es. ["[[<sistema>]]"]
docs_url: <URL>                       # facoltativo, pagina dell'azienda nel docs system
people: []                            # persone di questa azienda con un file. es. ["[[<slug-persona>]]"]
---

<!--
ASIMMETRIA DEL CORPO:
- VOSTRA azienda (is_self: true) = corpo più ricco (posizionamento e voce).
- Azienda ESTERNA                = corpo leggero, About di 1-2 frasi e nient'altro.
- COMPETITOR                     = corpo minimo; niente crm_url; industry facoltativo.
Tieni SOLO la forma che corrisponde a questa azienda.
-->

<!-- ============ FORMA A: VOSTRA azienda (is_self: true) ============ -->

# <Azienda>

## About

<Cosa fa l'azienda, in una o due frasi. Fatti stabili.>

## Posizionamento

<Chi servite, cosa vendete, in che categoria giocate. Rimanda a canon/company-rules.md.>

## Voce

<Il tono che ogni agente usa quando parla per l'azienda.>

<!-- ============ FORMA B: azienda ESTERNA ============ -->

# <Nome azienda>

## About

<1-2 frasi: settore, modello di business, area geografica. Solo fatti stabili.>

<!--
Per le ESTERNE ci si ferma qui. Niente note, contesto, stato del deal, rischi, date
dell'ultimo contatto o prosa sulla relazione: vive nel CRM (via crm_url).
-->

<!-- ============ FORMA C: COMPETITOR (niente crm_url) ============ -->

# <Nome concorrente>

## About

<Una riga: cosa offrono e dove si sovrappongono a voi.>
