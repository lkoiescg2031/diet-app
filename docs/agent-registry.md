# Agent Registry

이 문서는 프로젝트 agent의 단일 목록이다. agent를 추가, 수정, 병합, 폐기할 때 반드시 함께 갱신한다.

| Agent | 목적 | 사용 조건 | 입력 | 출력 | 주요 파일 | 관련 skill |
| --- | --- | --- | --- | --- | --- | --- |
| `ai-steward-agent` | AI 운영 체계 관리 | agent/skill 변경, registry 정리, context budget 조정 | 변경 요청, registry, spec, plan, ADR | agent/skill 결정, registry 갱신, ADR 제안 | `AGENTS.md`, `agents/*`, `skills/*`, `docs/agent-registry.md`, `docs/skill-registry.md`, `docs/ai-governance.md`, `docs/context-budget.md` | `agent-or-skill-change` |
| `product-agent` | 제품 의도와 기능 경계 관리 | 기능 spec 작성, MVP 범위 결정, 수용 기준 정리 | 사용자 요청, spec, plan, 데이터 제약 | 기능 요구사항, 수용 기준, 제외 범위 | `docs/specs/*`, `docs/plans/*`, `docs/data-model.md` | `feature-design` |
| `frontend-agent` | UI와 상호작용 관리 | 화면/컴포넌트/레이아웃 변경 | spec, plan, 데이터 모델, UI 제약 | 화면 구조, 컴포넌트 책임, UI 체크리스트 | `docs/specs/*`, `docs/plans/*`, `docs/testing.md`, 앱 UI 파일 | `ui-change` |
| `data-agent` | 로컬 데이터와 저장 계약 관리 | 데이터 모델, 저장 방식, migration 변경 | 제품 요구, 데이터 모델, 저장 계약, ADR | 데이터 변경안, 저장 계약, migration note | `docs/data-model.md`, `docs/local-storage-contract.md`, `docs/decisions/*`, 앱 데이터 파일 | `local-storage-change` |
| `qa-agent` | 테스트와 검증 관리 | 완료 전 검증, 테스트 전략 수립, 회귀 위험 점검 | plan, diff, spec, 테스트 결과 | 검증 체크리스트, 실패 분석, 최종 검증 요약 | `docs/testing.md`, `docs/plans/*`, 테스트 파일 | `test-and-verify` |
| `reviewer-agent` | 리뷰와 위험 탐지 | 커밋/PR 전 자체 리뷰, spec 대비 변경 확인 | diff, spec, plan, 검증 결과 | 리뷰 finding, 수정 필요 사항, 남은 위험 | 모든 변경 파일, `docs/specs/*`, `docs/plans/*` | `test-and-verify` |

## 관리 규칙

- 새 agent는 `ai-steward-agent` 검토 없이 추가하지 않는다.
- agent 파일과 registry 항목은 같은 변경 안에서 갱신한다.
- 책임이 겹치면 새 agent를 만들기보다 기존 agent를 수정하거나 병합한다.
- agent가 실제로 쓰이지 않으면 폐기 후보로 표시하고 migration note를 남긴다.
