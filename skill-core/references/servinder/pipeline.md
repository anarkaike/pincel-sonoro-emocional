# Pipeline Servinder — do prompt-pacote aprovado à música tocável

Como um agente (Claude Code ou outro) transforma uma obra composta por este método em áudio gerado, usando a plataforma Servinder Artes. Pré-requisito: CLI `servinder` autenticado (`~/.servinder/config.json`, perfil com token).

## 1. O prompt-pacote (`pacote.json`)

A composição termina num arquivo único que o humano aprova ANTES de qualquer geração (portão inalienável: veredito emocional humano).

```jsonc
{
  "version": 1,
  "prompt": "conceito curto da música",            // obrigatório
  "title": "Título da Obra",                        // obrigatório
  "style": "Style ≤1000 chars (sung in...)",        // obrigatório — hoje a API aceita ≤500; peça poda à linha seta
  "lyrics": "letra ≤5000 com metatags",             // obrigatório (exceto instrumental)
  "provider": "suno",                               // suno | mureka
  "model": "V5_5",
  "exclude": ["EDM", "trap"],                       // F2 — ainda ignorado pela API
  "instrumental": false,                            // F2
  "vocalGender": "male",                            // F2
  "styleInfluence": 78,                             // 0-100 (Style Influence) — F2
  "weirdness": 38,                                  // 0-100 (Weirdness) — F2
  "language": "pt-BR",
  "approval": {                                     // SEM isto o CLI recusa enviar
    "approvedBy": "nome de quem deu o veredito",
    "approvedAt": "ISO-8601",
    "method": "veredito-emocional-humano"
  },
  "composition": {                                  // auditoria das decisões (F2: gravado no job)
    "blend": "pincel-emocional + seta",
    "decisions": [{ "stage": "style", "decision": "...", "rationale": "..." }]
  }
}
```

## 2. Sequência de comandos

```bash
servinder audio generate-music --file pacote.json   # → { jobId, statusUrl } (debita créditos; 402 se faltar)
servinder audio status <jobId> --watch              # poll até completed (exit 0) / failed (1) / timeout (2)
servinder audio download <jobId> --out musica.mp3   # baixa o áudio final (URL pública)
python3 ~/.claude/skills/gerar-audio/render-artifact.py \
  musica.mp3 letra.txt "Suno" "V5_5" musica.html "Título" \
  --label1=Provedora --label2=Modelo                # player standalone: play, waveform, letra, download
```

Entregue o `musica.html` ao usuário (abrir/anexar). `letra.txt` = a letra do pacote (com ou sem metatags, a gosto).

## 3. Regras do método neste pipeline

- **Nunca gerar sem `approval` preenchido** — a cura não se impõe; a obra só viaja depois do veredito.
- Variações em leque (Pincel/Cientista): 1 pacote por variação, 1 job por pacote — o débito/refund é por job, falha numa faixa não contamina as outras. Álbum = loop sobre `faixa-NN.json`.
- Se a API recusar por limite de caracteres no `style`, é a Seta quem corta — não trunque mecanicamente.
- Custos: geração de música debita créditos da plataforma (ver `servinder audio generate-music` → 402 com saldo). Curadoria continua humana: gere, ouça, aprove ou refaça.
