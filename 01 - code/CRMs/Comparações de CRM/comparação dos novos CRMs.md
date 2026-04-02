# Comparação dos novos CRMs

## Notas comparadas
- [[Check-list CRM novo Seepmode!]]
- [[Check-list do CRM novo Tacovia!]]

## Ordem de análise
- Comparação feita de baixo para cima.
- A ideia é validar módulo a módulo e depois confirmar se existem diferenças reais.

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
- Conteúdo alinhado no essencial

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
- `Seepmode`: campos extra `Training`, `Assigned To`, `Contact`, `Receipt Value`, `Currency`
- `Tacovia`: campo extra `(preencher)`
- `Vista de Lista`
- `Tacovia`: mais detalhe com `Ação`, `Ação de Formação`, `Cliente`, `Data da formação`, `Nº de Formandos da Ação`
- `Filtro`
- `Tacovia`: mais campos do que a `Seepmode`

---

## ==Formandos==

### Diferença
- Tipo: nomenclatura
- `Edição / Detalhe / Vista de Lista / Criação rápida / Filtro`
- `Nº ação` vs `Nº acção`
- `Nº Referência` vs `N/ Referência`
- `IEPF` na `Seepmode` vs `IEFP` na `Tacovia`

---

## ==Formações==

### Diferença
- Tipo: nomenclatura
- `Vista de edição`
- `Seepmode`: `Nº Formandos [trainees_number]`
- `Tacovia`: `Nº Faturados`
- `Vista de detalhe / Vista de Lista / Criação rápida / Filtro`
- Conteúdo alinhado no essencial

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
- `Seepmode`: mistura PT/EN e mantém totais/campos comerciais no bloco principal
- `Tacovia`: concentra a `Visão geral` em PT e separa totais em `Itens de linha`
- `Tacovia`: inclui `Data criação`
- `Vista de Lista`
- `Seepmode`: lista curta com `ID`, `Annuity` e poucos campos
- `Tacovia`: lista mais completa com `Anuidade`, `Versão`, `Data Renovação`, `Valor Líquido €`, `Pack`, `Estado do Pack`, `Valor do Pack`, `Assigned To`, `Data criação`
- `Criação rápida`
- Conteúdo próximo, mas com diferenças de nomenclatura PT/EN

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
- `Seepmode`: um único bloco com totais e campos comerciais
- `Tacovia`: `Visão geral` + `Itens de linha`
- Diferenças de nomes: `number`, `stage`, `expiration`, `term`, `Company`, `approval_issue`
- `Vista de Lista`
- `Seepmode`: lista curta
- `Tacovia`: lista mais completa com `number`, `Company`, `Data prevista fecho`, `billing_address_city`, `billing_address_state`, `total_amount`, `total_amt`, `stage`, `Situação de aprovação`, `Atribuído a`, `Date Created`, `Date Modified`, `created_by_name`
- `Criação rápida / Filtro`
- Conteúdo alinhado no essencial

---

## ==Clientes==

### Diferença
- Tipo: campos + nomenclatura
- `Edição / Detalhe / Lista / Filtro`
- Conteúdo alinhado no essencial
- Diferenças de apresentação: `Mais detalhes (More Information)` vs `Mais detalhes`, `Outro (Assignment)` vs `Outro`, `Visão geral (Account Information)` vs `Visão geral`
- `Criação rápida`
- `Tacovia`: mais campos como `NUTS II`, `Nº Cond.`, `Nº Estab.`, `Enviar lembrete de Pagamento`, `Descrição`, `Membro de`, `Área de atividade`, `Telefone de trabalho`, `Sítio Internet`, `Endereço de faturação`, `Billing State`, `Billing Country`, `Shipping City`, `Shipping Postal Code`, `Rating`
- `Seepmode`: menos campos e rótulos mais técnicos como `CAE [accounts_cae_c]`, `Tipo [client_service_type_c]`

---

## Próximo passo
- Continuar a partir desta base e validar cada módulo campo a campo, mantendo esta ordem de baixo para cima.
