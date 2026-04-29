Casos de conflito no excell :
As 9 mismatches confirmadas em OpsDock-development/apps/api/external_files/leave-import-review-2026-03-23T17-39-01-838Z/leave-import-plan/blocked-items.json são estas:

  | Colaborador | Nº colaborador | Excel Total | Dias marcados | Diferença |
  
  | Paulo Livramento | plivramento   | 24.5 |                    25                   +0.5 
  | Casimiro Gomes    | cgomes            | 19 |                       18                      -1 
  | Filipe Folgado        | ffolgado           | 8 |                           9                      +1 
  | João Gomes           | jgomes              | 21 |                        22                    +1 
  | José Lopez             | jlopez                | 23 |                       25                     +2 
  | Ricardo Pimentel  | rpimentel        | 19 |                       22                    +3 
  | Susana Soares        | ssoares             | 18 |                      20                    +2 
  | Filipe Sousa             | fsousa              | 17 |                      18                    +1 
  | Susana Vaz               | svaz                  | 10 |                      12                    +2 

  Leitura rápida:

  - Só Paulo Livramento sugere claramente meio dia (24.5 vs 25).
  - Casimiro Gomes é o único caso em que o Excel tem mais do que os dias marcados.
  - Os restantes 7 casos apontam para dias assinalados a mais face ao Total.

  Nota: o ficheiro de bloqueios também tem os 3 unmatched duplicados no fim. Isso não altera estas 9 discrepâncias, mas convém limpar quando fizermos a fase seguinte.
  
  ###### **Caso do Casimiro Gomes :** 
- a diferença de um dia é em junho de 2026 o mapa tem Total = 4, mas os dias marcados lidos são 3, 5, 24 e aparece também um 31, que é inválido para junho. Qual é o 4.º dia correto?

![[Pasted image 20260324095921.png]]
Visão no Excel:  
![[Pasted image 20260324101214.png]]
Solução :
A importação de férias, qualquer marcação feita num dia inexistente para o mês/ano em causa é ignorada para efeitos de contagem e sinalizada como erro de validação. O registo fica devolvido para correção. Como melhoria, o template deve bloquear o preenchimento de dias inválidos.

==Aconselha-se== rever o caso do **Casimiro Gomes** para confirmar se o registo em **31/06/2026** foi um lapso de preenchimento em vez de **01/07/2026**.

##### Caso do Paulo Livramento:
- Total anual: 24.5
- dias marcados válidos: 25(no Calendário)

  O ponto-chave está em fevereiro:

  - Total de fevereiro: 2.5
  - dias marcados: 9, 16, 17
  - valores lidos no parser:
      - dia 9 = 0.5
      - dia 16 = 1
      - dia 17 = 1

  Ou seja:

  - o Excel está a representar corretamente um meio dia em 09/02
  - a contagem “por dias marcados” dá 3 casas assinaladas
  - mas o total correto do mês é 2.5

![[Pasted image 20260324105155.png|697]]
Solução:
Usar o Total do Excel como fonte de verdade para a contagem de férias, e usar os dias assinalados apenas para identificar e validar as datas marcadas.

==Sugestão== nestes casos podemos se necessário podemos adaptar no Excel os meios dias para 0.5, ½, M e T passam a contar 0.5.

###### **Caso Filipe Sousa**
 Total anual: 17
  - dias marcados: 18

  Detalhe mensal:

  - fevereiro: 1 e 1 dia marcado, ok
  - abril: 1 e 1 dia marcado, ok
  - junho: 1 e 1 dia marcado, ok
  - agosto: 10 e 10 dias marcados, ok
  - julho: aqui está a diferença

  Em julho:

  - Total = 4
  - dias marcados = 27, 28, 29, 30, 31
  - ou seja, estão 5 dias assinalados

  Portanto a discrepância é esta:

  - em julho há 1 dia marcado a mais
  - o Excel diz que o correto são 4 dias, não 5
![[Pasted image 20260324114607.png]]

Solução: 
Alterei a formula de soma das células que não estava a contabilizar o primeiro e ultimo dia do mês.

O mesmo aconteceu no caso do João Gomes, José Lopez,

Os conflitos identificados nos casos revistos resultaram de fórmulas incorretas no Excel para a soma dos dias marcados. Em vários casos, o Total mensal/anual não incluía corretamente todas as colunas dos dias, originando discrepâncias artificiais entre o total calculado e os dias assinalados. Este é um problema que pode voltar a surgir, por não terem sido revistos casos onde não existia erro.

Mapeamento:
# Employee Presence Mapping

```text
Colaborador                 | Excel | Seeds/Web | Estado                          
----------------------------+-------+-----------+---------------------------------
Adriano Ferreira            | x     | x         | Ambos                           
Alessandra Samuel           |       | x         | Só Seeds/Web                    
Alexandra Borges            | x     | x         | Ambos                           
Ana Ramos                   | x     | x         | Ambos                           
Ana Teixeira                |       | x         | Só Seeds/Web                    
Ana Teodoro                 | x     | x         | Ambos                           
André Rodrigues             | x     | x         | Ambos                           
Andreia Serafim             | x     | x         | Ambos                           
Andresa Salgueiro           | x     | x         | Ambos                           
António Santos              |       | x         | Só Seeds/Web                    
Artur Santos                | x     | x         | Ambos                           
Bernardo Saramago           |       | x         | Só Seeds/Web                    
Bozena Ferreira             |       | x         | Só Seeds/Web                    
Bruno Gomes                 | x     | x         | Ambos                           
Caren Souza                 |       | x         | Só Seeds/Web                    
Carla Joaquim               | x     | x         | Ambos                           
Carla Silva                 |       | x         | Só Seeds/Web                    
Carlos Malarranha           | x     | x         | Ambos                           
Carlos Pinheiro             | x     | x         | Ambos                           
Carolina Baeta              | x     | x         | Ambos                           
Casimiro Gomes              | x     | x         | Ambos                           
Claudia Gomes               | x     | x         | Ambos                           
Claudio Camacho             |       | x         | Só Seeds/Web                    
Cristina Trindade           | x     | x         | Ambos                           
Dalia Sousa                 |       | x         | Só Seeds/Web                    
Dália Sousa                 | x     |           | Só Excel                        
Daniel Vinhais              |       | x         | Só Seeds/Web                    
Daniela Vida                |       | x         | Só Seeds/Web                    
Danielle Rufino             | x     | x         | Ambos                           
Danilo Vieira               | x     | x         | Ambos                           
Duarte Soeiro               |       | x         | Só Seeds/Web                    
Eduardo Mateus              |       | x         | Só Seeds/Web                    
Erick Gomez                 |       | x         | Só Seeds/Web                    
Fabio Vilela                | x     |           | Só Excel                        
Fábio Vilela                |       | x         | Só Seeds/Web                    
Feizal Mayet                | x     | x         | Ambos                           
Fernando Pinto              | x     | x         | Ambos                           
Filipa Gomes                | x     | x         | Ambos                           
Filipa Tiago                |       | x         | Só Seeds/Web                    
Filipe Coelho               | x     | x         | Ambos                           
Filipe Folgado              | x     | x         | Ambos                           
Filipe Sousa                | x     | x         | Ambos                           
Francisco Andrade           |       | x         | Só Seeds/Web                    
Frederico Moreira           | x     | x         | Ambos                           
Gonçalo Alexandre Florencio |       | x         | Só Seeds/Web                    
Gonçalo Martins             |       | x         | Só Seeds/Web                    
Guilherme Ferreira          | x     | x         | Ambos                           
Gustav Azevedo              | x     | x         | Ambos                           
Helder Emidio               |       | x         | Só Seeds/Web                    
Hélder Emídio               | x     |           | Só Excel                        
Herculano Dias              | x     | x         | Ambos                           
Ines Fernandes              |       | x         | Só Seeds/Web                    
Inês Ferreira               | x     | x         | Ambos                           
Inês Maia                   | x     |           | Mapeado para Ines Maia Fernandes
Ines Maia Fernandes         |       | x         | Mapeado de Inês Maia            
Inês Viegas                 | x     | x         | Ambos                           
Isabel Fernandes            | x     | x         | Ambos                           
Ivo Leite                   |       | x         | Só Seeds/Web                    
Jennyfer Nunes              |       | x         | Só Seeds/Web                    
João Antunes                | x     | x         | Ambos                           
João Coelho                 | x     | x         | Ambos                           
João Ferreira               |       | x         | Só Seeds/Web                    
João Gomes                  | x     | x         | Ambos                           
João Gomes Novo             |       | x         | Mapeado de João Ribeiro Gomes   
João Martinho               | x     | x         | Ambos                           
João Mateus                 | x     |           | Mapeado para João Paulo Mateus  
João Paulo Mateus           |       | x         | Mapeado de João Mateus          
João Ribeiro Gomes          | x     |           | Mapeado para João Gomes Novo    
Joaquina Mourato            | x     | x         | Ambos                           
Jordania Nascimento         |       | x         | Só Seeds/Web                    
Jorge Augusto               | x     | x         | Ambos                           
José Barros                 |       | x         | Só Seeds/Web                    
José Fernandes              | x     | x         | Ambos                           
José Lopez                  | x     | x         | Ambos                           
José Pires                  | x     | x         | Ambos                           
Juliana Miranda             | x     | x         | Ambos                           
Júlio Silva                 |       | x         | Só Seeds/Web                    
Leonardo Landim             |       | x         | Só Seeds/Web                    
Liliana Machado             |       | x         | Só Seeds/Web                    
Lucas Sancho                |       | x         | Só Seeds/Web                    
Luis Arruda                 |       | x         | Só Seeds/Web                    
Luís Arruda                 | x     |           | Só Excel                        
Luis Barradas               |       | x         | Só Seeds/Web                    
Luis Candeias               | x     | x         | Ambos                           
Luis Monteiro               |       | x         | Só Seeds/Web                    
Luis Moura                  | x     |           | Só Excel                        
Luís Oliveira               | x     | x         | Ambos                           
Luiz Azevedo                |       | x         | Só Seeds/Web                    
Madalena Malveiro           |       | x         | Só Seeds/Web                    
Mafalda Duque               | x     | x         | Ambos                           
Manuel Fernandes            |       | x         | Só Seeds/Web                    
Manuel Sousa                | x     | x         | Ambos                           
Marcelo Fernandes           | x     | x         | Ambos                           
Marcia Mendonça             |       | x         | Só Seeds/Web                    
Márcia Mendonça             | x     |           | Só Excel                        
Margarida Farmhouse         |       | x         | Só Seeds/Web                    
Maria Castañeira            | x     | x         | Ambos                           
Maria Fernandes             | x     | x         | Ambos                           
Maria Ferreira              |       | x         | Só Seeds/Web                    
Maria Joao Filipe           |       | x         | Só Seeds/Web                    
Mário Van Zeller            |       | x         | Só Seeds/Web                    
Marta Costa                 |       | x         | Só Seeds/Web                    
Mauro Silva                 | x     | x         | Ambos                           
Miguel Aires                |       | x         | Só Seeds/Web                    
Miguel Angelo Pinto         | x     |           | Mapeado para Miguel Pinto       
Miguel Loureiro             |       | x         | Só Seeds/Web                    
Miguel Mota                 |       | x         | Só Seeds/Web                    
Miguel Perdigão             | x     | x         | Ambos                           
Miguel Pinto                |       | x         | Mapeado de Miguel Angelo Pinto  
Neisser Pinheiro            |       | x         | Só Seeds/Web                    
Nuno Costa                  |       | x         | Só Seeds/Web                    
Nuno Freitas                | x     | x         | Ambos                           
Nuno Marques                | x     | x         | Ambos                           
Pablo Pinto                 |       | x         | Só Seeds/Web                    
Patricia Sousa              |       | x         | Só Seeds/Web                    
Paulo Gonçalves             |       | x         | Só Seeds/Web                    
Paulo Livramento            | x     | x         | Ambos                           
Paulo Martins               | x     | x         | Ambos                           
Pedro Augusto               | x     | x         | Ambos                           
Pedro Barbosa               | x     | x         | Ambos                           
Pedro Leandro               |       | x         | Só Seeds/Web                    
Pedro Moura                 |       | x         | Só Seeds/Web                    
Pedro Pereira               | x     | x         | Ambos                           
Pedro Roberto               |       | x         | Só Seeds/Web                    
Rafael Jorge Rodrigues      |       | x         | Só Seeds/Web                    
Rafael Mantas               | x     | x         | Ambos                           
Ricardo Pimentel            | x     | x         | Ambos                           
Ricardo Vinhais             | x     | x         | Ambos                           
Rita Fonseca                | x     | x         | Ambos                           
Rita Teixeira               | x     |           | Só Excel                        
Roberto Gomez               |       | x         | Só Seeds/Web                    
Rodrigo Ferreira            |       | x         | Só Seeds/Web                    
Rui Castro                  | x     | x         | Ambos                           
Rui Machado                 | x     | x         | Ambos                           
Rute Bastos                 | x     | x         | Ambos                           
Sandro Sá                   | x     | x         | Ambos                           
Sara Queiroz                | x     | x         | Ambos                           
Sara Santos                 | x     | x         | Ambos                           
Sofia Catraia               |       | x         | Só Seeds/Web                    
Sofia Fonseca               | x     | x         | Ambos                           
Soraia Dias                 | x     | x         | Ambos                           
Susana Salgado              |       | x         | Só Seeds/Web                    
Susana Soares               | x     | x         | Ambos                           
Susana Vaz                  | x     | x         | Ambos                           
Tânia Sousa                 | x     | x         | Ambos                           
Thatiana Pereira            |       | x         | Só Seeds/Web                    
Tiago Rodrigues             | x     | x         | Ambos                           
Vitor Sousa                 | x     | x         | Ambos                           
```

## Resumo

- Total de nomes no Excel: 85
- Total de nomes nas Seeds/Web: 137
- Presentes em ambos com o mesmo nome: 74
- Só Excel: 7
- Só Seeds/Web: 59
- Mapeados manualmente: 8