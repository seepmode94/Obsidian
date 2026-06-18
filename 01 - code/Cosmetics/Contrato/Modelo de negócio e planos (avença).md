---
tags: [cosmetics, ebeauty, contrato, avenca, negocio, precos]
atualizado: 2026-06-18
status: rascunho
---

# EBeauty — Modelo de negócio, planos e avença

> [!warning] Isto não é aconselhamento jurídico
> É um **rascunho de trabalho** para estruturar a proposta. Os valores `€X` são **placeholders** — preenche com os teus números. Antes de assinar/faturar, valida o **regime de IVA, faturação e contrato** com um **contabilista/jurista**.

> 📌 Contexto do projeto: [[Ponto de situação]] · [[EBeauty - Catálogo (projeto Vendas)]] · [[Chat-IA (assistente de beleza)]]
> 🌐 Site live: https://ebeauty-pt.vercel.app

---

## 🎯 Ideia-chave

Construí o site **para o cliente** (EBeauty). O lucro não vem de "ter o site" — vem de **(a) cobrar pelo serviço** e **(b) reutilizar o motor** noutros clientes. Esta nota foca o **(a)**: como vender a gestão como serviço, com planos.

A escada de planos foge ao "empregado dos €30": vendo **valor em planos**, não horas. O diferenciador é a **consultora IA com câmara** (tem custo de API → fica no plano de cima).

---

# PARTE A — Para apresentar ao cliente

## 📦 Os 3 planos

| | **Mensal** | **Anual** | **Performance** |
|---|---|---|---|
| **Modelo** | Serviço, flexível | Serviço, comprometido | Base + % das vendas |
| **Compromisso** | Cancela c/ 30 dias | 12 meses | A definir |
| **Gestão + hosting + CMS (Sanity)** | ✅ | ✅ | ✅ |
| **Updates de segurança** | ✅ | ✅ | ✅ |
| **Pequenas alterações incluídas** | 2 / mês | **4 / mês** | 4 / mês |
| **Consultora IA + câmara** | básica / — | ✅ (até **N** conversas/mês) | ✅ (até **N** conversas/mês) |
| **Pré-requisito** | — | — | **Pagamento online integrado** |
| **Preço** | **€59 / mês** | **€590 / ano** (≈ €49/mês · poupa ~2 meses) | **€39/mês + 6%** das vendas online |
| **Ideal para** | Quer baixo risco e flexibilidade | Quer mais valor + desconto | Acredita no volume, quer parceria |

> [!tip] Como ler
> - O **Anual** é mais barato ao ano **porque há compromisso** (não dou desconto a quem pode sair no mês 3).
> - O **Performance** só "liga" depois de existir **pagamento online** (senão não há como medir vendas).

## 💶 Discriminação dos valores

> [!note] Pressupostos (recalibrar com a secção *O meu valor/hora* em [[Custos e margem (EBeauty)]])
> Valor/hora **€27,5** (meio da banda €25–30) · tempo médio real **~0,75h/mês** (site pequeno estável; as alterações incluídas são um **teto**, não a média) · infra partilhada + Sanity free + IA baixa. A avença é lucrativa mesmo modesta — o **lucro grande vem do build + extras + escala**, não da avença.

**Mensal — €59/mês**
| Componente | ~Valor |
|---|---|
| Alojamento + domínio gerido (DNS/SSL) | €5 |
| Gestão, monitorização, updates + até 2 alterações/mês (~0,75h) | €20 |
| CMS (Sanity) | incl. |
| **Margem** | **~€34** |

**Anual — €590/ano (≈ €49/mês)**
| Componente | ~Valor/mês |
|---|---|
| Tudo do Mensal (custo ~€25) | — |
| Consultora **IA com câmara** (até N conversas) | €4 |
| Até 4 alterações/mês + prioridade | incl. |
| **Margem** | **~€20/mês + cash à cabeça** |

> A troca pelo desconto é o **compromisso de 12 meses** (e o cash adiantado). Margem mensal menor que o Mensal, mas ganhas retenção + tesouraria.

**Performance — €39/mês + 6% das vendas online**
| Componente | ~Valor |
|---|---|
| Base (infra + gestão mínima) — não trabalho de graça | €39 (custo ~€25 · margem ~€14) |
| IA com câmara (interessa-me que converta) | incl. |
| **+ 6% das vendas online** (só as medíveis) | upside |
| Pré-requisito: pagamento online integrado | setup one-time |

> [!tip] Tens margem para subir
> €59/€49 é **barato** para um site gerido **com consultora IA**. Posicionando como premium, **€69–89/mês** defende-se. Começa onde fechas o cliente e sobe com referências.

> [!info] Setup/build (one-time, FORA da avença)
> Cliente novo (branding + conteúdo + go-live) ≈ **€250–600** conforme o trabalho. A EBeauty já está construída.

## 🧾 O que está incluído na avença

- Gestão e manutenção do website (manter no ar, monitorizar).
- CMS (Sanity) disponível para o cliente gerir o catálogo no desktop.
- Atualizações de segurança e de dependências.
- **N pequenas alterações/mês** — entende-se por *pequena alteração* um pedido de **até ~30 min** (ex.: trocar um preço, uma foto, um texto). Acumulável? **Não** (não transita para o mês seguinte).

## 🚫 O que NÃO está incluído (orçamento à parte)

- Funcionalidades novas (ex.: pesquisa, novas páginas, integrações).
- Redesenhos ou mudanças estruturais.
- Campanhas, SEO avançado, produção de conteúdo/fotografia.
- Integração de **pagamentos** (Stripe / MB Way) — trabalho one-time.

Tabela de extras: **€/hora** ou **orçamento fechado** por pedido.

## 💳 Custos repassados

- **API da consultora IA (Gemini)** e **hosting** escalam com o uso. Estão incluídos **até ao limite justo** de cada plano; acima disso, são faturados à parte.

## 🔁 Cancelamento

- **Mensal:** qualquer das partes cancela com **30 dias** de pré-aviso.
- **Anual:** compromisso de 12 meses; saída antecipada → [definir: paga meses em falta / penalização / aviso].
- Na saída: entrega de acessos (Sanity / Vercel / domínio) conforme o **modelo de propriedade** (ver Parte B).

---

# PARTE B — Notas internas (não mostrar ao cliente)

## ⚖️ Funcionário vs Fornecedor vs Sócio

O que decide **não** são as tarefas — é o **acordo**. Três testes:

1. **Como sou pago?** Fixo/por entrega → fornecedor. % das vendas → sócio.
2. **Quem corre o risco?** Recebo mesmo que não vendam → fornecedor. Só ganho se venderem → sócio.
3. **Autonomia?** Decido como/quando e posso ter outros clientes → fornecedor. Sob direção deles + exclusivo → **empregado** (risco de *falso recibo verde* em PT).

> [!danger] Falso recibo verde
> Gestão contínua para **um só cliente, exclusivo e sob direção dele** pode ser reclassificada como contrato de trabalho. Manter-me claramente **fornecedor** (livre para outros clientes, a faturar entregas). Confirmar com contabilista.

- **Mensal/Anual** = sou **fornecedor**. Seguro.
- **Performance (% das vendas)** = derivo para **sócio**. Decidir:
  - **Fornecedor com bónus** → base normal + **% pequena**. Continuo seguro.
  - **Sócio a sério** → base baixa + **% grande**, aposta no volume → **formalizar por escrito** (% definida, partilha de decisões).
- ⚠️ **Nunca % pura.** Sem base, se não venderem trabalho de graça e ainda pago API + hosting. Sempre **base (cobre custos) + %**.

## 🛒 Pré-requisito do Performance: ver as vendas

- Comissão exige vendas **medíveis**. Checkout atual = **WhatsApp manual** → invisível.
- Para % real → **integrar pagamento online** (Stripe / MB Way via gateway). Setup one-time (€Z).
- A conta de pagamento é **do cliente**; faturo a % no fim do mês com base no relatório.
- ❌ **Não** ser eu a plataforma (Stripe Connect) → tornar-me-ia *merchant of record* (reembolsos, KYC, impostos). Peso a mais para uma loja pequena.
- Gatilho a escrever: *"Se quiseres pagamento online + partilha de receita, o modelo passa a base €X + Y% das vendas, com setup de €Z."*

## 🏷️ Propriedade do código (DECIDIR — muda tudo)

- **Licença** (recomendado p/ avença): o "motor" é meu; usam enquanto pagam. Se cancelam, a minha alavanca mantém-se. ← coerente com avença.
- **Venda outright:** ficam donos do código; só lhes vendo manutenção.
- Define o que recebem na saída (export Sanity, transferência Vercel/domínio).

## 🧾 Faturação e avença "automática" (PT)

São **duas peças**:
1. **Fatura legal:** como trabalhador independente, **fatura-recibo** no **Portal das Finanças** ou **software certificado AT** (InvoiceXpress, Vendus, Moloni, Cegid…). Vários fazem **faturas recorrentes**.
2. **Pagamento automático:** **débito direto SEPA** ou subscrição (**Stripe Billing**) que cobra o cartão todo o mês. O **contrato autoriza** a cobrança recorrente.

> [!note] IVA
> Regime de isenção (art. 53.º) vs. regime normal depende do volume/limites. **Confirmar com contabilista** — não assumir números de cabeça.

## ✅ Recomendação

1. **Base = serviço.** Fechar **Mensal** (ou Anual com saída fácil) com a EBeauty já. Receita previsível.
2. **Faturar a backlog + "pacote go-live"** como trabalho (ver pendentes em [[Ponto de situação]]).
3. **Performance = 3.ª opção opcional**, sempre **base + %**, só após pagamento integrado. É o "quando crescermos juntos", não a porta de entrada.
4. **A alavancagem real = escala:** o mesmo motor em vários clientes. A EBeauty é o **caso de estudo / demo**.

## ❓ Decisões em aberto (preencher antes de propor)

- [ ] Preços reais: `€X` mensal, desconto anual, `€base + Y%` e `€Z` setup.
- [ ] Limite de uso da IA por plano (**N** conversas/mês).
- [ ] **Mensal (flexível)** ou **Anual (compromisso)** como entrada?
- [ ] **Propriedade:** licença vs venda.
- [ ] Definição fechada de "pequena alteração" (tempo/tipo).
- [ ] Quem paga o quê dos custos variáveis (API/hosting) acima do limite.
