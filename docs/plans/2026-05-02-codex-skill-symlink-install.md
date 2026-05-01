# Codex Skill Symlink Install 구현 계획

**Goal:** repo의 project skill을 Codex 전역 skill 디렉터리에 symlink로 설치하는 스크립트와 Makefile target을 추가한다.

**Architecture:** repo의 `skills/diet-app--*` 디렉터리를 정본으로 두고, 설치 스크립트가 Codex skill 디렉터리에 같은 이름의 symlink를 만든다. 실제 설치 위치는 `CODEX_SKILLS_DIR`, `CODEX_HOME/skills`, `$HOME/.codex/skills` 순서로 결정한다.

**Verification:** temp 디렉터리를 `CODEX_SKILLS_DIR`로 지정해 실제 사용자 전역 설정을 건드리지 않고 symlink 동작을 검증한다.

## 작업

- [x] `tests/install-project-skills.test.sh`를 먼저 작성해 설치 동작을 검증한다.
- [x] 테스트가 script/Makefile 부재로 실패하는지 확인한다.
- [x] project skill directory와 frontmatter `name`을 `diet-app--*` 형식으로 맞추고 설치 시 검증한다.
- [x] `scripts/install-project-skills.sh`를 작성한다.
- [x] `Makefile`에 `install-project-skills` target을 추가한다.
- [x] registry와 관련 문서 참조를 갱신한다.
- [x] 테스트, whitespace 검사, 빈칸 표시 검사를 실행한다.
