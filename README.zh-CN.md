<div align="center">
  <h1><strong>Study Anything</strong></h1>
  <p><strong>一个帮助学习者建立可迁移、可长期保留理解的通用学习教练 Skill。</strong></p>
  <p>
    <a href="./README.md">English</a> · <strong>简体中文</strong>
  </p>
  <p>
    <img alt="版本 0.1.1" src="https://img.shields.io/badge/version-0.1.1-0f766e?style=flat-square">
    <img alt="MIT 许可证" src="https://img.shields.io/badge/license-MIT-2563eb?style=flat-square">
    <img alt="Skill 压缩包" src="https://img.shields.io/badge/package-skill.zip-334155?style=flat-square">
    <img alt="可复现 SHA-256" src="https://img.shields.io/badge/SHA--256-reproducible-7c3aed?style=flat-square">
  </p>
</div>

`study-anything` 帮助 Agent 引导学习者从陌生概念走向可迁移的真实理解。它将学习校准、主动回忆、具体解释、引导练习和复习整合为一个自包含的 Skill 包。

它不绑定具体产品、模型提供商、数据库或部署环境，可以直接用于普通对话，也可以接入带状态管理的宿主应用。

## 简要信息

| 项目 | 说明 |
| --- | --- |
| 包标识 | `study-anything` |
| 版本 | `0.1.1` |
| 完整指令 | `SKILL.md` |
| 精简运行时 | `runtime.md` |
| 使用模式 | 普通对话、结构化 JSON |
| 公开协议 | `study_context_v1` → `study_decision_v1` |
| 发布产物 | `dist/study-anything.skill.zip` |
| 开源许可证 | MIT |

## 一句话安装

在 **Codex**、**Claude Code**、**Trae**、**WorkBuddy** 或 **OpenCode** 中，直接告诉你的 Agent：

> 安装 `github.com/konglong87/study-anything`

推荐使用下面这句完整口令，安装后会自动确认结果：

```text
安装 github.com/konglong87/study-anything 作为本地 Skill。完成后读取 SKILL.md，
并告诉我安装路径和校验结果。
```

Agent 需要能够访问 GitHub，并拥有写入本地 Skill 目录的权限。如果当前客户端不支持自动安装，可以下载 `dist/study-anything.skill.zip` 后通过客户端的 Skill 管理器导入，或者将仓库克隆到该客户端的本地 Skill 目录。

## 它解决什么问题

- 在制定学习计划前，先校准目标、当前水平、约束和熟悉领域。
- 只有学习者确认参照领域后才使用类比，并明确类比的适用边界。
- 生成范围清晰的小型学习计划，避免一次铺开过大的课程体系。
- 保护复习环节，优先使用主动回忆，而不是连续灌输解释。
- 通过苏格拉底式提问和费曼复述检查知识能否迁移。
- 每轮回复都给出明确的下一步动作，避免学习者不知道如何继续。

## 学习流程

| 阶段 | 目标 |
| --- | --- |
| 1. 校准 | 理解学习目标、当前水平、现实约束和可用的熟悉领域。 |
| 2. 规划 | 生成规模适中、单元目标明确的学习路径。 |
| 3. 练习 | 引导学习者预测、比较、回忆、解释和应用。 |
| 4. 复习 | 用简短、针对性的主动回忆重新激活旧知识。 |
| 5. 迁移 | 通过费曼复述和新例子验证理解，而不是只检查原句记忆。 |

## 快速开始

将本仓库放入 Agent 使用的 Skill 目录，或者让运行时直接加载 `SKILL.md`。

```text
study-anything/
├── SKILL.md
├── runtime.md
├── package.yaml
└── examples/
```

普通学习对话只需要加载 `SKILL.md`，不要求提供任何特定应用的数据结构。

## 结构化接入

宿主应用可以加载精简的 `runtime.md`，并传入 `study_context_v1`。Skill 返回一个 `study_decision_v1` 对象，其中包含面向学习者的回复、建议的状态变化，以及可选且有边界的类比记录。

完整协议见 [docs/runtime-contract.md](docs/runtime-contract.md)。数据持久化、权限控制和最终校验仍由宿主应用负责。

## 构建与校验

本地需要安装：`bash`、`jq`、`zip`、`shasum`、`awk`、`find`、`sort` 和 `touch`。

```bash
./scripts/validate-package.sh
./scripts/build-zip.sh
```

构建产物：

```text
dist/study-anything.skill.zip
dist/study-anything.skill.zip.sha256
```

构建过程使用排序后的文件列表和固定时间戳，因此相同源码会生成相同的 SHA-256。

## 仓库结构

```text
SKILL.md                          完整 Skill 指令
runtime.md                        精简结构化运行时
package.yaml                      Skill 包清单
README.md                         English documentation
docs/runtime-contract.md          结构化输入输出协议
docs/package-notes.md             打包说明与边界
examples/                         结构化模式示例
scripts/                          校验和可复现构建工具
dist/                             可直接发布的压缩包和校验文件
```

## 设计原则

学习者需要真正参与思考。当一个简短问题、比较、预测或微任务能更快暴露理解程度时，就不应使用冗长讲解。熟悉领域类比是可选能力，并且必须说明边界；没有合适参照时，默认使用具体例子。

## 开源许可证

本项目使用 [MIT License](LICENSE)。
