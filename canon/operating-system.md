# Operating system

> Come {{NOME_AZIENDA}} pianifica ed esegue il lavoro. Ogni agente che scrive un recap, un piano, un update di team o valuta un progetto **segue questo modello**, non uno generico.
>
> Sotto il canon (vedi [`company-rules.md`](company-rules.md) → "Ordine di verità"). Lo **stato vivo** (numeri, status, avanzamento) vive su {{DOCS_SYSTEM}}; qui c'è il modello, non i dati.

<!--
COME SI COMPILA
- Il file arriva con un modello già scritto (OKR → Progetto → Attività → Task, progetti globali
  per scope). È quello con cui il template è nato e funziona bene per team sotto le 50 persone.
- Se la vostra azienda lavora in un altro modo (sprint senza OKR, shape-up, roadmap trimestrale),
  riscrivete le sezioni tenendo la struttura: gerarchia, regola d'oro, tracking, ruoli, cadenze,
  anti-pattern, dove vive cosa. Le skill e i README di objectives/ e projects/ si appoggiano a
  questo file: se cambiate il modello, aggiornate anche quelli.
-->

---

## Principio guida

*Una frase su come volete crescere. Esempio di partenza: "scalare il talento, non l'organico": si limita la crescita della complessità organizzativa, non quella del business.* I team decidono e sperimentano in autonomia; chi guida dà **contesto, non controllo**.

## La gerarchia del lavoro

Il lavoro vive su due piani. I livelli alti stanno su {{DOCS_SYSTEM}}, visibili a tutta l'azienda; sotto l'Attività vive l'esecuzione del singolo team, nello strumento che preferisce.

- **Objective (globale).** L'obiettivo aziendale del quarter. Campi: Objective, Business Owner, Quarter, Status.
- **Key Result (globale).** La metrica che misura l'Objective. Il valore si legge **sul prodotto o sul sistema che lo possiede**, non sommando i contributi. Campi: Nome, Target, Valore attuale, Status.
- **Progetto (globale).** Una delivery con un risultato atteso, che dura più sprint e spesso coinvolge più team. Ha un **Owner facilitatore** (non per forza un PM) e gira sui team coinvolti. Può essere Tier 1 (i due o tre strategici del quarter) o Tier 2. Campi: Nome, Owner, Team, Status, Progress calcolato.
- **Contributo (tabella ponte).** Una tabella a parte, non una proprietà del Progetto, perché un Progetto spinge più KR e un KR riceve spinta da più Progetti (molti a molti). Per ogni coppia Progetto-KR: contributo stimato in % a inizio quarter (somma 100% per KR) e contributo attuale in %, aggiornato ogni sprint dall'owner.
- **Attività (globale).** Il contributo di un singolo team a un Progetto. È l'unità minima di tracking, con un avanzamento aggiornato almeno una volta a settimana.
- **Task (locale).** La singola operazione, nello strumento del team. Sotto l'Attività il team è sovrano.

## Regola d'oro: progetti per scope, non per team

I Progetti sono **globali e per scope (Discovery, Delivery, BAU), non per team**. Il lavoro che conta è quasi sempre trasversale: dichiarare da subito i team coinvolti fa progettare insieme dall'inizio invece di ricucire dopo. Un Progetto di un solo team è legittimo quando lo decide il tipo di lavoro. Anche il lavoro **BAU** ricorrente vive come Attività dentro i Progetti, non su un binario separato.

## I due tracking, tenuti separati

- **Progress calcolato: output, dal basso.** Media degli avanzamenti delle Attività. Quanto del lavoro previsto è fatto.
- **Contributo attuale ai KR: outcome, dall'alto.** Misurato dopo il rilascio dall'owner. Quanto quel lavoro sta muovendo i KR.

I due **possono divergere** ed è normale: output all'80% e contributo al KR al 10% vuol dire consegnato ma senza effetto sulle metriche. Leggere la divergenza è il lavoro del checkpoint di metà quarter. Il valore del KR resta misurato alla fonte, non derivato dai contributi.

## Kill o ship

Ogni Progetto dichiara un criterio di **kill o ship**: la condizione misurabile che decide se continua o si chiude. La review settimanale ha il diritto di **chiudere un progetto che procede senza spostare i KR**. Alcuni progetti non si possono chiudere per natura (la prevenzione dell'abbandono dei clienti, per esempio): va detto nel file del progetto.

## Ruoli

- **Owner del Progetto:** facilitatore. Tira le fila, rimuove gli ostacoli, aggiorna ogni sprint il contributo ai KR. Non decide il come al posto del team.
- **Business Owner:** lo sponsor dell'OKR.
- **Team sulle Attività:** la delivery è dei team coinvolti.

## Cadenze

- **Settimanale:** ogni team aggiorna l'avanzamento delle Attività; l'owner aggiorna il contributo ai KR. *<se esiste un recap settimanale, scrivi chi lo scrive e dove esce>*
- **Metà quarter:** checkpoint con doppia lettura (output e outcome).
- Tra un checkpoint e l'altro il piano non si rivede, salvo emergenze o opportunità rilevanti.

## Anti-pattern

- Creare Progetti o Attività "di un team": OKR, Progetti e Attività sono globali, la separazione è per scope.
- Derivare il valore del KR dalla somma dei contributi: il KR si misura alla fonte.
- Confondere Attività (contributo di un team a un Progetto) e Task (singola operazione nello strumento del team).
- Far propagare gli status da un livello all'altro in automatico: ogni livello dice la verità alla propria altezza.
- Mettere il contributo come proprietà del Progetto invece che sulla tabella ponte: si perde il molti a molti.

## Dove vive cosa

- **Anagrafiche vive di OKR, Progetti e Attività** → {{DOCS_SYSTEM}}, aggiornate ogni settimana. Il repo non le duplica.
- **Nodi stabili e narrativa** → questo repo: [`../objectives/`](../objectives/) (un file per quarter, puntatore allo stato vivo), [`../projects/`](../projects/) (un file per Progetto globale, puntatore allo stato vivo), [`../signals/`](../signals/) (recap e note datate che si agganciano a progetti e KR).
