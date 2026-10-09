---
# people/<nome>-<cognome>.md
# Uno schema, due forme. Interno o esterno si ricava da `company:`.
# Interno → company punta alla vostra azienda (il file con is_self: true).
# Esterno → company punta a qualsiasi altro companies/<slug>.md.
#
# Cancella i commenti e il blocco che non ti serve prima di salvare.

# --- Per tutti ---
name: <Nome Cognome>
short: <Nome>                        # facoltativo
aliases: []                          # OBBLIGATORIO, mai vuoto. Ogni grafia, handle, email visti in
                                     # trascrizioni, chat, posta. es. ["<Nome>", "<n.cognome@dominio>"]
linkedin: <https://www.linkedin.com/in/...>
company:
  - "[[<azienda>]]"                  # interno → [[<vostra-azienda>]]; esterno → [[<sua-azienda>]]
job_title:
  - "[[<ruolo>]]"                    # wikilink a job-titles/<ruolo>.md

# --- Solo interni (tieni SOLO se company è la vostra azienda) ---
founder: true                        # solo per chi ha fondato l'azienda, altrimenti cancella
reports_to:
  - "[[<slug-responsabile>]]"        # si omette al vertice
direct_reports: []                   # inverso manuale di reports_to
start_date: <YYYY-MM-DD>
timezone: <fuso>                     # es. Europe/Rome
team:
  - "[[<team>]]"
external_collaborator: true          # SOLO per chi lavora dentro un team senza essere in organico.
                                     # Cancella altrimenti. Vedi README.
status: uscita                       # SOLO per chi ha lasciato l'azienda. Il file non si cancella:
end_date: <YYYY-MM>                  # i signal passati lo citano. Vedi README per i 3 passi.

# --- Solo esterni (tieni SOLO se company NON è la vostra azienda) ---
crm_url: <URL del contatto nel CRM>  # OBBLIGATORIO per gli esterni. Vuoto per gli interni.
twitter:                             # facoltativo
website:                             # facoltativo
---

<!--
ASIMMETRIA DEL CORPO: il peso del corpo segue dove vive la verità.
- INTERNO = corpo ricco. La fonte è il repo.
- ESTERNO = corpo leggero. La fonte è il CRM, questo file è un puntatore.
Tieni SOLO la forma che corrisponde a questa persona.
-->

<!-- ============ FORMA A: persona INTERNA ============ -->

# <Nome Cognome>

## Azienda

[[<azienda>]]

## Team

[[<team>]]

## Scope, cosa possiedo

- <Responsabilità concreta, espressa con un verbo>

## Anti-scope, cosa non possiedo

- <Un'idea sbagliata che un agente potrebbe farsi su questa persona>

## Autorità decisionale

<Cosa firma da sola e cosa richiede un'altra firma.>

## Stile (facoltativo)

<Quello che aiuta un agente a scrivere nella sua voce.>

## Come scrivo (facoltativo)

<Ritmo, registro, cosa evitare. Divisa per superficie: mail interna, post pubblico, messaggio.>

## Contesto (facoltativo)

<Percorso, ruoli precedenti, competenze.>

<!-- ============ FORMA B: persona ESTERNA ============ -->

# <Nome Cognome>

## About

<1-2 frasi: chi è, il ruolo, eventualmente il percorso. Solo fatti stabili.>

## Azienda

[[<sua-azienda>]]

<!--
Per gli ESTERNI ci si ferma qui. Niente note, contesto, coinvolgimento nei deal, storia,
preferenze o prosa sulla relazione: vive nel CRM (via crm_url) e qui invecchia in settimane.
-->
