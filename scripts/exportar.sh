#!/usr/bin/env bash
# Exporta o método (skill-core/) para outra plataforma de IA.
# Fonte da verdade: skill-core/ — este script só monta pacotes, nunca edita conteúdo.
#
# Uso:
#   scripts/exportar.sh claude-skill                  # gera claude/pincel-sonoro-emocional.skill (zip p/ app Claude)
#   scripts/exportar.sh <provedor> <repo-destino>     # instala adaptador + skill-core num repo
#     provedores: cursor | windsurf | trae | devin | codex-cli | gemini-cli | copilot | universal
#   scripts/exportar.sh gem <pasta-destino>           # monta pacote p/ Gemini Gem (upload manual)
#   scripts/exportar.sh custom-gpt <pasta-destino>    # monta pacote p/ ChatGPT Custom GPT (upload manual)
set -euo pipefail
cd "$(dirname "$0")/.."
NOME="pincel-sonoro-emocional"
ALVO="${1:?informe o alvo (claude-skill | cursor | windsurf | trae | devin | codex-cli | gemini-cli | copilot | universal | gem | custom-gpt)}"
DEST="${2:-}"

copia_core() { rsync -a --delete skill-core/ "$1/skill-core/"; }

case "$ALVO" in
  claude-skill)
    TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
    cp -R skill-core "$TMP/$NOME"
    (cd "$TMP" && zip -qr "$NOME.skill" "$NOME")
    mv "$TMP/$NOME.skill" "claude/$NOME.skill"
    echo "gerado: claude/$NOME.skill (instale pelo app Claude ou descompacte em ~/.claude/skills/)";;
  cursor)     : "${DEST:?informe o repo destino}"; copia_core "$DEST"; rsync -a cursor/.cursor "$DEST/";;
  windsurf)   : "${DEST:?informe o repo destino}"; copia_core "$DEST"; rsync -a windsurf/.windsurf "$DEST/";;
  trae)       : "${DEST:?informe o repo destino}"; copia_core "$DEST"; rsync -a trae/.trae "$DEST/";;
  copilot)    : "${DEST:?informe o repo destino}"; copia_core "$DEST"; rsync -a github-copilot/.github "$DEST/";;
  codex-cli)  : "${DEST:?informe o repo destino}"; copia_core "$DEST"; cp openai/codex-cli/AGENTS.md "$DEST/";;
  gemini-cli) : "${DEST:?informe o repo destino}"; copia_core "$DEST"; cp gemini/gemini-cli/GEMINI.md "$DEST/";;
  devin|universal) : "${DEST:?informe o repo destino}"; copia_core "$DEST"; cp universal/AGENTS.md "$DEST/";;
  gem)        : "${DEST:?informe a pasta destino}"; mkdir -p "$DEST"; rsync -a gemini/gem/ "$DEST/";;
  custom-gpt) : "${DEST:?informe a pasta destino}"; mkdir -p "$DEST"; rsync -a openai/custom-gpt/ "$DEST/";;
  *) echo "alvo desconhecido: $ALVO" >&2; exit 1;;
esac
echo "ok."
