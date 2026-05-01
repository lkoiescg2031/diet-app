# Codex Integration

이 문서는 repo의 project skill을 Codex 전역 skill 디렉터리에 연결하는 방법을 설명한다.

## 설치 방식

project skill의 정본은 이 저장소의 `skills/diet-app--*` 디렉터리다. Codex가 skill로 발견할 수 있도록 설치 스크립트는 전역 skill 디렉터리에 symlink를 만든다.

```text
~/.codex/skills/diet-app--ui-change -> <repo>/skills/diet-app--ui-change
```

## 실행

기본 설치:

```bash
make install-project-skills
```

같은 target의 짧은 alias:

```bash
make install-skills
```

## 설치 위치

설치 위치는 다음 우선순위로 결정된다.

1. `CODEX_SKILLS_DIR`
2. `CODEX_HOME/skills`
3. `$HOME/.codex/skills`

테스트나 임시 설치는 `CODEX_SKILLS_DIR`를 사용한다.

```bash
CODEX_SKILLS_DIR=/tmp/diet-app-skills make install-project-skills
```

## 안전 규칙

- 기존 symlink는 repo의 현재 skill 디렉터리를 가리키도록 갱신한다.
- 기존 일반 파일이나 디렉터리는 덮어쓰지 않고 중단한다.
- `SKILL.md`의 `name`은 skill 디렉터리 이름과 같아야 한다.
- project skill 이름은 전역 충돌을 줄이면서 프로젝트명과 skill명을 구분하기 위해 `diet-app--*` 형식을 사용한다.

## 검증

```bash
make test-project-skill-install
```
