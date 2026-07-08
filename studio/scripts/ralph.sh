#!/usr/bin/env bash
# Ralph loop: reinvoca o Claude Code headless ate esvaziar a fila ou MAX_ITER.
set -euo pipefail
cd "$(dirname "$0")/.."
MAX_ITER="${MAX_ITER:-10}"; SLEEP="${SLEEP:-5}"
LOCK=estado/.lock
if ! mkdir "$LOCK" 2>/dev/null; then echo "Ja em execucao ($LOCK)"; exit 0; fi
trap 'rmdir "$LOCK"' EXIT
for i in $(seq 1 "$MAX_ITER"); do
  echo "=== Ralph iteracao $i/$MAX_ITER $(date -Is) ==="
  OUT=$(claude -p "$(cat scripts/PROMPT.md)" --output-format text 2>&1 | tee -a estado/ralph.log) || true
  if echo "$OUT" | grep -q "SEM_TRABALHO"; then echo "Fila vazia. Encerrando."; break; fi
  sleep "$SLEEP"
done
