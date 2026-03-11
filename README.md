# zhixian-slides

技术分享 slides 合集，使用 [Slidev](https://sli.dev) 构建。

## 本地开发

```bash
npm install
npm run dev
```

访问 http://localhost:3030

## 构建

```bash
npm run build    # 构建静态站点到 dist/
npm run export   # 导出 PDF
```

## 部署

推送到 `main` 分支后自动部署到 Cloudflare Pages。

### 首次配置

1. 在 Cloudflare Pages 创建项目 `zhixian-slides`
2. 在 GitHub repo 添加 Secrets：
   - `CF_API_TOKEN`: Cloudflare API Token (需要 Pages 权限)
   - `CF_ACCOUNT_ID`: Cloudflare Account ID
3. 绑定自定义域名 `slides.zhixian.io`

## 添加新 slides

编辑 `slides.md` 或创建新的 `.md` 文件。

语法参考: https://sli.dev/guide/syntax
