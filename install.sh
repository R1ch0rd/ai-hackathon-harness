#!/usr/bin/env bash
# 현재 폴더에 하네스 파일을 내려받는다. 이미 있는 파일은 덮어쓰지 않는다.
set -euo pipefail
BASE="https://raw.githubusercontent.com/R1ch0rd/ai-hackathon-harness/main"
for f in AGENTS.md CLAUDE.md PLAN.md DECISIONS.md eval.py test_smoke.py .gitignore; do
  if [ -e "$f" ]; then
    echo "skip  $f (이미 있음)"
  else
    curl -fsSL "$BASE/$f" -o "$f" && echo "added $f"
  fi
done
