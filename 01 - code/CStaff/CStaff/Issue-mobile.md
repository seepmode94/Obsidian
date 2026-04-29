# Mobile/Admin: corrigir aceitação e rejeição de pedidos de ausência nas notificações

## Intro

Na versão mobile, quando o utilizador admin tenta gerir pedidos de ausência a partir do ecrã de notificações, o fluxo está partido em dois pontos: ao tentar **rejeitar** um pedido de ausência aparece a mensagem de que não é possível rejeitar o pedido (a acção falha), e ao **aceitar** um pedido o estado é actualizado para aceite mas a notificação correspondente não desaparece da lista, ficando o pedido a aparecer indefinidamente como pendente para o admin. O pedido é corrigir ambos os comportamentos para que o admin consiga gerir os pedidos de ausência directamente nas notificações.

## Alterações

Correcção do fluxo de aceitação/rejeição de pedidos de ausência nas notificações da app mobile (perfil admin). Principais alterações:

- **Rejeição funcional:** corrigir a acção de rejeitar pedido de ausência nas notificações para que execute a rejeição com sucesso, em vez de devolver "não é possível rejeitar pedido"; investigar e remover a causa do bloqueio (validação/endpoint/permissão).

- **Remoção da notificação após aceitação:** ao aceitar um pedido de ausência, a notificação correspondente passa a ser removida (ou marcada como tratada) da lista de notificações do admin, evitando que o pedido continue a aparecer como pendente após a acção.

- **Consistência de estado:** garantir que o estado apresentado nas notificações reflecte o estado real do pedido após a acção (aceite/rejeitado), com refresh da lista após cada operação.

- **Feedback ao utilizador:** mensagens de sucesso/erro coerentes para ambas as acções (aceitar e rejeitar), de modo a que o admin perceba claramente o resultado da operação.

**Resultado esperado:** admin consegue aceitar e rejeitar pedidos de ausência directamente nas notificações da app mobile; pedidos rejeitados deixam de devolver erro, pedidos aceites desaparecem da lista de notificações e o estado fica coerente entre notificações e pedido real.

---

# Registo de Ponto: remover imagem de localização e usar apenas morada de apresentação

## Intro

No ecrã de Registo de Ponto, a imagem da localização (mapa/snapshot) está a apresentar uma morada incorrecta, gerando confusão sobre o local efectivo do registo. Como a morada já é apresentada em texto separadamente, a imagem é redundante e neste caso prejudica a experiência. O pedido é remover a imagem de localização e manter apenas a morada de apresentação como referência do local do registo.

## Alterações

Simplificação da apresentação da localização no Registo de Ponto, removendo o componente de imagem que está a induzir em erro. Principais alterações:

- **Remoção da imagem de localização:** retirar o componente de imagem/mapa do ecrã de Registo de Ponto, eliminando a fonte da morada incorrecta apresentada visualmente.

- **Morada de apresentação:** manter apenas a morada em texto como referência do local do registo, garantindo que reflecte correctamente as coordenadas obtidas no momento do ponto.

- **Limpeza de dependências:** remover/ajustar chamadas e recursos associados à geração da imagem de localização (ex.: serviço de mapa estático) que deixam de ser necessários.

**Resultado esperado:** ecrã de Registo de Ponto sem a imagem de localização errada, apresentando apenas a morada em texto, reduzindo confusão para o utilizador e simplificando o ecrã.

---

# Mobile: integrar vídeo tutorial (URL YouTube) dentro da app

## Intro

A app mobile não disponibiliza actualmente um vídeo tutorial acessível de dentro da aplicação, obrigando os utilizadores a procurarem o conteúdo fora da app. Existe um vídeo tutorial em YouTube que deve ser integrado num local visível da app, para apoiar a adopção e reduzir dúvidas recorrentes sobre o uso das funcionalidades. O pedido é incluir o vídeo (via URL do YouTube) dentro da app, de forma simples e acessível.

## Alterações

Integração de vídeo tutorial do YouTube dentro da app mobile. Principais alterações:

- **Embed do vídeo YouTube:** inclusão do vídeo tutorial usando a URL do YouTube, através de um componente de player embebido (ex.: `youtube_player_flutter`/WebView) ou abertura controlada no YouTube, conforme melhor encaixe na navegação.

- **Localização na app:** colocação do acesso ao vídeo num ponto visível e contextual (ex.: ecrã de ajuda/onboarding ou definições), de modo a ser facilmente encontrado pelo utilizador.

- **Configuração de URL:** URL do vídeo parametrizável (constante/config) para facilitar futura substituição por novas versões do tutorial sem nova release.

- **Fallback offline/erro:** mensagem clara quando não há ligação ou o vídeo não carrega, evitando ecrã em branco.

**Resultado esperado:** utilizador da app mobile passa a ter acesso ao vídeo tutorial directamente de dentro da app, num ponto visível, com reprodução estável e URL facilmente actualizável.

---

# Mobile: corrigir horários dos pontos (1h a menos vs versão web)

## Intro

Na app mobile, os horários dos registos de ponto aparecem com uma hora a menos do que os mesmos registos apresentados na versão web, criando incoerência entre plataformas para o mesmo registo. O sintoma típico aponta para problema de fuso horário/UTC: a app mobile estará a apresentar a hora em UTC (ou sem aplicar offset local) enquanto a web apresenta correctamente em hora local. O pedido é alinhar os horários entre mobile e web para que o registo seja apresentado de forma consistente.

## Alterações

Correcção da apresentação dos horários de pontos na app mobile, alinhando com a versão web. Principais alterações:

- **Conversão para hora local:** garantir que os timestamps recebidos do backend são convertidos para o fuso horário local do utilizador (Europe/Lisbon) antes de serem apresentados, em vez de exibidos directamente em UTC.

- **Auditoria dos pontos de formatação:** rever todos os locais onde são apresentadas horas de ponto na app (lista de pontos, detalhe, notificações, exportações) para aplicar a mesma lógica de formatação/timezone.

- **Coerência com o backend/web:** validar que o backend devolve timestamps em formato consistente (ISO 8601 com timezone) e que a web e mobile usam a mesma referência de fuso na apresentação.

- **Testes em horário de verão/inverno:** confirmar que a correcção se mantém estável durante a mudança de hora (DST), evitando regressões sazonais.

**Resultado esperado:** horários dos pontos na app mobile passam a coincidir com os apresentados na versão web, sem o desvio de 1h, mantendo coerência independentemente do fuso/DST.

---

# Mobile/Registo de Ponto: separar botões, confirmar fim de serviço e aplicar cooldown de picagem

## Intro

No ecrã de Registo de Ponto da app mobile, o botão de **pausa** está colocado demasiado próximo do botão de **terminar serviço**, o que aumenta o risco de o utilizador carregar no botão errado e terminar o turno por engano. Acresce que a acção de terminar serviço não pede qualquer confirmação, tornando o erro irreversível em poucos toques. Por outro lado, é possível efectuar várias picagens consecutivas em segundos, sem qualquer protecção contra duplicação acidental. O pedido é melhorar a UX e a robustez do fluxo: separar os botões, exigir confirmação para terminar o serviço e introduzir um cooldown entre picagens.

## Alterações

Melhorias de UX e protecção contra registos acidentais no ecrã de Registo de Ponto da app mobile. Principais alterações:

- **Separação de botões:** afastar visualmente o botão de pausa do botão de terminar serviço (espaçamento, agrupamento ou hierarquia visual distinta), reduzindo o risco de toque errado.

- **Confirmação ao terminar serviço:** adicionar diálogo de confirmação ao carregar em "terminar serviço/sair do trabalho", exigindo uma confirmação explícita do utilizador antes de fechar o turno.

- **Cooldown de 5 minutos entre picagens:** após uma picagem (entrada/saída/pausa), bloquear nova picagem durante 5 minutos, com indicação clara ao utilizador (botão desactivado e tempo restante visível) para evitar picagens duplicadas acidentais.

- **Feedback visual durante cooldown:** estado desactivado dos botões com contagem decrescente ou mensagem do tempo restante até nova picagem permitida.

**Resultado esperado:** ecrã de Registo de Ponto mais resistente a erros de utilização — botões pausa/terminar separados, confirmação explícita antes de terminar o serviço e cooldown de 5 min entre picagens que evita registos duplicados acidentais.

---

# Mobile/Gestão de Ponto: abrir modal de detalhes ao carregar no card (paridade com web)

## Intro

Na Gestão de Ponto da app mobile, os cards apresentam apenas informação resumida e não permitem aceder ao detalhe completo do registo, ao contrário da versão web que mostra a informação alargada do ponto. Isto cria um desnível de funcionalidade entre plataformas e obriga o utilizador a recorrer à web sempre que precisa de detalhes. O pedido é, ao carregar num card de ponto na mobile, abrir um modal com os detalhes do registo, apresentando a mesma informação que a versão web.

## Alterações

Adição de modal de detalhes do ponto na Gestão de Ponto da app mobile, com paridade de informação face à versão web. Principais alterações:

- **Tap no card abre modal:** cada card de ponto passa a ser interactivo; ao carregar, abre um modal com o detalhe completo do registo seleccionado.

- **Paridade de informação com web:** o modal apresenta os mesmos campos disponibilizados no detalhe web do ponto (ex.: hora de entrada/saída, pausas, duração total, localização, observações, estado, autor de eventuais alterações), sem omitir campos relevantes.

- **Layout adaptado a mobile:** estrutura do modal adequada ao formato mobile (scroll, secções claras, fecho fácil), preservando a legibilidade.

- **Reutilização de fonte de dados:** consumir o mesmo endpoint/contrato usado pela web para garantir coerência de dados entre plataformas.

**Resultado esperado:** utilizador da app mobile passa a aceder, com um toque no card, a um modal com os detalhes completos do ponto, alinhado com a informação apresentada na versão web — eliminando o desnível de funcionalidade entre plataformas.
