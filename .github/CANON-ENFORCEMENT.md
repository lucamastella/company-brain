# Protezione del canon

`canon/` (company-rules, operations, operating-system, anatomy, profile, icp, competition, team/) contiene le regole del cervello. Si cambia **solo via Pull Request**, mai con un push diretto su `main`, owner compreso. Così le regole non cambiano per sbaglio.

## Come è protetto

1. **Autosave** (`scripts/git_autosave.sh`): l'hook Stop non committa mai `canon/`. Le modifiche restano nel working tree finché qualcuno apre una PR.
2. **Canon guard** (`.github/workflows/canon-guard.yml`): una GitHub Action che fallisce se un commit non di merge su `main` tocca `canon/`. Segnala la violazione.
3. **CODEOWNERS**: ogni PR su `canon/` richiede la review di chi possiede il canon.

## Passo manuale, una volta sola, su GitHub

L'Action segnala ma da sola non blocca. Per bloccare il push:

GitHub → repo → **Settings → Rules → Rulesets** (oppure Branches → Branch protection) su `main`:
- Require status checks to pass → seleziona **Canon guard**.
- (Facoltativo) Require review from Code Owners, per le PR.

Da quel momento un push diretto che tocca `canon/` viene rifiutato dal server.

**Attenzione al vincolo dell'autosave.** L'hook Stop pusha `main` a fine di ogni turno. Se attivate "Require a pull request before merging" su `main` per ogni tipo di modifica, l'autosave non riesce più a pushare e il lavoro resta solo in locale. La configurazione giusta è la protezione col **solo** status check "Canon guard" richiesto, senza obbligo di PR per tutto il resto: il canon resta bloccato e i signal continuano a salire da soli.

Alcuni piani di GitHub non offrono le regole di protezione sui repo privati. In quel caso il vincolo regge sulla disciplina, sull'autosave e sul segnale a posteriori del workflow: ditelo al team.

Se tenete un repo a specchio, il passo va rifatto anche lì: le regole di GitHub non si sincronizzano con i commit.

## Come si cambia una regola del canon

```
git switch -c canon/<motivo-breve>
# modifica i file sotto canon/
git add canon/<file>
git commit -m "canon: <cosa cambia e perché>"
git push -u origin canon/<motivo-breve>
gh pr create --title "canon: <...>" --body "<cosa cambia, perché, quale decisione lo giustifica>"
# review dell'owner, poi merge
```

Il merge va fatto con **"Create a merge commit"**. "Squash and merge" e "Rebase and merge" producono un commit normale su `main` che tocca `canon/`: il controllo li boccia, è voluto, vedi il commento dentro `canon-guard.yml`.
