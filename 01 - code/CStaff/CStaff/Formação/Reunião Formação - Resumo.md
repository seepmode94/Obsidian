<div align="center">

# Reunião Formação — Resumo

_CRM — reorganização de módulos para o fluxo da Formação_

**Data:** 2026-05-25

</div>

---

## Sumário

- Centralizar tudo no módulo _Ações_ com submódulos embutidos — acabar com saltos entre páginas.
- Eliminar texto livre → todos os campos selecionáveis (com opção "criar novo").
- Acrescentar estado _Pré-Ativo_ e bloquear progressão enquanto faltarem campos / anexos.
- Integrar Calendário CStaff, SIGO (CSV + recibos) e automatizar o Comprovativo de Frequência.
- _Decisão pendente:_ Contactos multi-tipo vs módulos dedicados a Formandos / Pacientes.

<div style="page-break-after: always;"></div>

## 1. Ações — submódulos

| Submódulo | O que muda |
|---|---|
| _Formador_ | Dropdown com formações ministradas; ao selecionar, autopreenche os campos relacionados. |
| _Sala_ | Novos campos: nome, morada, condições comerciais/pagamento, IVA, nº fatura, data pagamento, responsável + email. Pesquisa por dropdowns encadeados Região → Concelho → Cidade (mostra projetores disponíveis na área). |
| _Formandos_ | Dentro da Ação. Anexar certificados / justificativos / reclamações. Checkbox "está no SIGO". |
| _Sessões_ | Datas, hora início/fim, formandos em dropdown, _projetor atribuído_. Cada Ação tem duração definida = X sessões. |
| _Projetores_ (aba) | Inventário central de todos os projetores. Atribuição ao nível da _Sessão_ (não da Ação). Vê posição em tempo real, calendário de reservas por projetor, evita double-booking, cruza com filtro geográfico das salas, mantém histórico de utilização e dispara e-mail automático ao detentor a pedir devolução. |
| _DTP / Anexos_ (fim) | PPT, digitalização DTP, plano de sessão (auto), avaliações, relatórios. Sem anexos → ação não finaliza. Inclui verificação IEFP. |

<div style="page-break-after: always;"></div>

## 2. Estados e Fluxo

- Atualmente _6 estados_ → adicionar _Pré-Ativo_ (estados antes da criação efetiva).
- _Pré-Ativo_ só transita quando todos os campos obrigatórios estiverem preenchidos.
- _Comprovativo de Frequência Individual_ deixa de ser Word manual → gerado automaticamente via IEFP ↔ CRM.

## 3. Contactos

- Hoje agrega Formadores, Formandos, Médicos, Pacientes, Salas… via campo _Tipo_.
- Necessário separar _conteúdo sensível_ (ex.: pacientes invisíveis para colegas da Formação).
- _Questão em aberto:_

| Opção | Vantagens |
|---|---|
| Módulos próprios (Formandos, Pacientes) | Schema dedicado · permissões granulares · separação de dados sensíveis |
| Contactos unificado | 1 fonte de identidade · menos duplicação se a pessoa tem vários papéis |

![[anexos/crm-contactos-tipo.png|550]]

<div style="page-break-after: always;"></div>

## 4. Integrações

### 4.1 Calendário CStaff ↔ CRM
- Frame embebida no CRM com a vista mensal do CStaff: contadores diários (`Xaç. · Xform.`), cores por empresa e modalidade, entradas clicáveis abrem a ação.
- Campos dinâmicos por modalidade: _e-learning_ vs _presencial_ abrem tabelas diferentes.

![[anexos/cstaff-calendario.png|650]]

### 4.2 SIGO
- Importação de formandos via Excel preenchido pelo cliente + macros entre Excels.
- CRM passa a importar o CSV do SIGO.
- Integração dos recibos.
- Adaptar `Formandos_Template.xls` para preenchimento pelos formadores (fonte única).

![[anexos/sigo-formandos-template.png|550]]

### 4.3 Importação no CRM
- Campos obrigatórios definidos.
- Deduplicação de clientes + normalização (chave única).

<div style="page-break-after: always;"></div>

## 5. Outros pontos

- _Acessos IEFP_ — página nunca usada pelas colegas; manter em ambiente próprio.
- _Pasta do Cliente_ — ficheiros no servidor, informação no CRM; permite estado de candidaturas em massa.
- _NUTS II_ — campo a normalizar como local da ação.
- _Módulo IEFP_ — avaliar utilidade; consolidar ou remover se redundante.
- _Normalização_ — sem texto livre em lado nenhum; só listas selecionáveis com opção "criar novo".
- _Automação_ — princípio transversal a todos os pontos.

<div style="page-break-after: always;"></div>

## 6. Mapeamento do ecrã atual da Ação

![[anexos/crm-acao-mapeamento.png|700]]

| Secção | Estado | Notas |
|---|---|---|
| Seguimento | Manter | Datas de verificação, envio info, certificados, fecho, etc. |
| Localização / Sala | Expandir | Acrescentar: nome sala, condições comerciais/pagamento, IVA, _Fatura (em falta)_, responsável + email |
| Formadores | Novo | Dropdown com formações ministradas; autopreenche campos |
| Sessões | Novo | Início, fim, formandos (dropdown), _projetor atribuído à sessão_. Duração da Ação = nº fixo de sessões. |
| Projetor | Move-se | Sai do ecrã da Ação (campo único em Localização) e passa para o nível _Sessão_. Gestão central na aba _Projetores_ (inventário + calendário). |
| Formandos | Novo | Anexar documentos + checkbox SIGO |
| Fatura | Manter | Nº, valor, datas, valor pago |
| Atribuição | Manter | Atribuído a · Vendedor |
| Relações | Manter | Faturas · Sessões · Grupos de segurança |

> _A confirmar:_ campos legais/IEFP fora deste ecrã que precisem entrar no novo desenho.

<div style="page-break-after: always;"></div>

## 7. Próximos passos

- [ ] Definir submódulos de _Ações_ e arquitetura final.
- [ ] _Sala_ — novos campos + base de dados geográfica (Região → Concelho → Cidade) cruzada com projetores.
- [ ] _Formador_ — dropdown com autopreenchimento.
- [ ] _Formandos_ — módulo dentro da Ação.
- [ ] _Sessões_ — datas, horas, formandos em dropdown, projetor atribuído. Duração da Ação = nº fixo de sessões (regra a estipular).
- [ ] _Projetores_ — inventário central, calendário de reservas por projetor (validação anti-double-booking ao criar sessão), histórico de utilização e e-mail automático de devolução.
- [ ] _DTP/Anexos_ — módulo final; ação não finaliza sem anexos; ligar verificação IEFP.
- [ ] Confirmar onde se faz a _emissão de certificados_.
- [ ] _Calendário CStaff_ — integração + frame embebida no CRM.
- [ ] Campos dinâmicos por modalidade (e-learning vs presencial).
- [ ] Estado _Pré-Ativo_ — adicionar ao ciclo (6 → 7) e bloqueio até campos preenchidos.
- [ ] _Comprovativo de Frequência_ — automação IEFP ↔ CRM.
- [ ] _Pasta do cliente_ centralizada no CRM + estado de candidaturas em massa.
- [ ] _NUTS II_ — normalizar como local da ação.
- [ ] _SIGO_ — recibos + CSV de formandos; adaptar `Formandos_Template.xls` para formadores.
- [ ] _Importação CRM_ — campos obrigatórios + deduplicação.
- [ ] _IEFP_ — avaliar manter / consolidar / remover.
- [ ] _Contactos_ — regra de visibilidade para isolar dados sensíveis.
- [ ] Converter todo o texto livre em listas selecionáveis (com "criar novo").
- [ ] Validar se Formandos/Formadores ficam ocultos após migração para Sessões.

## 8. Pendências

- _Decisão de modelo:_ Contactos multi-tipo vs módulos dedicados a Formandos e Pacientes.
- Confirmar se o template SIGO suporta várias tipologias num só ficheiro.
- Confirmar local de _emissão de certificados_.
