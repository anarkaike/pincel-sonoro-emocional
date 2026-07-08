#!/usr/bin/env bash
# Wrapper para crontab: UMA iteracao, com trava. Ordens com campo "programacao"
# devem ser agendadas no crontab apontando para este script.
set -euo pipefail
cd "$(dirname "$0")/.."
LOCK=estado/.lock
if ! mkdir "$LOCK" 2>/dev/null; then echo "Ocupado; pulando disparo."; exit 0; fi
trap 'rmdir "$LOCK"' EXIT
claude -p "$(cat scripts/PROMPT.md)" --output-format text >> estado/cron-exec.log 2>&1 || true
echo "$(date -Is) iteracao concluida" >> estado/ultima_execucao.txt
