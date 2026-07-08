# Arquitetura — decisões e porquês (mini-ADRs)

**ADR-1 · SKILL.md enxuto + referências sob demanda.** Contexto de LLM é recurso caro; o núcleo ensina o fluxo e aponta arquivos que só são lidos quando necessários (metatags, multilíngue, styles, v5.5, docs).
**ADR-2 · Linhas como perfis, não como prompts soltos.** Perfis têm estrutura fixa (Alma/Quando/Domínios/Processo/Assinaturas/Mescla) → comparáveis, mescláveis e extensíveis por template.
**ADR-3 · Lentes separadas de condutoras.** Duplos sentidos e despertar são transversais: acoplá-los a uma condutora os limitaria; como lentes, vestem qualquer mescla como camada final.
**ADR-4 · Mescla com autoridade ordenada.** Resolver conflitos por ordem declarada é simples, previsível e legível por humanos e agentes.
**ADR-5 · Agentes vestem linhas.** No estúdio, equipe (papéis/handoffs) é estrutura; linha é temperamento. Isso permite trocar temperamento sem reorganizar o time.
**ADR-6 · Governança e aprovações como arquivos em git.** Único mecanismo idêntico em notebook, cron, Ralph loop, Actions, Devin e Trae; auditável por natureza; humano aprova movendo/editando arquivo.
**ADR-7 · Memória curada com teto (~50 itens) e sanção humana.** Auto-evolução sem curadoria degrada; memória viva é a que cabe na cabeça do agente; excedente vai a arquivo morto.
**ADR-8 · Núcleo + adaptadores no multiplataforma.** Uma fonte de verdade (skill-core) e tradutores finos por dialeto de plataforma; manutenção em um lugar só.
**ADR-9 · API do Suno como adaptador opcional.** Não há API oficial; o script é plugável e, na ausência, o pipeline degrada graciosamente para "pronto-para-colar" manual.
**ADR-10 · Privacidade por design.** Fontes pessoais ficam fora do pacote; a documentação conta a jornada sem expor terceiros (ver PRIVACIDADE.md).
