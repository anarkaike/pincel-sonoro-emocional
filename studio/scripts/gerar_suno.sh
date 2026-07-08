#!/usr/bin/env bash
# Adaptador OPCIONAL para API do Suno (nao-oficial, a sua escolha).
# Uso: ./scripts/gerar_suno.sh <obra_id> <style_file> <lyrics_file> <exclude_file> <n_variacoes>
# Requer: SUNO_API_URL e SUNO_API_KEY no ambiente. Sem eles, sai com codigo 2
# e o Maestro cai no modo manual-assistido (pronto-para-colar.md).
set -euo pipefail
[ -z "${SUNO_API_URL:-}" ] && { echo "SUNO_API_URL ausente -> modo manual"; exit 2; }
ID="$1"; STYLE="$(cat "$2")"; LYRICS="$(cat "$3")"; EXCLUDE="$(cat "$4")"; N="${5:-3}"
mkdir -p "obras/$ID/geracoes"
for i in $(seq 1 "$N"); do
  curl -sS -X POST "$SUNO_API_URL/generate" \
    -H "Authorization: Bearer $SUNO_API_KEY" -H "Content-Type: application/json" \
    -d "$(jq -n --arg s "$STYLE" --arg l "$LYRICS" --arg e "$EXCLUDE" \
        '{custom_mode:true, style:$s, prompt:$l, negative_tags:$e, model:"v5.5"}')" \
    > "obras/$ID/geracoes/resp_$i.json"
  echo "variacao $i solicitada"
done
echo "Ajuste os campos do payload conforme a API que voce usa." >&2
