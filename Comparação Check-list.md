# Comparação Check-list

## Objetivo
Comparar `check-list Tacovia.md` com `check-list Seepmode.md`, focando na organização dos módulos e nas secções principais, para identificar o que ainda falta do lado da Seepmode.

## Módulos existentes nos dois ficheiros
- Clientes
- Propostas
- Faturas
- Contratos
- Contactos
- Telefonemas
- Reuniões
- Documentos
- Notas
- Emails
- Formações
- Formandos
- Formadores
- Sessões
- Acessos IEFP
- Assistências
- Medicina Ocupacional
- Fichas de Aptidão

## Módulos alinhados na estrutura principal
- Clientes
- Propostas
- Faturas
- Reuniões
- Notas
- Emails
- Formandos
- Formadores

## Módulos com faltas ou diferenças relevantes na Seepmode




### Documentos
- Na `Vista de detalhe`, Tacovia usa `##### LBL_REVISIONS_PANEL`.
- Na Seepmode existe `##### Outro` em vez desse bloco.

### Formações
- Quase alinhado.
- Em `Criação rápida` falta:
- `##### Recursos Administrativos`

### Sessões
- Em Tacovia, `Vista de Edição` e `Vista de Detalhe` estão separadas.
- Em Seepmode estão fundidas em `### Vista de edição/Vista de detalhe:`.
- O conteúdo principal existe, mas a organização não coincide.

### Acessos IEFP
- Existem as vistas principais, mas a estrutura está incompleta.
- Faltam:
- `#### Predefinido` em `Vista de Lista`
- `#### Predefinido` em `Criação rápida`
- `#### Predefinido` em `Filtro`

### Assistências
- Estrutura incompleta em relação à Tacovia.
- Faltam:
- `#### Predefinido` em `Vista de Lista`
- `#### Predefinido` em `Filtro`

### Medicina Ocupacional
- É um dos módulos mais diferentes.
- Em Tacovia, a estrutura está separada por:
- `### Vista de Edição`
- `### Vista de Detalhe`
- `### Criação rápida`
- Em Seepmode, tudo está agregado em:
- `### Vista de edição/Vista de detalhe/Criação rápida:`
- Além disso, vários blocos com nomes próprios em Tacovia aparecem como `##### FMO` na Seepmode.
- Principais diferenças de nome/organização:
- `Passatempos` aparece como `FMO`
- `Recomendações` aparece como `FMO`
- `Observações Finais` aparece como `FMO`
- `Outros` aparece como `FMO`
- A `Vista de Lista` e o `Filtro` existem em Seepmode, mas a organização geral do módulo ainda não está equivalente à da Tacovia.

### Fichas de Aptidão
- É o módulo mais incompleto na Seepmode.
- Em Tacovia, o módulo está organizado com vários blocos distintos.
- Na Seepmode, a distribuição das secções entre `Vista de edição`, `Vista de detalhe` e `Criação rápida` ainda não corresponde à organização da Tacovia.
- Blocos que existem em Tacovia e devem ser validados/organizados na Seepmode:
- `##### Predefinido`
- `##### Serviço de saúde do trabalho`
- `##### Trabalhador`
- `##### Posto de trabalho`
- `##### Exame de saúde e resultado de aptidão`
- `##### Recomendações`
- `##### Médico do Trabalho`
- `##### Gestor`
- `##### Assinaturas`

## Diferenças gerais entre os ficheiros
- `check-list Tacovia.md` está mais normalizado por vista.
- `check-list Seepmode.md` tem vários módulos onde as vistas estão agregadas numa só linha, por exemplo:
- `Vista de edição/Vista de detalhe`
- `Vista de edição/Vista de detalhe/Criação rápida`
- Em vários módulos da Seepmode faltam subtítulos `Predefinido` onde Tacovia os usa.
- Em `Medicina Ocupacional`, a Seepmode reutiliza `FMO` em vez de nomes mais específicos dos blocos.
- Em `Contratos`, há um erro claro de hierarquia de títulos.

## Prioridade de revisão sugerida
1. Fichas de Aptidão
2. Medicina Ocupacional
3. Contactos
4. Contratos
5. Acessos IEFP
6. Assistências
7. Sessões
8. Telefonemas
9. Documentos
10. Formações
