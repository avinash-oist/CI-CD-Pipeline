---
# .github/instructions/ai-workflow.instructions.md
# ============================================================
# TOPIC: AI tooling workflow for this project
# TOGGLE: Always enabled
# ============================================================
applyTo: "**"
---

# AI Workflow Instructions

## How to Use AI Effectively in This Project

### Use AI for Learning, Not Just Output
The goal is UNDERSTANDING. Always ask AI to explain:
- "Why is this the best approach?"
- "What are the alternatives?"
- "What could go wrong here?"
- "What should I learn next?"

### Prompt Engineering Tips for This Stack

#### For Terraform questions, include:
- Current `terraform plan` output (if relevant)
- The error message in full
- What you expected vs what happened

#### For AWS questions, include:
- Region you're working in
- Error from AWS Console or CLI
- What the resource is supposed to do

#### For Jenkins questions, include:
- The stage that failed
- Full console output of the failed build
- Jenkinsfile snippet

## AI Files in This Repository

| File | Purpose | Committed? | Read By |
|------|---------|-----------|---------|
| `CLAUDE.md` | Full project context, learning goals | ✅ Yes | Copilot CLI, Claude CLI |
| `AGENTS.md` | Agent behaviour rules | ✅ Yes | Copilot CLI, Codex |
| `.github/copilot-instructions.md` | Copilot-specific rules | ✅ Yes | Copilot CLI, VS Code Copilot |
| `.github/instructions/*.instructions.md` | Topic-specific rules | ✅ Yes | Copilot CLI |
| `~/.copilot/copilot-instructions.md` | Personal global rules | ❌ Never | Copilot CLI only |

## When to Use MCP (Model Context Protocol)

MCP extends Copilot CLI with extra tools. Current MCP servers configured:

| MCP Server | When to Use |
|-----------|------------|
| `playwright` | When you need AI to interact with a web UI (e.g., check Jenkins UI) |
| `github` (built-in) | Always active — issues, PRs, repos |

**When to add more MCP servers:**
- `aws-mcp` — when you want AI to query real AWS resources
- `terraform-mcp` — when you want AI to understand your Terraform state
- `kubernetes-mcp` — when you add K8s later

**Add MCP servers via:** `~/.copilot/mcp-config.json`

## When to Use Skills vs Instructions vs MCP

| Feature | What it is | When to use |
|---------|-----------|------------|
| **Instructions** (*.instructions.md) | Static context/rules loaded into AI context | Project-specific rules, style guides, patterns |
| **Skills** (`/skills`) | Reusable action sequences the AI can invoke | Repetitive multi-step tasks (e.g., "deploy to staging") |
| **MCP** (`/mcp`) | External tools that extend what AI can DO | When AI needs to query/interact with external systems |
| **Agents** (`/agent`) | Specialized AI sub-agents | Complex domain-specific tasks |

## Useful Copilot CLI Commands to Know

```
/instructions   — toggle which instruction files are active
/skills         — see available skills
/mcp            — manage MCP server connections
/diff           — review changes you've made
/init           — initialize/regenerate repo instructions
/context        — see how much context window is used
/env            — see what instructions/MCP/skills are loaded
/plan           — create an implementation plan before coding
```
