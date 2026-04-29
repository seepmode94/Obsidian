# Issue Web: ajustes em Recrutamento, Centro de Operações, Detalhe do Colaborador e Excepções

## Intro

Páginas afectadas:

- **Recrutamento** — vagas mal organizadas, sem agrupamento por departamento nem identificação da empresa, sem suporte a múltiplas vagas e com departamentos em falta na listagem.
- **Centro de Operações** — listagem de colaboradores por departamento incorrecta (mostra inactivos), sem indicação de vagas abertas no mesmo local, SST sem delegações representadas e dados não alinhados com o Excel de necessidades de vagas.
- **Detalhe do Colaborador (Dep. Técnico)** — sem local para registar o ID do terminal de picagem Dahua.
- **Excepções** — opções limitadas: gestor não consegue ter em paralelo as acções de validar e assumir falta.

## Alterações

### Recrutamento
- Agrupar vagas por departamento.
- Mostrar empresa associada a cada vaga.
- Permitir múltiplas vagas em simultâneo (mesmo dep./empresa).
- Inserir todos os departamentos em falta.

### Centro de Operações
- Filtrar colaboradores inactivos da listagem por departamento.
- Mostrar nº de vagas abertas no mesmo local do departamento.
- SST: suportar e apresentar delegações.
- Alinhar números/necessidades com o Excel de vagas existente.

### Detalhe do Colaborador (Dep. Técnico)
- Nova aba para inserir o ID do terminal de picagem Dahua.

### Excepções
- Duas acções disponíveis em paralelo: **Validar** (não cobra falta) e **Assumir falta**.
- Manter regras de negócio já implementadas para cada uma.

## Resultado esperado

Recrutamento legível e completo (vagas agrupadas por dep./empresa, múltiplas vagas suportadas, todos os deps. presentes); Centro de Operações coerente (apenas colaboradores activos, vagas visíveis, SST com delegações, dados alinhados com Excel); colaboradores do Dep. Técnico com ID de terminal Dahua associado no detalhe; e gestor com as duas acções de tratamento de excepções sempre disponíveis sem alterar regras existentes.
