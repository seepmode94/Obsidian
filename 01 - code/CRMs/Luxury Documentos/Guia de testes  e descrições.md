# Guia de Testes e Descrições — Luxury CRM

> **Plataforma:** Luxury CRM
> **Versão analisada:** Aplicação móvel (Android)
> **Data:** Abril 2026

---

## Índice

1. [Banner / Identidade](#banner--identidade)
2. [Página de Login](#1-página-de-login)
3. [Dashboard](#2-dashboard)
4. [Módulo de Vendas — Clientes](#3-módulo-de-vendas--clientes)
5. [Criação de Cliente](#4-criação-de-cliente)
6. [Módulo de Atividades](#5-módulo-de-atividades)
7. [Calendário](#6-calendário)
8. [Assistências](#7-assistências)
9. [Matriz de Testes Geral](#matriz-de-testes-geral)

---

## Banner / Identidade



---

## 1. Página de Login

![[loginPage.png]]

### Descrição
Ecrã de entrada da plataforma. Apresenta logótipo, título *Luxury CRM*, slogan e formulário de autenticação simples.


### Casos de teste

| ID | Cenário | Passos | Resultado esperado |
|---|---|---|---|
| LOG-01 | Login com credenciais válidas | Inserir utilizador e palavra-passe corretos → tocar **Entrar** | Redireciona para Dashboard |
| LOG-02 | Login com credenciais inválidas | Inserir utilizador e/ou palavra-passe errados | Mensagem de erro clara; não autentica |
| LOG-03 | Campos vazios | Tocar **Entrar** sem preencher | Validação inline; botão inativo ou aviso |
| LOG-04 | Mostrar/ocultar palavra-passe | Tocar ícone do olho | Alterna entre texto visível e oculto |
| LOG-05 | Persistência de sessão | Fechar e reabrir app após login | Sessão mantém-se ativa (se aplicável) |
| LOG-06 | Teclado e foco | Tocar nos campos | Teclado abre; foco visível no campo ativo |

---

## 2. Dashboard

![[dashboard.png]]

### Descrição
Ecrã principal pós-login. Mostra saudação personalizada e mini-aplicações (widgets) com indicadores-chave do utilizador. Inclui barra de navegação inferior com os quatro módulos principais.

### Elementos da interface
| Elemento | Descrição |
|---|---|
| Avatar utilizador (`GF`) | Iniciais no canto superior esquerdo |
| Sino de notificações | Canto superior direito |
| Saudação | "Bom dia, Guilherme." (dinâmica por hora do dia) |
| **PAINEL CRM** | Botão / separador ativo |
| **Ações ▼** | Menu pendente de ações rápidas |
| **Miniaplicações do Painel** | Lista de cartões (Reuniões, Chamadas, Top oportunidades em aberto, Contas) |
| Barra de navegação inferior | DASHBOARD · VENDAS · ATIVIDADES · MENU |

### Casos de teste

| ID | Cenário | Resultado esperado |
|---|---|---|
| DASH-01 | Saudação dinâmica | Texto adapta-se a período do dia (Bom dia / Boa tarde / Boa noite) |
| DASH-02 | Saudação com nome do utilizador | Apresenta nome correto da conta autenticada |
| DASH-03 | Carregamento de miniaplicações | Indicadores de loading aparecem; dados carregam após pedido |
| DASH-04 | Fechar miniaplicação (`×`) | Cartão é removido do dashboard |
| DASH-05 | Adicionar miniaplicação | Ícone superior direito permite adicionar novos widgets |
| DASH-06 | Menu **Ações** | Abre lista de ações rápidas (criar cliente, registar chamada, etc.) |
| DASH-07 | Notificações | Tocar no sino abre lista de notificações |
| DASH-08 | Navegação inferior | Cada separador (Vendas / Atividades / Menu) navega corretamente |

---

## 3. Módulo de Vendas — Clientes

![[clienteDetalhes.png]]

### Descrição
Ecrã de listagem de clientes ativos com pesquisa e filtros. Cada cartão mostra dados-chave do cliente (NIF, área, billing, responsável, data de criação). Botão flutuante (FAB `+`) para adicionar novo cliente.

### Elementos da interface
| Elemento | Descrição |
|---|---|
| Cabeçalho **CLIENTES** | Título + botão de retroceder |
| Barra de pesquisa | Pesquisa em tempo real (ex.: `tacovia`) |
| Botão de filtros | Abre painel de filtros avançados |
| Banner **CLIENTES ATIVOS · TOTAL: N** | Contagem de resultados |
| Cartão de cliente | Nome, NIF, Nº Func., Área, Billing, Visita, Responsável, Criado em, badge **CLIENTE** |
| Ações rápidas no cartão | Telefone (📞) e e-mail (✉️) |
| FAB `+` | Cria novo cliente |

### Casos de teste

| ID | Cenário | Resultado esperado |
|---|---|---|
| CLI-01 | Pesquisa por nome | Lista filtra dinamicamente (ex.: `tacovia` → apresenta `Tacovia, Lda`) |
| CLI-02 | Pesquisa sem resultados | Mensagem "Sem resultados" e total = 0 |
| CLI-03 | Limpar pesquisa (`×`) | Lista volta ao estado completo |
| CLI-04 | Filtros avançados | Painel abre; filtros aplicam-se à lista |
| CLI-05 | Tocar em cartão | Abre página de detalhe do cliente |
| CLI-06 | Ação telefone | Abre marcador com número do cliente |
| CLI-07 | Ação e-mail | Abre cliente de e-mail com endereço pré-preenchido |
| CLI-08 | FAB `+` | Navega para o formulário **Novo Cliente** |
| CLI-09 | Campos não definidos | "Não definido" surge quando o valor está vazio |
| CLI-10 | Total dinâmico | Contador `TOTAL` reflete resultados após filtro/pesquisa |

---

## 4. Criação de Cliente

![[addCliente.png]]

### Descrição
Formulário **Novo Cliente** organizado em secção **Informação do Cliente** com dados principais e endereço de faturação.

### Campos
| Campo | Obrigatório | Tipo | Validação |
|---|---|---|---|
| Nome | ✅ | Texto | Não vazio |
| Sítio Internet | ❌ | URL | Formato `https://...` |
| Telefone de Trabalho | ❌ | Telefone (`+351`) | Formato PT |
| Telefone Alternativo | ❌ | Telefone | Formato PT |
| Email | ❌ | E-mail | Formato `exemplo@dominio.pt` |
| Rua | ❌ | Texto longo | — |
| Código Postal | ❌ | Texto | Formato `0000-000` |
| Cidade | ❌ | Texto | — |
| Concelho | ❌ | Texto | — |
| País | ❌ | Texto / dropdown | — |

### Ações
- **X** (canto superior esquerdo) — fecha o formulário
- **GUARDAR** (canto superior direito) — submete o formulário

### Casos de teste

| ID | Cenário | Resultado esperado |
|---|---|---|
| ADD-01 | Guardar com **Nome** vazio | Validação bloqueia; aviso visível |
| ADD-02 | Guardar só com Nome | Cliente criado com restantes campos vazios/`Não definido` |
| ADD-03 | Email mal formatado | Validação inline (`exemplo@dominio.pt`) |
| ADD-04 | Código Postal mal formatado | Validação `0000-000` |
| ADD-05 | Telefone com prefixo errado | Aceita só `+351 ---` ou normaliza |
| ADD-06 | Cancelar via `X` | Pede confirmação se houve alterações |
| ADD-07 | Guardar com sucesso | Volta para lista; novo cliente aparece com `TOTAL` incrementado |
| ADD-08 | Foco em **Cidade** | Borda do campo destaca-se (verde) |
| ADD-09 | Scroll do formulário | Cabeçalho fixo; barra inferior fixa |
| ADD-10 | Rotação de ecrã | Dados não se perdem |

---

## 5. Módulo de Atividades

![[moduloVendas.png]]

### Descrição
Hub de atividades com seis sub-módulos. Funciona como menu de navegação para os tipos de interação suportados pelo CRM.

### Sub-módulos
| Sub-módulo | Ícone | Descrição |
|---|---|---|
| **Calendário** | 📅 verde | Vista temporal de eventos |
| **Assistências** | 🎧 laranja | Tickets / pedidos de suporte |
| **Telefonemas** | 📞 azul | Registo de chamadas |
| **Reuniões** | 👥 roxo | Marcações com clientes |
| **Formações** | 🎓 verde-água | Sessões formativas |
| **Formadores** | 🪪 verde | Gestão de formadores |

### Casos de teste

| ID | Cenário | Resultado esperado |
|---|---|---|
| ATV-01 | Tocar em cada sub-módulo | Navega para o ecrã correspondente |
| ATV-02 | Voltar ao hub | Botão de retroceder mantém estado |
| ATV-03 | Ícones e cores | Cada item mantém ícone/cor consistentes |
| ATV-04 | Scroll | Lista permite ver todos os 6 itens |
| ATV-05 | Estado ativo na nav inferior | **Atividades** destacado quando neste hub |

---

## 6. Calendário

![[Calendario.png]]

### Descrição
Vista mensal do calendário com eventos categorizados por cor. Suporta navegação entre meses e tem o dia atual destacado.

### Elementos da interface
| Elemento | Descrição |
|---|---|
| Cabeçalho **CALENDÁRIO** | Botão retroceder + ajustes (filtros) |
| Seletor de vista | **Mês ▼** (presumível: Dia / Semana / Mês) |
| Navegação | `<` mês anterior · **Hoje** · `>` mês seguinte |
| Mês corrente | Ex.: **Abril 2026** |
| Legenda de cores | 🟩 Reunião · 🟦 Telefonema · 🟦 Tarefa · 🟥 Formações |
| Grelha mensal | DOM–SAB; dia atual (28) com círculo verde |

### Casos de teste

| ID | Cenário | Resultado esperado |
|---|---|---|
| CAL-01 | Vista por defeito | Mês corrente, dia atual marcado |
| CAL-02 | Navegar mês anterior/seguinte | Grelha atualiza com mês correto |
| CAL-03 | Botão **Hoje** | Volta ao mês corrente e marca o dia atual |
| CAL-04 | Mudar vista (Dia/Semana/Mês) | Grelha re-renderiza para a vista escolhida |
| CAL-05 | Tocar em dia com eventos | Mostra lista de eventos do dia |
| CAL-06 | Tocar em dia sem eventos | Permite criar evento ou mostra estado vazio |
| CAL-07 | Cores dos eventos | Coincidem com legenda (Reunião / Telefonema / Tarefa / Formações) |
| CAL-08 | Filtros | Permite ocultar/mostrar tipos de evento |
| CAL-09 | Dias fora do mês | Apresentados a cinzento (28–31 mar; 1–9 mai) |
| CAL-10 | Data limite passada | Eventos passados visualmente diferenciados |

---

## 7. Assistências

![[assistencias.png]]

### Descrição
Listagem de tickets de assistência (atendimentos). Cada cartão mostra prioridade, datas, responsável e estado (NEW / EXPI…). Suporta pesquisa, filtros e criação via FAB.

### Elementos da interface
| Elemento | Descrição |
|---|---|
| Cabeçalho **ASSISTÊNCIAS** | Botão retroceder |
| Pesquisa | "Procurar assistências…" |
| Botão filtros | Abre filtros avançados |
| Banner **REGISTOS RECENTES · N Atendimentos** | Total de tickets |
| Cartão de assistência | Tipo · Título · Prioridade · Criado em · Responsável · Data limite · Badge de estado |
| FAB `+` | Cria novo registo |

### Estados observados
- **NEW** — recém-criado
- **EXPI** (Expirado) — passou da data limite

### Prioridades observadas
- 🟢 **Média** (com ícone de raio)
- (presumível: Baixa, Alta, Urgente)

### Casos de teste

| ID | Cenário | Resultado esperado |
|---|---|---|
| ASS-01 | Pesquisa por título | Filtra (ex.: `Formação` → mostra `Formação E-LIC`) |
| ASS-02 | Filtros avançados | Filtra por prioridade / responsável / estado / data |
| ASS-03 | Tocar num cartão | Abre detalhe do ticket |
| ASS-04 | FAB `+` | Abre formulário de novo registo |
| ASS-05 | Estado **NEW** | Surge em tickets criados recentemente |
| ASS-06 | Estado **EXPI** | Surge quando `Data limite < hoje` e ticket por concluir |
| ASS-07 | Data limite a vermelho | Datas críticas visualmente destacadas |
| ASS-08 | Total de atendimentos | Reflete contagem real (ex.: `20 Atendimentos`) |
| ASS-09 | Scroll | Lista carrega registos adicionais (paginação ou infinite scroll) |
| ASS-10 | Responsável | Avatar com iniciais + nome correto |

---

## Matriz de Testes Geral

### Testes transversais (aplicáveis a todos os ecrãs)

| ID | Categoria | Cenário | Resultado esperado |
|---|---|---|---|
| GEN-01 | Navegação | Barra inferior persistente | Sempre visível em ecrãs principais |
| GEN-02 | Navegação | Botão retroceder | Volta ao ecrã anterior preservando estado |
| GEN-03 | Performance | Tempo de carregamento | < 2s em rede 4G |
| GEN-04 | Offline | Sem internet | Mensagem clara + cache local quando aplicável |
| GEN-05 | Acessibilidade | Tamanho de fonte | Adapta-se às definições do sistema |
| GEN-06 | Acessibilidade | Contraste | Cumpre WCAG AA |
| GEN-07 | Internacionalização | Idioma PT-PT | Todos os textos em português europeu |
| GEN-08 | Sessão | Token expirado | Redireciona para login com mensagem |
| GEN-09 | Erros | Falha de servidor | Mensagem amigável + retry |
| GEN-10 | Visual | Tema/cores | Paleta consistente em todos os ecrãs |
| GEN-11 | Visual | Estado de loading | Indicador visível em fetch de dados |
| GEN-12 | Dispositivos | Vários tamanhos de ecrã | Layout responsivo sem cortes |
| GEN-13 | Rotação | Portrait/landscape | Sem perda de dados nem quebras |
| GEN-14 | Notificações | Sino do dashboard | Lista atualiza em tempo real |
| GEN-15 | Segurança | Palavra-passe oculta por defeito | Toggle explícito para mostrar |

---

## Notas finais

- **Bottom navigation:** quatro entradas — **Dashboard**, **Vendas**, **Atividades**, **Menu**.
- **Padrão de cabeçalho:** verde escuro com título centrado em maiúsculas.
- **FAB (`+`):** verde, presente em listagens onde se cria novo recurso (Clientes, Assistências).
- **Cor do estado ativo:** ícone destacado em fundo claro na barra inferior.
- **Inconsistência detetada:** ecrã de **Atividades** usa em ambos os lados (gráfico) o ícone do separador "Vendas" — confirmar mapeamento `moduloVendas.png` ↔ Atividades.

> **Próximos prints recomendados** para completar o guia:
> - Detalhe de cliente (após tocar num cartão)
> - Detalhe de assistência
> - Telefonemas / Reuniões / Formações / Formadores (sub-módulos ainda sem prints)
> - Menu (4.º separador da nav inferior)
> - Estado de erro / vazio / sem internet
