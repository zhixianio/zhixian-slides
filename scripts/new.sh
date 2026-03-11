#!/bin/bash
# 用法: npm run new 2026-03-ai-agents

name=$1
if [ -z "$name" ]; then
  echo "Usage: npm run new <deck-name>"
  echo "Example: npm run new 2026-03-ai-agents"
  exit 1
fi

mkdir -p "decks/$name"
cat > "decks/$name/slides.md" << EOF
---
theme: default
title: $name
highlighter: shiki
transition: slide-left
mdc: true
---

# $name

Your presentation here

---

# Slide 2

Content

---
layout: center
class: text-center
---

# Thanks!

[zhixian.site](https://zhixian.site)
EOF

echo "Created decks/$name/slides.md"
echo "Run: npm run dev -- decks/$name/slides.md"
