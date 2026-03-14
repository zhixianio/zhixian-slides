#!/bin/bash

deck=${1:-2026-03-example}

# 支持多种输入格式
# 1. 只输入名字: 2026-03-example
# 2. decks/名字: decks/2026-03-example
# 3. 完整路径: decks/2026-03-example/slides.md

# 去掉可能的 decks/ 前缀和 /slides.md 后缀，得到纯名字
name="${deck#decks/}"
name="${name%/slides.md}"
name="${name%/}"

deck="decks/$name/slides.md"

if [[ ! -f "$deck" ]]; then
  echo "Deck not found: $deck"
  echo ""
  echo "Available decks:"
  ls -1 decks/
  exit 1
fi

# 为每个 deck 创建 public symlink，让 slidev 能访问共享资源
deck_dir="decks/$name"
if [[ ! -L "$deck_dir/public" ]]; then
  ln -sf "../../public" "$deck_dir/public"
fi

echo "Starting: $deck"
__VITE_ADDITIONAL_SERVER_ALLOWED_HOSTS=bunker npx slidev "$deck" --remote
