# ADR 0002: Project skill을 symlink로 Codex에 설치

## 상태

Accepted

## 날짜

2026-05-02

## 배경

이 저장소의 `skills/diet-app--*/SKILL.md`는 프로젝트 전용 작업 절차를 담는다. 하지만 repo 안에만 있으면 Codex의 전역 skill discovery에서 자동으로 발견되지 않을 수 있다.

project skill의 정본은 repo에 남기면서도 Codex가 호출할 수 있게 하려면 설치 레이어가 필요하다.

## 결정

`scripts/install-project-skills.sh`를 통해 repo의 `skills/diet-app--*` 디렉터리를 Codex skill 디렉터리에 symlink로 설치한다.

설치 위치 우선순위:

1. `CODEX_SKILLS_DIR`
2. `CODEX_HOME/skills`
3. `$HOME/.codex/skills`

`Makefile`은 `make install-project-skills`와 `make install-skills` target을 제공한다.

## 대안

### 복사 방식

장점:

- symlink 경로가 깨질 위험이 없다.
- 설치본이 독립적으로 남는다.

단점:

- repo의 skill과 설치본이 drift될 수 있다.
- skill 수정 후 재설치가 필요하다.

### symlink 방식

장점:

- repo가 단일 정본으로 유지된다.
- skill 수정이 설치본에 즉시 반영된다.
- AI 운영 산출물이 저장소 안에 남는다.

단점:

- repo 위치가 바뀌면 symlink가 깨질 수 있다.
- 미완성 skill 변경도 설치본에 바로 반영될 수 있다.

## 결과

- `SKILL.md`의 `name`은 디렉터리 이름과 일치해야 한다.
- project skill은 `diet-app--*` 형식으로 이름을 지정해 프로젝트명과 skill명을 구분한다.
- 기존 non-symlink 경로는 덮어쓰지 않는다.
- 실제 사용자 환경 설치 없이도 `CODEX_SKILLS_DIR`로 테스트할 수 있다.
