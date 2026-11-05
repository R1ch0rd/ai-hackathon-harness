# ai-hackathon-harness

AI 코딩 에이전트(Codex CLI, Claude Code)용 해커톤 작업 규칙 하네스.

- `AGENTS.md`: 작업 규칙 (Codex CLI가 자동으로 읽음)
- `CLAUDE.md`: Claude Code가 자동으로 읽고 AGENTS.md를 불러옴
- `PLAN.md`, `DECISIONS.md`: 계획/결정 기록 템플릿
- `eval.py`, `test_smoke.py`: 검증 명령(`python eval.py`, `python -m pytest -q`) 뼈대
- `setup-omx.sh`: oh-my-codex(OMX)를 기존 규칙을 보존한 채로 연결하는 스크립트

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

## OMX(oh-my-codex)와 같이 쓰기

OMX는 Codex CLI 위에 계획/실행/검증 워크플로를 얹는 레이어다. 공식: https://github.com/Yeachan-Heo/oh-my-codex

### 준비물 (처음 한 번)
```bash
node --version      # v20 이상
codex --version     # 설치 + 로그인 완료 상태
brew install tmux   # 팀 모드($team)용, 선택
```
Homebrew로 Codex를 설치했다면 `npm install -g @openai/codex`를 다시 하지 않는다(EEXIST 충돌).

### 설치 + 연결
위 "사용법"으로 프로젝트를 만든 뒤, git 커밋을 한 번 하고 실행한다.
```bash
git add . && git commit -m "init harness"
bash setup-omx.sh
```
수동으로 하려면:
```bash
npm install -g oh-my-codex
omx setup --scope project --merge-agents   # --merge-agents 필수: 기존 7개 규칙 보존
omx doctor
```
`AGENTS.md` 맨 위에 7개 규칙이 그대로 있고, 아래에 `<!-- OMX:AGENTS:START -->` 구간이 생기면 정상이다.

### 동작 확인
```bash
codex login status
omx exec --skip-git-repo-check -C . "Reply with exactly OMX-EXEC-OK"   # OMX-EXEC-OK가 나오면 준비 완료
```

### 해커톤 당일 흐름
```bash
omx --worktree=feat/task --xhigh
```
`--madmax`는 승인/샌드박스를 끄는 옵션이라 기본으로는 쓰지 않는다(검증 흔적을 남기는 편이 평가에 유리).

| 단계 | 입력 예시 | 연결되는 규칙 |
|-|-|-|
| 문제 정리 | `$deep-interview "문제, 제약, 평가지표 정리"` | 1 (PLAN.md) |
| 계획 승인 | `$ralplan "PLAN.md 기준 계획 + 제외할 대안 비교"` | 1, 7 |
| 실행 | `$ultragoal "승인된 계획 단계별 실행, 단계마다 pytest/eval.py"` | 2, 3 |
| 병렬(선택) | `$team "EDA와 베이스라인 모델 분리 진행"` | 큰 작업일 때만 |
| 마무리 | `$code-review` 후 DECISIONS.md 확인 | 5, 7 |

- 스킬은 관련 있는 2~5개만 쓴다.
- OMX 지침과 작업 규칙이 충돌하면 `AGENTS.md`의 작업 규칙이 우선한다(파일 상단 명시).
