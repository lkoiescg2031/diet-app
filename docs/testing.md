# Testing And Verification

이 문서는 프로젝트 검증 기준을 정의한다. 실제 명령은 프론트엔드 스택 선택 후 갱신한다.

## 기본 원칙

- 완료 주장은 검증 실행 뒤에만 한다.
- 문서 변경도 최소한 whitespace와 빈칸 표시 검사를 수행한다.
- 저장 데이터 변경은 migration 위험을 별도로 검토한다.
- UI 변경은 자동 테스트와 수동 smoke check를 함께 고려한다.

## 현재 하네스 검증

하네스 문서 변경 시 실행할 명령:

```bash
git diff --check
rg -n "T[B]D|TO[D]O|FIX[M]E|placeholde[r]|미[정]" AGENTS.md agents skills docs
find AGENTS.md agents skills docs -type f | sort
```

## 앱 구현 후 예상 검증

프론트엔드 스택이 선택되면 다음 명령을 실제 package script로 확정한다.

- lint
- test
- build
- component 또는 integration test

## 데이터 검증 기준

- record 생성, 수정, 삭제가 저장소에 반영되는지 확인한다.
- schema version이 예상대로 저장되는지 확인한다.
- migration은 이전 version fixture로 검증한다.
- 파생 계산은 순수 함수 테스트로 검증한다.

## UI smoke check 기준

초기 MVP의 수동 확인 항목:

- 운동 기록을 추가하고 목록 또는 요약에 반영되는지 확인한다.
- 식단 기록을 추가하고 목록 또는 요약에 반영되는지 확인한다.
- 체중 기록을 추가하고 변화 표시가 갱신되는지 확인한다.
- 전체 현황 화면에서 세 종류의 기록이 함께 반영되는지 확인한다.
- 새로고침 후 로컬 데이터가 유지되는지 확인한다.

## 실패 기록

검증 실패 시 최종 요약 또는 plan에 다음을 남긴다.

- 실행 명령
- 실패 출력의 핵심
- 재현 방법
- 수정 여부
- 남은 위험
