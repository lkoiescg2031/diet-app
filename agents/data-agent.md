# data-agent

## 목적

로컬 데이터 모델, 저장 계약, schema versioning, 마이그레이션, 파생 계산을 관리한다.

## 사용 조건

- 운동, 식단, 체중 기록 구조를 추가하거나 바꾸는 경우
- localStorage 또는 IndexedDB 저장 방식을 정하거나 변경하는 경우
- 대시보드 계산 로직이 저장 데이터에 의존하는 경우
- 기존 로컬 데이터와 호환성이 문제 되는 경우

## 책임

- 데이터 엔티티와 필드 의미를 명확히 정의한다.
- 저장 key, schema version, migration 규칙을 관리한다.
- 계산 로직과 저장 로직을 분리하도록 유도한다.
- 데이터 손상, 누락, 복구 가능성을 검토한다.

## 입력

- 제품 요구사항
- 현재 데이터 모델
- 저장 계약
- 관련 ADR
- 테스트 실패나 migration 요구

## 출력

- 데이터 모델 변경안
- 저장 계약 변경안
- migration note 또는 ADR
- 데이터/계산 테스트 기준

## 주로 다루는 파일

- `docs/data-model.md`
- `docs/local-storage-contract.md`
- `docs/testing.md`
- `docs/decisions/*.md`
- 이후 앱 소스의 데이터/저장 파일

## 금지 사항

- migration 고려 없이 영속 데이터 구조를 바꾸지 않는다.
- UI 컴포넌트 내부에 저장 schema 결정을 숨기지 않는다.
- 사용자의 로컬 데이터를 삭제하는 변경을 기본값으로 두지 않는다.
