#!/usr/bin/env python3
"""
suno_generate.py — geração de música via sunoapi.org (wrapper Suno), pronto p/ CLI.

Uso:
  export SUNO_API_KEY=...            # ou --api-key
  python3 suno_generate.py \
      --title "Meu Jingle" \
      --style "warm acoustic brazilian, spoken-word narration, very light bed" \
      --lyrics-file letra.txt \
      [--model V5] [--negative "sad,dark,edm"] [--vocal-gender male] \
      [--persona <voiceId> --persona-model voice_persona] \
      [--instrumental] [--out out.mp3]

Gotchas aprendidos (ver api-generation.md):
  • Cloudflare 1010: SEM User-Agent de navegador → 403. Manda UA nos requests E no download.
  • Status: GET /api/v1/generate/record-info?taskId=  (NÃO /api/v1/query/{id} — 404, endpoint antigo).
  • Campo do áudio: audioUrl (camelCase) em data.response.sunoData[].
  • callBackUrl é aceito mas usamos polling; pode ser placeholder.
  • Persona/voz custom: personaId + personaModel ("voice_persona" | "style_persona").
"""
import argparse, json, os, sys, time, urllib.request, urllib.error

UA = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"


def http(base, path, key, method="GET", body=None, timeout=60):
    req = urllib.request.Request(base + path, data=(json.dumps(body).encode() if body is not None else None), method=method)
    req.add_header("Authorization", "Bearer " + key)
    req.add_header("User-Agent", UA)
    req.add_header("Accept", "application/json, text/plain, */*")
    if body is not None:
        req.add_header("Content-Type", "application/json")
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            return json.loads(r.read().decode())
    except urllib.error.HTTPError as e:
        return {"_httperror": e.code, "_body": e.read().decode()[:400]}


def find_urls(obj):
    out = []
    def walk(o):
        if isinstance(o, dict):
            for k, v in o.items():
                if k in ("audioUrl", "audio_url") and isinstance(v, str) and v.startswith("http"):
                    out.append(v)
                else:
                    walk(v)
        elif isinstance(o, list):
            for x in o:
                walk(x)
    walk(obj)
    return out


def download(url, dst):
    req = urllib.request.Request(url)
    req.add_header("User-Agent", UA)
    with urllib.request.urlopen(req, timeout=180) as r, open(dst, "wb") as f:
        f.write(r.read())
    return os.path.getsize(dst)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--api-key", default=os.environ.get("SUNO_API_KEY"))
    ap.add_argument("--base", default=os.environ.get("SUNO_API_BASE", "https://api.sunoapi.org"))
    ap.add_argument("--title", default="")
    ap.add_argument("--style", required=True)
    ap.add_argument("--lyrics")
    ap.add_argument("--lyrics-file")
    ap.add_argument("--model", default="V5")
    ap.add_argument("--negative", default="")
    ap.add_argument("--vocal-gender", choices=["male", "female"])
    ap.add_argument("--style-weight", type=float, default=0.8)
    ap.add_argument("--weirdness", type=float, default=0.3)
    ap.add_argument("--persona")
    ap.add_argument("--persona-model", default="voice_persona", choices=["voice_persona", "style_persona"])
    ap.add_argument("--instrumental", action="store_true")
    ap.add_argument("--callback", default="https://example.com/suno-callback")
    ap.add_argument("--out", default="suno-out.mp3")
    ap.add_argument("--timeout", type=int, default=300)
    a = ap.parse_args()
    if not a.api_key:
        sys.exit("faltou SUNO_API_KEY (env ou --api-key)")

    lyrics = a.lyrics or (open(a.lyrics_file).read() if a.lyrics_file else None)
    if not a.instrumental and not lyrics:
        sys.exit("customMode com voz precisa de --lyrics ou --lyrics-file (ou use --instrumental)")

    body = {
        "customMode": True,
        "instrumental": a.instrumental,
        "model": a.model,
        "prompt": lyrics or a.style,
        "style": a.style,
        "title": a.title,
        "styleWeight": a.style_weight,
        "weirdnessConstraint": a.weirdness,
        "callBackUrl": a.callback,
    }
    if a.negative:
        body["negativeTags"] = [t.strip() for t in a.negative.split(",") if t.strip()]
    if a.vocal_gender:
        body["vocalGender"] = a.vocal_gender
    if a.persona:
        body["personaId"] = a.persona
        body["personaModel"] = a.persona_model

    gen = http(a.base, "/api/v1/generate", a.api_key, method="POST", body=body)
    data = gen.get("data") if isinstance(gen.get("data"), dict) else {}
    task_id = (data or {}).get("taskId") or (data or {}).get("task_id")
    if not task_id:
        sys.exit("generate falhou: " + json.dumps(gen)[:400])
    print("taskId:", task_id)

    deadline = time.time() + a.timeout
    urls = []
    while time.time() < deadline:
        q = http(a.base, "/api/v1/generate/record-info?taskId=" + task_id, a.api_key)
        d = q.get("data") or {}
        status = d.get("status") if isinstance(d, dict) else None
        urls = find_urls(q)
        print(f"  status={status} urls={len(urls)}")
        s = str(status).upper()
        if urls and s in ("SUCCESS", "COMPLETE", "COMPLETED", "FIRST_SUCCESS"):
            break
        if "FAIL" in s or "ERROR" in s or "SENSITIVE" in s:
            sys.exit("geração falhou: " + json.dumps(q)[:400])
        time.sleep(6)
    if not urls:
        sys.exit("timeout sem áudio")

    seen = []
    for u in urls:
        if u in seen:
            continue
        seen.append(u)
        dst = a.out if len(seen) == 1 else a.out.rsplit(".", 1)[0] + f"-{len(seen)}.mp3"
        print("salvo:", dst, download(u, dst), "bytes")


if __name__ == "__main__":
    main()
