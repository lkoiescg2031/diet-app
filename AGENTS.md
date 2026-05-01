# AI Project Operating Guide

이 저장소는 AI가 지속적으로 관리하는 다이어트 웹앱 프로젝트다. 모든 AI 작업자는 이 파일을 먼저 읽고, 필요한 경우 registry와 관련 agent/skill만 추가로 읽는다.

## 대화 원칙

- 사용자와의 대화는 항상 한글로 한다.
- 모호한 요구는 바로 구현하지 말고, 필요한 만큼만 짧게 확인한다.
- 구현 세부사항이 열려 있으면 기존 spec, plan, ADR, registry를 우선한다.

## 기본 작업 흐름

1. 관련 spec을 확인한다.
2. 구현 계획이 없으면 `docs/plans/`에 먼저 작성한다.
3. 작업에 필요한 agent와 skill만 선택한다.
4. 변경을 작고 검증 가능한 단위로 수행한다.
5. 완료를 주장하기 전에 검증 명령을 실행하고 결과를 확인한다.
6. 장기 영향이 있는 결정은 `docs/decisions/`에 ADR로 남긴다.

## 문맥 로딩 규칙

- 항상 이 파일을 읽는다.
- agent/skill 선택이 필요할 때만 `docs/agent-registry.md`와 `docs/skill-registry.md`를 읽는다.
- 작업과 직접 관련된 `agents/*.md`, `skills/*/SKILL.md`, spec, plan, ADR만 읽는다.
- 모든 문서를 기본으로 한꺼번에 읽지 않는다.
- 자세한 기준은 `docs/context-budget.md`를 따른다.

## Agent와 Skill 관리

- agent와 skill 변경은 `agents/ai-steward-agent.md`의 기준을 따른다.
- 새 agent나 skill을 만들 때는 기존 artifact로 충분하지 않은 이유를 남긴다.
- agent 변경 시 `docs/agent-registry.md`를 함께 갱신한다.
- skill 변경 시 `docs/skill-registry.md`를 함께 갱신한다.
- 중복되거나 오래된 agent/skill은 병합 또는 폐기한다.

## 프로젝트 범위

- 초기 제품은 운동 기록, 식단 기록, 체중 변화 기록, 전체 현황 화면을 제공한다.
- 서버는 사용하지 않고 사용자 데이터는 브라우저 로컬에 저장한다.
- 제품 앱 구현은 별도 MVP spec과 plan에서 다룬다.

## 커밋과 산출물

- `.superpowers/` 같은 임시 브레인스토밍 산출물은 커밋하지 않는다.
- 기능 구현, 하네스 변경, ADR 추가는 가능하면 분리된 커밋으로 남긴다.
- 검증하지 않은 상태를 “완료”라고 표현하지 않는다.
