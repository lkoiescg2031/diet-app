#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$ROOT_DIR/skills"

if [[ -n "${CODEX_SKILLS_DIR:-}" ]]; then
  TARGET_DIR="$CODEX_SKILLS_DIR"
elif [[ -n "${CODEX_HOME:-}" ]]; then
  TARGET_DIR="$CODEX_HOME/skills"
else
  TARGET_DIR="$HOME/.codex/skills"
fi

mkdir -p "$TARGET_DIR"

shopt -s nullglob
installed=0

for skill_dir in "$SOURCE_DIR"/diet-app--*; do
  [[ -d "$skill_dir" ]] || continue
  [[ -f "$skill_dir/SKILL.md" ]] || continue

  skill_name="$(basename "$skill_dir")"
  declared_name="$(awk -F': *' '/^name:/ { print $2; exit }' "$skill_dir/SKILL.md")"

  if [[ "$declared_name" != "$skill_name" ]]; then
    echo "Refusing to install $skill_dir: SKILL.md name '$declared_name' must match directory '$skill_name'." >&2
    exit 1
  fi

  link_path="$TARGET_DIR/$skill_name"

  if [[ -L "$link_path" ]]; then
    current_target="$(readlink "$link_path")"
    if [[ "$current_target" == "$skill_dir" ]]; then
      echo "Already linked: $link_path -> $skill_dir"
    else
      ln -sfn "$skill_dir" "$link_path"
      echo "Updated link: $link_path -> $skill_dir"
    fi
  elif [[ -e "$link_path" ]]; then
    echo "Refusing to overwrite non-symlink path: $link_path" >&2
    exit 1
  else
    ln -s "$skill_dir" "$link_path"
    echo "Created link: $link_path -> $skill_dir"
  fi

  installed=$((installed + 1))
done

if [[ "$installed" -eq 0 ]]; then
  echo "No project skills found in $SOURCE_DIR." >&2
  exit 1
fi

echo "Installed $installed project skill symlink(s) into $TARGET_DIR."
