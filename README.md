# vitae

A LaTeX resume template with modular sections, task-based build tooling, and GitHub Actions CI/CD for automatic PDF release artifacts.

---

## Prerequisites

**Option A — Local**

- [mise](https://mise.jdx.dev) (task runner)
- TeX Live packages: `texlive-latex-recommended`, `texlive-latex-extra`, `texlive-fonts-recommended`, `texlive-fonts-extra`, `latexmk`

**Option B — Dev Container**

- Docker + VS Code with the Dev Containers extension

The dev container installs TeX Live, mise, and the LaTeX Workshop extension automatically.

---

## Quickstart

```bash
# Clone the repo
git clone <your-fork-url> vitae && cd vitae

# Build the PDF (output: out/resume.pdf)
mise run build

# Build and open immediately
mise run build --open

# Watch for changes and rebuild automatically
mise run watch
```

---

## Project Structure

```
resume.tex              # Main entry point
sections/
  header.tex            # Name, email, phone, LinkedIn, GitHub
  summary.tex
  experience.tex
  education.tex
  skills.tex
  projects.tex
.mise/tasks/
  build                 # Compile PDF
  watch                 # Watch + recompile on change
  clean                 # Remove output directory
  release               # Tag + push to trigger CI
.env.example            # Build defaults
.env                    # Personal overrides (gitignored)
.devcontainer/          # VS Code dev container config
.github/workflows/release.yml
```

---

## Customizing Your Resume

Edit files under `sections/`. Start with `sections/header.tex` to set your name and contact information.

Experience and education entries use the `\entry` command:

```latex
\entry{Job Title}{Company Name}{City, State}{Jan 2024 -- Present}
```

Each section file is independent and can be reordered in `resume.tex` by changing the `\input{}` calls.

---

## Build Options

All options are available for both `build` and `watch`. CLI flags always take priority over `.env`.

| Flag | Short | Default | Description |
|---|---|---|---|
| `<input>` | | `resume.tex` | Source `.tex` file |
| `--name` | `-n` | stem of input | Output PDF base name (no extension) |
| `--outdir` | `-o` | `out` | Output directory |
| `--open` | | off | Open PDF after build |
| `--clean-aux` | | off | Remove auxiliary files after build |

**Examples:**

```bash
# Custom output name
mise run build -n john-doe

# Custom input file, name, and output directory
mise run build cv.tex -n jane-smith -o dist

# Watch a different file
mise run watch cv.tex -n jane-smith

# Remove build artifacts
mise run clean

# Remove a specific output directory
mise run clean -o dist
```

The `build` task includes change detection and skips recompilation when sources are unchanged.

---

## Environment Defaults

Copy `.env.example` to `.env` to persist your preferred defaults:

```bash
cp .env.example .env
```

Edit `.env` to set values for `INPUT`, `NAME`, `OUTDIR`, `OPEN`, and `CLEAN_AUX`. CLI flags override any value set in `.env`.

---

## Dev Container

Open the project in VS Code and select **Reopen in Container** when prompted (or run **Dev Containers: Reopen in Container** from the command palette).

The container provides:

- Full TeX Live installation with all required packages
- mise with all tasks available
- LaTeX Workshop extension with live PDF preview in a side tab

No local TeX Live installation is required.

---

## CI/CD

Pushing a version tag triggers `.github/workflows/release.yml`, which builds the PDF and attaches it as an artifact to a GitHub Release.

**To cut a release:**

```bash
# Using the mise task (prompts for confirmation, then tags and pushes)
mise run release 2026.04

# Equivalent manual steps
git tag v2026.04
git push origin v2026.04
```
