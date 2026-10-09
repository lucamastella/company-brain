---
name: session-start
description: Apre una sessione di lavoro nel cervello aziendale ricostruendo da dove si riprende. Trigger quando l'utente dice "session start", "da dove riprendo", "cosa c'è di aperto", "cosa era rimasto in sospeso", "apri la sessione", "cosa facciamo oggi", "riprendiamo", "fammi il punto", oppure quando apre la giornata senza dire su cosa vuole lavorare. Legge signals/aperto.md (i thread lasciati a metà), i signal recenti, le decisioni già chiuse in decisions/ e controlla se il cervello è stantio, poi propone le priorità con la fonte di ognuna e carica le regole del team che possiede il task. Skill di sola lettura, non scrive niente nel repo. NON usare per chiudere una sessione (session-end) né per il punto della giornata con le priorità a ritorno più alto e l'aggiornamento della card settimanale (focus).
---

# Session start · riprendere da dove si era rimasti

L'hook SessionStart ([`scripts/session_context.sh`](../../../scripts/session_context.sh)) stampa già il conteggio dei thread aperti a ogni avvio. Questa skill è la versione ragionata: non elenca, **decide cosa vale la pena riprendere** e prepara il contesto per farlo.

**Sola lettura.** Questa skill non scrive nel repo, non committa, non aggiorna il registro. Chi scrive è `session-end`.

## Procedura

### 1. Thread aperti

Leggi [`signals/aperto.md`](../../../signals/aperto.md), sezione `## Aperto`. Per ogni riga tieni: cosa manca, da quanti giorni è lì, il signal di origine.

**Il registro è condiviso da tutto il team.** Prima i thread di chi ha aperto la sessione (lo slug si ricava da `git config user.name`, in minuscolo con i trattini), poi in una riga quanti ne restano assegnati ad altri. Un thread di un'altra persona non si propone come priorità: lo si nomina e basta.

Segnala in chiaro due cose:

- **I thread vecchi.** Sopra i 14 giorni non sono priorità dimenticate, sono candidati a essere chiusi. Chiedilo.
- **Il file troppo lungo.** Sopra le 40 righe aperte il registro non serve più: proponi un giro di pulizia prima di aggiungere lavoro nuovo.

Se il registro è vuoto, dillo. Non riempire il vuoto con ipotesi su cosa la persona potrebbe voler fare.

### 2. Cosa è cambiato da allora

Leggi i signal degli ultimi 30 giorni in [`signals/`](../../../signals/) (`manual/`, `daily-call/`, `email/`), dal più recente. Servono per due motivi: capire se un thread aperto è già stato chiuso altrove; non riproporre come nuovo qualcosa che è già stato affrontato.

**Controllo di freschezza.** Se il signal più recente ha più di 7 giorni, dillo in chiaro: *"l'ultimo signal è del <data>, il cervello è stantio su cosa è successo dopo"*. Non trattare uno stato vecchio come attuale e non compensarlo inventando. Lo stato vivo di OKR, KR e progetti sta nel docs system (vedi `canon/operating-system.md`): se serve, va letto là.

### 3. Cosa è già stato deciso

Prima di riaprire un tema, controlla [`decisions/`](../../../decisions/). Una decisione chiusa non si rilitiga: si legge. Se la condizione di riapertura è soddisfatta si propone di riaprirla citando il file. Controlla sempre `superseded_by:` prima di trattare una decisione come valida.

### 4. Memoria locale contro repo

Riconcilia la memoria locale col repo come prescrive [`canon/operations.md`](../../../canon/operations.md) → "Riconciliazione della memoria locale a inizio sessione": sui temi aziendali vince il repo. Se una memoria personale contraddice il canon, correggila e dillo. Le preferenze personali che non contraddicono niente si lasciano stare.

### 5. Carica le regole del task, non solo quelle della persona

Quando la persona dice su cosa vuole lavorare, carica `canon/team/<team-che-possiede-il-task>.md`, non solo quello del suo team ([`canon/operations.md`](../../../canon/operations.md) → "Caricamento delle regole per task"). Se il task ne tocca più di uno, caricali tutti.

## Output in chat

Massimo dodici righe, in questa forma. Ogni voce porta la sua fonte, così chi legge può aprire il file invece di fidarsi.

```
Aperti: <n>. Il più vecchio è di <n> giorni.

1. <thread> · dal <data> · [signal](percorso)
2. <thread> · dal <data> · [signal](percorso)
3. <thread> · dal <data> · [signal](percorso)

Freschezza: ultimo signal <data> (<n> giorni). <avviso se stantio>
Da chiudere, secondo me: <thread vecchi che non hanno più senso>
Su cosa lavoriamo?
```

Se ci sono più di tre thread aperti, mostra i tre che proponi come priorità e di' quanti restano. La proposta va motivata in mezza riga (blocca altri, ha una scadenza, è vecchio di tre settimane).

## Regole

- Non inventare thread che non stanno nel registro o nei signal.
- Non dare per fatto quello che non è a record: se non sai se una cosa è stata chiusa, chiedi.
- Non aprire lavoro nuovo prima di aver detto cosa c'era di aperto: è tutto il punto della skill.
- Scrivi nella lingua e con le regole di voce di `canon/company-rules.md` → "Voce".
