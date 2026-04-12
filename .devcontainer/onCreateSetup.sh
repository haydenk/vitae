#!/usr/bin/env bash
set -euo pipefail

sudo apt update && sudo apt install -y --no-install-recommends \
  texlive-latex-recommended \
  texlive-latex-extra \
  texlive-fonts-recommended \
  texlive-fonts-extra \
  texlive-font-utils \
  texlive-lang-greek \
  latexmk \
  lmodern

tlmgr init-usertree
tlmgr option repository https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2023/tlnet-final
tlmgr --usermode install inter
