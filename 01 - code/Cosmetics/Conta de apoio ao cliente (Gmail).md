# Conta de apoio ao cliente (Gmail)

> [!warning] Informação sensível
> Esta nota contém uma password em texto simples. Mantém o cofre Obsidian privado (não sincronizar para sítios públicos). Idealmente, guarda a password num gestor de passwords e ativa a verificação em 2 passos (2FA) na conta Google.

*Criado: 2026-06-19*

## Credenciais

| Campo | Valor |
|---|---|
| **Email (apoio ao cliente)** | `apoio.ebeauty@gmail.com` |
| **Password** | `apoioebeauty01` |
| **Telemóvel associado** | `+351 939 467 356` |
| **Email de recuperação** | `andrewvieira95@gmail.com` |

## Estado

- [ ] Conta Google ainda **por criar** (criação manual em accounts.google.com/signup — verificação por SMS no nº acima).
- [ ] Confirmar se o handle `apoio.ebeauty` ficou disponível (senão, registar a alternativa e atualizar esta nota + o site).
- [ ] Ativar verificação em 2 passos (2FA).
- [ ] Considerar password mais forte (`apoioebeauty01` é fraca).

## Onde é usado no site (projeto Vendas)

- **Rodapé** — contacto público da loja (`COMPANY.email` em `lib/legal.ts`).
- **Carrinho** — link "Encomendar por email" (`STORE.email` em `lib/products.ts`, via `mailtoOrderLink`).

O **WhatsApp** (`+351 939 467 356`) é o canal principal de encomenda (checkout do carrinho + dúvidas na página de produto).

> Nota: o email de recuperação (`andrewvieira95@gmail.com`) é **privado** — só para recuperar a conta, **não** aparece no site.
