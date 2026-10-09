# Aperto · thread di lavoro non chiusi

> Registro rotante di cosa è rimasto in sospeso. Lo **scrive** la skill `session-end`, lo **leggono** la skill `session-start` e l'hook SessionStart ([`../scripts/session_context.sh`](../scripts/session_context.sh)), che ne stampa le prime righe nel contesto di ogni nuova sessione.

**Questo file è una cache derivata, non la fonte di verità.** La verità sta nella sezione `## Aperto` dei signal in [`manual/`](manual/). Se il file si perde, va in conflitto o smette di tornare, si ricostruisce leggendo i signal degli ultimi 60 giorni. Non sostituisce lo strumento in cui vivono le Attività e i Task del team (vedi [`../canon/operating-system.md`](../canon/operating-system.md)): qui stanno solo i fili lasciati a metà dentro una sessione di lavoro con Claude.

## Come si scrive una riga

```
- [ ] <cosa manca, una riga> · @<slug-persona> · dal YYYY-MM-DD · [signal](manual/YYYY/MM/<file>.md)
```

Regole:

- **Ci entra solo ciò che Claude può riprendere ed eseguire** nella sessione dopo: una skill da correggere, un file da portare su `main`, una misura da rifare, un allegato da sistemare. Le decisioni si propongono in chat e vanno in `decisions/` quando sono prese; i task delle persone stanno nello strumento del team; le idee senza prossimo passo restano nel signal. Il signal resta la fonte completa, il registro è il sottoinsieme che serve a riprendere.
- **Una riga per thread**, al presente e con un verbo. Non "lancio di marzo" ma "portare su main il report del lancio di marzo".
- **`- [ ] ` a inizio riga è obbligatorio**: è il pattern che l'hook cerca. Una riga senza checkbox è invisibile al sistema.
- **`@<slug-persona>`** è lo stesso slug di `people/<slug>.md` e di `git config user.name` in minuscolo con i trattini: l'hook lo usa per mostrare a ognuno prima i propri thread.
- **Chiudere vuol dire spostare**, non cancellare: la riga va in `## Chiuso di recente` con `- [x]` e la data di chiusura. Si tengono le ultime 15 righe chiuse, le più vecchie si tolgono (restano nei signal).
- **Ordine**: le più vecchie in alto. Un thread aperto da tre settimane o si fa o si chiude.
- **Sopra le 40 righe aperte il file non serve più a nessuno.** Quando succede, `session-start` lo dice e `session-end` propone una potatura.
- Valgono le esclusioni del canon ([`../canon/company-rules.md`](../canon/company-rules.md) → "Cosa il sistema non deve mai fare"): niente compensi, valutazioni di persone, dati sensibili, valori di contratto.

## Aperto

## Chiuso di recente
