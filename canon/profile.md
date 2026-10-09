# Profile

> Fonte unica di verità per i fatti sull'azienda. Ogni agente legge questo file quando deve sapere "chi è chi" o "che business facciamo".
>
> Lingua di lavoro degli artefatti: **{{LINGUA}}**. Voce e posizionamento in [`company-rules.md`](company-rules.md).

<!--
COME SI COMPILA
- È il primo file da scrivere, insieme a company-rules.md.
- Solo fatti stabili, ognuno con la fonte accanto quando è un numero. Lo stato che cambia ogni
  settimana (valori dei KR, pipeline, campagne) non va qui: sta nel sistema che lo possiede.
- I numeri economici sono facoltativi. Se li scrivi, indica sempre il sistema da cui vengono.
- Gli esempi usano l'azienda inventata "Fornace". Cancellali quando scrivi i tuoi.
-->

---

## Azienda

- **Nome:** <!-- ragione sociale -->
- **Pitch in una riga:** <!-- es. "Il software di prenotazione per ristoranti indipendenti." -->
- **Verticale e mercato:** <!-- -->
- **Stadio:** <!-- es. bootstrapped e profittevole, seed, serie A -->
- **Organico:** <!-- numero indicativo -->
- **Mercati primari:** <!-- -->
- **Metrica di riferimento:** <!-- es. ricavi ricorrenti annui, con il sistema che fa da fonte di verità -->

## Leadership

Possiede i file trasversali di questo repo.

- **<Nome Cognome>**, <ruolo>. <!-- cosa guida, link a people/<slug>.md -->
- **<Nome Cognome>**, <ruolo>.

## Team lead

| Team | Lead | Di cosa si occupa |
|---|---|---|
| <!-- Leadership --> | <!-- [[nome-cognome]] --> | <!-- strategia, OKR, decisioni trasversali --> |
| <!-- ... --> | | |

> Indice ad alto livello. Per chi fa cosa (e cosa non fa), alias e autorità decisionale vedi [`people/`](../people/) e le regole di team in [`canon/team/`](team/).

## Integrazioni in uso (fonti per la generazione)

*Elenca gli strumenti da cui gli agenti leggono, con una riga su cosa contengono e come si accede (MCP, CLI, export). Annota le trappole note.*

- **{{DOCS_SYSTEM}}** (docs system, via MCP): <!-- cosa ci vive -->
- **{{CHAT_TOOL}}** (team chat, via MCP): <!-- canali principali; regola di lettura, es. "per intervallo di date, non per parola chiave" -->
- **{{CRM}}** (via MCP): <!-- contatti, aziende, pipeline -->
- **GitHub** (`{{REPO_URL}}`): questo repo e <!-- i repo di prodotto -->.
- **Note delle call**: <!-- strumento di trascrizione; le trascrizioni storpiano i nomi propri, si verificano prima di scriverli -->
- **Analytics**: <!-- -->
- **Pagamenti e fatturazione**: <!-- -->

## Clienti e partner citabili

*Solo nomi che si possono citare in un output. Niente valori di contratto (vedi [`company-rules.md`](company-rules.md) → "Regole dati cliente").*

---

## Missione

*Una frase, scritta da {{OWNER_CANON}}. Se la formulazione è fissa, scrivilo: "si usa così com'è".*

## Temi dell'anno

Ancore a cui ogni roadmap, campagna e deal deve ricollegarsi.

- **<tema>:** <!-- una riga sul perché -->

## Obiettivi dell'anno

- <!-- obiettivo, con il riferimento all'objective del quarter in ../objectives/ -->

## Pilastri di prodotto

- **<pilastro>:** <!-- -->

## Postura go-to-market

- **Mercati e segmenti:** <!-- dettaglio in icp.md -->
- **Come raggiungiamo i clienti:** <!-- canali -->
- **Chi guida le vendite:** <!-- -->

## Principi operativi

- <!-- es. "Un solo owner per deliverable." -->
- <!-- es. "Ogni numero si scrive con la fonte accanto." -->

---

*File modificabile da {{OWNER_CANON}} via PR. Va aggiornato quando cambia l'organizzazione (nuovo lead, nuovo mercato, nuovo tema dell'anno). La sessione successiva lo legge da sola.*
