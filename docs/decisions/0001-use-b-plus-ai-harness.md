# ADR 0001: B+ AI 하네스 사용

## 상태

Accepted

## 날짜

2026-05-02

## 배경

이 프로젝트는 다이어트 웹앱을 100% AI 관리 방식으로 지속 운영하는 것을 목표로 한다. 초기 제품 범위는 운동 기록, 식단 기록, 체중 기록, 전체 현황 화면, 로컬 저장이다.

제품 기능보다 먼저 필요한 것은 다음 AI 세션이 프로젝트를 안전하게 이어받을 수 있는 하네스다. 하네스는 agent, skill, registry, governance, context budget, ADR, 데이터/저장/검증 기준을 포함해야 한다.

## 고려한 대안

### A. 가벼운 하네스

README, AGENTS, 간단한 spec만 둔다.

장점:

- 빠르게 시작할 수 있다.
- 산출물이 적다.

단점:

- agent와 skill의 지속 관리 기준이 부족하다.
- AI가 같은 결정을 반복할 가능성이 높다.
- 100% AI 관리라는 프로젝트 조건을 약하게 만족한다.

### B. 표준 AI 프로젝트 하네스

AGENTS, specs, plans, testing, data/storage 문서를 둔다.

장점:

- 초기 앱 규모에 적절하다.
- 구현 흐름을 안정적으로 만든다.

단점:

- agent와 skill 자체를 관리하는 메타 구조가 부족할 수 있다.

### C. 강한 운영 하네스

역할별 agent, skill, ADR, release, audit, risk register까지 엄격하게 둔다.

장점:

- 장기 운영과 병렬 작업에 강하다.
- 변경 추적과 감사 가능성이 높다.

단점:

- 초기 프로젝트에는 절차와 문서가 과하다.
- 토큰 사용과 관리 비용이 커질 수 있다.

## 결정

B안을 기본으로 하되 C안의 일부를 가져온 **B+ AI 하네스**를 사용한다.

포함하는 요소:

- `AGENTS.md`
- 역할별 `agents/*.md`
- 프로젝트 전용 `skills/*/SKILL.md`
- `docs/agent-registry.md`
- `docs/skill-registry.md`
- `docs/ai-governance.md`
- `docs/context-budget.md`
- `docs/data-model.md`
- `docs/local-storage-contract.md`
- `docs/testing.md`
- `docs/decisions/*.md`
- `docs/specs/*.md`
- `docs/plans/*.md`

핵심 차이는 `ai-steward-agent`를 두어 agent와 skill 생태계를 관리하게 하는 것이다.

## 결과

긍정적 결과:

- 다음 AI 세션이 하네스와 작업 규칙을 빠르게 이해할 수 있다.
- agent와 skill이 저장소 산출물로 관리된다.
- 새 agent/skill 추가를 통제할 수 있다.
- ADR로 중요한 결정을 보존한다.
- context budget으로 토큰 사용을 제어한다.

부정적 결과:

- 최소 프로젝트보다 초기 문서가 많다.
- registry와 governance 문서를 함께 갱신해야 하는 관리 비용이 있다.

완화책:

- 모든 문서를 매번 읽지 않고 context budget에 따라 필요한 문서만 읽는다.
- 새 agent/skill은 `ai-steward-agent` 기준을 통과해야 한다.
- 단발성 절차는 skill로 만들지 않는다.
