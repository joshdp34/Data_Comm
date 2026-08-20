# STA 2310 Data Communication with AI

This repository contains the Quarto book used as the student-facing notes for STA 2310: Data Communication with AI.

## Render locally

Render the book before publishing:

```bash
quarto render
```

On this machine, Quarto is also available through the RStudio bundle:

```powershell
& 'C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe' render
```

The rendered site is written to `docs/`.

## GitHub Pages

After rendering locally, commit both the source files and the rendered `docs/` folder. In GitHub, set Pages to deploy from the `main` branch and the `/docs` folder.

The project uses `execute.freeze: auto`. Keep `_freeze/` under version control when code-generated output is added to the notes.
