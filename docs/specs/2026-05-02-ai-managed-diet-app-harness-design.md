# AI 관리형 다이어트 앱 하네스 설계

## 1. 배경

이 저장소는 AI가 지속적으로 관리하는 다이어트 웹앱을 담는다. 초기 제품 범위는 다음과 같다.

- 운동 기록 화면
- 식단 기록 화면
- 체중 변화 기록 화면
- 전체 현황 화면
- 서버 없이 브라우저 로컬에 저장되는 데이터

제품 기능을 구현하기 전에, 먼저 AI가 이 프로젝트를 장기적으로 안전하게 이어받을 수 있는 운영 하네스를 만든다. 이 하네스는 다음 AI 세션이 프로젝트 맥락을 빠르게 이해하고, 같은 결정을 반복하지 않으며, 프로젝트 전용 agent와 skill을 찾기 쉽게 만들고, 불필요한 토큰 사용을 줄이는 것을 목표로 한다.

이 설계 시점의 저장소는 비어 있는 상태에서 시작했으며, 설계 문서와 이후 구현 작업을 단계별로 커밋하기 위해 git 저장소로 초기화한다.

## 2. 결정

이 프로젝트는 **B+ AI 하네스**로 설계한다.

- 표준 AI 프로젝트 하네스를 기본으로 둔다.
- 강한 운영 하네스에서 필요한 일부만 가져온다.
- 프로젝트 전용 agent와 skill을 저장소 산출물로 관리한다.
- agent와 skill 생태계를 관리하는 `ai-steward-agent`를 둔다.
- registry와 context budget을 통해 문서 규모와 토큰 사용을 제어한다.

이 방식은 기업형 거버넌스처럼 과하게 무겁지 않으면서도, “100% AI 관리 프로젝트”라는 핵심 조건을 만족한다.

## 3. 목표

- AI 관리 개발에 필요한 저장소 산출물을 정의한다.
- 모든 프로젝트 agent와 skill을 registry로 발견 가능하게 만든다.
- `ai-steward-agent`가 agent/skill 추가, 수정, 병합, 폐기를 관리하게 한다.
- 중요한 장기 결정은 ADR로 기록한다.
- 과한 문맥 로딩과 문서 증식을 방지한다.
- 이후 다이어트 앱 MVP 설계와 구현 계획으로 넘어갈 기반을 만든다.

## 4. 비목표

- 이 설계에서 다이어트 앱 기능을 구현하지 않는다.
- 이 설계에서 최종 프론트엔드 프레임워크를 선택하지 않는다.
- 모든 미래 기능 spec을 한 번에 작성하지 않는다.
- 초기 앱에 외부 백엔드, 서버 DB, 호스팅된 AI 서비스를 요구하지 않는다.
- 전역 Codex/Superpowers skill을 프로젝트 저장소에 복사하지 않는다.

## 5. 저장소 산출물

하네스는 다음 프로젝트 소유 산출물을 만든다.

```text
AGENTS.md

agents/
  ai-steward-agent.md
  product-agent.md
  frontend-agent.md
  data-agent.md
  qa-agent.md
  reviewer-agent.md

skills/
  agent-or-skill-change/SKILL.md
  feature-design/SKILL.md
  local-storage-change/SKILL.md
  ui-change/SKILL.md
  test-and-verify/SKILL.md

docs/
  agent-registry.md
  skill-registry.md
  ai-governance.md
  context-budget.md
  data-model.md
  local-storage-contract.md
  testing.md
  decisions/
  specs/
  plans/
```

`.superpowers/` 같은 임시 브레인스토밍 산출물은 지속 관리 대상이 아니며 커밋하지 않는다.

## 6. Agent 모델

### ai-steward-agent

`ai-steward-agent`는 프로젝트의 AI 운영 체계를 관리한다. 제품 기능을 직접 만드는 역할이 아니라, agent와 skill 세트가 건강하게 유지되도록 돌보는 메타 agent다.

책임:

- 새 agent나 skill이 실제로 필요한지 판단한다.
- agent 간 책임 중복을 방지한다.
- agent/skill 변경 시 관련 registry 갱신을 요구한다.
- 중복되거나 낡은 agent/skill을 병합하거나 폐기한다.
- 실무적으로 감당 가능한 문맥 로딩 규칙을 유지한다.
- 장기 영향이 있는 구조 결정은 ADR로 기록하게 한다.

권한:

- 프로젝트 전용 agent와 skill을 추가, 수정, 병합, 폐기할 수 있다.
- 새 agent/skill에는 이유, 트리거 조건, 책임, 기대 산출물을 반드시 남긴다.
- 기존 artifact의 작은 수정으로 충분한 경우 새 agent/skill을 만들지 않는다.

### product-agent

제품 의도, 사용자 흐름, 기능 경계, 수용 기준을 관리한다.

### frontend-agent

UI 구조, 상호작용 설계, 프론트엔드 아키텍처, 접근성, 반응형 동작을 관리한다.

### data-agent

로컬 데이터 모델, 저장 계약, 마이그레이션, 검증, 가져오기/내보내기 고려사항, 파생 계산을 관리한다.

### qa-agent

테스트 전략, 회귀 테스트, 검증 명령, 수동 QA 체크리스트를 관리한다.

### reviewer-agent

코드 리뷰 관점, 위험 탐지, 누락된 엣지 케이스, 병합/릴리즈 전 준비 상태를 관리한다.

## 7. Skill 모델

프로젝트 전용 skill은 `skills/*/SKILL.md`에 저장한다. 이 skill들은 전역 Codex skill을 대체하지 않고, 이 프로젝트에서 반복될 작업 절차를 기록한다.

초기 skill:

- `agent-or-skill-change`: AI 하네스 자체를 변경하는 절차
- `feature-design`: 제품 아이디어를 프로젝트 spec으로 바꾸는 절차
- `local-storage-change`: 브라우저 저장 데이터 변경을 안전하게 처리하는 절차
- `ui-change`: 화면이나 공유 UI 동작을 변경하는 절차
- `test-and-verify`: 완료 주장 전에 검증을 선택하고 실행하는 절차

새 skill은 같은 프로젝트 전용 절차가 반복될 가능성이 있을 때만 만든다. 한 번짜리 지시는 spec, plan, ADR 중 알맞은 곳에 남긴다.

## 8. Registry

`docs/agent-registry.md`는 모든 프로젝트 agent에 대해 다음을 기록한다.

- 이름
- 목적
- 사용 조건
- 필요한 입력
- 기대 산출물
- 소유하거나 자주 다루는 파일
- 관련 skill

`docs/skill-registry.md`는 모든 프로젝트 skill에 대해 다음을 기록한다.

- 이름
- 트리거 조건
- 범위
- 필요한 입력
- 기대 산출물
- 관련 agent
- 마지막 검토일

agent와 skill은 registry 항목이 있어야 완성된 것으로 본다.

## 9. Governance

`docs/ai-governance.md`는 하네스 변경 규칙을 정의한다.

- agent와 skill 변경은 `ai-steward-agent`를 거친다.
- 새 agent/skill은 기존 artifact로 충분하지 않은 이유를 적어야 한다.
- 폐기된 agent/skill은 짧은 migration note를 남긴다.
- 장기 영향이 있는 구조 결정은 `docs/decisions/`에 ADR로 기록한다.
- 하네스 변경은 작고 리뷰 가능한 단위로 한다.

ADR이 필요한 결정 예시:

- 프론트엔드 스택 선택
- 로컬 저장 기술 선택
- 영속 데이터 schema versioning
- 마이그레이션 전략
- 테스트 전략
- agent/skill 모델의 큰 변경

## 10. Context Budget

`docs/context-budget.md`는 다음 AI 세션이 읽어야 하는 문맥의 양을 제어한다.

기본 문맥 로딩 규칙:

- 항상 `AGENTS.md`를 읽는다.
- 프로젝트 agent/skill을 선택해야 할 때만 `docs/agent-registry.md`와 `docs/skill-registry.md`를 읽는다.
- 작업과 관련된 agent/skill 파일만 읽는다.
- 현재 작업의 spec과 plan을 읽는다.
- ADR은 해당 결정 영역을 건드릴 때만 읽는다.
- 모든 docs, 모든 agents, 모든 skills를 기본으로 읽지 않는다.

이 규칙이 산출물이 늘어나도 프로젝트를 지속 가능하게 만든다.

## 11. 데이터와 앱 경계

다이어트 앱 자체는 이후 별도 spec에서 설계한다. 다만 하네스는 다음 앱 요구를 미리 고려한다.

- 로컬 전용 데이터 저장
- 기록 데이터의 schema versioning
- 기록 형태가 바뀔 때 안전한 마이그레이션
- 향후 사용자 백업/내보내기 경로
- 운동, 식단, 체중, 전체 현황 계산 로직의 분리

초기 `docs/data-model.md`와 `docs/local-storage-contract.md`는 구현 전에 고수준 데이터 계약을 설명한다. 정확한 프론트엔드 API와 저장 API는 구현 계획 단계에서 결정한다.

## 12. 오류 처리와 복구

하네스 수준의 오류 처리는 프로젝트 연속성을 중심으로 한다.

- agent나 skill이 불명확하면 사용하기 전에 수정한다.
- 두 agent의 책임이 겹치면 `ai-steward-agent`가 소유권을 정리한다.
- 저장소 변경이 기존 로컬 데이터를 깨뜨릴 수 있으면 ADR과 migration note를 만든다.
- 검증을 실행할 수 없으면 최종 작업 요약에 이유를 남긴다.
- 생성된 임시 로컬 artifact는 의도적으로 승격하지 않는 한 커밋하지 않는다.

## 13. 테스트와 검증

이 spec은 최종 앱 테스트를 확정하지 않지만, 하네스는 이후 작업에서 검증을 요구해야 한다.

예상 검증 계층:

- 순수 데이터/계산 로직 단위 테스트
- 로컬 저장 adapter와 migration 테스트
- 주요 기록 흐름의 component 또는 integration 테스트
- 완료 주장 전 build와 lint 확인
- 네 개 초기 화면에 대한 수동 smoke check

정확한 명령은 프론트엔드 스택 선택 후 `docs/testing.md`에 기록한다.

## 14. 지속가능성과 규모

예상 산출물 규모:

- 초기 하네스: 지속 산출물 약 15~20개
- MVP 앱 구현 후: 지속 산출물 약 20~35개
- 기능 확장 여러 차례 이후: registry와 context budget이 유지되면 약 35~60개

이 규모는 최소 프로젝트보다 무겁지만, “AI가 100% 관리하는 프로젝트”라는 조건에는 적절하다. `ai-steward-agent`와 context budget이 이 구조를 통제 가능한 범위에 묶어둔다.

## 15. 구현 순서

이 spec이 승인되면 다음 순서로 진행한다.

1. `docs/plans/` 아래에 구현 계획을 작성한다.
2. 이 spec에 명시된 AI 하네스 파일을 만든다.
3. 초기 agent와 skill의 registry 항목을 추가한다.
4. governance, context budget, testing, data model, local storage contract 문서를 추가한다.
5. 선택된 하네스 모델과 이후 스택 선택에 대한 ADR을 추가한다.
6. 완성된 하네스를 제품 기능 구현 전 별도 변경으로 커밋한다.
7. 다이어트 앱 MVP에 대한 별도 feature spec과 plan을 시작한다.

## 16. 이후 spec으로 미루는 결정

다음 결정은 이 하네스 설계 안에서 확정하지 않는다.

- 프론트엔드 프레임워크
- 스타일링 시스템
- 정확한 로컬 저장 기술
- 정확한 데이터 schema
- 대시보드 지표
- 가져오기/내보내기 동작
- 배포 대상

이 결정들은 이후 spec과 ADR에서 다룬다.
