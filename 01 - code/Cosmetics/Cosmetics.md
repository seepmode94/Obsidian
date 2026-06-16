---
tags: [projeto, cosmetics, ia, visao, on-device, flutter]
status: ideação
---

# Cosmetics — App de análise de pele + recomendação de produtos

> [!info] Relação com o catálogo
> Isto é uma **ideia/feature**, ainda em ideação. O **catálogo e-commerce real e construído** é o **EBeauty** (projeto `Vendas`) — ver [[EBeauty - Catálogo (projeto Vendas)]]. Esta análise de pele faria sentido como feature que **recomenda produtos do catálogo EBeauty**.

## 🎯 Conceito

App que usa IA com acesso à câmara para **analisar a pele** do utilizador e **recomendar um produto da loja** (base de dados própria).

- Enquadramento **cosmético / bem-estar** — NÃO diagnóstico médico.
- **Tudo local (on-device)** — a imagem é processada no telemóvel e **descartada**, sem guardar dados.
- Recomenda **apenas produtos que existem na base de dados**.
- Se a pele estiver em boa condição → reconhece isso e recomenda um **creme de manutenção**.

## ⚖️ Fronteira regulatória (decisão central)

| ✅ Cosmético (este projeto) | ⚠️ Médico (evitar) |
|---|---|
| "A tua pele parece seca → experimenta este produto" | "Tens dermatite / acne / melanoma" |
| tipo de pele, hidratação, textura, vermelhidão, bem-estar | doença, condição, lesão, diagnóstico |
| regulação leve (produto de consumo) | **EU MDR — dispositivo médico** (marcação CE, etc.) |

> [!danger] Linha que não se cruza
> Assim que o software **diagnostica uma condição de saúde**, passa a **dispositivo médico (MDR 2017/745)** na UE — carga regulatória enorme. **Detetar cancro/melanoma é zona de alto risco e fica fora do âmbito.** O app nunca faz afirmações médicas — "não é médico nenhum".

## 🔒 RGPD

Imagens de rosto/pele = dados pessoais, possivelmente **categoria especial (Art. 9 — biométricos/saúde)**.

- ✅ Processamento **on-device** → a imagem nunca sai do telemóvel → reduz drasticamente o risco.
- ✅ **Não guardar dados** — processar e descartar.
- ✅ Consentimento explícito antes de usar a câmara.
- ✅ Política de privacidade + finalidade clara.
- ✅ Transparência sobre o viés comercial (recomenda produtos da própria loja).

## 🏗️ Arquitetura — separar "ver" de "recomendar"

> Os guardrails são **arquitetura**, não só prompt.

```
[1] Perceção (on-device)            [2] Recomendação (regras, determinístico)
  modelo olha para a pele   →         mapeia atributos → produto da BD
  devolve SÓ atributos:                - zonas secas?  → creme hidratante X
   { secura: 0-1,                      - oleosa?       → produto Y
     oleosidade: 0-1,                  - tudo bem?     → creme manutenção Z
     vermelhidao: 0-1,
     textura: 0-1, ... }               ⚠️ recomenda APENAS o que está na BD
```

- **Camada 1** não produz texto livre → impossível "inventar" frase médica. Devolve só atributos cosméticos (output estruturado).
- **Camada 2** é lógica própria: mapeia atributos → produto do catálogo. O modelo não escolhe livremente.
- **Ramo "está tudo bem"**: todos os atributos em bom intervalo → reconhece boa condição + recomenda creme de manutenção.

### Mapa requisitos → solução

| Requisito | Possível? | Como |
|---|---|---|
| Tudo local, sem guardar dados | ✅ | modelo on-device; imagem descartada |
| Só recomenda produtos da BD | ✅ | camada de regras → catálogo |
| Nunca diz "cancro"/diagnóstico | ✅ | camada 1 só devolve atributos (sem texto livre) |
| Reconhece pele saudável + manutenção | ✅ | ramo "tudo bem" no mapeamento |

## 🤖 Escolha do modelo (decisão em aberto)

> **Claude e os VLMs grandes são cloud-only — não correm on-device.** Como o requisito é local, ficam de fora para a camada 1.

Duas vias para o modelo de perceção on-device:

1. **Modelo especializado de classificação de pele** (treinado/afinado p/ atributos cosméticos) — mais robusto e previsível para esta tarefa fechada; mais trabalho a obter/treinar.
2. **VLM pequeno on-device genérico** — mais fácil de arrancar, mas é preciso "trancá-lo" para devolver só o schema de atributos; qualidade em pele pode ser irregular sem afinação.

Considerar runtime de ML on-device para Flutter (mobile).

## ✅ Boas práticas / a não esquecer

- [ ] Disclaimer visível: "análise informativa/cosmética, não substitui aconselhamento médico/dermatológico."
- [ ] Vocabulário cosmético em toda a UI e no schema do modelo (nada de "doença").
- [ ] Sem claims de saúde no marketing (é onde se "escorrega" para dispositivo médico).
- [ ] Transparência sobre recomendação de produtos da própria loja.
- [ ] Confirmação jurídica antes de lançar (isto não é aconselhamento jurídico).

## ❓ Questões em aberto

- [ ] Que modelo on-device usar (via 1 vs via 2)?
- [ ] Schema de atributos definitivo + regras de mapeamento → catálogo.
- [ ] Runtime de ML on-device para Flutter.
- [ ] Fluxo de consentimento/RGPD na UI.
- [ ] Copy dos disclaimers.
