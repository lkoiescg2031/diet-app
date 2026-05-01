# Local Storage Contract

이 문서는 서버 없이 브라우저 로컬에 데이터를 저장하기 위한 고수준 계약이다. 정확한 API는 MVP 구현 계획에서 확정한다.

## 기본 원칙

- 초기 앱은 외부 서버에 사용자 데이터를 보내지 않는다.
- 저장소 변경은 `skills/local-storage-change/SKILL.md` 절차를 따른다.
- 영속 데이터 구조 변경은 schema version을 검토한다.
- 사용자의 기존 데이터 삭제는 기본 migration 전략이 아니다.

## 저장 기술

초기 저장 기술은 아직 확정하지 않는다. 후보는 다음과 같다.

- `localStorage`: 구현이 단순하고 MVP에 충분할 수 있다.
- `IndexedDB`: record가 커지거나 migration이 중요해질 때 적합하다.

최종 선택은 별도 ADR에서 결정한다.

## 저장 key 후보

정확한 key는 저장 기술 선택 후 확정한다. key는 앱 이름과 schema version을 드러내야 한다.

예상 namespace:

```text
diet-app
```

예상 data groups:

```text
exercise-records
meal-records
weight-records
settings
schema-version
```

## Schema Version

- 저장 데이터는 version을 가진다.
- 앱 시작 시 저장 version을 확인한다.
- 현재 앱 version보다 오래된 데이터는 migration 대상이다.
- migration 실패 시 원본 데이터를 보존하고 사용자에게 복구 가능한 오류를 제공한다.

## Migration 원칙

- migration은 가능한 한 순차적으로 수행한다.
- migration 전후 record 수가 예상과 다르면 실패로 본다.
- 삭제 migration은 ADR과 명시적 사용자 승인 없이는 기본값으로 두지 않는다.
- migration 테스트는 `docs/testing.md`에 반영한다.

## 백업과 내보내기

초기 MVP 필수 범위는 아니지만, 데이터 구조는 향후 export/import를 막지 않아야 한다.

향후 후보:

- JSON export
- JSON import
- 전체 데이터 초기화 전 백업 제안
