
```SQL
USE seepmode_suitecrm_db;

  

-- Truncate tables in smaller batches to avoid statement length issues

  

-- Accounts (Clientes)

TRUNCATE TABLE accounts;

TRUNCATE TABLE accounts_audit;

TRUNCATE TABLE accounts_contacts;

TRUNCATE TABLE accounts_cstm;

TRUNCATE TABLE accounts_opportunities;

TRUNCATE TABLE accounts_project_1_c;

TRUNCATE TABLE accounts_sdmod_capability_1_c;

TRUNCATE TABLE accounts_sdmod_contracts_manager_1_c;

TRUNCATE TABLE accounts_sdmod_training_1_c;

TRUNCATE TABLE accounts_sdmod_training_control_1_c;

  
  

-- Faturas

TRUNCATE TABLE sdmod_contracts;

TRUNCATE TABLE sdmod_contracts_accounts_c;

TRUNCATE TABLE sdmod_contracts_audit;

TRUNCATE TABLE sdmod_contracts_cstm;

TRUNCATE TABLE sdmod_contracts_documents_c;

TRUNCATE TABLE sdmod_contracts_sdmod_renewals_c;

  
  

-- Faturas Descontinuado ()

  

TRUNCATE TABLE aos_invoices;

TRUNCATE TABLE aos_invoices_audit;

  
  

-- Anexos (sdmod_renewals)

TRUNCATE TABLE sdmod_renewals;

TRUNCATE TABLE sdmod_renewals_audit;

TRUNCATE TABLE sdmod_renewals_cstm;

  
  

-- Contratos

TRUNCATE TABLE sdmod_contracts_manager;

TRUNCATE TABLE sdmod_contracts_manager_audit;

TRUNCATE TABLE sdmod_contracts_manager_cstm;

  
  

-- Contratos Descontinuado (aos_contracts)

  

TRUNCATE TABLE aos_contracts;

TRUNCATE TABLE aos_contracts_audit;

TRUNCATE TABLE aos_contracts_documents;

  

-- Propostas (Quotes)

  

TRUNCATE TABLE aos_quotes;

TRUNCATE TABLE aos_quotes_aos_invoices_c;

TRUNCATE TABLE aos_quotes_audit;

TRUNCATE TABLE aos_quotes_sdmod_contracts_manager_1_c;

  
  
  

-- PROPOSTAS (HISTORICO) - opportunities

  

TRUNCATE TABLE opportunities;

TRUNCATE TABLE opportunities_contacts;

TRUNCATE TABLE opportunities_cstm;

  
  

-- Contactos (Contacts)

  

TRUNCATE TABLE contacts;

  

TRUNCATE TABLE contacts_audit;

TRUNCATE TABLE contacts_cases;

TRUNCATE TABLE contacts_cstm;

TRUNCATE TABLE contacts_project_1_c;

TRUNCATE TABLE contacts_sdmod_capability_1_c;

TRUNCATE TABLE contacts_sdmod_iefp_accesses_1_c;

TRUNCATE TABLE contacts_sdmod_training_control_1_c;

TRUNCATE TABLE contacts_users;

  
  
  

-- Telefonemas (Calls)

  

TRUNCATE TABLE calls;

TRUNCATE TABLE calls_contacts;

TRUNCATE TABLE calls_leads;

TRUNCATE TABLE calls_users;

  
  

-- Reuniões (Meetings)

  

TRUNCATE TABLE meetings;

  

TRUNCATE TABLE meetings_contacts;

TRUNCATE TABLE meetings_cstm;

TRUNCATE TABLE meetings_users;

  
  

-- Documentos (Documents)

  

TRUNCATE TABLE documents;

TRUNCATE TABLE documents_accounts;

TRUNCATE TABLE documents_cases;

TRUNCATE TABLE documents_contacts;

TRUNCATE TABLE documents_opportunities;

  

TRUNCATE TABLE document_revisions;

  
  
  

-- leads (Leads)

  

TRUNCATE TABLE leads;

  
  

-- Notas (Notes)

  

TRUNCATE TABLE notes;

  
  

-- Formações/ Formandos/ Formadores (Trainings)

  

TRUNCATE TABLE sdmod_trainers;

TRUNCATE TABLE sdmod_trainers_cstm;

TRUNCATE TABLE sdmod_trainers_sdmod_training_c;

TRUNCATE TABLE sdmod_training;

TRUNCATE TABLE sdmod_training_accounts_1_c;

TRUNCATE TABLE sdmod_training_audit;

TRUNCATE TABLE sdmod_training_control;

TRUNCATE TABLE sdmod_training_control_audit;

TRUNCATE TABLE sdmod_training_control_contacts_c;

TRUNCATE TABLE sdmod_training_control_cstm;

TRUNCATE TABLE sdmod_training_cstm;

TRUNCATE TABLE sdmod_training_sdmod_attendances_c;

TRUNCATE TABLE sdmod_training_sdmod_trainers_c;

TRUNCATE TABLE sdmod_formation_trainers;

TRUNCATE TABLE sdmod_formation_trainers_audit;

TRUNCATE TABLE sdmod_formation_trainers_cstm;

TRUNCATE TABLE sdmod_formation_trainers_sdmod_training_c;

  
  

-- Sessões (sdmod_Sessions)

  

TRUNCATE TABLE sdmod_sessions;

TRUNCATE TABLE sdmod_sessions_audit;

TRUNCATE TABLE sdmod_sessions_cstm;

TRUNCATE TABLE sdmod_sessions_sdmod_attendances_c;

TRUNCATE TABLE sdmod_sessions_sdmod_formation_trainers_c;

TRUNCATE TABLE sdmod_sessions_sdmod_training_c;

  
  

-- Acessos IEFP (sdmod_iefp_accesses)

  

TRUNCATE TABLE sdmod_iefp_accesses;

TRUNCATE TABLE sdmod_iefp_accesses_cstm;

  
  
  

-- Assistências (cases)

  

TRUNCATE TABLE cases;

TRUNCATE TABLE cases_audit;

TRUNCATE TABLE cases_bugs;

TRUNCATE TABLE cases_cstm;

  
  
  

-- MEDICINA OCUPACIONAL (projects)

  

TRUNCATE TABLE project;

TRUNCATE TABLE project_cstm;

TRUNCATE TABLE project_documents_1_c;

TRUNCATE TABLE projects_cases;

  
  

-- FICHAS DE APTIDÃO(sdmod_capability)

  

TRUNCATE TABLE sdmod_capability;

TRUNCATE TABLE sdmod_capability_audit;

  

TRUNCATE TABLE sdmod_capability_cstm;

TRUNCATE TABLE sdmod_capability_documents_1_c;

  

-- Presenças

  

TRUNCATE TABLE sdmod_attendances;

TRUNCATE TABLE sdmod_attendances_cstm;

  

-- Reltórios (reports)

  

TRUNCATE TABLE aor_reports;

  
  

-- PRODUTOS - CATEGORIAS (aos_product_categories)

  

TRUNCATE TABLE aos_product_categories;

  
  

-- Produtos (aos_products)

  

TRUNCATE TABLE aos_products;

TRUNCATE TABLE aos_products_audit;

TRUNCATE TABLE aos_products_cstm;

TRUNCATE TABLE aos_products_quotes;

TRUNCATE TABLE aos_products_quotes_audit;

  
  

-- PDF - MODELOS ()

  

TRUNCATE TABLE aos_pdf_templates;

  

-- Anomalias (bugs)

  

TRUNCATE TABLE bugs;

TRUNCATE TABLE bugs_audit;

  
  
  

-- Operations?? (sdmod_operations)

  

TRUNCATE TABLE sdmod_operations_center;

TRUNCATE TABLE sdmod_operations_center_accounts_c;

TRUNCATE TABLE sdmod_operations_center_audit;

  

TRUNCATE TABLE sdmod_operations_center_cstm;

  

-- Others

  

TRUNCATE TABLE outbound_email;

TRUNCATE TABLE tasks;

TRUNCATE TABLE email_addr_bean_rel;

TRUNCATE TABLE email_addresses;

TRUNCATE TABLE emails;

TRUNCATE TABLE emails_beans;

TRUNCATE TABLE emails_email_addr_rel;

TRUNCATE TABLE emails_text;
```