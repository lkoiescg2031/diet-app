#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="$(mktemp -d "${TMPDIR:-/tmp}/diet-app-skills.XXXXXX")"

expected_skills=(
  diet-app--agent-or-skill-change
  diet-app--feature-design
  diet-app--local-storage-change
  diet-app--test-and-verify
  diet-app--ui-change
)

cd "$ROOT_DIR"

CODEX_SKILLS_DIR="$TARGET_DIR" ./scripts/install-project-skills.sh >/tmp/diet-app-install-project-skills.out

for skill in "${expected_skills[@]}"; do
  link_path="$TARGET_DIR/$skill"
  target_path="$ROOT_DIR/skills/$skill"

  if [[ ! -L "$link_path" ]]; then
    echo "Expected symlink missing: $link_path" >&2
    exit 1
  fi

  actual_target="$(readlink "$link_path")"
  if [[ "$actual_target" != "$target_path" ]]; then
    echo "Unexpected target for $link_path: $actual_target" >&2
    echo "Expected: $target_path" >&2
    exit 1
  fi

  if [[ ! -f "$link_path/SKILL.md" ]]; then
    echo "Linked SKILL.md missing: $link_path/SKILL.md" >&2
    exit 1
  fi
done

link_count="$(find "$TARGET_DIR" -maxdepth 1 -type l | wc -l | tr -d ' ')"
if [[ "$link_count" != "${#expected_skills[@]}" ]]; then
  echo "Expected ${#expected_skills[@]} symlinks, found $link_count" >&2
  exit 1
fi

CODEX_SKILLS_DIR="$TARGET_DIR" make install-project-skills >/tmp/diet-app-make-install-project-skills.out
