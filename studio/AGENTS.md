# Instruções universais para agentes (Devin, Trae, Actions, Claude Code)

1. Leia `CLAUDE.md`, `governanca.yaml` e `.claude/agents/*.md` antes de agir.
2. Unidade de trabalho: UMA ordem de `fila/*.yaml` com `status: pendente` (a mais antiga). Sem ordens pendentes → escreva `SEM_TRABALHO` em `estado/ultima_execucao.txt` e encerre.
3. Siga o pipeline do agente Maestro. Nunca pule portões de governança: se o modo da ordem exigir aprovação humana, crie `aprovacoes/pendentes/<id>.md`, mude o status para `aguardando_aprovacao`, commite e ENCERRE a iteração.
4. Commit pequeno a cada etapa concluída, mensagem `studio(<id>): <etapa>`.
5. Linhas vermelhas de `governanca.yaml` param TUDO, em qualquer modo.
6. Publicação externa (SoundOn/DSP) exige aprovação humana registrada em `aprovacoes/aprovadas/`.
7. Aprendizado permanente só via retrospectiva (`.claude/commands/retro.md`) com sanção humana.
