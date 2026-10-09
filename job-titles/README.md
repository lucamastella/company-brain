# job-titles/

Un file per **ruolo** ricoperto da una persona, interna o esterna. È un bersaglio stabile per i wikilink:
- `people/<X>.md` dichiara `job_title: [[<slug>]]`;
- un agente chiede "tutti i CEO con cui parliamo" o "ogni responsabile IT nel verticale X" con un salto solo.

Vale per **tutte le persone in [`people/`](../people/)**, interne ed esterne.

---

## Quando si crea un file

Quando si crea una persona e il suo ruolo canonico non esiste ancora. Niente ruoli speculativi: si aspetta la prima persona vera che lo ricopre.

## Canonicalizzazione degli slug

- **Uno slug per concetto.** "Responsabile marketing", "Head of Marketing", "Marketing Manager" collassano in `head-of-marketing` (o nella forma che scegliete). Le varianti vanno negli `aliases`, non in file nuovi.
- **La famiglia vince sulla formulazione esatta.** La responsabilità estesa sta nel `## About` della persona, non nello slug.
- **Si separa solo quando servono entrambi i sensi.** "CDO" diventa due file (dati e digitale) solo quando compaiono persone con entrambi i ruoli.

Una persona con due cappelli li elenca tutti e due: `job_title: [[cto]], [[founder]]`. Una persona di cui non si conosce il ruolo lascia il campo vuoto e lo dice nel corpo.

---

## Convenzione dei file

`<slug>.md`, minuscolo, con i trattini.

### Frontmatter

```yaml
---
name: <Nome del ruolo>
slug: <slug-ruolo>
aliases: []                          # ogni formulazione e abbreviazione. Vuoto è un bug.
people: []                           # inverso manuale di people.job_title
                                     #   - "[[<slug-persona>]]"
---
```

### Corpo

```markdown
# <Nome del ruolo>

## About

Una riga: cosa copre di solito questo ruolo nel vostro contesto.
```

Niente "responsabilità tipiche" o "competenze": il file è un'etichetta, non un annuncio di lavoro.

---

## Coppia diretta e inversa

- `people/<x>.md → job_title: [[<ruolo>]]` (diretta)
- `job-titles/<ruolo>.md → people: [[<persona>]]` (inversa, a mano)

Quando si imposta o si cambia il ruolo di una persona si aggiorna l'inverso nella stessa scrittura.
