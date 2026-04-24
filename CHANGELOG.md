# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project uses `YYYY.MM` versioning aligned with release branch names.

## [Unreleased]

### Added

- AI skills row in resume covering Claude (Sonnet, Opus), Claude Code, Anthropic API, OpenAI API, Codex, and agentic workflows
- Experience bullet describing AI-assisted development work at current role
- `mise run setup` task that installs the LaTeX toolchain and inter font on macOS (MacTeX) and Debian/Ubuntu
- `overseer` (from `github:haydenk/overseer`) to the mise tool list
- Banner image in the README

### Changed

- Current role title updated to "Senior Software Engineer / Architect"
- `Procfile` `serve` process now honors `$PORT` instead of hardcoding `8000`

### Fixed

- `resume.tex` uses the lowercase `inter` package name, matching the CTAN package

---

## [2026.04.1] - 2026-04-12

> This patch release exists because the branch policy fix was accidentally merged into `develop` instead of going directly to `master` via a `release/*` branch, necessitating a new release cut.

### Fixed

- Branch policy now allows `hotfix/*` branches to target `master`, in addition to `release/*`

---

## [2026.04] - 2026-04-12

### Added

- Initial project scaffolding: `resume.tex`, modular `sections/` directory, `.gitignore`, `.env.example`, and dev container configuration
- `mise` task runner setup with `build`, `watch`, `clean` tasks
- GitHub Actions workflows: `ci.yml`, `branch-policy.yml`, `gitflow-release.yml`, `release.yml`
- GitFlow branching model with enforced branch naming via `branch-policy.yml`
- `AGENT.md` with AI assistant context for the project
- Browser preview support via `Procfile` and a new `dev` mise task
- `.latexmkrc` for `latexmk` configuration
- `lmodern` package to LaTeX CI environment for better font support

### Changed

- CI/CD refactored so release versioning is derived entirely from the `release/<version>` branch name — no manual version file needed
- `watch` task updated to support browser-based PDF preview alongside file watching
- GitHub Action version hashes pinned for reproducibility

### Removed

- `VERSION` file — version is now extracted from the release branch name by `gitflow-release.yml`
- Manual `release` mise task — replaced by fully automated GitHub Actions release pipeline

---

[Unreleased]: https://github.com/haydenk/vitae/compare/v2026.04.1...HEAD
[2026.04.1]: https://github.com/haydenk/vitae/compare/v2026.04...v2026.04.1
[2026.04]: https://github.com/haydenk/vitae/releases/tag/v2026.04
