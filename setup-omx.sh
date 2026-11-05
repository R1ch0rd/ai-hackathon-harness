#!/usr/bin/env bash
# 현재 git 프로젝트에 oh-my-codex(OMX)를 설치/연결한다. 기존 AGENTS.md 규칙은 보존(merge)된다.
set -euo pipefail

command -v node  >/dev/null || { echo "Node.js 20+ 가 필요합니다: brew install node"; exit 1; }
command -v codex >/dev/null || { echo "Codex CLI가 필요합니다: npm install -g @openai/codex (Homebrew로 설치했다면 그대로 사용)"; exit 1; }
git rev-parse --git-dir >/dev/null 2>&1 || { echo "git 프로젝트 폴더에서 실행하세요 (git init 먼저)"; exit 1; }

command -v omx >/dev/null || npm install -g oh-my-codex
command -v tmux >/dev/null || echo "참고: 팀 모드(\$team)를 쓰려면 brew install tmux"

omx setup --scope project --merge-agents
omx doctor

echo
echo "AGENTS.md 맨 위 확인:"
head -11 AGENTS.md
echo
echo "다음: omx exec --skip-git-repo-check -C . \"Reply with exactly OMX-EXEC-OK\""
