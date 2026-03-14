#!/bin/bash
set -e

rm -rf dist
mkdir -p dist

# 构建每个 deck
for deck in decks/*/; do
  name=$(basename "$deck")
  # 创建 public symlink，让 slidev 能访问共享资源
  if [[ ! -L "$deck/public" ]]; then
    ln -sf "../../public" "$deck/public"
  fi
  echo "Building $name..."
  npx slidev build "$deck/slides.md" --base "/$name/" --out "../../dist/$name"
done

# 生成首页
echo "Generating index..."
cat > dist/index.html << 'HEADER'
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>zhixian slides</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: system-ui, -apple-system, sans-serif;
      background: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 100%);
      color: #e0e0e0;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 4rem 2rem;
    }
    .container { max-width: 700px; width: 100%; }
    header { text-align: center; margin-bottom: 3rem; }
    .logo { font-size: 4rem; margin-bottom: 1rem; filter: drop-shadow(0 0 20px rgba(88, 166, 255, 0.3)); }
    h1 {
      font-size: 2.5rem; font-weight: 700;
      background: linear-gradient(90deg, #58a6ff, #a78bfa);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }
    .subtitle { color: #888; margin-top: 0.5rem; font-size: 1.1rem; }
    .decks { list-style: none; display: flex; flex-direction: column; gap: 1rem; }
    .deck-card {
      background: rgba(255, 255, 255, 0.03);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 12px; padding: 1.5rem;
      transition: all 0.3s ease; position: relative; overflow: hidden;
    }
    .deck-card::before {
      content: ''; position: absolute; top: 0; left: 0; right: 0; height: 2px;
      background: linear-gradient(90deg, #58a6ff, #a78bfa); opacity: 0; transition: opacity 0.3s;
    }
    .deck-card:hover {
      border-color: rgba(88, 166, 255, 0.3); transform: translateY(-2px);
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
    }
    .deck-card:hover::before { opacity: 1; }
    .deck-card a {
      color: #fff; text-decoration: none; font-size: 1.3rem; font-weight: 600;
      display: flex; align-items: center; gap: 0.75rem;
    }
    .deck-card .icon { font-size: 1.5rem; }
    .deck-card .arrow {
      margin-left: auto; color: #58a6ff; opacity: 0;
      transform: translateX(-10px); transition: all 0.3s;
    }
    .deck-card:hover .arrow { opacity: 1; transform: translateX(0); }
    footer { margin-top: 4rem; text-align: center; color: #666; }
    footer a { color: #888; text-decoration: none; margin: 0 0.75rem; transition: color 0.2s; }
    footer a:hover { color: #58a6ff; }
    .divider { color: #444; }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <div class="logo">📽️</div>
      <h1>zhixian slides</h1>
      <p class="subtitle">技术分享 slides 合集</p>
    </header>
    <ul class="decks">
HEADER

# 添加每个 deck
for deck in dist/*/; do
  name=$(basename "$deck")
  echo "      <li class=\"deck-card\"><a href=\"/$name/\"><span class=\"icon\">🎯</span><span>$name</span><span class=\"arrow\">→</span></a></li>" >> dist/index.html
done

cat >> dist/index.html << 'FOOTER'
    </ul>
    <footer>
      <a href="https://zhixian.io">Blog</a>
      <span class="divider">·</span>
      <a href="https://github.com/zhixianio">GitHub</a>
      <span class="divider">·</span>
      <a href="https://x.com/zhixianio">X</a>
    </footer>
  </div>
</body>
</html>
FOOTER

echo "Done! Output in dist/"
