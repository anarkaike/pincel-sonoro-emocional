# Pincel Sonoro Emocional — Pacote multiplataforma

**Arquitetura: um núcleo, muitos tradutores.** `skill-core/` é a fonte canônica (método completo: 9 linhas criativas, mesclas, referências). Cada pasta de provedor contém apenas o adaptador no dialeto daquela plataforma + COMO-INSTALAR.

| Provedor | Mecanismo | Pasta |
|---|---|---|
| Claude / Claude Code | Skill (.skill / pasta) | `claude/` |
| ChatGPT | Custom GPT ou Projeto (instruções + knowledge) | `openai/custom-gpt/` |
| OpenAI Codex CLI | AGENTS.md no repo | `openai/codex-cli/` |
| Gemini (app) | Gem (instruções + conhecimento) | `gemini/gem/` |
| Gemini CLI | GEMINI.md no repo | `gemini/gemini-cli/` |
| GitHub Copilot | .github/copilot-instructions.md | `github-copilot/` |
| Cursor | .cursor/rules/*.mdc | `cursor/` |
| Windsurf | .windsurf/rules/ | `windsurf/` |
| Trae | .trae/rules/project_rules.md | `trae/` |
| Devin | Knowledge ou AGENTS.md | `devin/` |
| Qualquer outro agente | AGENTS.md universal | `universal/` |

Regra dos adaptadores de repositório: sempre copie TAMBÉM a pasta `skill-core/` para a raiz do projeto — os adaptadores apontam para ela.
Nota honesta: a experiência completa (subagentes, comandos, memória do Estúdio) é exclusiva do Claude Code; nas demais plataformas a skill opera como método + base de conhecimento.
Manutenção: edite apenas `skill-core/`; depois rode `scripts/exportar.sh refresh` para regenerar os artefatos derivados (`.skill` + knowledge-files 01-08 do Gem/Custom GPT — o 09 é curadoria manual). `scripts/exportar.sh <alvo> [destino]` monta pacote para qualquer plataforma.

**Estrutura agnóstica de plataforma (ADR-11):** o método (linhas, mesclas, lentes, `references/multilingual.md`) não depende do gerador. O conhecimento específico do Suno vive em `references/suno/`; outro provedor (Udio, ElevenLabs Music...) = nova pasta `references/<provedor>/`, método intocado.

## `studio/` — Estúdio Pincel Sonoro (a "gravadora de agentes")
Workspace operacional que USA a skill: agentes (Maestro, Letrista-Pincel, Cronista-Cientista), fila de ordens YAML (`fila/`), governança (`governanca.yaml`: modos por_faixa/por_lote/por_excecao, linhas vermelhas, portões inalienáveis), execução via cron, Ralph loop e GitHub Actions. Consome a skill por **symlink relativo** (`studio/.claude/skills/pincel-sonoro-emocional → ../../../skill-core`) — sem cópia, sem drift (ADR-12). Operar: `claude` dentro de `studio/` → `/produzir fila/<ordem>.yaml`.

## Instalação viva neste Mac (symlinks — editar aqui = skill em uso atualizada)
Este repo é a fonte da verdade; as instalações locais são symlinks para `skill-core/`:
- App Claude (agent mode): `~/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin/92ba84f0-…/bf594650-…/skills/pincel-sonoro-emocional`
- Claude Code CLI: `~/.claude/skills/pincel-sonoro-emocional`

Se o app Claude recriar o diretório numa atualização (quebrando o symlink), basta refazê-lo
apontando para `skill-core/` — todo o conteúdo vive neste repo git.

## Contexto para agentes (leitura recomendada antes de operar)
Todo o PORQUÊ do projeto vive em `skill-core/docs/`: **HISTORIA.md** (a jornada que gerou o método — do tarô às lentes), **NEGOCIO.md** (Servinder Artes: missão, modelo, estratégia, princípios), **GLOSSARIO.md** (vocabulário próprio), **ARQUITETURA.md** (decisões de design em mini-ADRs) e **PRIVACIDADE.md** (o que deliberadamente não está aqui e as regras ao lidar com dados de pessoas). Agentes que forem propor mudanças devem ler ARQUITETURA.md primeiro; agentes que forem compor devem honrar PRIVACIDADE.md sempre.
