# ai-hackathon-harness

AI 코딩 에이전트(Codex CLI, Claude Code)용 해커톤 작업 규칙 하네스.

- `AGENTS.md`: 작업 규칙 (Codex CLI가 자동으로 읽음)
- `CLAUDE.md`: Claude Code가 자동으로 읽고 AGENTS.md를 불러옴
- `PLAN.md`, `DECISIONS.md`: 계획/결정 기록 템플릿
- `eval.py`, `test_smoke.py`: 검증 명령(`python eval.py`, `python -m pytest -q`) 뼈대

## 사용법

### 1. 새 프로젝트로 시작
```bash
git clone https://github.com/R1ch0rd/ai-hackathon-harness.git my-project
cd my-project
rm -rf .git && git init   # 내 프로젝트 히스토리로 새로 시작
```
또는 GitHub에서 **Use this template** 버튼으로 내 레포를 바로 만든다.

### 2. 이미 있는 프로젝트 폴더에 추가
```bash
cd 내-프로젝트-폴더
curl -fsSL https://raw.githubusercontent.com/R1ch0rd/ai-hackathon-harness/main/install.sh | bash
```
이미 있는 파일은 덮어쓰지 않는다.

### 3. 확인
```bash
pip install pytest    # 처음 한 번
python -m pytest -q   # 1 passed
python eval.py        # status: not_implemented
```
그 다음 폴더에서 `codex` 또는 `claude`를 실행하면 규칙이 자동 적용된다.
