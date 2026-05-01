# AI 관리형 다이어트 앱 하네스 구현 계획

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** AI가 이 다이어트 앱 프로젝트를 장기적으로 이어받아 설계, 구현, 검증, agent/skill 관리를 수행할 수 있는 저장소 하네스를 만든다.

**Architecture:** 하네스는 최상위 `AGENTS.md`, 역할별 `agents/*.md`, 프로젝트 전용 `skills/*/SKILL.md`, registry/governance/context/data/testing 문서, ADR로 구성된다. 제품 앱 코드는 아직 만들지 않고, 이후 MVP spec과 plan에서 다룬다.

**Tech Stack:** Markdown 문서, git, 프로젝트 전용 agent/skill 규약. 런타임 앱 스택은 이 계획의 범위 밖이다.

---

### Task 1: 저장소 기본 운영 파일

**Files:**
- Create: `.gitignore`
- Create: `AGENTS.md`

- [x] **Step 1: `.gitignore` 작성**

`.superpowers/`, OS 임시 파일, 의존성/빌드 산출물 후보를 제외한다.

- [x] **Step 2: `AGENTS.md` 작성**

모든 AI 세션이 기본으로 읽을 최상위 운영 규칙을 작성한다. 포함할 내용:

- 항상 한글로 사용자와 대화
- `docs/context-budget.md`에 따른 문맥 로딩
- agent/skill 변경은 `ai-steward-agent`와 registry를 거침
- 제품 기능은 spec → plan → implementation → verification 순서로 진행
- 임시 산출물은 커밋하지 않음

- [x] **Step 3: 검증**

Run: `test -f AGENTS.md && test -f .gitignore`

Expected: exit code 0

---

### Task 2: Agent 파일과 agent registry

**Files:**
- Create: `agents/ai-steward-agent.md`
- Create: `agents/product-agent.md`
- Create: `agents/frontend-agent.md`
- Create: `agents/data-agent.md`
- Create: `agents/qa-agent.md`
- Create: `agents/reviewer-agent.md`
- Create: `docs/agent-registry.md`

- [x] **Step 1: agent 파일 작성**

각 파일은 목적, 사용 조건, 책임, 입력, 출력, 소유 문서, 금지 사항을 포함한다.

- [x] **Step 2: `docs/agent-registry.md` 작성**

모든 agent를 한 표로 등록한다. registry 항목은 spec의 필드와 일치해야 한다.

- [x] **Step 3: 검증**

Run: `find agents -maxdepth 1 -type f -name '*-agent.md' | wc -l`

Expected: `6`

Run: `rg -n "ai-steward-agent|product-agent|frontend-agent|data-agent|qa-agent|reviewer-agent" docs/agent-registry.md`

Expected: all six names are present

---

### Task 3: Project skill 파일과 skill registry

**Files:**
- Create: `skills/diet-app--agent-or-skill-change/SKILL.md`
- Create: `skills/diet-app--feature-design/SKILL.md`
- Create: `skills/diet-app--local-storage-change/SKILL.md`
- Create: `skills/diet-app--ui-change/SKILL.md`
- Create: `skills/diet-app--test-and-verify/SKILL.md`
- Create: `docs/skill-registry.md`

- [x] **Step 1: project skill 파일 작성**

각 `SKILL.md`는 YAML frontmatter의 `name`, `description`을 포함하고, 본문은 프로젝트에 필요한 절차만 간결히 적는다.

- [x] **Step 2: `docs/skill-registry.md` 작성**

모든 project skill을 트리거 조건, 범위, 입력, 출력, 관련 agent와 함께 등록한다.

- [x] **Step 3: 검증**

Run: `find skills -path '*/SKILL.md' -type f | wc -l`

Expected: `5`

Run: `rg -n "^name:|^description:" skills`

Expected: each `SKILL.md` has both fields

---

### Task 4: Governance, context, data, testing 문서

**Files:**
- Create: `docs/ai-governance.md`
- Create: `docs/context-budget.md`
- Create: `docs/data-model.md`
- Create: `docs/local-storage-contract.md`
- Create: `docs/testing.md`

- [x] **Step 1: governance 문서 작성**

agent/skill 추가, 수정, 병합, 폐기 기준과 ADR 필요 기준을 작성한다.

- [x] **Step 2: context budget 문서 작성**

AI 세션이 기본으로 읽을 문서와 조건부로 읽을 문서를 구분한다.

- [x] **Step 3: data/storage/testing 문서 작성**

MVP 구현 전 기준이 될 고수준 데이터 모델, 로컬 저장 계약, 검증 전략을 작성한다.

- [x] **Step 4: 검증**

Run: `test -f docs/ai-governance.md && test -f docs/context-budget.md && test -f docs/data-model.md && test -f docs/local-storage-contract.md && test -f docs/testing.md`

Expected: exit code 0

---

### Task 5: ADR과 최종 검증

**Files:**
- Create: `docs/decisions/0001-use-b-plus-ai-harness.md`
- Modify: `docs/plans/2026-05-02-ai-managed-diet-app-harness-implementation.md`

- [x] **Step 1: ADR 작성**

B+ AI 하네스를 선택한 결정, 대안, 결과를 기록한다.

- [x] **Step 2: 계획 체크박스 갱신**

구현 완료 후 이 계획 문서의 체크박스를 완료 상태로 갱신한다.

- [x] **Step 3: 전체 검증**

Run: `git diff --check`

Expected: no whitespace errors

Run: `find AGENTS.md agents skills docs -type f | sort`

Expected: harness files are present and `.superpowers/` is absent from tracked candidate list

Run: `rg -n "T[B]D|TO[D]O|FIX[M]E|placeholde[r]|미[정]" AGENTS.md agents skills docs`

Expected: no matches

- [x] **Step 4: 커밋**

Run: `git add .gitignore AGENTS.md agents skills docs && git commit -m "Implement AI project harness"`

Expected: commit succeeds
