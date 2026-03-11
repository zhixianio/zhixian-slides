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

# 生成首页索引
echo "Generating index..."
cat > dist/index.html << 'EOF'
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>zhixian slides</title>
  <style>
    body { font-family: system-ui, sans-serif; max-width: 800px; margin: 2rem auto; padding: 0 1rem; }
    h1 { border-bottom: 2px solid #333; padding-bottom: 0.5rem; }
    ul { list-style: none; padding: 0; }
    li { margin: 1rem 0; }
    a { color: #0066cc; text-decoration: none; font-size: 1.2rem; }
    a:hover { text-decoration: underline; }
  </style>
</head>
<body>
  <h1>📽️ zhixian slides</h1>
  <ul>
EOF

for deck in dist/*/; do
  name=$(basename "$deck")
  echo "    <li><a href=\"/$name/\">$name</a></li>" >> dist/index.html
done

cat >> dist/index.html << 'EOF'
  </ul>
  <p><a href="https://zhixian.site">← Back to blog</a></p>
</body>
</html>
EOF

echo "Done! Output in dist/"
