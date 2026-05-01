# 프로젝트 온보딩

이 문서는 사람이 이 프로젝트의 운영 구조를 빠르게 이해하고, Codex와 함께 작업을 시작하기 위한 안내서다. 앱 기능보다 먼저 구축된 AI 하네스가 어떻게 구성되어 있고, 언제 어떤 문서를 참고해야 하는지 설명한다.

## 1. 프로젝트 운영 방식 요약

이 프로젝트는 다이어트 웹앱을 AI 중심으로 지속 관리하기 위해 별도의 하네스를 둔다. 하네스의 목적은 다음과 같다.

- 작업 기준을 `AGENTS.md`에 고정한다.
- 역할별 agent 문서로 작업 관점을 분리한다.
- 프로젝트 전용 skill 문서로 반복 절차를 보존한다.
- registry 문서로 agent와 skill 목록을 추적한다.
- ADR로 중요한 의사결정의 이유를 남긴다.
- Codex가 project skill을 발견할 수 있도록 symlink 설치를 지원한다.

여기서 agent는 실제 실행 프로세스가 아니라 역할 정의 문서다. skill은 Codex가 읽고 따를 수 있는 절차 문서이며, 설치 후에도 정본은 이 저장소 안의 `skills/diet-app--*` 디렉터리다.

## 2. 하네스 구성 요소

주요 파일과 역할은 다음과 같다.

| 파일 또는 디렉터리 | 용도 |
| --- | --- |
| `AGENTS.md` | AI 작업자가 기본으로 따라야 하는 프로젝트 운영 규칙 |
| `agents/*.md` | 제품, UI, 데이터, QA, 리뷰, 하네스 관리 역할 정의 |
| `skills/diet-app--*/SKILL.md` | 이 프로젝트에서 반복되는 작업 절차 |
| `docs/agent-registry.md` | agent 목록, 사용 조건, 관련 skill |
| `docs/skill-registry.md` | skill 목록, 트리거 조건, 관련 agent |
| `docs/context-budget.md` | 작업할 때 필요한 문서만 읽도록 하는 문맥 로딩 기준 |
| `docs/codex-integration.md` | Codex project skill 설치 방법 |
| `docs/decisions/` | 중요한 의사결정을 기록하는 ADR |
| `docs/specs/` | 기능 또는 하네스 설계 문서 |
| `docs/plans/` | 구현 계획 문서 |

사람이 모든 문서를 매번 읽을 필요는 없다. 작업을 맡기기 전에는 이 문서와 `AGENTS.md`를 먼저 보고, 세부 작업에 따라 registry에서 관련 agent와 skill을 확인하면 된다.

## 3. 프로젝트용 하네스 설치

### Codex project skill 설치

Codex에서 이 프로젝트 전용 skill을 발견하게 하려면 symlink 설치를 실행한다.

```bash
make install-project-skills
```

같은 작업을 하는 짧은 alias도 있다.

```bash
make install-skills
```

설치 위치는 다음 우선순위로 결정된다.

1. `CODEX_SKILLS_DIR`
2. `CODEX_HOME/skills`
3. `$HOME/.codex/skills`

설치 결과는 대략 다음 형태다.

```text
~/.codex/skills/diet-app--ui-change -> <repo>/skills/diet-app--ui-change
```

기존 일반 파일이나 디렉터리가 같은 이름으로 있으면 설치 스크립트는 덮어쓰지 않고 중단한다. 기존 symlink는 현재 repo의 skill 디렉터리를 가리키도록 갱신한다.

### 설치 검증

실제 Codex 설정을 건드리지 않고 설치 동작만 검증하려면 다음 명령을 사용한다.

```bash
make test-project-skill-install
```

이 명령은 임시 디렉터리에 symlink를 만들고, 각 `SKILL.md`가 정상 연결되는지 확인한다.

## 4. Agent와 Skill을 이해하는 방법

### Agent

agent는 “누가 어떤 관점으로 이 작업을 봐야 하는가”를 정의한다. Codex subagent가 자동으로 실행되는 객체가 아니라, 작업 책임과 검토 기준을 정리한 문서다.

현재 agent는 다음과 같다.

| Agent | 사람이 이해해야 할 역할 |
| --- | --- |
| `ai-steward-agent` | agent/skill 추가, 수정, 병합, 폐기 기준 관리 |
| `product-agent` | 제품 범위, 사용자 흐름, 수용 기준 관리 |
| `frontend-agent` | 화면 구조, UI 흐름, 접근성, 반응형 기준 관리 |
| `data-agent` | 로컬 데이터 모델, 저장 계약, migration 관리 |
| `qa-agent` | 테스트 전략, 검증 명령, 완료 전 확인 관리 |
| `reviewer-agent` | 변경사항 리뷰, 누락/회귀 위험 점검 |

### Skill

skill은 “반복되는 작업을 어떤 절차로 처리할 것인가”를 정의한다. Codex에 symlink 설치하면 `diet-app--*` 이름으로 발견될 수 있다.

현재 project skill은 다음과 같다.

| Skill | 사람이 이해해야 할 용도 |
| --- | --- |
| `diet-app--agent-or-skill-change` | agent 또는 skill 변경 절차 |
| `diet-app--feature-design` | 기능 아이디어를 spec으로 정리하는 절차 |
| `diet-app--local-storage-change` | 로컬 저장 데이터 변경 절차 |
| `diet-app--ui-change` | UI 변경 절차 |
| `diet-app--test-and-verify` | 완료 전 검증 절차 |

skill을 수정하거나 새로 추가하면 `docs/skill-registry.md`도 함께 갱신해야 한다. agent를 수정하거나 새로 추가하면 `docs/agent-registry.md`도 함께 갱신해야 한다.

## 5. Codex에게 작업을 맡기는 기본 흐름

사람이 Codex에게 작업을 요청할 때는 다음 순서가 기준이다.

1. 작업 목적을 한 문장으로 말한다.
2. 기능 추가, UI 변경, 데이터 변경, 하네스 변경 중 어디에 해당하는지 알려준다.
3. 관련 제약이 있으면 함께 말한다.
4. Codex가 필요한 agent와 skill을 선택하게 한다.
5. 구현 전 spec 또는 plan이 필요한 작업이면 먼저 문서화를 요청한다.
6. 완료 전에는 검증 결과를 확인한다.

예시:

```text
운동 기록 화면 MVP spec을 작성해줘. 로컬 저장 구조에 영향이 있으니 data-agent 관점도 포함해줘.
```

```text
project skill을 하나 추가해야 할 것 같아. ai-steward-agent 기준으로 기존 skill로 충분한지 먼저 검토해줘.
```

```text
UI 변경을 구현해줘. 완료 전에 make test-project-skill-install과 문서 검증까지 실행해줘.
```

## 6. 주요 작업별 운영 흐름

### 신규 기능 설계

사람이 요청할 내용:

- 기능 목적
- MVP에 포함할 범위
- 제외할 범위
- 데이터 저장 영향 여부
- UI 영향 여부

Codex가 주로 참고할 문서:

- `agents/product-agent.md`
- `skills/diet-app--feature-design/SKILL.md`
- 필요 시 `agents/data-agent.md`
- 필요 시 `agents/frontend-agent.md`

예상 산출물:

- `docs/specs/<date>-<topic>.md`
- 필요 시 ADR

### UI 변경

사람이 요청할 내용:

- 바꾸려는 화면
- 사용자가 수행할 행동
- 모바일/데스크톱 고려 여부
- 저장 데이터나 계산 로직 영향 여부

Codex가 주로 참고할 문서:

- `agents/frontend-agent.md`
- `skills/diet-app--ui-change/SKILL.md`
- 필요 시 `agents/data-agent.md`

예상 산출물:

- UI 변경 코드
- 관련 plan 또는 spec 갱신
- 수동 smoke check 결과

### 로컬 저장 데이터 변경

사람이 요청할 내용:

- 바꾸려는 record 또는 저장 key
- 기존 데이터 보존 필요 여부
- migration 필요 여부
- export/import 고려 여부

Codex가 주로 참고할 문서:

- `docs/data-model.md`
- `docs/local-storage-contract.md`
- `agents/data-agent.md`
- `skills/diet-app--local-storage-change/SKILL.md`

예상 산출물:

- 데이터 모델 문서 갱신
- 저장 계약 문서 갱신
- migration note 또는 ADR
- 관련 테스트 기준 갱신

### Agent 또는 Skill 변경

사람이 요청할 내용:

- 왜 기존 agent/skill로 부족한지
- 새 역할 또는 절차가 반복될 가능성이 있는지
- 기존 artifact를 수정하는 것으로 충분하지 않은지

Codex가 주로 참고할 문서:

- `agents/ai-steward-agent.md`
- `skills/diet-app--agent-or-skill-change/SKILL.md`
- `docs/agent-registry.md`
- `docs/skill-registry.md`
- `docs/ai-governance.md`

예상 산출물:

- agent 또는 skill 파일 변경
- registry 갱신
- 필요 시 ADR
- `make test-project-skill-install` 검증 결과

## 7. 완료 전 확인

문서 또는 하네스 변경 후에는 최소한 다음을 확인한다.

```bash
git diff --check
rg -n "T[B]D|TO[D]O|FIX[M]E|placeholde[r]|미[정]" AGENTS.md agents skills docs scripts tests Makefile ONBOARDING.md
```

project skill 설치 구조가 바뀌었으면 다음도 실행한다.

```bash
make test-project-skill-install
```

앱 코드가 추가된 뒤에는 `docs/testing.md`에 정의된 lint, test, build 명령도 함께 실행해야 한다.
