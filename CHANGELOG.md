# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project uses `YYYY.MM` versioning aligned with release branch names.

## [Unreleased]

### Fixed

- Gitflow release workflow adjustments (in progress)

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

[Unreleased]: https://github.com/haydenk/vitae/compare/v2026.04...HEAD
[2026.04]: https://github.com/haydenk/vitae/releases/tag/v2026.04
