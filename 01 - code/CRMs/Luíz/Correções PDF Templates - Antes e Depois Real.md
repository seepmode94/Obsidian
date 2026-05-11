

## SEEP-C03 - Seepmode C03 - Contrato E-lic

**Problema:** Assinatura aparecia depois da informação da empresa.

**Correção:** Assinatura passou a ficar antes da informação da empresa.

### Antes

**Antes - empresa antes das assinaturas**

![[SEEP-C03 - antes 1.png]]

### Depois

**Depois - assinaturas antes da empresa**

![[SEEP-C03 - depois 1.png]]

## SEEP-C04 - Seepmode C04 - Contrato Seepmed PT

**Problema:** Assinatura aparecia depois da informação da empresa.

**Correção:** Assinatura passou a ficar antes da informação da empresa.

### Antes

**Antes - empresa antes das assinaturas**

![[SEEP-C04 - antes 1.png]]

### Depois

**Depois - assinaturas antes da empresa**

![[SEEP-C04 - depois 1.png]]

## SEEP-C05 - Seepmode C05 - Contrato On-Route

**Problema:** Assinatura aparecia depois da informação da empresa.

**Correção:** Assinatura passou a ficar antes da informação da empresa.

### Antes

**Antes - empresa antes das assinaturas**

![[SEEP-C05 - antes 1.png]]

### Depois

**Depois - assinaturas antes da empresa**

![[SEEP-C05 - depois 1.png]]

## TAC-C01 - Tacovia C01 - Contrato Tacovia PT

**Problema:** Assinatura aparecia depois da informação da empresa.

**Correção:** Assinatura passou a ficar antes da informação da empresa.

### Antes

**Antes - empresa antes das assinaturas**

![[TAC-C01 - antes 1.png]]

### Depois

**Depois - assinaturas antes da empresa**

![[TAC-C01 - depois 1.png]]

## TAC-C02 - Tacovia C02 - Contrato Tacovia E-lic

**Problema:** Assinatura aparecia depois da informação da empresa.

**Correção:** Assinatura passou a ficar antes da informação da empresa.

### Antes

**Antes - empresa antes das assinaturas**

![[TAC-C02 - antes 1.png]]

### Depois

**Depois - assinaturas antes da empresa**

![[TAC-C02 - depois 1.png]]

## TAC-C03 - Tacovia C03 - Contrato Tacovia ES

**Problema:** Assinatura/empresa e page break ficavam mal distribuídos.

**Correção:** Assinatura passou a ficar antes da empresa e o page break foi consolidado.

### Antes

**Antes - empresa antes das assinaturas**

![[TAC-C03 - antes 1.png]]

### Depois

**Depois - assinaturas antes da empresa**

![[TAC-C03 - depois 1.png]]

## TAC-C04 - Tacovia C04 - Contrato On-Route

**Problema:** Assinatura aparecia depois da informação da empresa.

**Correção:** Assinatura passou a ficar antes da informação da empresa.

### Antes

**Antes - empresa antes das assinaturas**

![[TAC-C04 - antes 1.png]]

### Depois

**Depois - assinaturas antes da empresa**

![[TAC-C04 - depois 1.png]]

## SEEP-P04 - Seepmode P04 - Proposta Seeptrucker

**Problema:** Página vazia antes de CONDIÇÕES COMERCIAIS.

**Correção:** Removida a quebra forçada antes de CONDIÇÕES COMERCIAIS.

### Antes

**Antes - página vazia antes das condições**

![[SEEP-P04 - antes 1.png]]

**Antes - condições só na página seguinte**

![[SEEP-P04 - antes 2.png]]

### Depois

**Depois - condições sem página vazia antes**

![[SEEP-P04 - depois 1.png]]

## SEEP-P06 - Seepmode P06 - Proposta SST Medidas de Autoproteção

**Problema:** Página vazia antes de CONDIÇÕES COMERCIAIS.

**Correção:** Removida a quebra forçada antes de CONDIÇÕES COMERCIAIS.

### Antes

**Antes - página vazia antes das condições**

![[SEEP-P06 - antes 1.png]]

**Antes - condições só na página seguinte**

![[SEEP-P06 - antes 2.png]]

### Depois

**Depois - condições sem página vazia antes**

![[SEEP-P06 - depois 1.png]]

## TAC-R03 - Tacovia R03 - Proposta Tachoplus Renovação

**Problema:** SUPORTE TÉCNICO ficava separado de CONDIÇÕES GERAIS DA OFERTA, criando página adicional.

**Correção:** SUPORTE TÉCNICO e CONDIÇÕES GERAIS DA OFERTA ficaram na mesma página em fluxo contínuo.

### Antes

**Antes - SUPORTE TÉCNICO isolado no fim da página**

![[TAC-R03 - antes 1.png]]

**Antes - CONDIÇÕES GERAIS em página separada**

![[TAC-R03 - antes 2.png]]

### Depois

**Depois - SUPORTE e CONDIÇÕES na mesma página**

![[TAC-R03 - depois 1.png]]

## PROPOSTAS-GRUPOS - Duplicação de páginas por grupos de produtos

**Problema:** Em propostas com mais de um grupo de produtos, o renderer repetia blocos completos do template para cada grupo. Na prática, a introdução, páginas de descrição e condições comerciais podiam aparecer duplicadas, como aconteceu na proposta Tacovia Hardware.

**Correção:** Ajustado o renderer/importador para repetir apenas o bloco comercial do grupo, incluindo a respetiva tabela de produtos/serviços e os totais do próprio grupo. O conteúdo fixo da proposta fica renderizado uma única vez, mantendo o design dos templates existentes.

**Âmbito:** Correção de comportamento do renderer para propostas Tacovia e Seepmode com grupos múltiplos. Não altera a aparência dos templates nem o HTML guardado na base.

### Antes

**Antes - primeiro grupo renderizado normalmente**

![[TAC-HARDWARE-GRUPOS - antes 1.png]]

**Antes - segundo grupo reiniciava a proposta e duplicava conteúdo fixo**

![[TAC-HARDWARE-GRUPOS - antes 2.png]]

### Depois

**Depois - grupos e totais renderizados em sequência, sem repetir introdução/condições**

![[TAC-HARDWARE-GRUPOS - depois 1.png]]
