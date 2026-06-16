---
tags: [cegid, primavera, webapi, acessos]
---

# Cegid / Primavera — Web API (Acessos)

> [!warning] Credenciais sensíveis
> Esta nota contém credenciais e tokens reais. Não partilhar nem sincronizar fora da vault pessoal.

## 🔌 Endpoints (base URL)

| Ambiente | URL |
|---|---|
| Dentro da rede (local) | `http://192.168.0.7:2018/WebApi/` |
| Fora da rede (público) | `http://46.189.246.8:50056/WebApi/` |

> [!note] Porta externa
> No texto inicial a URL externa aparecia como `:2018`, mas o ambiente Postman usa `:50056` (port forwarding). Usar **50056** para acessos de fora da rede.

## 🔑 Acessos (ambiente Postman "Primavera")

| Variável                 | Valor                              |
| ------------------------ | ---------------------------------- |
| `grandType` (grant_type) | `password`                         |
| `apiUrl` (externo)       | `http://46.189.246.8:50056/WebApi` |
| `localApiUrl` (interno)  | `http://192.168.0.7:2018/WebApi`   |
| `username`               | `Seepmode00`                       |
| `password`               | `Jennyferp`                        |
| `company`                | `999903`                           |
| `instance`               | `DEFAULT`                          |
| `line`                   | `Professional`                     |
| `access_token`           | gerado no `/token` (não fixo)      |
| `firstToken`             | —                                  |
| `secondToken`            | gerado (não fixo)                  |

> Coleção Postman completa em anexo: [[Primavera WebAPI Collections.postman_collection.json]]

### Prints

**Ambiente Postman (Primavera API):**

![[cegid-postman-env-primavera.png]]

**Informação dos acessos (password):**

![[cegid-acessos-password.png]]

## 📦 Vendas

- **Artigos**
- **Vendas**
- **Documentos de venda:** Factura (`FA`); Fatura Recibo (`FAR`)

### Constantes

| Constante | Valor |
|---|---|
| `Filial` | `'TODAS'`, `'000'`, `'00?'`, … |
| `QueryTipo` | ? (a confirmar) |
| `Moeda` | `EUR` |
| `Serie` | `2024` |
| `TipoDoc` | `FA` |
| `DateString` | `2018-11-30` / `05/03/2024` |

## ❓ Questões em aberto

- [ ] Como **listar todos os documentos** emitidos no módulo de vendas para uma determinada série
- [ ] Como **criar um documento (Factura)**? O endpoint `POST /Vendas/Docs/CreateDocument` não funciona
- [ ] Que valores pode tomar a variável **`QueryTipo`**
- [ ] Como ter **acesso à base de dados** — não é possível aceder ao SQL Server Management Studio (SSMS)
- [ ] `Vendas/Docs/CreateSalesDocument/` **VS** `Vendas/Docs/CreateDocument/` ??
- [ ] **NIF português não é válido** (algoritmo de validação NIF)

### Pistas da coleção Postman

> Endpoints encontrados na coleção que ajudam nas questões acima.

- **Listar documentos de vendas:**
  - `GET /Vendas/TabVendas/LstTodosDocVendas` — lista todos os docs de venda
  - `GET /v2/Vendas/Docs/LstCabecalhoDocVenda/{Filial}/{Serie}/{TipoDoc}/{Entidade}` — cabeçalhos por filial/série/tipo/entidade
  - `GET /Base/Series/ListaSeries/V/FA/true` — listar séries
- **Criar documento (em vez de `CreateDocument`):**
  - `POST /Vendas/Docs/CreateSalesDocument/` ← usado no fluxo SuiteCRM (faturas e notas de crédito)
  - `POST /Vendas/Docs/EmiteDocumento/{Serie}` ← alternativa v1
  - Fluxo: `PreencheDadosRelacionados` → `AdicionaLinha/{Artigo}/{Qtd}/{Armazem}` → `CreateSalesDocument`
- **Validação de NIF / contribuinte:**
  - `GET /Base/Clientes/ExisteContribuinte/{strContribuinte}`
  - `GET /Base/Clientes/NumeroContribuintesRepetidos/{strContribuinte}`

## 📚 Documentação

- Fórum: https://developers.ila.cegid.com/forum/
- Documentação API: https://developers.ila.cegid.com/v10/recursos/web-api/
- Acesso Web API (local): http://192.168.0.7:2018/WebApi
- Interface vendas (IVndBSVendas): https://v10api.primaverabss.com/html/api/marketing_vendas/IVndBS100.IVndBSVendas.html
- Estrutura de base de dados do módulo de inventário *(a localizar)*
- Algoritmo de validação do NIF não está disponível — **Cabo Verde**
- Integração Documento Venda V10 — Algoritmo de Validação NIF
