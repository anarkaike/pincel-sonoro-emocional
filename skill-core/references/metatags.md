# Catálogo de metatags (Suno v5.5)

Tags vão na caixa de LETRA, entre colchetes, em inglês. São sinais fortes, não comandos absolutos — o modelo obedece melhor quando a tag combina com o Style.

## Estrutura
`[Intro]` `[Verse 1]` `[Verse 2]` `[Pre-Chorus]` `[Chorus]` `[Post-Chorus]` `[Bridge]` `[Interlude]` `[Break]` `[Build]` `[Climax]` `[Breath]` `[Final Chorus]` `[Coda]` `[Outro]` `[fade out]` `[Instrumental]`

Dica: seções instrumentais aceitam descrição dentro da tag:
`[Interlude — harp and flute weaving like sweet silent clouds]`

## Vozes
- Tipo: `[male vocal]` `[female vocal]` `[deep male vocal]` `[soft female vocal]` `[children's voices]` `[choir]` `[group chant]` `[duet]`
- Entrega: `[Whisper]` / `[Whispered]` `[Spoken Word]` `[almost whisper]` `[belting]` `[falsetto]` `[vocalise]` (melodia sem palavras)
- Direção emocional dentro da tag: `[Verse 1 — warm rustic male vocal, unhurried]` `[Chorus — male + female harmony, gently rising]`
- Alternância de vozes em duetos: tag antes de cada linha ou bloco.

## Dinâmica e andamento
Descreva na própria tag da seção: `slow` `rising` `building` `half-time` `stripped down` `full arrangement` `soaring` `celebratory` `intimate` `grounded` `unhurried`

## Efeitos sonoros e ambiências (funcionam bem no v5.5)
Natureza: `[birdsong]` `[birds chirping]` `[distant waterfall]` `[water flowing]` `[crickets]` `[night crickets]` `[wind]` `[mountain wind]` `[rain on a window]` `[distant lion roar]` (sons de animais específicos funcionam com moderação)
Humanos/objetos: `[laughter]` `[footsteps]` `[three wooden stage knocks]` `[heartbeat]` `[city traffic dissolving]` `[stone-chisel percussion]` (percussões "de objeto" descritas funcionam!)
Posicionamento estéreo (probabilístico, não determinístico): `[birdsong left]` `[waterfall right]` + `wide stereo field` no Style. Para pan cirúrgico, pós-produção.

## Truques avançados testados
- **Assinatura de marca**: `[Whispered] Nome da Marca` como última linha antes do fade.
- **Dedicatória**: `[Spoken Word — warm, personal] texto` no Outro.
- **Callback no Extend**: comece a extensão com `[Callback: same healing atmosphere, return to waterfall and flute]`.
- **"Silêncio preenchido"**: interlúdio com 2 instrumentos + descrição poética da textura.
- **Live feel**: palavra-chave `LIVE` no Style gera clima de apresentação ao vivo.
- **Sotaque**: declare no Style (`sung in Venezuelan Spanish`, `British English`), não na letra.

## Limites
- Style: 1000 caracteres. Lyrics: 5000 caracteres. Título: opcional mas recomendado.
- Não misture idiomas/alfabetos na MESMA linha (quebra a pronúncia). Seções inteiras em outro idioma são ok se claramente separadas.

## Gramática avançada (escola chinesa + hacks globais)
- **Tags globais herdáveis** no topo da letra: `[genre: progressive house]` `[mood: energetic, uplifting]` `[tempo: fast, 128bpm]` `[instruments: synth leads, warm bass]` — as seções herdam e sobrescrevem só o que declararem.
- **Tag com parâmetro exige dois-pontos na mesma linha**: `[tense development: the theme grows until a climactic counterpoint]`. Sem os dois-pontos, o texto é CANTADO como letra.
- **~3 palavras por metatag simples** (recomendação oficial); detalhe longo → dentro da tag com dois-pontos.
- **Anti-loop**: blocos 100% idênticos podem travar a geração em repetição; varie levemente refrões repetidos.
- **MAIÚSCULAS** em palavras-chave = ênfase mais forte (uso pontual).
- **Vocal anchor**: o caráter do cantor é decidido nos primeiros 1-2 segundos — coloque a definição vocal na primeira tag/linha cantada.
- **Instrumentos étnicos que falham**: renomeie descritivamente ("shakuhachi" → "Japanese bamboo flute"; "berimbau" → "Brazilian musical bow").
- **Estruturas de impacto**: `[Silence]` antes do clímax; `[Big Finish]`; formas clássicas (canon, passacaglia) como arquitetura experimental.
