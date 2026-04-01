![[kubernets.jpg]]


  Kubernetes, ou K8s, é uma plataforma de orquestração de containers. Em vez de correres containers manualmente um a um, defines como a tua aplicação deve estar a funcionar, e o Kubernetes trata de manter esse estado.

 ### Na prática, serve para gerir aplicações feitas de vários containers:

  - arrancar e parar serviços
  - distribuir containers por várias máquinas
  - reiniciar containers com falha
  - escalar a app para cima ou para baixo
  - expor serviços para acesso externo
  - fazer deploys e updates com menos interrupções

  ## Porque existe
  Com Docker, consegues correr containers facilmente. O problema começa quando tens:

  - muitos containers
  - vários serviços
  - várias máquinas
  - necessidade de alta disponibilidade
  - deploys frequentes

  Aí, gerir tudo manualmente torna-se impraticável. O Kubernetes automatiza isso.

##  Conceitos principais

  - Cluster: conjunto de máquinas onde a aplicação corre.
  - Node: cada máquina dentro do cluster.
  - Pod: unidade básica do Kubernetes; normalmente contém um ou mais containers.
  - Deployment: define quantas réplicas de uma app devem existir e como atualizá-las.
  - Service: cria um ponto de acesso estável para comunicar com os pods.
  - Ingress: gere acesso HTTP/HTTPS vindo de fora do cluster.
  - ConfigMap e Secret: guardam configurações e dados sensíveis.
  - Namespace: ajuda a separar ambientes ou equipas dentro do mesmo cluster.

## Exemplo simples
  Imagina uma app com frontend, backend e base de dados.
  Sem Kubernetes:

  - tens de arrancar tudo à mão
  - se um container cair, tens de o voltar a subir
  - se precisares de mais capacidade, tens de duplicar manualmente

 ### Com Kubernetes:

  - defines que queres, por exemplo, 3 instâncias do backend
  - se uma falhar, ele recria
  - se o tráfego subir, podes escalar para 5 ou 10
  - o tráfego é distribuído entre as instâncias

 ### Vantagens

  - automação operacional
  - escalabilidade
  - tolerância a falhas
  - deploys mais consistentes
  - melhor uso de infraestrutura
  - bom suporte para arquiteturas de microserviços

 ### Desvantagens

  - curva de aprendizagem alta
  - mais complexidade
  - debugging e observabilidade podem ficar mais difíceis
  - pode ser excessivo para projetos pequenos

 ### Quando faz sentido usar?
###  Kubernetes faz sentido quando tens:

  - aplicações com vários serviços
  - necessidade de escalar
  - equipas que fazem deploy frequentemente
  - ambientes cloud ou infra distribuída
  - requisitos de disponibilidade elevados

Vídeo:
https://www.youtube.com/watch?v=F4U1KsTnVyQ