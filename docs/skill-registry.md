# Skill Registry

이 문서는 프로젝트 전용 skill의 단일 목록이다. skill을 추가, 수정, 병합, 폐기할 때 반드시 함께 갱신한다.

| Skill | 트리거 조건 | 범위 | 필요한 입력 | 기대 산출물 | 관련 agent | 마지막 검토일 |
| --- | --- | --- | --- | --- | --- | --- |
| `diet-app--agent-or-skill-change` | agent/skill 추가, 수정, 병합, 폐기 | AI 하네스 관리 | registry, governance, 변경 요청 | 갱신된 agent/skill, registry, 필요 시 ADR | `ai-steward-agent` | 2026-05-02 |
| `diet-app--feature-design` | 제품 아이디어를 spec으로 바꾸거나 기능 범위를 조정 | 기능 설계 | 사용자 요청, 기존 spec, 데이터/UI 제약 | 기능 spec, 수용 기준, 비목표 | `product-agent` | 2026-05-02 |
| `diet-app--local-storage-change` | 로컬 저장, schema, migration, 파생 데이터 계약 변경 | 데이터 지속성 | 데이터 모델, 저장 계약, 변경 요구 | 저장 계약 변경안, migration note, 테스트 기준 | `data-agent` | 2026-05-02 |
| `diet-app--ui-change` | 화면, 폼, 네비게이션, 반응형 UI 변경 | 프론트엔드 UX | spec, plan, 데이터 계약 | 화면 구조, UI 기준, smoke check | `frontend-agent` | 2026-05-02 |
| `diet-app--test-and-verify` | 완료 주장, 커밋, 인계 전 검증 | 품질 확인 | diff, spec, plan, 테스트 명령 | 검증 결과, 실패 기록, 최종 요약 | `qa-agent`, `reviewer-agent` | 2026-05-02 |

## 관리 규칙

- 새 skill은 반복 가능한 프로젝트 절차일 때만 추가한다.
- skill description은 트리거 조건만 설명하고 절차 요약을 넣지 않는다.
- skill 파일과 registry 항목은 같은 변경 안에서 갱신한다.
- skill이 전역 Codex skill과 겹치면 프로젝트 특화 내용만 남긴다.
