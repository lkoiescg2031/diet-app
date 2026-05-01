---
name: diet-app--agent-or-skill-change
description: Use when this project needs to add, update, merge, retire, or review project-specific agents or skills.
---

# Agent Or Skill Change

## 핵심 원칙

agent와 skill은 프로젝트의 장기 운영 비용이다. 새 파일을 만들기 전에 기존 artifact 수정으로 충분한지 먼저 판단한다.

## 절차

1. `AGENTS.md`, `docs/agent-registry.md`, `docs/skill-registry.md`, `docs/ai-governance.md`를 확인한다.
2. 변경 이유를 한 문장으로 적는다.
3. 기존 agent/skill로 해결 가능한지 확인한다.
4. 새 agent/skill이 필요하면 목적, 사용 조건, 입력, 출력, 금지 사항을 정의한다.
5. 관련 registry를 같은 변경에서 갱신한다.
6. 장기 영향이 크면 `docs/decisions/`에 ADR을 추가한다.
7. `docs/context-budget.md`에 문맥 로딩 영향이 있는지 확인한다.

## 새 agent 기준

- 독립된 책임이 반복적으로 필요하다.
- 기존 agent에 넣으면 책임이 흐려진다.
- 명확한 입력과 출력이 있다.
- 관련 파일 소유 범위를 설명할 수 있다.

## 새 skill 기준

- 같은 절차가 반복될 가능성이 높다.
- 절차를 잊으면 품질이나 안전성이 떨어진다.
- `SKILL.md`만으로 실행자가 올바른 순서를 따를 수 있다.

## 금지

- 단발성 요청을 skill로 만들지 않는다.
- 이름만 다른 중복 agent를 만들지 않는다.
- registry 갱신 없이 완료하지 않는다.
