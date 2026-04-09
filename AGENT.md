# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Project Is

A LaTeX resume template with modular sections, `mise`-based build tooling, and GitHub Actions CI/CD that compiles and publishes a PDF on every release.

## Build Commands

```bash
mise run build                  # Compile PDF → out/resume.pdf
mise run build --open           # Compile and open
mise run build -n hayden_king   # Custom output name
mise run watch                  # Watch and recompile on change
mise run clean                  # Remove output directory
```

Build options (flags override `.env`):

| Flag | Short | Default | Description |
|---|---|---|---|
| `<input>` | | `resume.tex` | Source `.tex` file |
| `--name` | `-n` | stem of input | Output PDF base name |
| `--outdir` | `-o` | `out` | Output directory |
| `--open` | | off | Open PDF after build |
| `--clean-aux` | | off | Remove auxiliary files after build |

Personal defaults live in `.env` (gitignored); copy from `.env.example`.

## Architecture

`resume.tex` is the entry point — it inputs six section files:

```
sections/header.tex       # \resumeheader{name}{email}{phone}{linkedin}{github}
sections/summary.tex
sections/experience.tex   # uses \entry{title}{org}{location}{date}
sections/education.tex
sections/skills.tex       # uses \entryskills{label}{value}
sections/projects.tex
```

Build tasks live in `.mise/tasks/build`, `watch`, and `clean`. They use `latexmk` under the hood and include change detection to skip unnecessary recompilation.

## CI/CD

| Workflow | Trigger | Action |
|---|---|---|
| `ci.yml` | Push/PR to `master`/`develop` | Build PDF, upload artifact |
| `branch-policy.yml` | PR to `master`/`develop` | Enforce branch naming |
| `gitflow-release.yml` | `release/*` → `master` merged | Tag version, back-merge to `develop` |
| `release.yml` | Tag push (`v*`) or manual dispatch | Build PDF, publish GitHub Release |

## Branching Model (GitFlow)

- `master` — releasable only; accepts merges from `release/*`
- `develop` — integration; accepts `feature/*`, `bugfix/*`, `chore/*`, `hotfix/*`, `release/*`, `dependabot/*`
- Release versions follow `YYYY.MM` in branch names (e.g. `release/2026.05` → tag `v2026.05`)

Branch naming is enforced by `branch-policy.yml` — PRs with wrong source branches will fail.

## Cutting a Release

```bash
git checkout develop && git pull origin develop
git checkout -b release/2026.05
git push origin release/2026.05
# Open PR: release/2026.05 → master
# Merge it — gitflow-release.yml auto-tags and back-merges
# release.yml publishes the GitHub Release with the PDF
```

`release.yml` supports manual dispatch with an optional `dry_run` flag to test the build without publishing.
