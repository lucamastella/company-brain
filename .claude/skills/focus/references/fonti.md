# Fonti, ID e comandi della skill focus

Tutto quello che serve per non cercare niente a runtime. **Da compilare una volta per persona** (la skill gira sulla macchina di chi la usa). Data dell'ultima verifica: <!-- YYYY-MM-DD -->

<!--
Gli ID di calendari, database e canali NON sono segreti, ma identificano la vostra organizzazione:
se il repo è condiviso fuori dal team, valutate di tenerli in un file locale fuori da git
(es. .claude/skills/focus/references/fonti.local.md, già escluso da *.local.md) e di lasciare qui
solo la struttura.
-->

---

## 1. Calendario

| Calendario | ID | Serve |
|---|---|---|
| Principale | <!-- id o email --> | sì, è l'unico che conta per l'ordinamento |
| <!-- altri --> | | <!-- solo su domanda --> |

- Fuso: `{{FUSO_ORARIO}}`.
- Fine della giornata lavorativa: <!-- es. 19:00 -->.

Due letture, niente di più: da adesso a fine giornata più domani per intero.

**Cosa si legge di un evento:** titolo, inizio, fine, partecipanti, la propria risposta, il link della call.
**Cosa non si legge mai:** la descrizione.

Ricorrenti note sul calendario principale: <!-- es. stand-up delle 9:15, review del giovedì -->

---

## 2. Card settimanale

- Strumento: {{DOCS_SYSTEM}}.
- Database o cartella: <!-- id o URL -->
- Proprietà utili: <!-- es. Title, Date (intervallo), Tags -->

### Trovare la card della settimana corrente

<!-- La query o la ricerca che restituisce la card la cui data contiene oggi. Esempio per un
database con una proprietà Date a intervallo:

SELECT url, Title, "date:Date:start", "date:Date:end"
FROM "<id-del-database>"
WHERE date("date:Date:start") <= date('now','localtime')
  AND date(COALESCE(NULLIF("date:Date:end", ''), "date:Date:start")) >= date('now','localtime')
ORDER BY "Last edited time" DESC
LIMIT 3
-->

### Struttura del corpo della card

```
**Obiettivo principale unico**: <obiettivo>
**I tre obiettivi della settimana**
- [ ] **1. <obiettivo>.** <contesto coi numeri> *Chiuso quando:* <criterio>
- [ ] **2. ...**
- [ ] **3. ...**
Resta fuori dai tre: <cosa>
**Giorni:**
- [x] Lunedì <n>
	- [x] <voce>
- [ ] Giovedì <n>
	- [ ] <voce>
		- [ ] <sottovoce>
<backlog senza data: voci sparse>
```

### Scrivere

<!-- Il comando dello strumento per sostituire una stringa nella pagina (es. update con
old_str / new_str). Annota le trappole: indentazione con i tab, comandi che riscrivono la pagina
intera da non usare mai. -->

---

## 3. Chat del team

- Strumento: {{CHAT_TOOL}}.
- ID utente della persona: <!-- -->

Una sola ricerca: i messaggi della persona di oggi, senza contesto, ordinati per data.

| Canale | ID |
|---|---|
| <!-- #canale-team --> | <!-- --> |

Per capire **chi è bloccato in attesa della persona**, una seconda ricerca al massimo. Prima di segnare un thread come aperto, controllare che la persona non abbia già risposto o reagito.

---

## 4. Sessioni Claude di oggi

Gli strumenti di gestione delle sessioni di Claude Code (elenco delle sessioni, ricerca nei transcript) quando sono disponibili. Servono perché buona parte del lavoro finisce in una chat e da nessun'altra parte.

---

## 5. Repo

```bash
git log --all --no-merges --format='%ad|%s' --date=format:'%Y-%m-%d %H:%M' \
  | grep "^$(date +%Y-%m-%d)" | sort -t'|' -k2 -u | sort -r | sed 's/|/  /'
```

Tre trappole:

- **`--since=midnight` non basta.** Filtra sulla data di commit, che merge e rebase riscrivono: un lavoro di ieri ricompare oggi. Si filtra sulla data di **autore**, come sopra.
- **I merge vanno esclusi** (`--no-merges`).
- **Lo stesso lavoro compare più volte**, una per worktree: il `sort -u` sul messaggio ne tiene una riga sola.

Più la sezione `## Aperto` di [`signals/aperto.md`](../../../../signals/aperto.md), filtrata sullo slug di chi lavora (`git config user.name`).

---

## 6. Obiettivi, progetti, persone

| Cosa | Dove |
|---|---|
| Objective del quarter | `objectives/<quarter>.md` |
| Progetti globali | `projects/*.md` |
| Modello OKR → Progetto → Attività → Task | `canon/operating-system.md` |
| Persone a cui delegare | `people/<slug>.md` |
| Chi possiede cosa | `canon/team/<team>.md` |

Lo stato vivo dei KR sta nel docs system: <!-- id o URL del database dei KR -->.

---

## 7. Delega: chi prende cosa

Default ricavato da `canon/team/` e `people/`, da usare come punto di partenza e non come regola:

- **<area>** → <!-- [[slug-persona]] -->

Prima di proporre un nome, apri `people/<slug>.md`: se la persona è già carica su un'altra cosa della settimana, dillo invece di aggiungere lavoro.
