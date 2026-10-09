---
name: consolidate-memory
description: Passata di riordino sui file della memoria locale di Claude Code. Unisce i doppioni, corregge i fatti invecchiati, pota l'indice MEMORY.md e sposta nel repo quello che riguarda il team. Trigger con "consolida la memoria", "riordina la memoria", "pulisci la memoria", "consolidate memory". NON usare per salvare un fatto nuovo (basta la parola-trigger "salva questo") né per chiudere una sessione (session-end).
---

# Consolidamento della memoria

Stai facendo una passata di riordino su quello che hai imparato su questa persona e sul suo lavoro. L'obiettivo: una sessione futura deve orientarsi in fretta (con chi lavora, su cosa è concentrata, come vuole le cose) senza richiedere niente.

La sezione sulla memoria automatica del tuo prompt di sistema definisce la cartella, il formato dei file e i tipi di memoria. Seguila.

## Fase 1: fai l'inventario

- Elenca la cartella della memoria e leggi l'indice (`MEMORY.md`).
- Scorri ogni file. Annota quali si sovrappongono, quali sembrano vecchi, quali sono magri.

## Fase 2: consolida

**Separa il durevole dal datato.** Preferenze, modo di lavorare, relazioni chiave e flussi ricorrenti sono durevoli: tienili e rendili più precisi. Progetti specifici, scadenze e compiti singoli sono datati: se la data è passata o il lavoro è finito, ritira il file oppure porta la lezione che resta (es. "per i documenti di lancio preferisce il formato X") dentro un file durevole.

**Unisci le sovrapposizioni.** Se due file descrivono la stessa persona, lo stesso progetto o la stessa preferenza, uniscili in uno e tieni il percorso del più ricco.

**Correggi i riferimenti al tempo.** "La settimana prossima", "questo trimestre", "entro venerdì" diventano date assolute, così restano leggibili più avanti.

**Togli quello che si ritrova facilmente.** Se una memoria ripete qualcosa che puoi ricavare al momento da calendario, documenti o strumenti collegati, tagliala. Tieni quello che è difficile da ricostruire: preferenze dichiarate, il contesto dietro una decisione, a chi rivolgersi per cosa.

**Riconcilia col repo.** Sui temi aziendali vince il repo ([`canon/operations.md`](../../../canon/operations.md) → "Riconciliazione della memoria locale a inizio sessione"). Se una memoria contraddice il canon, correggila. Se una memoria contiene qualcosa che serve al team (un fatto sull'azienda, una regola di produzione di una skill), proponi di spostarla nel posto giusto del repo e lascia in memoria al massimo un puntatore: due copie sono una che si aggiorna e una che invecchia.

## Fase 3: riordina l'indice

Aggiorna `MEMORY.md` in modo che resti sotto le 200 righe e circa 25KB. Una riga per voce, sotto i 150 caratteri circa: `- [Titolo](file.md) · gancio di una riga`.

- Togli i puntatori alle memorie ritirate.
- Accorcia le righe che portano dettagli da file di argomento.
- Aggiungi quello che è diventato importante.

Chiudi con un riepilogo breve: quanti file hai toccato, cosa è cambiato, cosa proponi di spostare nel repo.
