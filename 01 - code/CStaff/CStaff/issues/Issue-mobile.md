# Issue Mobile: ajustes em Notificações, Registo de Ponto, Gestão de Ponto e Tutorial

## Intro

Páginas afectadas:

- **Notificações (admin)** — rejeitar pedido de ausência devolve "não é possível rejeitar"; aceitar não remove a notificação da lista.
- **Registo de Ponto** — imagem de localização mostra morada errada; botões pausa e terminar serviço demasiado próximos; terminar serviço sem confirmação; sem cooldown entre picagens; horários com 1h a menos que a versão web (timezone).
- **Gestão de Ponto** — cards não abrem detalhes; falta paridade com a versão web.
- **App em geral (Ajuda/Onboarding)** — sem acesso ao vídeo tutorial dentro da app.

## Alterações

### Notificações (admin)
- Corrigir rejeição de pedidos de ausência (acção falha actualmente).
- Remover notificação da lista após aceitar pedido.
- Garantir refresh/coerência de estado e mensagens claras de sucesso/erro.

### Registo de Ponto
- Remover imagem de localização; manter apenas morada em texto.
- Corrigir horários (converter para hora local Europe/Lisbon; alinhar com web).
- Separar visualmente botão de pausa do botão de terminar serviço.
- Adicionar diálogo de confirmação ao terminar serviço.
- Cooldown de 5 min entre picagens (botão desactivado + tempo restante visível).

### Gestão de Ponto
- Tap no card abre modal com detalhes do registo.
- Paridade de informação com a versão web (mesmos campos do detalhe).

### App / Tutorial
- Integrar vídeo tutorial (URL YouTube) dentro da app, em local visível (ex.: Ajuda/Onboarding).
- URL parametrizável; fallback claro em erro/offline.

## Resultado esperado

Admin consegue gerir pedidos de ausência directamente nas notificações sem erros nem registos fantasma; Registo de Ponto sem morada errada, com horários coerentes com a web, botões separados, confirmação ao terminar serviço e cooldown que evita picagens duplicadas; Gestão de Ponto com modal de detalhes alinhado com a web; e utilizador com acesso ao vídeo tutorial dentro da app.
