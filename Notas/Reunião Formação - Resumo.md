<div align="center">

<u>CRM — reorganização de módulos para o fluxo da Formação</u>

<u>Data: 2026-05-25</u>

</div>

---

## Sumário

- Centralizar tudo no módulo <u>Ações</u> com submódulos embutidos — acabar com saltos entre páginas.
- Eliminar texto livre → todos os campos selecionáveis (com opção "criar novo").
- Acrescentar estado <u>Pré-Ativo</u> e bloquear progressão enquanto faltarem campos / anexos.
- Integrar Calendário CStaff, SIGO (CSV + recibos) e automatizar o Comprovativo de Frequência.
- <u>Decisão pendente:</u> Contactos multi-tipo vs módulos dedicados a Formandos / Pacientes.

<div style="page-break-after: always;"></div>

## 1. Ações — submódulos

| Submódulo | O que muda |
|---|---|
| <u>Formador</u> | Dropdown com formações ministradas; ao selecionar, autopreenche os campos relacionados. |
| <u>Sala</u> | Novos campos: nome, morada, condições comerciais/pagamento, IVA, nº fatura, data pagamento, responsável + email. Pesquisa por dropdowns encadeados Região → Concelho → Cidade (mostra projetores disponíveis na área). |
| <u>Formandos</u> | Dentro da Ação. Anexar certificados / justificativos / reclamações. Checkbox "está no SIGO". |
| <u>Sessões</u> | Datas, hora início/fim, formandos em dropdown, <u>projetor atribuído</u>. Cada Ação tem duração definida = X sessões. |
| <u>Projetores</u> (aba) | Inventário central de todos os projetores. Atribuição ao nível da <u>Sessão</u> (não da Ação). Vê posição em tempo real, calendário de reservas por projetor, evita double-booking, cruza com filtro geográfico das salas, mantém histórico de utilização e dispara e-mail automático ao detentor a pedir devolução. |
| <u>DTP / Anexos</u> (fim) | PPT, digitalização DTP, plano de sessão (auto), avaliações, relatórios. Sem anexos → ação não finaliza. Inclui verificação IEFP. |

<div style="page-break-after: always;"></div>

## 2. Estados e Fluxo

- Atualmente <u>6 estados</u> → adicionar <u>Pré-Ativo</u> (estados antes da criação efetiva).
- <u>Pré-Ativo</u> só transita quando todos os campos obrigatórios estiverem preenchidos.
- <u>Comprovativo de Frequência Individual</u> deixa de ser Word manual → gerado automaticamente via IEFP ↔ CRM.

## 3. Contactos

- Hoje agrega Formadores, Formandos, Médicos, Pacientes, Salas… via campo <u>Tipo</u>.
- Necessário separar <u>conteúdo sensível</u> (ex.: pacientes invisíveis para colegas da Formação).
- <u>Questão em aberto:</u>

| Opção | Vantagens |
|---|---|
| Módulos próprios (Formandos, Pacientes) | Schema dedicado · permissões granulares · separação de dados sensíveis |
| Contactos unificado | 1 fonte de identidade · menos duplicação se a pessoa tem vários papéis |

![[anexos/crm-contactos-tipo.png|550]]

<div style="page-break-after: always;"></div>

## 4. Integrações

### 4.1 Calendário CStaff ↔ CRM
- Frame embebida no CRM com a vista mensal do CStaff: contadores diários (`Xaç. · Xform.`), cores por empresa e modalidade, entradas clicáveis abrem a ação.
- Campos dinâmicos por modalidade: <u>e-learning</u> vs <u>presencial</u> abrem tabelas diferentes.

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

- <u>Acessos IEFP</u> — página nunca usada pelas colegas; manter em ambiente próprio.
- <u>Pasta do Cliente</u> — ficheiros no servidor, informação no CRM; permite estado de candidaturas em massa.
- <u>NUTS II</u> — campo a normalizar como local da ação.
- <u>Módulo IEFP</u> — avaliar utilidade; consolidar ou remover se redundante.
- <u>Normalização</u> — sem texto livre em lado nenhum; só listas selecionáveis com opção "criar novo".
- <u>Automação</u> — princípio transversal a todos os pontos.

<div style="page-break-after: always;"></div>

## 6. Mapeamento do ecrã atual da Ação

![[anexos/crm-acao-mapeamento.png|700]]

| Secção             | Estado   | Notas                                                                                                                                         |
| ------------------ | -------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| Seguimento         | Manter   | Datas de verificação, envio info, certificados, fecho, etc.                                                                                   |
| Localização / Sala | Expandir | Acrescentar: nome sala, condições comerciais/pagamento, IVA, <u>Fatura (em falta)</u>, responsável + email                                         |
| Formadores         | Novo     | Dropdown com formações ministradas, pagamento, IVA, <u>Fatura (em falta)</u>, responsável + email; autopreenche campos ao selecionar o formador    |
| Sessões            | Novo     | Início, fim, formandos (dropdown), <u>projetor atribuído à sessão</u>. Duração da Ação = nº fixo de sessões.                                       |
| Projetor           | Move-se  | Sai do ecrã da Ação (campo único em Localização) e passa para o nível <u>Sessão</u>. Gestão central na aba <u>Projetores</u> (inventário + calendário). |
| Formandos          | Novo     | Anexar documentos + checkbox SIGO                                                                                                             |
| Fatura             | Manter   | Nº, valor, datas, valor pago, documentos em anexo                                                                                             |
| Atribuição         | Manter   | Atribuído a · Vendedor                                                                                                                        |
| Relações           | Manter   | Faturas · Sessões · Grupos de segurança                                                                                                       |


<div style="page-break-after: always;"></div>

## 7. Próximos passos

- [ ] <u>Sala</u> — novos campos + base de dados geográfica (Região → Concelho → Cidade) cruzada com projetores.
- [ ] <u>Formador</u> — dropdown com autopreenchimento.
- [ ] <u>Formandos</u> — módulo dentro da Ação.
- [ ] <u>Sessões</u> — datas, horas, formandos em dropdown, projetor atribuído. Duração da Ação = nº fixo de sessões (regra a estipular).
- [ ] <u>Projetores</u> — inventário central, calendário de reservas por projetor (validação anti-double-booking ao criar sessão), histórico de utilização e e-mail automático de devolução.
- [ ] <u>DTP/Anexos</u> — módulo final; ação não finaliza sem anexos; ligar verificação IEFP.
- [ ] Confirmar onde se faz a <u>emissão de certificados</u>.
- [ ] <u>Calendário CStaff</u> — integração + frame embebida no CRM.
- [ ] Campos dinâmicos por modalidade (e-learning vs presencial).
- [ ] Estado <u>Pré-Ativo</u> — adicionar ao ciclo (6 → 7) e bloqueio até campos preenchidos.
- [ ] <u>Comprovativo de Frequência</u> — automação IEFP ↔ CRM.
- [ ] <u>Pasta do cliente</u> centralizada no CRM + estado de candidaturas em massa.
- [ ] <u>NUTS II</u> — normalizar como local da ação.
- [ ] <u>SIGO</u> — recibos + CSV de formandos; adaptar `Formandos_Template.xls` para formadores.
- [ ] <u>Importação CRM</u> — campos obrigatórios + deduplicação.
- [ ] <u>IEFP</u> — avaliar manter / consolidar / remover.
- [ ] <u>Contactos</u> — regra de visibilidade para isolar dados sensíveis.
- [ ] Converter todo o texto livre em listas selecionáveis (com "criar novo").
- [ ] Validar se Formandos/Formadores ficam ocultos após migração para Sessões.
- [ ] automatizar via scripts e scraping a emissão de certificados de conclusao e os estados no iefp

<div style="page-break-before: always;"></div>

## 8. Pendências

- <u>Decisão de modelo:</u> Contactos multi-tipo vs módulos dedicados a Formandos e Pacientes.
- Confirmar se o template SIGO suporta várias tipologias num só ficheiro.
