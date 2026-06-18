---
tags: [enable-banking, psd2, pis, pagamentos, plano]
criado: 2026-06-18
estado: rascunho / investigação
---

# Plano — Transferências automáticas (PIS) com Enable Banking

> [!info] Contexto
> Plano **genérico** para implementar **iniciação de pagamentos** (transferências reais, inclusive automáticas/recorrentes) via Enable Banking. Nasceu da experiência do [[enable banking|Enable Banking no FinançaClara]], mas aqui o alvo é **outro projeto**. O que já temos no FinançaClara é **AIS** (leitura). Isto é **PIS** — outra liga em regulação, custo e responsabilidade.

---

## 1. AIS vs PIS — o que muda

| | **AIS** (o que já temos) | **PIS** (transferências) |
|---|---|---|
| O que faz | Lê contas, saldos, movimentos | **Inicia pagamentos** (move dinheiro) |
| Licença | Registo AISP (leve) | **Licença PISP** ou guarda-chuva de TPP licenciado |
| Capital regulatório | ~€0 efetivo | **~€50.000** (licença própria) |
| Custo produção | Testável grátis (restricted mode) | **Sem free tier** — pago desde o 1.º pagamento |
| SCA | 1x por consentimento (~90 dias) | **Por pagamento** (salvo ordens permanentes/recorrentes) |
| Responsabilidade | Baixa (só lê) | Reclamações, reembolsos, falhas, AML/KYC |

> [!warning] A implicação dominante NÃO é técnica — é regulatória.
> Em **sandbox** o PIS está ligado automaticamente (engana: parece grátis e fácil). Em **produção** só é ativado para empresas com licença PISP ou via contrato/guarda-chuva da Enable Banking. **Não há atalho anónimo** — exige empresa constituída + KYB/KYC.

---

## 2. Pré-requisitos regulatórios

> [!warning] Antes de tudo: **a quem pagas?** É isto que decide se há regulação.
> A licença (e o capital) **só entra quando iniciar pagamentos é o serviço que vendes a terceiros**. Mover o teu próprio dinheiro não é isso.
>
> | Cenário | Regulado? |
> |---|---|
> | **Pagar aos TEUS próprios empregados / fornecedores** (a empresa paga a quem trabalha para ela) | ❌ **Não.** Não é serviço de pagamento a terceiros — não precisas de PISP, nem capital, nem Enable Banking. Usa ficheiro SEPA em massa do banco, software de salários, ou Wise/Revolut Business. |
> | **Produto onde OUTRAS pessoas/empresas pagam a terceiros através de ti** (payroll-as-a-service, marketplace, etc.) | ✅ **Sim** — aí presta-se serviço de pagamento → PISP próprio ou guarda-chuva da Enable Banking. |
>
> **Só continua para as 3 vias abaixo se estás no 2.º cenário.**

Três vias para poder iniciar pagamentos em produção:

| Via | O que implica | Para quem |
|---|---|---|
| **Guarda-chuva da Enable Banking** ⭐ | Operas *sob a licença deles*. A EB usa certificados eIDAS (QWAC/QSealC) e liga-se aos bancos em teu nome. Exige **contrato assinado + KYB** da empresa. | Recomendado para projeto novo / indie / startup |
| **Licença PISP própria** | Autorização do regulador (Banco de Portugal / FCA), reconhecido como instituição de pagamento, **capital mínimo ~€50k**, processo de meses. | Quem vai a sério, volume alto |
| **Os teus eIDAS** (QWAC/QSealC) | Se já fores TPP licenciado; a EB fica como mero *technical service provider* (ambiente single-tenant). | Quem já tem licença |

> [!tip] Caminho realista
> Para um projeto novo: **guarda-chuva da Enable Banking**. Precisas mesmo assim de empresa + passar KYB/KYC. Contacto para ativar: **support.api@enablebanking.com**.

---

## 3. Tabela de preços 💸

> [!important] A Enable Banking **não publica preços**.
> Modelo por **orçamento personalizado** ("Get a Quote", desde abril 2026). Os números dependem de volume, países e do teu setup regulatório. O que é público está abaixo.

### 3.1. Estrutura de preços da Enable Banking

| Item | Detalhe |
|---|---|
| **Modelo** | Volume-based: por **conta acedida** (AIS) + por **pagamento iniciado** (PIS) |
| **Mínimo mensal** | Sim — fatura mínima/mês que inclui um nº de contas + pagamentos |
| **Sandbox** | **Grátis** — PIS ligado automaticamente para testar |
| **Restricted mode** | Testar em produção só com as tuas próprias contas (grátis) |
| **Free tier PIS produção** | ❌ Não existe — pago desde o 1.º pagamento real |
| **Como obter número** | Contacto direto / ferramenta "Get a Quote" |
| **Inputs do orçamento** | Volume projetado (meses 1 / 12 / 24), países, setup regulatório (licença própria vs guarda-chuva) |

### 3.2. Custo regulatório (licença PISP própria — público, PSD2)

| Atividade | Capital inicial mínimo |
|---|---|
| Money remittance | €20.000 |
| **Payment initiation (PISP)** | **€50.000** |
| Transferências + acquiring + emissão de cartões | €125.000 |

> [!note] O capital **não é uma taxa que pagas**
> É **capital próprio mínimo que a empresa tem de *deter*** no balanço para ser autorizada como instituição de pagamento. Fica como fundos próprios da empresa — não é pago ao regulador nem à Enable Banking. **Não depende do nº de destinatários nem do volume** (pagar a 5 ou a 100 empregados é igual) — é um patamar fixo só para *poderes ser licenciado de todo*. E só se aplica se estiveres no 2.º cenário da [secção 2](#2-pré-requisitos-regulatórios).

### 3.3. Cobertura

| | |
|---|---|
| Instituições | **108+** bancos |
| Regiões fortes | Nórdicos + Bálticos (DK, FI, EE, LV, LT, NO, PL, SE) + grandes europeus (ING, BNP Paribas, **Revolut**) |
| Portugal | Suportado (bancos PT no AIS já validados no FinançaClara) |

### 3.4. Alternativas a considerar (onboarding PISP às vezes mais simples)

| Provedor | Nota | Link |
|---|---|---|
| TrueLayer | Forte em PIS/VRP, UK+EU | https://truelayer.com |
| Yapily | API-only, bom para PISP via guarda-chuva | https://www.yapily.com |
| GoCardless | Foco em débitos diretos + open banking payments | https://gocardless.com |
| Tink (Visa) | Cobertura europeia ampla | https://tink.com |
| Nordigen/GoCardless Bank Account Data | AIS grátis (só leitura, **não faz PIS**) | https://gocardless.com/bank-account-data |

---

## 4. Arquitetura técnica — fluxo PIS

Difere do AIS (`bank-session` → `bank-transactions`). Reaproveita o padrão das Vercel Functions com JWT RS256 (`iss=enablebanking.com`, `aud=api.enablebanking.com`, `kid=app id`).

```
App  ──(token Firebase)──>  Vercel Function  ──(JWT RS256)──>  Enable Banking
                                                                     │
1. POST /payments {aspsp, valor, IBAN destino, referência}          │
   ← devolve { payment_id, redirect_url }                           │
2. Redirect do utilizador → página Enable Banking (revê + aceita ToS)
3. SCA no banco (app / multifator)  ← OBRIGATÓRIO POR LEI
4. Banco autoriza → EB executa a iniciação
5. Polling do estado do pagamento (PENDING → ... → SETTLED/REJECTED)
```

### Endpoints a criar (espelhando os `bank-*.mjs` atuais)

| Function | Faz |
|---|---|
| `bank-payment-create.mjs` | `POST /payments` → devolve `payment_id` + URL de redirect |
| `bank-payment-status.mjs` | Polling do estado do pagamento |
| `bank-payment-cancel.mjs` | Cancelar (quando suportado pelo banco) |
| _(opcional)_ `bank-standing-order.mjs` | Ordens permanentes / recorrentes |

### Regras de ouro técnicas

> [!danger] Nada de iframes / WebViews
> Por CORS e pelo *app-switch* da SCA, a autorização **tem de abrir no browser por defeito**. Em mobile, nunca embutir em WebView (a SCA do banco pode falhar). Mesma lição do AIS.

- **SCA é requisito legal** por pagamento. Suporta *decoupled authentication* em alguns bancos.
- **Polling de estado** obrigatório — o pagamento não é síncrono.
- **Deferred submission** (opcional): segura o pagamento após autorização do utilizador, para verificação antes de mover fundos.
- **Idempotência**: gerar chave única por pagamento para evitar duplos débitos.

---

## 5. Transferências AUTOMÁTICAS — o ponto sensível ⚙️

"Automática" colide com a SCA, que por defeito é **por pagamento**. Opções:

| Abordagem | Como funciona | SCA | Disponibilidade |
|---|---|---|---|
| **Ordem permanente** (standing order) | Configura-se 1x no banco; o banco executa sozinho (ex.: todo dia 1) | 1x na criação | Depende do banco |
| **Pagamentos recorrentes / agendados** | Lista de pagamentos futuros autorizada de uma vez | 1x | Depende do banco |
| **VRP** (Variable Recurring Payments) | Mandato com limites; app dispara sem SCA por transação | 1x no mandato | Forte no **UK**, limitado na UE |
| **Pagamento único repetido** | App pede pagamento e utilizador faz SCA de cada vez | **Cada vez** | Sempre — mas não é "automático" |

> [!note] Conclusão sobre "automático"
> Verdadeiramente sem-toque na UE = **ordem permanente** ou **pagamento recorrente** suportado pelo banco. VRP (o ideal para automação) ainda é sobretudo UK. Validar **banco a banco** o que suportam antes de prometer automação.

---

## 6. Riscos e responsabilidades ⚠️

- Como PISP (mesmo sob guarda-chuva): **obrigação de responder a reclamações** e tratar disputas.
- **Pagamentos falhados, reembolsos, reconciliação, erros** — passam a ser responsabilidade tua.
- **AML/KYC** sobre os utilizadores.
- **Limites e cobertura** variam por banco/país (SEPA Credit Transfer vs SEPA Instant).
- Segurança das **chaves privadas RSA / eIDAS** no servidor (nunca no cliente — já é assim no AIS).

---

## 7. Roadmap por fases

- [ ] **Fase 0 — Decisão de negócio.** Constituir/usar empresa. Escolher via regulatória (recomendado: guarda-chuva EB). Pedir orçamento à EB com volumes projetados.
- [ ] **Fase 1 — Sandbox.** Implementar `bank-payment-create` + `bank-payment-status` em sandbox (PIS ligado automaticamente). Validar fluxo redirect + SCA + polling.
- [ ] **Fase 2 — Contrato.** Assinar contrato com a EB + KYB/KYC. Obter ativação de produção e eIDAS/guarda-chuva.
- [ ] **Fase 3 — Restricted mode.** Testar com contas próprias reais em produção (grátis). Confirmar estados e reconciliação.
- [ ] **Fase 4 — Automação.** Mapear, banco a banco, suporte a ordens permanentes / recorrentes / VRP. Implementar `bank-standing-order` onde fizer sentido.
- [ ] **Fase 5 — Produção.** Idempotência, tratamento de erros/reembolsos, suporte a reclamações, monitorização ([[FinancaClara|Sentry]]).

---

## 8. Decisões em aberto

- Que **país(es)** e bancos no arranque? (define cobertura e preço)
- **Volume** esperado de pagamentos/mês? (define se vale a pena vs mínimo mensal)
- Automação via **ordem permanente** (UE) chega, ou precisa de **VRP** (→ olhar UK / TrueLayer)?
- Empresa **própria** ou já existe entidade para o KYB?

---

## 9. Links e referências

**Enable Banking**
- Site: https://enablebanking.com/
- API reference: https://enablebanking.com/docs/api/reference/
- FAQ (licença, PIS, pricing, SCA): https://enablebanking.com/docs/faq/
- Changelog (março 2026, "Get a Quote"): https://enablebanking.com/blog/2026/04/08/enable-banking-changelogmarch-2026
- Contacto PIS produção: **support.api@enablebanking.com**

**Regulação / conceitos**
- PSD2 explicado (PT): https://www.reduniq.pt/blog/psd2-o-que-e-e-como-funciona/
- Como tornar-se PISP (Yapily): https://www.yapily.com/blog/how-to-become-a-pisp
- AIS vs PIS — guia 2026 (Noda): https://noda.live/articles/ais-vs-pis-in-open-banking
- O que é um TPP / AISP / PISP (GoCardless): https://gocardless.com/guides/posts/what-is-tpp-in-open-banking

**Comparação de provedores**
- Open Banking Tracker — Enable Banking: https://www.openbankingtracker.com/api-aggregators/enablebanking
- Alternativas: https://www.openbankingtracker.com/api-aggregators/enablebanking/alternatives

---

> [!abstract] TL;DR
> **Primeiro: a quem pagas?** Pagar aos teus próprios empregados/fornecedores **não é regulado** — esquece o PIS, usa ficheiro SEPA em massa do banco ou Wise/Revolut Business. Só precisas de PISP/Enable Banking se **terceiros pagam a terceiros através de ti**. O capital (~€20k/€50k) não é uma taxa — é capital próprio a *deter*, e só nesse 2.º caso.
>
> Se for mesmo um produto de pagamentos: o bloqueador **não é código** — é o enquadramento legal (empresa + contrato/KYB com a EB, ou licença PISP ~€50k). Sandbox engana porque liga PIS automaticamente; produção não arranca sem contrato. Preços só por orçamento. "Automático" de verdade na UE = ordem permanente/recorrente (VRP é sobretudo UK). Tecnicamente reaproveita o padrão `bank-*.mjs` + JWT RS256 já usado no AIS, mais SCA no browser e polling de estado.
