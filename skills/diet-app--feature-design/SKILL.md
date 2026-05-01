---
name: diet-app--feature-design
description: Use when turning a diet app product idea into a project spec or revising feature scope before implementation.
---

# Feature Design

## 핵심 원칙

기능은 구현 전에 사용 목적, 데이터 영향, 화면 흐름, 수용 기준이 분리되어야 한다.

## 절차

1. 관련 사용자 요청과 기존 `docs/specs/`를 확인한다.
2. MVP 범위와 후속 범위를 나눈다.
3. 필요한 화면, 데이터, 계산, 저장 영향을 적는다.
4. 수용 기준과 비목표를 작성한다.
5. 저장 데이터 변경이 있으면 `data-agent`와 `diet-app--local-storage-change`를 함께 사용한다.
6. UI 변경이 있으면 `frontend-agent`와 `diet-app--ui-change`를 함께 사용한다.
7. spec은 `docs/specs/YYYY-MM-DD-<topic>.md`에 저장한다.

## spec에 포함할 항목

- 배경
- 목표
- 비목표
- 사용자 흐름
- 데이터 영향
- UI 영향
- 오류와 빈 상태
- 테스트와 검증 기준
- 이후로 미루는 결정

## 금지

- spec 없이 제품 기능을 바로 구현하지 않는다.
- 사용자가 요청하지 않은 기능을 MVP에 끼워 넣지 않는다.
- 저장 schema 변경을 암묵적으로 처리하지 않는다.
