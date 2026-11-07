# momo-standards

momojs 各项目共用的协作与写作规范，同时以 Agent Skill 的形式提供给 AI 协作者。

本仓库只收录跨项目通用的约定。某个项目专属的约定（包职责、依赖方向、构建命令等）写在该项目自己的 `AGENTS.md` 中。

## 目录

| 规范 | 路径 | Skill 名称 | 状态 |
| --- | --- | --- | --- |
| 简体中文写作规范 | [`skills/zh-cn-writing/`](skills/zh-cn-writing/) | `zh-cn-writing` | 初稿 |

计划收录 Git 工作流、Commit Message、命名和国际化规范。

每个规范是 `skills/` 下的一个 Skill 目录，目录名与 Skill 名称相同，包含以下内容：

- `SKILL.md`：精简规则，面向 Agent，只保留可执行的规则和正反例。
- `references/README.md`：完整规范，面向人，包含理由、示例和常见问题。
- `assets/`：工具配置。能由工具检查的规则交给工具，例如 `.autocorrectrc`、`.markdownlint.jsonc`。

## 安装 Skill

### Claude Code

本仓库是一个 Claude Code 插件市场（plugin marketplace）。在 Claude Code 中运行：

```text
/plugin marketplace add momojs/momo-standards
/plugin install momo-standards@momo-standards
```

安装后，Skill 以插件名为前缀，例如 `/momo-standards:zh-cn-writing`。

插件市场默认不自动更新。运行 `/plugin marketplace update momo-standards` 手动更新，或在 `/plugin` 的 Marketplaces 页面开启自动更新。

仓库为私有时，Claude Code 通过本机 git 凭据拉取，且不会弹出交互式登录：

- 使用 SSH：确保密钥已加入 ssh-agent，`ssh -T git@github.com` 无需输入密码即可通过。
- 使用 HTTPS：运行 `gh auth login` 和 `gh auth setup-git` 配置凭据，并设置 `CLAUDE_CODE_PLUGIN_PREFER_HTTPS=1` 跳过 SSH 探测。

### 其他 Agent

使用 [skills](https://github.com/vercel-labs/skills) CLI 安装到 Codex、Cursor 等 Agent：

```bash
npx skills add momojs/momo-standards
```

也可以克隆仓库后运行安装脚本。脚本把每个包含 `SKILL.md` 的目录软链接到 `~/.claude/skills/<skill 名称>`：

```bash
git clone https://github.com/momojs/momo-standards.git ~/momo-standards
~/momo-standards/install.sh
```

软链接指向本地仓库，执行 `git pull` 即可更新，无需重新安装。如需安装到其他目录，设置 `SKILLS_DIR` 环境变量：

```bash
SKILLS_DIR=~/.codex/skills ~/momo-standards/install.sh
```

## 在项目中声明

在项目的 `AGENTS.md` 中注明适用的规范，方便协作者查阅：

```markdown
- 简体中文文档遵循 [zh-cn-writing](https://github.com/momojs/momo-standards/tree/main/skills/zh-cn-writing) 规范。
```

## 工具检查

在项目中使用本仓库的工具配置：

```bash
npx autocorrect-node --lint --config ~/momo-standards/skills/zh-cn-writing/assets/.autocorrectrc .
npx markdownlint-cli2 --config ~/momo-standards/skills/zh-cn-writing/assets/.markdownlint.jsonc "**/*.md"
```

## 许可证

本仓库以 [MIT](LICENSE) 许可证发布。

简体中文写作规范修订自 [ruanyf/document-style-guide](https://github.com/ruanyf/document-style-guide)，原作品属于公共领域（public domain）。
