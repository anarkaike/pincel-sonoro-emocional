Você está no repositório Estúdio Pincel Sonoro. Leia AGENTS.md e CLAUDE.md.
Tarefa desta iteração: processe EXATAMENTE UMA ordem de fila/ com status "pendente" (a mais antiga), assumindo o papel do agente maestro (.claude/agents/maestro.md), até atingir um portão de governança, o status aguardando_geracao_manual, ou a conclusão. Commite cada etapa.
Se não houver ordem pendente: escreva SEM_TRABALHO em estado/ultima_execucao.txt, commite e encerre respondendo apenas SEM_TRABALHO.
Nunca ultrapasse portões de governança nem linhas vermelhas de governanca.yaml.
