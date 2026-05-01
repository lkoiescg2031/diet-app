---
name: diet-app--ui-change
description: Use when changing screens, navigation, forms, visual hierarchy, responsive behavior, or shared UI patterns in this diet app.
---

# UI Change

## 핵심 원칙

이 앱은 반복 기록 도구다. 화면은 빠른 입력, 명확한 피드백, 작은 인지 부담을 우선한다.

## 절차

1. 관련 spec, plan, 데이터 계약을 확인한다.
2. 사용자가 수행할 주요 행동을 한 문장으로 정리한다.
3. 화면 책임을 입력, 목록, 요약, 오류/빈 상태로 나눈다.
4. 모바일과 데스크톱에서 텍스트와 컨트롤이 겹치지 않게 설계한다.
5. 저장 또는 계산 로직 변경이 있으면 `data-agent` 검토를 포함한다.
6. 수동 smoke check 항목을 `docs/testing.md` 또는 plan에 남긴다.

## UI 기준

- 실제 앱 화면을 첫 화면으로 둔다.
- 기록 추가, 수정, 삭제 흐름은 예측 가능해야 한다.
- 폼 오류는 필드 가까이에 표시한다.
- 빈 상태는 다음 행동을 바로 제공한다.
- 반복되는 컨트롤은 일관된 배치와 명칭을 쓴다.

## 금지

- 설명용 랜딩 페이지를 앱 대신 만들지 않는다.
- 모바일에서 버튼이나 텍스트가 넘치는 상태를 방치하지 않는다.
- 저장 실패나 검증 실패를 조용히 무시하지 않는다.
