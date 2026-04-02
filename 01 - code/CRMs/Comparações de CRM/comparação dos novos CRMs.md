# Comparação dos novos CRMs

## Notas comparadas
- [[Check-list CRM novo Seepmode!]]
- [[Check-list do CRM novo Tacovia!]]

## Resumo
- A maior parte dos módulos tem conteúdo equivalente entre as duas notas.
- As diferenças mais relevantes concentram-se em `Sessões`, `Documentos`, `Medicina Ocupacional`, `Formações` e `Fichas de Aptidão`.
- A nota da `Seepmode` inclui o módulo `Fichas de Aptidão`, que não aparece na nota da `Tacovia`.

## Módulos sem diferenças relevantes
- Clientes
- Propostas
- Faturas
- Contratos
- Contactos
- Telefonemas
- Reuniões
- Notas
- Emails
- Formandos
- Formadores
- Assistências
- Acessos IEFP

## Diferenças relevantes por módulo

### Sessões
- Na `Tacovia`, o módulo está orientado para sessões de formação.
- Na `Seepmode`, o módulo está configurado para relatórios agendados.
- Na `Tacovia` aparecem campos como `Formação`, `Nome`, `Abreviatura`, `Sessões`, `Descrição` e `Atribuído a`.
- Na `Seepmode` aparecem campos como `Nome`, `Situação`, `Relatórios`, `Agendar`, `Última execução`, `Destinatários do email` e `Descrição`.
- Trata-se de uma diferença real de finalidade e não apenas de organização.

### Documentos
- Na `Seepmode`, na `Vista de detalhe`, surge o campo `Fichas de Aptidão`.
- Na `Tacovia`, na `Vista de detalhe`, aparecem elementos que não estão refletidos da mesma forma na `Seepmode`:
- `Faturas(Histórico)`
- `(preencher)`
- `Revisão criada por`
- `Data de criação da última revisão`
- `Situação`
- `Data de criação`
- `Data de alteração`
- Na `Vista de Lista`, a `Tacovia` inclui `Nome do documento: [document_name]`, que não está assinalado na `Seepmode`.

### Medicina Ocupacional
- Existem diferenças de conteúdo e de nomenclatura entre os dois check-lists.
- Na `Tacovia`, aparece `Rastreio oftalmológico`; na `Seepmode`, surge `Rastreio otorrinolingolo`.
- Depois de `Patologia Apresentada`, a `Tacovia` usa `Recomendações`, enquanto na `Seepmode` esse bloco surge como `FMO`.
- Na `Vista de Lista`, a `Seepmode` inclui `Data de Nascimento` e `Sexo`, que não estão refletidos na `Tacovia`.
- Nos `Filtros`, a `Seepmode` também inclui `Criado por`.

### Formações
- A diferença principal está na `Vista de Criação Rápida`.
- Na `Tacovia`, existe o bloco `Recursos Administrativos`, que não aparece nessa vista na `Seepmode`.
- Ainda assim, esse bloco existe na `Seepmode` noutras vistas, por isso a diferença parece ser localizada.

### Fichas de Aptidão
- Este módulo aparece na `Seepmode` e não está presente na nota da `Tacovia`.
- O conteúdo da `Seepmode` está detalhado por blocos como `Company Information`, `Service Organization`, `Worker Information`, `Work Analysis`, `Exam`, `Recommendations`, `Doctor`, `Assignment` e `Signatures`.
- Esta é a ausência estrutural mais evidente entre as duas notas.

## Mapa de inconsistências

| Módulo | Campo / Bloco | Seepmode | Tacovia | Observação |
|---|---|---|---|---|
| Sessões | Estrutura do módulo | Relatórios agendados | Sessões de formação | Diferença de finalidade |
| Sessões | Campo principal | Relatórios | Sessões | Diferença de conteúdo |
| Sessões | Campo | Situação | Abreviatura | Diferença de conteúdo |
| Sessões | Campo | Agendar | — | Campo a mais na Seepmode |
| Sessões | Campo | Última execução | — | Campo a mais na Seepmode |
| Sessões | Campo | Destinatários do email | — | Campo a mais na Seepmode |
| Sessões | Filtro | Meus itens | — | Campo a mais na Seepmode |
| Sessões | Filtro | Todos os endereços de email | — | Campo a mais na Seepmode |
| Sessões | Campo | — | Formação | Em falta na Seepmode |
| Sessões | Campo | — | Atribuído a | Em falta na Seepmode |
| Documentos | Vista de detalhe | Fichas de Aptidão | — | Campo a mais na Seepmode |
| Documentos | Vista de detalhe | — | Faturas(Histórico) | Em falta na Seepmode |
| Documentos | Vista de detalhe | — | (preencher) | Em falta na Seepmode |
| Documentos | Vista de detalhe | — | Revisão criada por | Em falta na Seepmode |
| Documentos | Vista de detalhe | — | Data de criação da última revisão | Em falta na Seepmode |
| Documentos | Vista de detalhe | — | Data de alteração | Em falta na Seepmode |
| Documentos | Vista de Lista | — | Nome do documento: [document_name] | Em falta na Seepmode |
| Medicina Ocupacional | Exame complementar | Rastreio otorrinolingolo | Rastreio oftalmológico | Diferença de conteúdo |
| Medicina Ocupacional | Bloco após `Patologia Apresentada` | FMO | Recomendações | Diferença de nomenclatura |
| Medicina Ocupacional | Vista de Lista | Data de Nascimento | — | Campo a mais na Seepmode |
| Medicina Ocupacional | Vista de Lista | Sexo | — | Campo a mais na Seepmode |
| Medicina Ocupacional | Filtro | Criado por | — | Campo a mais na Seepmode |
| Formações | Criação rápida | — | Recursos Administrativos | Em falta na Seepmode nesta vista |
| Fichas de Aptidão | Estrutura do módulo | Existe | — | Módulo apenas presente na Seepmode |

## Conclusão
- Os dois check-lists estão alinhados na maioria dos módulos principais.
- `Sessões` é o módulo com a diferença funcional mais clara entre os dois CRMs.
- `Documentos` e `Medicina Ocupacional` concentram a maior parte das diferenças de campos.
- `Fichas de Aptidão` é um módulo exclusivo da nota `Check-list CRM novo Seepmode!`.
