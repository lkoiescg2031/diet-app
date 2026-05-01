---
name: diet-app--local-storage-change
description: Use when changing local-only persistence, stored record shapes, schema versions, migrations, or derived data contracts in this project.
---

# Local Storage Change

## 핵심 원칙

로컬 데이터는 사용자의 유일한 데이터일 수 있다. 저장 구조 변경은 항상 호환성과 복구 가능성을 고려한다.

## 절차

1. `docs/data-model.md`와 `docs/local-storage-contract.md`를 확인한다.
2. 변경 대상 record, key, version, migration 필요 여부를 식별한다.
3. 기존 데이터가 깨지는지 판단한다.
4. schema version이 바뀌면 migration note를 작성한다.
5. 장기 결정이면 `docs/decisions/`에 ADR을 추가하거나 갱신한다.
6. 저장 adapter와 계산 로직 테스트 기준을 `docs/testing.md`에 반영한다.

## 검토 항목

- 저장 key가 안정적인가
- record id와 date 형식이 일관적인가
- 선택 필드와 필수 필드가 구분되는가
- 삭제보다 보존 또는 migration이 우선되는가
- export/import 가능성을 막지 않는가

## 금지

- migration 없이 영속 schema를 깨지 않는다.
- UI 상태를 영속 데이터 계약처럼 취급하지 않는다.
- 사용자 데이터를 조용히 삭제하지 않는다.
