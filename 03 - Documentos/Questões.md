## Página de Ausências

### Saldos
![[Pasted image 20260408101249.png|697]]Faz sentido:
- ter um saldo já definido para quem tem direto à Paternidade?
- ter um saldo para Outros ou licença sem vencimento?

### Tipos de Ausências:
![[Pasted image 20260408155507.png|504]]![[Pasted image 20260408155530.png]]
Análise:
- estes são os pedidos mais recorrentes em empresas, para facilitar o processo de pedidos e para acompanhar os resumos deixei os tipos de ausências mais explícitos.
- é necessário mais algum tipo de ausência ou retirar tipo de ausência?


### Pedidos Pendentes:
![[Pasted image 20260408152230.png]]

Faz sentido:
- deixar o admin e os recursos humanos verem que o colaborador fez o pedido de férias que ainda não passou a primeira fase do pedido(aceite pelo gestor/chefe de departamento)?
  Isto faz mais "lixo" visual pois não exige uma atividade prática por parte dos Admin ou Recursos humanos.
Preciso de:
- um mapa/ficheiro com os chefes de departamento e os colaboradores pelos quais são responsáveis 

 O fluxo atual de férias é este:

  1. O colaborador submete o pedido.
  2. O backend tenta encontrar o revisor inicial por esta ordem:

  - gestor direto do colaborador em hrm_employees.manager_id
  - se não existir, usa o manager_id do departamento

  3. Se encontrar uma chefia válida e não for o próprio colaborador:

  - o pedido nasce em pending_department_head

  4. Se não houver chefia válida, ou se a chefia for o próprio:

  - o pedido nasce em pending_hr

  5. Quando a chefia aprova:

  - passa para pending_hr

  6. Depois RH ou Admin fazem a aprovação final:

  - passa para approved

  Para outros tipos de ausência, o fluxo continua direto para pending e depois RH/Admin.
