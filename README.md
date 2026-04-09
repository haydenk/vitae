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
VERSION                 # Current version string (read by CI to create the release tag)
.mise/tasks/
  build                 # Compile PDF
  watch                 # Watch + recompile on change
  clean                 # Remove output directory
.env.example            # Build defaults
.env                    # Personal overrides (gitignored)
.devcontainer/          # VS Code dev container config
.github/workflows/
  ci.yml                # Build PDF on push/PR to master or develop
  branch-policy.yml     # Enforce branch naming conventions
  gitflow-release.yml   # Auto-tag when develop is merged to master
  release.yml           # Build PDF and publish GitHub Release on tag push
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

## Branching Model

This project follows a simple GitFlow convention:

| Branch | Purpose |
|---|---|
| `master` | Always-releasable. Only receives merges from `release/*` branches. |
| `develop` | Integration branch. Merges from feature/bugfix/chore/hotfix/release branches. |
| `feature/*` | New features — merge into `develop` via PR. |
| `bugfix/*` | Bug fixes — merge into `develop` via PR. |
| `chore/*` | Maintenance tasks — merge into `develop` via PR. |
| `hotfix/*` | Urgent fixes — merge into `develop` via PR. |
| `release/<version>` | Release preparation — created from `develop`, merged into `master` to trigger a release. |

Branch naming is enforced by `.github/workflows/branch-policy.yml`. PRs to `master` must come from `release/*`; PRs to `develop` must come from one of the prefixes above (or `dependabot/*`).

---

## CI/CD

Four workflows handle automation:

| Workflow | Trigger | What it does |
|---|---|---|
| `ci.yml` | Push or PR to `master`/`develop` | Compiles the PDF and uploads it as a build artifact. |
| `branch-policy.yml` | PR to `master` or `develop` | Validates branch naming conventions. |
| `gitflow-release.yml` | `release/*` → `master` PR merged | Extracts the version from the branch name, creates the git tag, and back-merges `master` into `develop`. |
| `release.yml` | Tag push (`v*`) or manual dispatch | Builds the PDF and publishes a GitHub Release with the PDF attached. |

**To cut a release:**

```bash
# 1. Create a release branch from develop
git checkout develop && git pull origin develop
git checkout -b release/2026.05
git push origin release/2026.05

# 2. Open a pull request from release/2026.05 → master on GitHub
# 3. Merge the PR — gitflow-release.yml extracts the version from the branch name,
#    creates tag v2026.05, and back-merges master into develop automatically
# 4. release.yml triggers on the new tag and publishes the GitHub Release
```

The `release.yml` workflow also supports manual dispatch with an optional dry-run mode (builds without publishing) for testing.
