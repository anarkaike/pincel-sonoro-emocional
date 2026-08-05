# pincel-sonoro-emocional — Claude Code Instructions

Ferramenta de áudio/música do ecossistema Servinder/EstampArtIA.

## Fluxo Git — TRUNK-BASED (obrigatório)

Este repo é **trunk-based**. Trunk = `master`.

- Commit **direto no `master`** — sem feature branch, sem PR interno.
- **Sempre `git pull --rebase` antes** de começar e **`git push` ao terminar**.
- Trunk sempre verde; commits pequenos e frequentes.

Política canônica do ecossistema: `../GIT-WORKFLOW.md`.
## Git — trunk-based (política do workspace)

Este repositório é **trunk-based**: commit **direto** na branch padrão
(`master`/`main`), sem branch de feature/entrega e sem PR obrigatório. Sempre
`git pull --rebase` antes de começar e `git push` ao terminar; nunca deixe a
working tree suja "pra depois". O hook `pre-commit` em `.githooks/` recusa commit
fora da branch padrão (override consciente: `TRUNK_HOOK_SKIP=1`); ele é ativado
por `git config core.hooksPath .githooks`.

Política canônica: `IA_Central/CLAUDE.md` → *Fluxo Git* e
`BotHub/docs/RUNBOOK.md` → *Modelo de branches — trunk-based*. Exceção git flow
do workspace: `servinder-artes`/`estampartia`.

## Nenhuma descoberta sem destino

Princípio raiz em `IA_Central/CLAUDE.md` → *Nenhuma descoberta sem destino*. Este repo
**não tem** sistema de task/backlog próprio — só skill files e scripts. Mecanismo aqui:

1. **Busque antes de abrir:** `gh issue list --repo anarkaike/pincel-sonoro-emocional --search "<termo>"` (remote confirmado: `git@github.com:anarkaike/pincel-sonoro-emocional.git`).
2. **Não achou → abra:** `gh issue create --repo anarkaike/pincel-sonoro-emocional --title "..." --body "..."` com Definition of Done verificável — nunca um `TODO` solto no código.
3. **Cedo demais até para virar issue?** Só fica de fora com **confirmação explícita do dev na mesma sessão** — nunca decisão unilateral do agente.

Texto solto no chat relatando um achado não é destino.
