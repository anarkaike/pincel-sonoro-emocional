# Estúdio Pincel Sonoro — Estúdio de produção musical com agentes

Equipe de agentes (Maestro, Letrista-Pincel, Cronista-Cientista) + linhas criativas (skill pincel-sonoro-emocional v2) + governança configurável + memória com retrospectiva. Tudo é arquivo em git: funciona igual no seu computador, em cron, em Ralph loop e na nuvem.

## Rodar em cada ambiente

**Local (interativo):** `claude` na raiz → `/produzir fila/exemplo-001-radio-servinder.yaml`

**Cron local (produções programadas):**
```
crontab -e
0 6 * * * cd /caminho/studio && ./scripts/cron-produzir.sh >> estado/cron.log 2>&1
```
Cada disparo processa UMA ordem pendente da fila (com trava anti-sobreposição) e para nos portões de governança.

**Ralph loop (varrer a fila até esvaziar):** `./scripts/ralph.sh` — reinvoca o Claude Code em modo headless, uma ordem por iteração, commit a cada passo, para quando não há trabalho ou ao atingir MAX_ITER.

**GitHub Actions (cloud):** configure o secret `ANTHROPIC_API_KEY` (ou `CLAUDE_CODE_OAUTH_TOKEN`). Workflows inclusos: `producao-agendada.yml` (cron diário + botão manual) e `retrospectiva-semanal.yml`. Aprovações viram arquivos em `aprovacoes/pendentes/` commitados — você aprova editando o arquivo ou rodando `/aprovar <id>` em qualquer ambiente.

**Devin / Trae / outros agentes cloud:** aponte o agente para este repositório; `AGENTS.md` contém as instruções universais. A tarefa padrão é: "execute scripts/PROMPT.md".

## Fluxo de uma ordem
`fila/*.yaml (pendente)` → Maestro lê governança e brief → Letrista-Pincel (letra) → prompt-pacote (skill pincel-sonoro-emocional) → geração (API via `scripts/gerar_suno.sh` se configurada; senão gera pacote pronto-para-colar e status `aguardando_geracao_manual`) → curadoria → **portão de governança** (`aprovacoes/pendentes/`) → publicação → Cronista registra no diário.

## Segredos/variáveis (opcionais para API do Suno)
`SUNO_API_URL`, `SUNO_API_KEY` — sem eles, o estúdio opera em modo manual-assistido (100% funcional).
