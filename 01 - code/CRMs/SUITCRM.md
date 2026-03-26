O objetivo desta integração é permitir que o projeto (seja um site, app ou sistema interno) comunique com o CRM para:

- **Sincronizar Contactos:** Criar ou atualizar leads automaticamente.
    
- **Gerir Tarefas:** Agendar atividades baseadas em ações do utilizador.
    
- **Centralizar Dados:** Garantir que o histórico do cliente está sempre atualizado.
    

###  Implementação Passo a Passo

Apresento um exemplo de como estruturar o ficheiro.
```env
CRM_API_URL=[https://(teu-crm)-link.com/api/v8](https://teu-crm-link.com/api/v8)
CRM_CLIENT_ID=(teu_id_aqui)
CRM_CLIENT_SECRET=(tua_chave_secreta_aqui)
```

🏗️ Arquitetura de Contentores (Docker) Garante que o teu `docker-compose.yml` permite a comunicação entre os serviços:

```
yaml services: app: build: . env_file: .env depends_on: - crm-db crm-db: image: mariadb:10.6 environment: MYSQL_DATABASE: crm_data
```

📚 **Explicação das Etapas e Instruções** 
1. **Interfaces TS:** No teu ambiente de trabalho, o TypeScript ajuda-te a saber exatamente quais campos (como `first_name`) o CRM espera, evitando que o código quebre em produção. 
2. **Singleton Pattern:** O uso do `getInstance()` garante que não cries centenas de ligações desnecessárias à API/BD do CRM, poupando memória no teu contentor Docker. 
3. **Environment Variables:** No Next.js, lembra-te de prefixar com `NEXT_PUBLIC_` apenas o que for para o frontend. Dados sensíveis do CRM devem ficar apenas no lado do servidor (Node).
4. **Docker Networking:** Como usas Docker, lembra-te de que no `.env`, o host da base de dados não será `localhost`, mas sim o nome do serviço definido no teu ficheiro YAML (ex: `crm-db`).**

**Queries Essenciais**

O e-mail no SuiteCRM não fica na tabela `leads`, mas sim numa relação complexa. Esta query simplifica essa busca:

```
SELECT 
    l.id, 
    l.first_name, 
    l.last_name, 
    ea.email_address,
    l.date_entered
FROM leads l
INNER JOIN email_addr_bean_rel eabr ON l.id = eabr.bean_id AND eabr.bean_module = 'Leads'
INNER JOIN email_addresses ea ON eabr.email_address_id = ea.id
WHERE l.deleted = 0 
  AND eabr.deleted = 0
ORDER BY l.date_entered DESC
LIMIT 10;
```

#### B. Relacionar Leads com Contas (Companies)

Se precisares de saber a que empresa um lead pertence no teu projeto Next.js:

```
SELECT 
    l.first_name AS lead_nome, 
    a.name AS empresa_nome
FROM leads l
JOIN accounts_leads al ON l.id = al.lead_id
JOIN accounts a ON al.account_id = a.id
WHERE l.deleted = 0 AND a.deleted = 0;
```

#### C. Inserir um novo Lead via SQL (Manual/Seed)

Embora recomendemos usar a API via Node.js, para testes ou _seeding_ no Docker, podes usar isto:

```
INSERT INTO leads (id, first_name, last_name, status, date_entered)
VALUES (UUID(), 'João', 'Silva', 'New', NOW());
```
[^1]: O SuiteCRM usa UUIDs (v4) como chaves primárias, não inteiros auto-incrementais.

### **Implementação no Node.js (TypeScript)**

Para executares estas queries no teu projeto, podes usar bibliotecas como `mysql2` ou um ORM como o **Prisma** ou **TypeORM**. Aqui está um exemplo rápido com `mysql2`:

```
import mysql from 'mysql2/promise';

async function getRecentLeads() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST, // Nome do serviço no Docker
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
  });

  const query = `SELECT first_name, last_name FROM leads WHERE deleted = 0 LIMIT 5`;
  const [rows] = await connection.execute(query);
  
  return rows;
}
```

### 📚 Documentação dos Campos Importantes

- **`deleted`**: No SuiteCRM, quase nada é apagado permanentemente. O campo é marcado como `1`. Filtra sempre por `deleted = 0`.
    
- **`id`**: Lembra-te que é uma string (Char 36).
    
- **`date_entered` / `date_modified`**: Úteis para sincronização incremental de dados entre o CRM e o teu sistema.