**Guia de Boas Práticas no Departamento de IT**

  

## **1. Introdução**

Este documento define as regras e critérios para a gestão de issues, branches, commits e pull requests (PRs) no GitHub, incluindo como deve ser feita a rotulagem, estrutura da descrição, processo de peer review e ciclo de desenvolvimento até à produção.

O objetivo é uniformizar práticas, facilitar a colaboração e garantir qualidade no processo de desenvolvimento.

  
  

## **2. Issues**

Cada issue deve conter:

- Título claro com resumo do problema/feature.
    
- Descrição detalhada do contexto.
    
- Critérios de aceitação (quando aplicável).
    
- Labels de categorização.  
      
    

### **Labels**

- Area – Qual área do sistema é afetada.
    
- PR Complexity – Baixa / Média / Alta.
    
- Priority – Alta / Média / Baixa.
    
- Feature / Enhancement / Bug – Tipo de alteração.
    
- Status (PR - ONLY) – Open / In Review / Changes Requested / Approved / Merged.
    

  
  

## **3. Branches**

### **Convenção nominal**

Sempre em **lowercase**, com formato:

tac-<issue ID>-<nome_da_feature_com_underscore>

Exemplos:

tac-99-fix-user-creation-bug

  
  

### **Regras**

- Criar branches a partir de **dev** ou de uma **release branch**.
    

  
  

## **4. Commits (Primeiro commit de cada branch)**

### **Formato**

<Issue ID, em uppercase>: <Commit message>

### **Exemplo**

TAC-99: Fix User Creation Bug

  
  

### **Regras**

- Primeiro commit deve referenciar o **Issue ID**.
    
- Os seguintes commits devem apresentar mensagens curtas, claras e descritivas do que foi feito.
    

  
  

## **5. Pull Requests (PRs)**

### **Título**

<Issue ID>: <Resumo da alteração>

Exemplo:

TAC-99: Add feature name

  
  

### **Estrutura da Descrição**

Todos os PRs devem seguir o template:

1. **Intro** – Contextualização do PR.  
      
    
2. **Alterações (departamento de IT)** – Lista das alterações implementadas a serem lidas pelos restantes colegas de IT  
      
    
3. **Como Testar** – Instruções de validação para a equipa de teste (Colegas de IT e QR test)  
      
    
4. **Anexos** (se existir) – Documentação ou ficheiros relevantes.  
      
    
5. **Alterações Visuais** (se existir, com imagens).  
      
    
    
![[guia.png]]

  


  

## **6. Peer Review**

- Cada PR deve ser revisto por pelo menos **1 colega designado**.  
      
    
- Revisores devem avaliar:  
      
    
    - Qualidade e clareza do código.*  
          
        
    - Cobertura de testes.  
          
        
    - Conformidade com o guia de commits/branches.  
          
        
- Se necessário, marcar comentários com **Changes Requested**.  
      
    
- O merge com o branch dev é somente feito por coordenadores e após a aprovação
    

  
  

* [https://github.com/trekhleb/state-of-the-art-shitcode](https://github.com/trekhleb/state-of-the-art-shitcode) - bom exemplo “irónico” do que são algumas práticas em node.js

  
  

## **7. Ciclo de Desenvolvimento até à Produção**

  
  

O desenvolvimento segue um conjunto de fases representadas por labels de status que permitem identificar em que ponto está uma tarefa, PR ou branch:

1. **Status: On Hold** – O trabalho está parado, dependente de outra tarefa ou decisão.  
      
    
2. **Status: Draft** – O PR ou feature está em preparação inicial, ainda incompleto.  
      
    
3. **Status: Waiting Review** – O PR está pronto para revisão e aguarda validação por pares.  
      
    
4. **Status: Peer Reviewed** – O código foi revisto e aprovado em peer review, aguardando integração.  
      
    
5. **Status: Currently on Staging** – A funcionalidade está disponível no ambiente de staging para testes de QA.  
      
    
6. **Status: Approved in Staging** – Os testes em staging foram aprovados e a funcionalidade está pronta para ser integrada na release branch ou em main (produção).
    

  

## **8. Labels de PR**

As seguintes labels devem ser aplicadas em PRs para melhor categorização:

- **Área** – Onde a alteração impacta (ex: Equipamentos, Empresas, lógica do negócio, etc).  
      
    
- **PR Complexity** – Alta / Média / Baixa.  
      
    
- **Priority** – Alta / Média / Baixa.  
      
    
- **Feature / Enhancement / Bug** – Tipo de mudança.  
      
    
- **Status (PR - ONLY)** – Open / In Review / Changes Requested / Approved / Merged.