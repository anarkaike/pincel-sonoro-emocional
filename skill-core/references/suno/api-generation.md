# Geração via API (sunoapi.org) — fluxo programático

A Suno **não tem API oficial**. Usamos o **sunoapi.org** (wrapper de terceiros). Este doc é o COMO gerar direto por código; o script pronto é `suno_generate.py` (mesma pasta).

- **Base:** `https://api.sunoapi.org` · **Auth:** header `Authorization: Bearer $SUNO_API_KEY`
- **Envelope:** todas as respostas vêm `{ code, msg, data }` (sucesso = `code: 200`).

## ⚠️ Gotchas que quebram silenciosamente (aprendidos na marra)

1. **Cloudflare 1010 (403).** Sem `User-Agent` de **navegador**, todo request volta `403 error code: 1010`. Mande UA de navegador **nos requests E no download** do CDN. (O `fetch` default do Node/urllib é barrado.)
2. **Endpoint de status mudou.** Use `GET /api/v1/generate/record-info?taskId=<id>`. O antigo `GET /api/v1/query/{id}` **dá 404**. (O client do app `estampartia` — `src/services/ai-strategy/clients/suno-client.ts` — ainda usa o antigo: corrigir lá.)
3. **Campo do áudio é camelCase:** `data.response.sunoData[].audioUrl` (não `audio_url`). O CDN é `tempfile.aiquickdraw.com/...mp3` e **também** exige UA.
4. **`/api/v1/credit` responde 404** por essa chave/plano — não dependa dele; siga direto pro generate.
5. **`callBackUrl` é aceito** e pode ser placeholder: usamos **polling** (`record-info`) como fonte da verdade.

## 1) Gerar — `POST /api/v1/generate`

```json
{
  "customMode": true,
  "instrumental": false,
  "model": "V5",                        // V4 | V4_5 | V4_5PLUS | V5 | V5_5
  "prompt": "<LETRA com metatags>",     // em customMode, prompt = a letra
  "style": "<Style ≤1000 chars, com 'sung/spoken in Brazilian Portuguese'>",
  "title": "<título>",
  "negativeTags": ["sad", "edm", "..."],
  "vocalGender": "male",                // ou "female"
  "styleWeight": 0.8,                    // 0..1
  "weirdnessConstraint": 0.3,            // 0..1
  "callBackUrl": "https://example.com/cb"
}
```
Resposta: `{ code:200, data:{ taskId } }`. Guarde o `taskId`.

## 2) Polling — `GET /api/v1/generate/record-info?taskId=<id>`

`data.status`: `PENDING → TEXT_SUCCESS → FIRST_SUCCESS → SUCCESS` (falhas: `*_FAILED`, `SENSITIVE_WORD_ERROR`, `CALLBACK_EXCEPTION`). Quando houver `audioUrl` e status `SUCCESS`/`FIRST_SUCCESS`, baixe (geralmente **2 takes**). Poll a cada ~6s, timeout ~5 min. V5 leva ~1–3 min.

## 3) Download — com UA
O `audioUrl` é CDN protegido por Cloudflare: baixe mandando o mesmo `User-Agent` de navegador.

## Voz / persona custom

- `personaId` + **`personaModel`**:
  - `"voice_persona"` → voz do **Suno Voice** (só V5/V5_5). Use o **voice ID** da conta.
  - `"style_persona"` (default) → persona de estilo (endpoint Generate Persona).
- **Não há endpoint público pra listar personas**, e persona é **escopada à conta da chave** — o `voice ID` tem que existir na conta dona da `SUNO_API_KEY`. Persona criada na conta pessoal do Suno **não** é acessível por outra conta/chave.

## Script pronto

```bash
export SUNO_API_KEY=...
python3 suno_generate.py \
  --title "Sinta, Crie e Vista" \
  --style "warm brazilian acoustic, spoken-word narration, very light bed, voice in front, spoken in Brazilian Portuguese" \
  --lyrics-file letra.txt \
  --negative "edm,heavy drums,sad,autotune" \
  --vocal-gender male \
  --out apresentacao.mp3
# voz custom:
#   --persona <voiceId> --persona-model voice_persona
# instrumental:
#   --instrumental   (dispensa --lyrics)
```
Baixa todos os takes (`apresentacao.mp3`, `apresentacao-2.mp3`, ...).
