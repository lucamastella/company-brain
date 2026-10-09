---
name: focus
description: Il punto della giornata per chi guida un team o un'azienda. Dice cosa è già stato fatto oggi, cosa resta aperto e quali sono le due o tre attività col ritorno più alto nel tempo che resta. Legge il calendario, la card settimanale nel docs system, i messaggi in chat di oggi, le sessioni Claude e il repo, poi aggiorna la card spuntando quello che risulta fatto e aggiungendo il lavoro non pianificato. Trigger con "focus", "cosa faccio adesso", "cosa faccio nel tempo che resta", "fammi il punto della giornata", "cosa ho fatto oggi", "aggiorna la card della settimana", "cosa mi resta oggi", "priorità del pomeriggio", "a che punto sono con gli obiettivi della settimana", "chiudi la giornata". Include le regole di ordinamento per ritorno, il test "questo lo posso fare solo io", la delega alla persona giusta e la creazione della card del lunedì. NON usare per riprendere i thread aperti del repo (session-start) né per chiudere una sessione di lavoro (session-end).
---

# Focus · il punto della giornata

<!--
PRIMA DI USARLA
Questa skill presuppone una "card settimanale": una pagina nel docs system con l'obiettivo unico
della settimana, tre obiettivi con il loro criterio di chiusura, una sezione per giorno e un
backlog. Se non la usate ancora, la fase 5 la crea al primo lunedì.
Compila references/fonti.md con gli ID dei tuoi strumenti: è l'unico file da adattare.
Cancella questo commento quando hai compilato le fonti.
-->

Una skill sola, un giro solo. Si lancia più volte al giorno e risponde sempre alle stesse tre domande, in quest'ordine: **cosa ho già fatto oggi**, **dove sono rispetto agli obiettivi della settimana**, **cosa faccio adesso nel tempo che resta**. Poi scrive la risposta dentro la card della settimana, perché il posto dove la persona guarda la giornata è quello, non la chat.

Il valore non è l'elenco. È togliere dal tavolo le cose che sembrano urgenti e non spostano niente, lasciando due attività per volta. **Una lista di dieci voci è il problema che questa skill risolve, non il suo output.**

## Quando usarla

- Rientro dopo pranzo o dopo un blocco di call, quando non si sa da dove ripartire.
- Metà mattina, per capire se la giornata sta andando dove doveva.
- Fine giornata, per registrare sulla card cosa è stato fatto.
- Lunedì, quando la card della settimana nuova non esiste ancora.

## Quando non usarla

- **Riprendere i thread aperti del repo** → `session-start`.
- **Chiudere un blocco di lavoro con Claude e scrivere il signal** → `session-end`.
- Quando si sta già lavorando su una cosa decisa: questa skill interrompe il lavoro per riordinarlo. Se il lavoro è chiaro, riordinarlo è tempo perso.

## Il giro, sei fasi in sequenza

Le fasi da 0 a 3 girano sempre. La 4 scrive, la 5 è il caso del lunedì. ID, query e comandi stanno in [`references/fonti.md`](references/fonti.md): leggilo prima di partire, così non si cerca niente.

### Fase 0. Orienta: che giorno è, quanto tempo resta

1. Data, ora e giorno della settimana con `date` (mai dedurli dal contesto).
2. Calendario principale della persona, due letture: da adesso a fine giornata più domani per intero.
3. Calcola il **tempo utile che resta**: da adesso all'ora di fine giornata indicata in `fonti.md`, meno gli eventi, meno quindici minuti per ogni passaggio da una call all'altra.

**Regola sul calendario.** Si leggono solo titolo, orario, partecipanti e la risposta all'invito. Le descrizioni degli eventi ricorrenti possono essere lunghissime e non servono: non vanno lette, citate o riassunte. Gli altri calendari restano fuori, tranne quando la domanda riguarda proprio quelli.

Un evento senza risposta che si sovrappone a un blocco di lavoro è una decisione da far notare in una riga, non da prendere al posto della persona.

### Fase 1. La card della settimana

Trova la card con la query di `fonti.md`, prendendo quella il cui intervallo di date contiene oggi. Poi leggi la pagina e tieni cinque cose:

- **l'obiettivo principale unico** della settimana;
- **i tre obiettivi**, ognuno col suo campo *Chiuso quando*;
- la riga **"Resta fuori dai tre"**, dove la persona scrive da sé cosa sta slittando;
- **la sezione del giorno**, con le voci spuntate e non;
- il **backlog** sotto i giorni, cioè le voci senza data che nessuno ha mai tirato in una giornata.

Il campo *Chiuso quando* è il perno della skill: è il criterio con cui si misura il progresso e si ordina il lavoro. Se un obiettivo non ce l'ha, dillo e chiedi di scriverlo, perché senza quello l'ordinamento è un'opinione.

Se la card non esiste, vai alla fase 5. Se esiste ma oggi non ha la sua sezione, creala in fase 4 con le voci che restano aperte.

### Fase 2. Riconcilia: cosa è già stato fatto

Quattro fonti, in quest'ordine. Servono a capire cosa è stato fatto, che è quasi sempre diverso dalla lista del mattino.

1. **La chat del team, una sola ricerca**: i messaggi scritti oggi dalla persona. È la fonte migliore perché nei canali racconta al team cosa ha fatto mentre lo fa. Una chiamata sola, non un giro canale per canale.
2. **Le sessioni Claude di oggi** su questa macchina: il lavoro fatto con Claude spesso non è scritto da nessun'altra parte.
3. **Il repo**: il `git log` di oggi filtrato sulla data di autore (comando in `fonti.md`) più la sezione `## Aperto` di `signals/aperto.md`, filtrata sullo slug della persona.
4. **Il docs system**, solo per chiudere il cerchio: le pagine modificate oggi.

**La regola della prova.** Una voce del giorno si dà per fatta solo con una prova: un messaggio, un commit, una sessione, una pagina modificata, una frase della persona in questa chat. Senza prova resta aperta. Meglio una casella vuota di una spuntata a caso: una card che mente vale meno di una vuota.

**La metà che vale.** Metà del lavoro di una giornata non era in lista. Quello va scritto, col numero quando c'è (es. la voce diceva "sistemare la campagna", il lavoro vero è stato portare il costo per contatto da 1,40 € a 0,40 €). È il motivo per cui questa fase esiste.

### Fase 3. Ordina per ritorno

Si propongono **due attività, tre al massimo**. Ognuna in una riga, col perché in mezza riga e il tempo stimato.

Le regole, in ordine di peso:

1. **Sale quello che sta sul percorso di uno dei tre obiettivi** e il cui *Chiuso quando* non è ancora vero. Nomina l'obiettivo, così la proposta si può contestare.
2. **Sale quello che sblocca altre persone**: qualcuno del team fermo in attesa di una risposta, di un sì, di un accesso. Scende quello in cui è la persona ad aspettare qualcun altro: si sollecita in trenta secondi, non si lavora.
3. **Test "questo lo posso fare solo io".** Sale: decisioni, posizionamento, prezzi, approvazioni, assunzioni, soldi, rapporti con le persone (team, clienti, candidati). Scende: analisi, bozze, copy, report, ricerche, sistemazioni. Per ogni cosa che scende, proponi **a chi va** guardando `people/` e `canon/team/`, con una riga pronta da incollare in chat.
4. **Sale quello che scade oggi**, scende quello che avrà ancora una finestra domani. La finestra si guarda sul calendario di domani: una cosa che serve alla call di domani mattina è di oggi.
5. **Quello che sta fuori dai tre obiettivi resta fuori**, con una sola eccezione: quando blocca soldi o spesa.
6. **Deve entrare nel tempo che resta.** Un'attività da tre ore alle 17:30 non è una proposta. Se il tempo utile è sotto i quaranta minuti, proponi una cosa sola e piccola.

### Fase 3 bis. Prima di proporre, chiedersi chi la fa

**Uno: la faccio io?** Per ogni attività candidata, la domanda è se Claude può farla tutta oppure farne la metà che costa più tempo. Quando la risposta è sì, la proposta non è l'attività: è la divisione del lavoro, detta in chiaro. "Tu fai la review coi team, io ti preparo l'analisi dei KR" vale più di "prepara la review", perché libera un'ora invece di prenotarla. Il taglio tipico: raccolta, lettura di report, conteggi, incrocio fra fonti e sintesi scritta sono di Claude; decisione, conversazione e giudizio sono della persona.

**Due: la fa qualcun altro senza bisogno di prepararla?** Un'attività di preparazione esiste solo se il lavoro è suo. Se la review la fanno i team, prepararla al posto loro è lavoro doppio. Prima di proporre una preparazione guarda chi possiede il lavoro nel modello OKR (`canon/operating-system.md`, `projects/`) e proponi quello che serve alla persona, non quello che nomina la card.

**Tre: la fa un'altra persona del team?** Vale il test della fase 3, punto 3, con il nome e la riga pronta.

Sul **backlog sotto i giorni** vale una regola a parte: non si propone mai come priorità del pomeriggio. Si dice quante voci sono, da quanto stanno lì e si propone di chiuderle o di agganciarle a un obiettivo.

Infine, una riga su **cosa hai escluso e perché**. È la parte che libera la testa.

### Fase 4. Scrivi sulla card

Il giro non è finito finché la card non riflette la realtà:

- **Spuntare una voce fatta**, sostituendo `- [ ] <testo esatto>` con `- [x] <testo esatto>`. Se la card annida le voci con i tab, la stringa da sostituire deve riprodurre l'indentazione esatta letta in fase 1.
- **Aggiungere il lavoro non pianificato**: nuove voci `- [x] <cosa, col numero se c'è>` dentro la sezione del giorno, alla stessa profondità delle altre. Nessun formato nuovo.
- **Aggiungere la sezione del giorno** quando manca, nella stessa forma delle altre.
- **Spostare quello che non è di oggi.** Quando la persona dice che una cosa non serve adesso, la si toglie dal giorno e la si mette nel backlog o nel giorno in cui va. Una voce non spuntata dentro un giorno passato è indistinguibile da una dimenticata. Prima di spostarla controlla che non ci sia già nel backlog.
- **Non toccare** l'obiettivo unico, i tre obiettivi, la riga "Resta fuori dai tre" e il backlog: li scrive la persona. Al massimo si propone in chat una correzione, per esempio quando un *Chiuso quando* è diventato vero.

Non si sovrascrive la pagina intera, non si creano pagine non richieste, si riscrive solo quello che è diventato falso e lo si dice. Una casella si spunta solo con la prova della fase 2.

**La prima settimana la skill propone e aspetta il sì**, elencando in chat le caselle che spunterebbe. Dalla seconda scrive da sola e riporta cosa ha scritto. Quando la persona dice "ho fatto questa", la prova è la sua frase: si spunta subito.

### Fase 5. Lunedì: la card nuova

Quando nessuna card contiene la data di oggi, la settimana non è ancora aperta. Prepara la bozza e **chiedi il sì prima di creare la pagina**. Si ricalca la struttura della card precedente:

1. **Titolo** e intervallo di date della settimana.
2. **Obiettivo principale unico**, proposto dall'objective del quarter (`objectives/`) e da cosa è rimasto aperto.
3. **I tre obiettivi**, ognuno col suo *Chiuso quando* misurabile. Tre, mai quattro.
4. **"Resta fuori dai tre"**: quello che si sa già che slitterà, detto in chiaro.
5. **I giorni**, con le call già a calendario al loro posto.
6. **Il backlog**: si riporta solo ciò che è agganciato a un obiettivo, per il resto si chiede voce per voce se si chiude. Riportare tutto significa rifare la lista dove le cose vanno a morire.

## Output in chat

Massimo dodici righe. Il resto sta nella card.

```
Giovedì 17, 12:30. Restano ~4 ore, una call alle 17 (review di prodotto).
Obiettivo unico: <obiettivo della settimana>.

Fatto oggi (3): <voce>, <voce>, <voce, col numero>. Aggiornato in card.

Adesso, in ordine:
1. <attività> (~60 min) · blocca <cosa>, slitta da due settimane, solo tu
2. <attività> (~20 min) · serve prima di <scadenza>

Delega: <attività> → <persona>. Riga pronta: «...»
Non oggi: <attività>, nessuna finestra si chiude prima di lunedì.
Backlog sotto i giorni: 8 voci, la più vecchia da tre settimane. Ne chiudiamo qualcuna?
```

## Regole

- **Niente proposte senza fonte.** Ogni voce proposta arriva dalla card, dal registro aperto, dalla chat o dal calendario.
- **Mai più di tre proposte**, mai l'elenco completo dell'aperto: quello lo dà `session-start`.
- **Il tempo è un vincolo.** Ogni proposta dichiara quanto dura e sta nel tempo che resta.
- **La delega ha un nome**, con la riga pronta.
- **Un thread si segnala aperto solo dopo aver guardato se è già chiuso.** Prima di proporre "rispondi a X", apri il thread: se la persona ha già risposto o reagito, la voce va spuntata. È l'errore che fa perdere fiducia più in fretta.
- **Due persone con lo stesso nome non sono la stessa persona.** Ricava il nome dal canale o dal thread da cui arriva la voce. Se resta ambiguo, scrivi il dubbio invece di scegliere.
- **Niente giudizi sulla giornata.** Si descrive con fatti e numeri, senza "giornata pesante" o "stai andando bene". Il giudizio lo tira la persona.
- Lingua e voce di `canon/company-rules.md` → "Voce".
- Se una fonte non risponde, si dice quale manca e si va avanti con le altre. Un punto parziale e dichiarato vale più di uno completo e inventato.

## Checklist prima di chiudere

- [ ] Data e ora prese da `date`, non dedotte
- [ ] Calendario letto senza aprire le descrizioni degli eventi
- [ ] Tempo utile residuo calcolato, call comprese
- [ ] Card della settimana trovata con la query, non con una ricerca generica
- [ ] I tre obiettivi letti col loro *Chiuso quando*
- [ ] Riconciliazione fatta su chat, sessioni Claude e repo
- [ ] Ogni casella spuntata ha una prova, le altre sono rimaste aperte
- [ ] Il lavoro fatto e non pianificato è finito in card, col numero dove c'era
- [ ] Per ogni proposta, chiesto prima se la fa Claude, un'altra persona o la persona stessa
- [ ] Massimo tre proposte, ognuna col perché, il tempo e l'obiettivo che spinge
- [ ] Detto cosa è stato escluso e perché
- [ ] Detto cosa si è scritto sulla card, con il link
