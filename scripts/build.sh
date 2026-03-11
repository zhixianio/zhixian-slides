#!/bin/bash
set -e

rm -rf dist
mkdir -p dist

# 构建每个 deck
for deck in decks/*/; do
  name=$(basename "$deck")
  echo "Building $name..."
  npx slidev build "$deck/slides.md" --base "/$name/" --out "../../dist/$name"
done

# 复制首页
cp public/index.html dist/index.html

# 动态更新首页的 slides 列表
echo "Updating index with deck list..."
DECK_LIST=""
for deck in dist/*/; do
  name=$(basename "$deck")
  DECK_LIST="$DECK_LIST<li class=\"deck-card\"><a href=\"/$name/\"><span class=\"icon\">🎯</span><span>$name</span><span class=\"arrow\">→</span></a></li>"
done

# 用 sed 替换占位内容
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s|<li class=\"deck-card\">.*<!-- 新增 slides 时在这里添加 -->|$DECK_LIST|" dist/index.html
else
  sed -i "s|<li class=\"deck-card\">.*<!-- 新增 slides 时在这里添加 -->|$DECK_LIST|" dist/index.html
fi

echo "Done! Output in dist/"
