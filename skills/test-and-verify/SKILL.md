---
name: test-and-verify
description: Use before claiming completion, committing, merging, or handing off changes in this project.
---

# Test And Verify

## 핵심 원칙

완료 주장은 검증 증거 뒤에만 한다. 실행하지 않은 테스트나 확인하지 않은 UI 상태를 통과했다고 말하지 않는다.

## 절차

1. 변경 파일과 관련 spec/plan을 확인한다.
2. 변경 위험도에 맞는 검증 명령을 선택한다.
3. 가능한 자동 검증을 먼저 실행한다.
4. UI 변경은 수동 smoke check 또는 브라우저 확인을 추가한다.
5. 실패하면 원인과 재현 명령을 기록하고 수정한다.
6. 최종 요약에는 실행한 명령과 결과를 적는다.

## 기본 검증 후보

- 문서만 변경: `git diff --check`, 누락된 빈칸 표시 검색
- 데이터 로직 변경: unit test, migration test
- UI 변경: build, component/integration test, 수동 smoke check
- 저장 계약 변경: 기존 schema migration 검증

## 금지

- 이전 세션의 결과로 현재 변경을 통과 처리하지 않는다.
- 테스트가 없다는 이유로 검증을 생략하지 않는다.
- 실패한 검증을 숨기지 않는다.
