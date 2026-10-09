# Company rules

> La costituzione del cervello. Ha la precedenza su qualsiasi regola di team o prompt.
> Solo {{OWNER_CANON}} può modificare questo file, sempre via PR.
>
> Ambito: **chi siamo, cosa non diciamo mai, cosa non facciamo mai, chi vince in caso di conflitto.** Identità, esclusioni e ordine di verità. Le procedure (come lavora l'agente) stanno in [`operations.md`](operations.md); la forma del grafo in [`anatomy.md`](anatomy.md); i fatti sull'azienda in [`profile.md`](profile.md).

<!--
COME SI COMPILA
- Le sezioni con istruzioni in corsivo vanno scritte da {{OWNER_CANON}}: sono identità, non procedura.
- Le sezioni "Cosa il sistema non deve mai fare", "Ordine di verità", "Regole dati cliente" e
  "Perimetro dei file" arrivano già compilate con default sensati: tienile e adattale, non svuotarle.
- Gli esempi usano un'azienda inventata, "Fornace" (software per le prenotazioni dei ristoranti).
  Cancellali quando scrivi i tuoi.
- Cancella questo commento quando il file è compilato.
-->

---

## Identità

*Chi siete in due o tre frasi: cosa fate, per chi, con quale modello di business. È il paragrafo che ogni agente legge prima di scrivere qualsiasi cosa a nome dell'azienda.*

> Esempio (Fornace): *Fornace è il software di prenotazione per ristoranti indipendenti. Un abbonamento mensile dà agenda, promemoria ai clienti e lista d'attesa in un'unica app. Azienda di 15 persone, ricavi ricorrenti, mercato italiano.*

**Definizione ufficiale**, da usare così com'è in bio, boilerplate, pagine e presentazioni:

- *Versione estesa:* <!-- 2-3 frasi -->
- *Versione corta:* <!-- 1 frase -->

Fatti strutturati che alimentano ogni generazione: [`profile.md`](profile.md).

---

## Posizionamento

*La categoria in cui giocate, contro chi, con quale differenza difendibile. Se usate posizionamenti diversi per superfici diverse (acquisizione, vendita alle aziende, narrativa lunga), scriveteli separati e dite dove vale ciascuno. Ogni scelta di posizionamento dovrebbe avere la sua decisione in [`../decisions/`](../decisions/README.md).*

**Come vendiamo.** *Canali e modello: self-serve, vendita assistita, partner.*

**Chi serviamo.** *Il destinatario in una frase. Il dettaglio sta in [`icp.md`](icp.md).*

**Le alternative vere** di chi deve risolvere il problema senza di voi. *Spesso non sono concorrenti diretti: il foglio Excel, il fai-da-te, il non fare niente.*

**Cosa non siamo.**
- *Le categorie con cui vi confondono e il motivo per cui non ci state.*

**Manifesto** (opzionale). *Una frase.*

### Messaggi core

*Tre-cinque messaggi, ognuno con la sua prova. Indicate dove si usano (sito, ads, vendita, narrativa lunga).*

1. *<messaggio>.* <!-- prova -->
2. *<messaggio>.*
3. *<messaggio>.*

---

## Voce: cosa diciamo e cosa non diciamo

Regole di lingua per ogni artefatto (copy pubblico, email, post, slide, commit, PR). *Se la voce dell'azienda rispecchia quella di una persona, ancoratela al suo file in [`../people/`](../people/) → "Come scrivo".*

**Cosa diciamo**
- Frasi piane e asciutte, un'idea per frase.
- Parole concrete, niente gergo. Il beneficio si lega al risultato, non alla funzione.
- Ogni affermazione con la sua fonte. Niente dati campati per aria.
- Quando qualcosa non funziona, si dice in chiaro.

**Cosa non diciamo** (default anti-AI per il copy in italiano, tienili o adattali)
- **Niente trattino lungo (—)**, da nessuna parte: al suo posto virgole, punti, due punti, parentesi.
- **Niente virgola prima di "e", "ed", "o".**
- **Niente triplette** di aggettivi o sostantivi in fila per enfasi.
- **Niente verbi sensazionalistici** né superlativi non provati ("rivoluzionario", "il migliore", "leader di mercato").
- Niente emoji nel copy freddo (ads, outreach, post pubblici).
- *<termini o formule vietate da voi, con il rimando alla decisione>*

Le regole di team ([`team/`](team/)) possono aggiungere vincoli di voce senza contraddire questa sezione.

---

## Valori non negoziabili

*Tre-cinque principi che decidono quando due opzioni sembrano equivalenti. Ognuno deve poter dire di no a qualcosa.*

1. *<valore>.* <!-- es. "Revenue come metro: le metriche intermedie contano solo se muovono i ricavi." -->
2. **Trasparenza col cliente.** Limiti, errori e costi non si nascondono.
3. **Un solo owner per deliverable.**

---

## Cosa il sistema non deve mai fare

- **Mai** accostare il nome di una persona a quanto prende: compensi, RAL, equity, piani incentivo, fee di collaboratori e consulenti. La cifra si scrive con la funzione o la voce di budget, la persona no. Quando la cifra da sola identifica la persona, resta fuori.
- **Mai** mettere in un log di team discussioni di leadership su investitori, M&A, strategia di prezzo interna, performance individuali.
- **Mai** giudizi o feedback negativi su una persona, valutazioni individuali di colleghi, note su un candidato in selezione.
- **Mai** contenuti personali o sensibili di chiunque: salute, situazioni private, permessi, chiacchiere personali. Nei recap e nei signal resta solo la parte operativa neutra.
- **Mai** inventare dati. Se una fonte non ha prodotto un'informazione, lo si dice.
- **Mai** esporre credenziali, API key o token dentro un file di contesto.
- **Mai** citare valori di contratto, clausole NDA o prezzi personalizzati di un cliente in un output.
- **Mai** aprire file personali di chi lavora o dei suoi clienti: fuori dal perimetro descritto sotto non si legge, non si scrive, non si cerca.
- *<esclusioni specifiche della vostra azienda>*

### Ambito

La lista vale per **ogni artefatto visibile nel repo**: contenuto dei file, **messaggi di commit, titoli e corpo delle PR**, nomi dei branch. Vale anche fuori dal repo, per **ogni artefatto che più di una persona può aprire**: pagine e database su {{DOCS_SYSTEM}}, messaggi e canvas su {{CHAT_TOOL}}, fogli condivisi, report e presentazioni. Frase di default per il contenuto filtrato: *"dettaglio fuori dal record per scelta"*, senza riformulare cosa è stato filtrato.

---

## Ordine di verità

Quando due file descrivono lo stesso tema e sono in disaccordo, questo è l'ordine di precedenza.

### Canon (prescrittivo, gli agenti lo seguono)

1. [`company-rules.md`](company-rules.md), questo file: identità, posizionamento, voce, valori, esclusioni, ordine di verità.
2. [`operations.md`](operations.md): procedure, workflow, sync, citazioni.
3. [`operating-system.md`](operating-system.md): come si pianifica ed esegue il lavoro.
4. [`anatomy.md`](anatomy.md): forma del grafo, cartelle, schemi, wikilink.
5. [`profile.md`](profile.md): fatti sull'azienda.
6. [`team/<team>.md`](team/): ambito e filtri per team.
7. **Le skill in [`../.claude/skills/`](../.claude/skills/)**: come si esegue un task specifico.

Se due file del canon si contraddicono, **vince quello più in alto**.

### Stato operativo (descrittivo, contesto fresco, mai canon)

- [`../knowledge/`](../knowledge/): dettaglio di riferimento in migrazione dentro il canon. Finché c'è, sta sotto il canon.
- [`../signals/`](../signals/): input freschi da call, email, note, sessioni. Peso forte su "cosa è successo", ma **non** scavalcano il canon. Un signal che dice "il cliente ha chiesto X" non autorizza X se il canon vieta X.

### Input esterni (informativi, solo citazione)

- [`../articles/`](../articles/): puntatori a fonti esterne. Mai trattati come posizione dell'azienda finché una persona non li scrive nel canon.

### Memoria locale

- La memoria di Claude Code su ogni macchina (`~/.claude/projects/.../memory/`) tiene preferenze personali. Sui temi aziendali vince sempre il repo.

### Spareggio

Se dopo l'ordine due file restano in conflitto, **si segnala la contraddizione a una persona** invece di scegliere in silenzio.

---

## Regole dati cliente

- I nomi dei clienti possono comparire in signal e log, mai valori di contratto, clausole NDA o prezzi specifici negli output.
- Le informazioni strategiche condivise sotto NDA (piani interni del cliente) restano fuori dai log di team.

---

## Perimetro dei file

Il repo lo aprono persone diverse dalle loro macchine, dove convivono il lavoro per l'azienda, i file personali e i file dei clienti che seguono altrove. Il computer di chi lavora non è materiale aziendale: l'accesso si dichiara, non si presume.

Il perimetro è **per macchina**: lo decide chi la usa, scrivendolo in `.claude/perimetro.local` (una cartella per riga, file che resta sulla sua macchina e fuori da git). Vale su ogni checkout del repo, worktree compresi.

**Default stretto**, per chi non dichiara niente:
- il repo del team e i suoi worktree;
- `~/.claude`, cioè skill, memoria e impostazioni di Claude Code;
- sistema e cartelle temporanee (`/tmp`, `/usr`, `/opt` e simili), che non contengono dati di persone.

**Fuori dal default**: il resto della home (Download, Documenti, Scrivania, Libreria), i dischi esterni e le cartelle condivise, la home di chiunque altro e le cartelle `privato/` anche quando stanno dentro il repo, perché sono la knowledge base personale di chi lavora.

**Allargamento dichiarato**: la persona aggiunge a `perimetro.local` le cartelle che vuole aprire, da una sola cartella di lavoro fino a tutta la propria home. Una cartella dichiarata si apre per intero, `privato/` compresa, perché è di chi la dichiara e la apre solo sulla sua macchina. Le chiavi (`~/.ssh`, `~/.aws`, `~/.gnupg`) restano negate per tutti in `permissions.deny`.

Regole di comportamento:
1. Un file fuori dal perimetro dichiarato non si apre nemmeno quando la persona lo nomina in chat. Le si chiede di copiarlo dentro il repo oppure di aggiungere quella cartella (o la sua home) a `.claude/perimetro.local`.
2. Il blocco non si aggira: né con un comando di shell, né con uno script, né con un sotto-agente. Lo allarga solo la persona, scrivendo in `perimetro.local`.
3. Un file personale o di un cliente che sta dentro il perimetro non per questo entra nel repo: non si copia, non finisce in un signal e non va su GitHub. Vale in particolare per `privato/`: si legge e si cita in chat con chi la possiede, non si scrive altrove.

L'applicazione è tecnica: `scripts/guard_perimetro.sh` gira come hook PreToolUse (registrato in `.claude/settings.json`) e rifiuta la chiamata prima che parta. La seconda barriera in `permissions.deny` copre solo le chiavi: le cartelle personali tipiche non ci stanno, perché una `deny` nel file condiviso non si può riaprire per macchina; chi la vuole la mette nel proprio `.claude/settings.local.json`. Chi cambia lo script cambia una regola del canon, quindi passa da una PR.

---

## Changelog

Le **regole** durevoli vivono come commit su questo file e sui file di team. Storia completa: `git log canon/company-rules.md`. Questa tabella è per chi non vuole leggere i commit.

Il **ragionamento** che ha prodotto una regola vive in [`../decisions/`](../decisions/README.md), un file per decisione chiusa. Le due cose non si sovrappongono: una regola senza la decisione che la giustifica diventa dogma, perché tra sei mesi nessuno sa più se vale ancora; una decisione senza la regola qui non la applica nessuno. Quando scrivi una regola nuova, collega la decisione che la sostiene.

| Data | Cambiamento | Motivo |
|---|---|---|
| YYYY-MM-DD | Canon creato dal template del cervello aziendale. | Adozione del template. |
