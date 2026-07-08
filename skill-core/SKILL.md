---
name: suno-maestro
description: Sistema modular de linhas criativas para gerar músicas de altíssima qualidade no Suno (v5.5+). Use SEMPRE que o usuário pedir para criar, compor, adaptar ou melhorar música, jingle, hino, trilha, música terapêutica, convite musical, álbum ou letra para IA de música — mesmo sem citar "Suno". Também para revisar prompts ruins (pronúncia, corte, refrão robótico), organizar linhas criativas, mesclar perfis criativos ou criar novas linhas.
---

# Suno Maestro v2 — Linhas Criativas

Música aqui não nasce de prompt: nasce de uma **linha criativa** — uma filosofia de trabalho com domínios próprios. Este sistema é modular e extensível: linhas podem ser usadas puras, **mescladas (2-3 por vez)** ou criadas do zero.

## Como operar

1. **Identifique a intenção** do pedido (presente pessoal? campanha? experimento? lote?).
2. **Escolha a linha** (ou mescla). Se o usuário não indicar: default = **Pincel Emocional**. Se ele nomear uma linha ou mescla salva, carregue-a de `profiles/` e `blends.md`.
3. **Leia o(s) arquivo(s) de perfil** em `profiles/` antes de compor — cada um define filosofia, processo e técnicas.
4. **Execute honrando os domínios** (ver Regras de Mescla).
5. Ao final, se o processo revelou um jeito novo que funcionou, **ofereça registrar** como nova linha (use `profiles/_template.md`) ou nova mescla em `blends.md`.

## As linhas disponíveis

| Linha | Alma | Domínio forte |
|---|---|---|
| `pincel-emocional` | Contexto vira massa emocional; exploração sensorial por variação | Letra, paisagem emocional, iteração intuitiva |
| `antropologo` | Pesquisar o público antes de compor; a chave cultural | Pesquisa, chave emocional do público, léxico |
| `cientista` | Cada geração é experimento versionado; 1 variável por vez | Iteração disciplinada, registro, debug |
| `seta` | Direção, não mapa; cortar até sobrar o essencial | Escrita do Style, anti-empilhamento |
| `diretor` | Brief de engenheiro de mixagem; ouvido de produtor | Vocal, mix, produção física, plataforma-alvo |
| `sistematizador` | Gramática fina das tags; estrutura como engenharia | Sintaxe de metatags, arquitetura da letra |
| `engenheiro` | Música como infraestrutura: API, lote, automação | Pipeline, batch, distribuição, rádio/stream |
| `tecelao` 🔍 | Duplos/triplos sentidos; metáfora que invoca vivência | Polissemia, subtexto, camadas de leitura |
| `xama` 🔍 | Despertar de consciência; viradas de chave sutis | Estado interno: respiração, silêncio, arrepio, pergunta |

🔍 = **linhas-lente (vestíveis)**: não conduzem — vestem-se sobre qualquer mescla como camada final (ex.: `Linha Cura + tecelao + xama`). Lentes passam DEPOIS da condutora e refinam letra, tags e style sem mudar o rumo.

## Regras de Mescla

- Mesclar = declarar 2-3 linhas em ordem. **Cada linha governa seu domínio forte**; nos conflitos, **a primeira declarada decide**.
- Exemplo: `Pincel Emocional + Cientista + Seta` → Pincel conduz letra e emoção; Cientista conduz o ciclo de variações e o registro; Seta poda o Style.
- Mesclas nomeadas ficam salvas em `blends.md` (leia-o quando o usuário citar uma mescla pelo nome ou pedir sugestão de combinação).

## Constantes técnicas (valem para TODAS as linhas)

- Custom Mode sempre. Style ≤1000 chars (idioma declarado: `sung in...`), Lyrics ≤5000, Exclude no campo próprio.
- Weirdness 30-45%, Style Influence 70-85% como ponto de partida (linhas podem ajustar).
- Mínimo 3 gerações antes de alterar o prompt; curadoria antes de edição.
- Nome próprio/marca: linha curta repetida no refrão. Marca sutil: `[Whispered] Marca` no outro.
- Referências técnicas: `references/metatags.md` (tags + gramática avançada), `references/v55-features.md` (Voices, Custom Models, My Taste, sliders, editor), `references/multilingual.md` (idiomas e adaptação cultural), `references/style-library.md` (receitas prontas).

## Contexto do projeto (o porquê)

Para entender o negócio, a jornada e as decisões por trás deste método — inclusive antes de propor mudanças — leia `docs/` (HISTORIA, NEGOCIO, GLOSSARIO, ARQUITETURA, PRIVACIDADE). Regra: docs explicam o PORQUÊ; este arquivo, o COMO.

## Criando novas linhas

Copie `profiles/_template.md`, preencha os 6 blocos (Alma, Quando usar, Domínios, Processo, Técnicas-assinatura, O que trago numa mescla) e salve como `profiles/nome-da-linha.md`. Anuncie a nova linha ao usuário e pergunte se deseja registrá-la em alguma mescla.

## Postura

Espelho honesto antes de compor: se a premissa estratégica do pedido estiver errada, corrija com carinho primeiro. Música é meio; a intenção do usuário é o fim.
