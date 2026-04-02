# Comparação dos novos CRMs

## Notas comparadas
- [[Check-list CRM novo Seepmode!]]
- [[Check-list do CRM novo Tacovia!]]

## Ordem de análise
- Comparação feita de baixo para cima.
- validar módulo a módulo e depois confirmar se existem diferenças reais.

---

## ==Fichas de Aptidão==
### Diferença
- Tipo: estrutural
- `Módulo`
- `Seepmode`: módulo existente
- `Tacovia`: módulo inexistente

---

## ==Assistências==

### Diferença
- Tipo: sem diferenças relevantes
- `Edição / Detalhe / Vista de Lista / Criação rápida / Filtro`
- Conteúdo alinhado no essencial

---

## ==Acessos IEFP==

### Diferença
- Tipo: campos
- `Vista de Lista`
- `Seepmode`: inclui `ID [id]`
- `Tacovia`: não inclui `ID`
- `Edição / Detalhe / Criação rápida / Filtro`
- Sem diferenças relevantes

---

## ==Sessões==
### Diferença
- Tipo: estrutural
- `Módulo`
- `Seepmode`: orientado para `Relatórios agendados`
- `Tacovia`: orientado para `Sessões` de formação

---

## ==Formadores==

### Diferença
- Tipo: campos + estrutura

- `Edição / Detalhe / Criação rápida`
- `Seepmode`: campos extra `Training [training_id]`, `Assigned To [assigned_user_id]`, `Contact [contact_id]`, `Receipt Value [receipt_value]`, `Currency [currency_id]`
- `Tacovia`: campo extra `(preencher)`
- Diferença de nome: `Número da Factura` vs `Número da Fatura`

- `Vista de Lista`
- `Seepmode`: só inclui `ID`, `Nome`, `Valor/Hora`, `Valor Total`, `Número da Factura`, `Data de pagamento`
- `Tacovia`: inclui `Ação`, `Ação de Formação`, `Cliente`, `Data da formação`, `Nº de Formandos da Ação`, `Valor do recibo (€)`, `Número da Fatura`, `Data da fatura`, `Data Entrega Recibo`, `Dossier entregue pelo formador/a`, `Data verificação do Dossier`, `Observações`

- `Filtro`
- `Seepmode`: `ID`, `Nome`, `Valor/Hora`, `Valor Total`, `Número da Factura`, `Data de pagamento`
- `Tacovia`: `Nome`, `Data da fatura`, `Dossier entregue pelo formador/a`, `Ação de Formação`, `Data da formação`, `Número de Formandos da Ação`, `Data de pagamento`, `Data Entrega Recibo`, `Valor Total`

---

## ==Formandos==

### Diferença
- Tipo: nomenclatura
- `Edição / Detalhe / Vista de Lista / Criação rápida / Filtro`
- `Nº ação` vs `Nº acção`
- `Nº Referência` vs `N/ Referência`
- `Sigo nº` vs `Sigo nº:`
- `Data Início Submissão IEPF Formando` vs `Data Inicio Submissão IEFP Formando`

---

## ==Formações==

### Diferença
- Tipo: nomenclatura
- `Vista de edição`
- `Seepmode`: `Nº Formandos [trainees_number]`
- `Tacovia`: `Nº Faturados`
- `Vista de detalhe / Vista de Lista / Criação rápida / Filtro`
- Sem diferenças relevantes

---

## ==Emails==

### Diferença
- Tipo: sem diferenças relevantes
- `Edição / Detalhe / Vista de Lista / Criação rápida / Filtro`
- Conteúdo alinhado no essencial

---

## ==Notas==

### Diferença
- Tipo: sem diferenças relevantes
- `Edição / Detalhe / Vista de Lista / Criação rápida / Filtro`
- Conteúdo alinhado no essencial

---

## ==Documentos==

### Diferença
- Tipo: sem diferenças relevantes
- `Edição / Detalhe / Vista de Lista / Criação rápida / Filtro`
- Conteúdo alinhado no essencial

---

## ==Reuniões==

### Diferença
- Tipo: sem diferenças relevantes
- `Edição / Detalhe / Vista de Lista / Criação rápida / Filtro`
- Conteúdo alinhado no essencial

---

## ==Telefonemas==

### Diferença
- Tipo: sem diferenças relevantes
- `Edição / Detalhe / Vista de Lista / Criação rápida / Filtro`
- Conteúdo alinhado no essencial

---

## ==Contactos==

### Diferença
- Tipo: sem diferenças relevantes
- `Edição / Detalhe / Vista de Lista / Criação rápida / Filtro`
- Conteúdo alinhado no essencial

---

## ==Contratos==

### Diferença
- Tipo: estrutura + nomenclatura + campos
- `Edição / Detalhe`
- `Seepmode`: mantém no bloco principal campos como `Annuity`, `Net Value €`, `Version`, `Renewal Date`, `Pack Value`, `Pack Status`, `Company`, `Currency`, `Total`, `Subtotal`, `Taxa de envio`, `Total final`
- `Tacovia`: concentra a `Visão geral` em PT e separa totais em `Itens de linha`
- `Tacovia`: inclui `Data criação`
- `Vista de Lista`
- `Seepmode`: lista curta com `ID`, `Annuity` e poucos campos
- `Tacovia`: lista mais completa com `Anuidade`, `Versão`, `Data Renovação`, `Valor Líquido €`, `Pack`, `Estado do Pack`, `Valor do Pack`, `Assigned To`, `Data criação`
- `Criação rápida`
- Diferenças de nomes entre campos como `Annuity` vs `Anuidade`, `Version` vs `Versão`, `Renewal Date` vs `Data Renovação`, `Company` vs `Empresa`

---

## ==Faturas==

### Diferença
- Tipo: estrutura + nomenclatura + campos
- `Edição / Detalhe`
- `Seepmode`: mais campos no bloco principal, incluindo totais e campos comerciais
- `Tacovia`: `Visão geral` mais curta + `Itens de linha`
- `Tacovia`: inclui `Data de criação`
- Diferenças de nomes: `number`, `type_c`, `Company`, `Invoicing Notes`, `Payment Reminder`
- `Vista de Lista`
- `Seepmode`: lista curta
- `Tacovia`: lista mais completa com `number`, `Descrição`, `total_amount`, `subtotal_amount`, `Valor Aberto (€)`, `Valor Pago (€)`, `Quote Date`, `Renovation Value`, `Vendedor`, `Data de criação`, `Atribuído a`, `created_by_name`
- `Criação rápida`
- Conteúdo próximo, com diferenças de nomenclatura como `Número da fatura` vs `number`, `Tipo` vs `type_c`, `Empresa` vs `Company`, `Notas da Faturação` vs `Invoicing Notes`
- `Seepmode`: linha vazia no fim da vista

---

## ==Propostas==

### Diferença
- Tipo: estrutura + nomenclatura + campos

- `Edição / Detalhe`
- `Seepmode`: um único bloco com todos os campos
- `Tacovia`: separa `Visão geral` e `Itens de linha`
- `Seepmode`: usa `Fase proposta [quote_stage]`, `Válida até [valid_until]`, `Condições de pagamento [payment_terms]`, `Expected Close Date [expected_close_date]`, `Billing Notes [billing_notes]`, `Empresa [company]`, `Currency [currency]`, `Total final [grand_total]`, `Company [empresa_c]`, `Notas para a Faturação [invoicing_notes_c]`
- `Tacovia`: usa `number`, `stage`, `expiration`, `term`, `Company`, `approval_issue`
- `Tacovia`: coloca os totais em `Itens de linha` com `currency_id`, `Line Items`, `total_amt`, `Desconto`, `subtotal_amount`, `Portes de envio`, `shipping_tax_amt`, `Taxa`, `total_amount`

- `Vista de Lista`
- `Seepmode`: `ID`, `Título`, `Clientes`, `Fase proposta`, `Válida até`, `Condições de pagamento`
- `Tacovia`: `number`, `Título`, `Clientes`, `Company`, `Data prevista fecho`, `billing_address_city`, `billing_address_state`, `total_amount`, `total_amt`, `stage`, `Situação de aprovação`, `Atribuído a`, `Date Created`, `Date Modified`, `created_by_name`

- `Criação rápida / Filtro`
- Sem diferenças relevantes

---

## ==Clientes==

### Diferença
- Tipo: campos + nomenclatura
- `Edição / Detalhe / Vista de Lista / Filtro`
- Sem diferenças relevantes

- `Criação rápida`
- `Tacovia`: mais campos como `NUTS II`, `Nº Cond.`, `Nº Estab.`, `Enviar lembrete de Pagamento`, `Descrição`, `Membro de`, `Área de atividade`, `Telefone de trabalho`, `Sítio Internet`, `Endereço de faturação`, `Billing State`, `Billing Country`, `Shipping City`, `Shipping Postal Code`, `Rating`
- `Seepmode`: não mostra esses campos e distingue dois campos `Tipo`, um deles como `Tipo [client_service_type_c]` e outro como `Tipo: [account_type]`

---

## Próximo passo
- Continuar a partir desta base e validar cada módulo campo a campo, mantendo esta ordem de baixo para cima.
