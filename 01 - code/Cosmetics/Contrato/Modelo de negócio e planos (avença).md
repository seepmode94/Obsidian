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
> Valor/hora **€20** (preço de arranque / primeiro cliente; chão recomendado €25) · tempo médio real **~0,75h/mês** (site pequeno estável; as alterações incluídas são um **teto**, não a média) · infra partilhada + Sanity free + IA baixa. A avença é lucrativa mesmo modesta — o **lucro grande vem do build + extras + escala**, não da avença.

| Plano | Preço | **Custo real** | Margem |
|---|---|---|---|
| **Mensal** | €59/mês | **~€20** | ~€39 |
| **Anual** | €49/mês (€590/ano) | **~€24** | ~€25/mês + cash |
| **Performance** | €39/mês + 6% | **~€24** | ~€15/mês + % |

> *Custo real = infra (~€5) + gestão (~€15 = 0,75h × **€20/h**) + IA (~€4, no Anual/Performance). Margem = Preço − Custo real.*

**Mensal — €59/mês**
| Componente | ~Valor |
|---|---|
| Alojamento + domínio gerido (DNS/SSL) | €5 |
| Gestão, monitorização, updates + até 2 alterações/mês (~0,75h × €20) | €15 |
| CMS (Sanity) | incl. |
| **Margem** | **~€39** |

**Anual — €590/ano (≈ €49/mês)**
| Componente | ~Valor/mês |
|---|---|
| Tudo do Mensal (custo ~€20) | — |
| Consultora **IA com câmara** (até N conversas) | €4 |
| Até 4 alterações/mês + prioridade | incl. |
| **Margem** | **~€25/mês + cash à cabeça** |

> A troca pelo desconto é o **compromisso de 12 meses** (e o cash adiantado). Margem mensal menor que o Mensal, mas ganhas retenção + tesouraria.

**Performance — €39/mês + 6% das vendas online**
| Componente | ~Valor |
|---|---|
| Base (infra €5 + gestão €15 + IA €4) — não trabalho de graça | €39 (custo ~€24 · margem ~€15) |
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

O que decide **não** são as tarefas (fazer imagens, gerir o Sanity, etc.) — é o **acordo**: como sou pago, quem corre o risco, que autonomia tenho. As mesmas tarefas podem fazer de mim as três coisas.

**Três testes:**
1. **Como sou pago?** Fixo / por entrega → fornecedor. % das vendas → sócio.
2. **Quem corre o risco?** Recebo mesmo que não vendam → fornecedor. Só ganho se venderem → sócio.
3. **Autonomia?** Decido como/quando e posso ter outros clientes → fornecedor/sócio. Sob direção deles + exclusivo + horário → **empregado**.

> [!danger] Falso recibo verde (risco real em PT)
> Gestão contínua para **um só cliente, exclusivo e sob a direção dele** pode ser reclassificada como contrato de trabalho — com consequências fiscais e legais para os dois. Antídoto: manter-me claramente **fornecedor** (livre para outros clientes, a faturar **serviço/entregas**, com autonomia). Confirmar com contabilista.

**Mapeamento dos planos:**
- **Mensal / Anual** → sou **fornecedor**. Recebo vendam eles muito ou pouco. Seguro.
- **Performance (% das vendas)** → derivo para **sócio**. Decidir conscientemente:
  - **Fornecedor com bónus** → base normal + **% pequena**. Continuo seguro, a % é só extra.
  - **Sócio a sério** → base baixa + **% grande**, aposto no volume → **formalizar por escrito** (% definida, partilha de decisões, talvez empresa).
- ⚠️ **Nunca % pura.** Sem base, se não venderem trabalho de graça e ainda pago API + hosting do meu bolso.

> [!tip] O antídoto ao "empregado dos €30"
> Não é o modelo — é: (1) **cobrar por outputs**, não por estar disponível; (2) manter **autonomia**; (3) ter (ou poder ter) **outros clientes**; (4) **escalar** o mesmo motor. Um cliente numa avença pequena sabe a pouco; cinco clientes no mesmo motor é uma agência.

## ⚠️ Riscos e mitigação por plano

| Plano | Risco principal | Mitigação |
|---|---|---|
| **Mensal** | Cancelam quando quiserem → receita instável | Pré-aviso 30 dias; usar para ganhar confiança e migrar para Anual |
| **Anual** | Margem mensal fina; cliente pesado consome > incluído | Cláusula de uso justo; limite de IA; alterações = teto não-acumulável |
| **Performance** | Dependo do **marketing deles** (não controlo vendas); atribuição difícil | Base que cobre custos; % só sobre vendas **online medíveis**; nunca % pura |

## 🎯 Como apresentar (script + objeções)

- **Ancorar no Anual** como o "recomendado" (mais valor + IA câmara + mais barato/mês). O Mensal é a âncora cara que faz o Anual parecer óbvio. O Performance é a opção de parceria.
- Apresentar sempre os **3 juntos** — dá sensação de escolha e controlo, e raramente escolhem o mais barato puro.
- **Objeções:**
  - *"É caro."* → Separar avença (manter no ar + IA) do build (one-time). €49/mês ≈ uns cafés/semana por um site gerido **com consultora IA**.
  - *"Posso gerir eu."* → Podem gerir o **conteúdo** (Sanity é para isso). A avença é a parte técnica, segurança, IA e disponibilidade — não o data-entry.
  - *"E se quiser cancelar?"* → Mensal: 30 dias, sem drama. Mostrar que não os prendo → gera confiança.
  - *"Não preciso da IA."* → Oferecer o **Mensal sem câmara**. A IA é upsell, não obrigatória.

## 🛒 Pré-requisito do Performance: ver as vendas

- Comissão exige vendas **medíveis**. Checkout atual = **WhatsApp manual** → invisível, não dá para cobrar %.
- Para % real → **integrar pagamento online** (Stripe / MB Way via gateway local: IfthenPay, Easypay, Eupago…). Setup **one-time (€Z)**, faturado à parte.
- A conta de pagamento é **do cliente**; eu faturo a % no fim do mês com base no relatório (preciso de acesso de leitura ao dashboard + confiança/reconciliação).
- ❌ **Não** ser eu a plataforma (Stripe Connect) → tornar-me-ia *merchant of record* (reembolsos, KYC/AML, impostos sobre dinheiro de terceiros). Peso a mais para uma loja pequena.
- **Porquê 6%?** Faixa defensável **5–8%** quando forneço plataforma + IA + otimização. Só sobre vendas **online** (não WhatsApp/presencial — não atribuíveis).
- **Alinhamento:** a parte boa é que passo a otimizar o site para **converter** (ganho com isso). Mas o volume de uma loja pequena é a incógnita → é o "quando crescermos juntos", não a porta de entrada.
- Gatilho a escrever: *"Se quiseres pagamento online + partilha de receita, o modelo passa a €39 base + 6% das vendas online, com setup de €Z."*

## 🏷️ Propriedade do código (DECIDIR — muda tudo o resto)

- **Licença (recomendado p/ avença):** o "motor" é **meu**; usam enquanto pagam. Se cancelam, a minha alavanca mantém-se e reutilizo o motor noutros clientes. ← coerente com avença + escala.
- **Venda outright:** ficam **donos** do código (build mais caro); depois só vendo manutenção. Perco alavanca e a reutilização fica limitada.
- **Híbrido:** vendo o site, mas a **consultora IA / componentes do motor** ficam sob licença (continuam a depender de mim).
- Definir o que recebem **na saída**: export do Sanity (conteúdo é deles), transferência de Vercel. O **domínio é sempre do cliente** (em nome dele).

## 🖥️ Infra: Vercel vs VPS (ver [[Custos e margem (EBeauty)]])

- **1 cliente → Vercel Pro.** Não comprar servidor para um site.
- **5+ clientes → VPS (Hetzner ~€5–6) + Coolify/Dokploy.** Custo fixo partilhado, paga-se sozinho; arranca o modelo de agência.
- O servidor **só** substitui o front-end (Vercel). **Sanity e Gemini ficam cloud sempre.**
- Trade-off: VPS troca **dinheiro por tempo** (eu viro o SRE: backups, SSL, uptime, ponto único de falha).

## 🤖 Custo da IA: controlar (ver [[Custos e margem (EBeauty)]])

- Risco real = **abuso/disparo** (bot, spam de fotos), não o uso normal.
- **A fazer no código (ainda não feito):** kill-switch mensal + limite por visitante + cap de tokens em `app/api/chat/route.ts`. Apólice contra contas de surpresa.
- Comercialmente: **franquia incluída + excedente** + cláusula de uso justo.

## 🧾 Faturação e avença "automática" (PT)

São **duas peças** separadas:
1. **Fatura legal:** como trabalhador independente, **fatura-recibo** no **Portal das Finanças** ou em **software certificado pela AT** (InvoiceXpress, Vendus, Moloni, Cegid…). Vários emitem **faturas recorrentes** automáticas.
2. **Pagamento automático:** **débito direto SEPA** ou subscrição (**Stripe Billing**) que cobra o cartão todo o mês. O **contrato autoriza** a cobrança recorrente.

> [!note] IVA e Segurança Social
> Regime de isenção (art. 53.º) vs. regime normal depende do volume/limites; como independente há também **Segurança Social (~21,4%)** e IRS. **Confirmar tudo com contabilista** — não assumir números de cabeça.

## 📈 Caminho de crescimento

1. Fechar a EBeauty (Mensal ou Anual) → primeira receita recorrente + **caso de estudo / demo ao vivo**.
2. **Faturar a backlog** one-time (pendentes em [[Ponto de situação]]: ligar storeSettings, favicon/OG, pesquisa, alinhar design, redes sociais, dados legais).
3. **Subir preços** com portfólio/referências (€59 → €69–89).
4. **Reutilizar o motor** noutras lojas pequenas (cosmética/parafarmácia) → cada cliente novo é quase só branding + conteúdo. Deixa de ser "um site" e vira produto/agência.

## ✅ Recomendação

1. **Base = serviço.** Fechar **Mensal** (ou **Anual** com saída fácil) com a EBeauty **já**. Receita previsível, risco baixo.
2. **Faturar backlog + "pacote go-live"** à parte (one-time).
3. **Performance = 3.ª opção opcional**, sempre **base + %**, só após pagamento integrado. "Quando crescermos juntos."
4. **Alavancagem real = escala** (mesmo motor, vários clientes).

## ❓ Decisões em aberto (preencher antes de propor)

- [x] ~~Preços~~ → propostos: **€59 mensal · €590/ano · €39 + 6% performance** (rever com valor/hora final).
- [x] ~~Valor/hora~~ → **€20/h** (arranque) · **~0,75h/mês**. Subir a €25–30 recalcula (margens descem ligeiramente).
- [ ] Limite de uso da IA por plano (**N** conversas/mês).
- [ ] **Mensal (flexível)** ou **Anual (compromisso)** como entrada para a EBeauty?
- [ ] **Propriedade:** licença vs venda vs híbrido.
- [ ] Cláusula de saída antecipada do Anual (meses em falta / penalização / aviso).
- [ ] Setup/build one-time para a EBeauty: já pago? quanto?
- [ ] Quem paga os custos variáveis (API/hosting) acima do limite.
- [ ] Infra de arranque: Vercel agora → migrar a VPS aos 5+ clientes.
