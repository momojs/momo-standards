#!/usr/bin/env sh
# 把仓库内每个包含 SKILL.md 的目录软链接到 $SKILLS_DIR/<skill 名称>。
# skill 名称取自 SKILL.md frontmatter 中的 name 字段。
set -eu

root=$(cd "$(dirname "$0")" && pwd)
skills_dir=${SKILLS_DIR:-"$HOME/.claude/skills"}

mkdir -p "$skills_dir"

find "$root" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/.git/*' |
  while IFS= read -r skill; do
    dir=$(dirname "$skill")
    name=$(sed -n 's/^name:[[:space:]]*//p' "$skill" | head -n 1)

    if [ -z "$name" ]; then
      echo "跳过：$skill 缺少 name 字段" >&2
      continue
    fi

    target="$skills_dir/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "跳过：$target 已存在且不是软链接" >&2
      continue
    fi

    ln -sfn "$dir" "$target"
    echo "已链接：$target -> $dir"
  done
