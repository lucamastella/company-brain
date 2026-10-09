# canon/

Il canon del repo: i file che governano tutti gli altri.

| File | A cosa serve |
|---|---|
| [`company-rules.md`](company-rules.md) | La costituzione: identità, posizionamento, voce, valori, esclusioni, ordine di verità, dati cliente, perimetro dei file. Ambito stretto per scelta: solo ciò che cambierebbe se l'azienda cambiasse business. |
| [`operations.md`](operations.md) | Come opera l'agente: procedure di scrittura, sync, citazioni, protocollo di sessione, decisioni, disciplina sulle entità. |
| [`operating-system.md`](operating-system.md) | Come l'azienda pianifica ed esegue il lavoro (OKR → Progetto → Attività → Task). |
| [`anatomy.md`](anatomy.md) | La forma del grafo: cartelle, schemi, glossario, fonti esterne, coppie di wikilink. |
| [`profile.md`](profile.md) | I fatti strutturati sull'azienda. |
| [`icp.md`](icp.md) | (Opzionale) Il cliente ideale: segmenti, job, barriere, anti-ICP. |
| [`competition.md`](competition.md) | (Opzionale) Il panorama competitivo: dove si vince, dove si perde. |
| [`team/<team>.md`](team/) | Le regole di ogni team (ambito, paletti, escalation). Un file per team. |

---

## La regola ferma: solo via PR

**Ogni modifica a un file sotto `canon/` passa da una pull request.** Nessuna eccezione e nessun push diretto su `main`, owner compreso.

Il resto del repo va su `main` in push diretto, perché lì conta la velocità. Il canon no: una regola vecchia o sbagliata si propaga in ogni sessione che la legge, quindi costa molto di più di un passaggio di review.

La disciplina regge su tre livelli:

1. **Convenzione**, dichiarata qui, in [`operations.md`](operations.md) → "Modifiche: push su main, con un'eccezione" e in [`../CLAUDE.md`](../CLAUDE.md).
2. **Hook locale**: [`../scripts/git_autosave.sh`](../scripts/git_autosave.sh) non committa mai `canon/`. Le modifiche restano nel working tree finché qualcuno apre la PR.
3. **Lato server**: il workflow [`../.github/workflows/canon-guard.yml`](../.github/workflows/canon-guard.yml) segnala ogni commit diretto su `main` che tocca `canon/`. Per bloccarlo serve una regola di protezione su GitHub, vedi [`../.github/CANON-ENFORCEMENT.md`](../.github/CANON-ENFORCEMENT.md).

### Come si cambia un file del canon

1. Ramo da `main`: `git switch -c canon/<scopo-breve>`.
2. Modifica, commit, push del ramo.
3. Apri la PR con un titolo corto e descrittivo. Le esclusioni di [`company-rules.md`](company-rules.md) → "Cosa il sistema non deve mai fare" valgono anche per titolo e corpo.
4. Approva almeno un CODEOWNER ({{OWNER_CANON}}). L'auto-approvazione è ammessa quando non c'è un altro revisore: il passaggio dalla PR invece resta obbligatorio.
5. Merge con **"Create a merge commit"** (gli altri metodi fanno fallire il workflow, vedi il commento nel file). Cancella il ramo.

### Cosa non sta qui

- Lo stato operativo ([`signals/`](../signals/) e le entità che collega): è descrittivo, non prescrittivo.
- Le skill ([`.claude/skills/`](../.claude/skills/)): le possiede chi le usa e vanno in push diretto.
- Persone, aziende, livello di dominio, articoli: push diretto.
