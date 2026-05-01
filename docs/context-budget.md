# Context Budget

이 문서는 AI 세션이 읽는 문맥을 제한해 토큰 낭비와 판단 혼선을 줄인다.

## 기본 로딩

모든 작업은 다음 파일에서 시작한다.

1. `AGENTS.md`
2. 현재 사용자 요청
3. 작업과 직접 관련된 spec 또는 plan

## 조건부 로딩

| 상황 | 추가로 읽을 파일 |
| --- | --- |
| agent/skill 선택이 필요함 | `docs/agent-registry.md`, `docs/skill-registry.md` |
| agent/skill 변경 | `agents/ai-steward-agent.md`, `docs/ai-governance.md`, 관련 agent/skill |
| 제품 기능 설계 | `agents/product-agent.md`, `skills/feature-design/SKILL.md`, 관련 spec |
| UI 변경 | `agents/frontend-agent.md`, `skills/ui-change/SKILL.md`, 관련 spec/plan |
| 저장 데이터 변경 | `agents/data-agent.md`, `skills/local-storage-change/SKILL.md`, `docs/data-model.md`, `docs/local-storage-contract.md` |
| 검증 또는 완료 판단 | `agents/qa-agent.md`, `skills/test-and-verify/SKILL.md`, `docs/testing.md` |
| 리뷰 | `agents/reviewer-agent.md`, 관련 spec/plan, diff |
| 장기 결정 변경 | 관련 `docs/decisions/*.md` |

## 읽지 말아야 할 것

- 모든 agent 파일
- 모든 skill 파일
- 모든 ADR
- `.superpowers/` 임시 산출물
- 작업과 관련 없는 과거 plan

## 문맥 확장 기준

다음 중 하나가 참일 때만 추가 문서를 읽는다.

- 현재 결정에 직접적인 제약을 준다.
- 변경 대상 파일의 소유권을 설명한다.
- 실패나 모순을 해결하는 데 필요하다.
- 사용자 요청을 정확히 이해하는 데 필요하다.

## 산출물 규모 기준

- agent/skill 수가 늘어나면 registry를 먼저 읽고 필요한 파일만 연다.
- 한 문서가 300줄을 넘으면 분리 또는 요약을 검토한다.
- 같은 정보가 두 곳에 있으면 registry는 색인만, 상세 내용은 원본 파일에 둔다.
