#!/usr/bin/env bash
# Exporta o método (skill-core/) para outra plataforma de IA.
# Fonte da verdade: skill-core/ — este script só monta pacotes, nunca edita conteúdo.
#
# Uso:
#   scripts/exportar.sh refresh                       # regenera artefatos derivados no próprio repo (.skill + knowledge-files)
#   scripts/exportar.sh claude-skill                  # gera claude/pincel-sonoro-emocional.skill (zip p/ app Claude)
#   scripts/exportar.sh <provedor> <repo-destino>     # instala adaptador + skill-core num repo
#     provedores: cursor | windsurf | trae | devin | codex-cli | gemini-cli | copilot | universal
#   scripts/exportar.sh gem <pasta-destino>           # monta pacote p/ Gemini Gem (upload manual)
#   scripts/exportar.sh custom-gpt <pasta-destino>    # monta pacote p/ ChatGPT Custom GPT (upload manual)
set -euo pipefail
cd "$(dirname "$0")/.."
NOME="pincel-sonoro-emocional"
ALVO="${1:?informe o alvo (refresh | claude-skill | cursor | windsurf | trae | devin | codex-cli | gemini-cli | copilot | universal | gem | custom-gpt)}"
DEST="${2:-}"

copia_core() { rsync -a --delete skill-core/ "$1/skill-core/"; }

gera_skill_zip() {
  local tmp; tmp="$(mktemp -d)"
  cp -R skill-core "$tmp/$NOME"
  (cd "$tmp" && zip -qr "$NOME.skill" "$NOME")
  mv "$tmp/$NOME.skill" "claude/$NOME.skill"; rm -rf "$tmp"
  echo "gerado: claude/$NOME.skill"
}

# knowledge-files 01-08 derivam do skill-core; 09 (contexto/jornada) é curadoria manual e não é tocado
gera_knowledge() {
  for dir in gemini/gem/knowledge-files openai/custom-gpt/knowledge-files; do
    # 01 = SKILL.md sem a seção "Contexto do projeto" (o contexto vive no 09)
    awk '/^## Contexto do projeto/{skip=1} /^## Criando novas linhas/{skip=0} !skip' skill-core/SKILL.md > "$dir/01-nucleo-metodo.md"
    cat skill-core/profiles/pincel-emocional.md skill-core/profiles/antropologo.md skill-core/profiles/cientista.md \
        skill-core/profiles/seta.md skill-core/profiles/diretor.md skill-core/profiles/sistematizador.md \
        skill-core/profiles/engenheiro.md > "$dir/02-linhas-condutoras.md"
    cat skill-core/profiles/tecelao.md skill-core/profiles/xama.md > "$dir/03-linhas-lente.md"
    cp skill-core/blends.md                      "$dir/04-mesclas.md"
    cp skill-core/references/suno/metatags.md    "$dir/05-metatags.md"
    cat skill-core/references/multilingual.md skill-core/references/suno/idiomas.md \
      | sed '/\.\.\/multilingual\.md/d; /suno\/idiomas\.md/d' > "$dir/06-multilingual.md"   # remove ponteiros de caminho relativos, sem sentido fora do repo
    cp skill-core/references/suno/style-library.md "$dir/07-style-library.md"
    cp skill-core/references/suno/v55-features.md  "$dir/08-suno-v55.md"
  done
  echo "knowledge-files 01-08 regenerados (gem + custom-gpt)"
}

case "$ALVO" in
  refresh)      gera_skill_zip; gera_knowledge;;
  claude-skill) gera_skill_zip;;
  cursor)     : "${DEST:?informe o repo destino}"; copia_core "$DEST"; rsync -a cursor/.cursor "$DEST/";;
  windsurf)   : "${DEST:?informe o repo destino}"; copia_core "$DEST"; rsync -a windsurf/.windsurf "$DEST/";;
  trae)       : "${DEST:?informe o repo destino}"; copia_core "$DEST"; rsync -a trae/.trae "$DEST/";;
  copilot)    : "${DEST:?informe o repo destino}"; copia_core "$DEST"; rsync -a github-copilot/.github "$DEST/";;
  codex-cli)  : "${DEST:?informe o repo destino}"; copia_core "$DEST"; cp openai/codex-cli/AGENTS.md "$DEST/";;
  gemini-cli) : "${DEST:?informe o repo destino}"; copia_core "$DEST"; cp gemini/gemini-cli/GEMINI.md "$DEST/";;
  devin|universal) : "${DEST:?informe o repo destino}"; copia_core "$DEST"; cp universal/AGENTS.md "$DEST/";;
  gem)        : "${DEST:?informe a pasta destino}"; gera_knowledge; mkdir -p "$DEST"; rsync -a gemini/gem/ "$DEST/";;
  custom-gpt) : "${DEST:?informe a pasta destino}"; gera_knowledge; mkdir -p "$DEST"; rsync -a openai/custom-gpt/ "$DEST/";;
  *) echo "alvo desconhecido: $ALVO" >&2; exit 1;;
esac
echo "ok."
