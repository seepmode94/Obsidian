

## Objetivo

Avaliar opções de terminais de controlo de acessos e assiduidade, bem como alternativas de implementação e métodos de integração de dados.

---

## Opções de equipamento

### 1. Identificação por reconhecimento facial de duplo sensor, cartão EM, impressão digital, PIN e/ou combinações

Produto: Anviz W2-FACE
![[Pasted image 20260409175449.png|286]]

Link de compra:
https://www.orbitadigital.com/pt/controlo-de-acessos/terminais/79126-anviz-w2-face-controlo-de-acesso-e-presenca-facial-impressao.html?gad_source=1&gad_campaignid=20767448601&gclid=CjwKCAjwnN3OBhA8EiwAfpTYekNfeiQz2e3vvEzB-x-F-3N2wp2KCBUUl6l6JFqKOC0JezzcwzqHCRoCUZ0QAvD_BwE

Preço:
217€

Link da página:
https://www.anviz.com/product/smart-face-fingerprint-recognition-access-attendace-terminal.html

### 2. Controlo biométrico por impressão digital e cartão

Produto: Anviz W2 Pro

![[Pasted image 20260409175510.png|266]]

Link de compra:
https://www.pccomponentes.pt/controle-de-acesso-anviz-w2-pro-impressao-digital-teclado-e-cartao-3000-usuarios-rele?srsltid=AfmBOoqAtM6vroPRnuMTDLFSlTLq0VNwP7qyfG9mXRl5fsr6aPMLx2AC

Preço:
113€

### 3. Proposta da IDONIC

![[Pasted image 20260409150239.png]]

Link:
https://idonic.pt/pt/artigo/idonic-chronos-219-s/6364

Características referidas:

- Biometria na ordem do dia
  O IDONIC CHRONOS 219 S é um relógio de ponto para registo de assiduidade por impressão digital, cartão de proximidade (RFID 125KHz e Mifare) e código pin.
- Perspicaz na validação
  Com um tempo de verificação de menos de 1 segundo, este terminal de assiduidade permite uma rápida picagem de ponto, tornando-se uma opção para empresas com um grande número de funcionários a cumprirem o mesmo horário de trabalho.
- Um visionário na comunicação
  Equipado com Wi-Fi ou com 4G, o IDONIC CHRONOS 219 S está à frente dos seus pares. Graças a estas duas formas de comunicação sem fios, este equipamento torna-se uma opção versátil e sempre online.

Preço:
350€

### 4. Escolha mais viável

![[Pasted image 20260409174448.png]]

Isto é o mesmo aparelho que a Fatorial vende, mas com o sistema da Fatorial. Ainda não sabendo o valor do aparelho temos acesso às drivers dele e temos liberdade para integrar o nosso software tal como a Fatorial faz.

Link:
https://www.zkteco.com/en/SpeedFaceSeries/SpeedFace-V5L-Series

Nota:
Email enviado para a equipa de vendas pelo email guilhermeferreira@seepmode.com em 09-04-2026.
## esquecer a comunicação entre a ZKTECO/IDONIC

‎Speedface-v5l - 334,57€


https://www.amazon.es/-/pt/dp/B0DWSHKM5G/ref=sr_1_5?crid=290WEKVW9SYUM&dib=eyJ2IjoiMSJ9.fao788NjDmQvwhAe3ABJfL3G2rrPpUYOVo6tdN52j51OJAfWKjBwjIK3KNu9K_oJTpEJU7DjJpR9Q-y6TdbO1XOVGGck24eGl8DGnz_rmXjO-jX6Z0azED8LMaLmGy9R8yjF9uaoqPtCXKsATtJTVONLUlTi3zJCQnzGkW5ablRVvjQ5ti0ps0V8fdbs2BeDgDkQhVa151K1QoB2GMJZzfQ8AcGcVkbqvUICbbJZwcQe91LUUBKJ2LlW7xKF5mo6YhD0_sM_2dsxsVHCSmE9J3queWmkTlOPbkq5NQDdRk4.RZ9UzTaOez9CAuVEn6kalD_ffXGwQdZNXwSjUg9gFeQ&dib_tag=se&keywords=SpeedFace-V5L&qid=1776162079&sprefix=speedface-v5l%2Caps%2C102&sr=8-5&th=1

- 30 dias para devolução
- Autenticação múltipla: reconhecimento facial, impressão digital, cartão e senha.  
- O brilho da luz de preenchimento é ajustável.  
- Software profissional de gerenciamento de rede.  
- Distância de reconhecimento: 0,3-2 metros.  
- Capacidade: 6.000  leitores de impressões digitais. Capacidade: 6.000  
- Métodos de comunicação: TCP/IP, RS485, RS232.  

Para integrar o terminal biométrico com o software in house podemos, utilizar o ==software development kit== disponibilizado pela ZKTeco: 
- Como funciona: O seu software comunica diretamente com o hardware através de bibliotecas (DLLs para C#, C++, Java).
    
- Vantagem: Controlo total. Pode enviar novos utilizadores para o terminal, apagar digitais ou puxar os registos em tempo real.

==Comunicação via Protocolo ADMS(Cloud):==
- Como funciona: O terminal atua como um "cliente" que envia os dados para um servidor web (o seu software) sempre que ocorre uma marcação.
    
- Vantagem: Ideal para ligar terminais em redes diferentes ou filiais, pois o terminal "empurra" a informação para o seu servidor assim que deteta internet.
    
- Configuração: configurar o IP do seu servidor e a porta no menu "Configuração de Nuvem" do terminal.

==Integração por Base de Dados (ZKBio Access/Time):==
- - Como funciona: O software da ZKTeco descarrega os dados do terminal para uma base de dados (SQL Server ou PostgreSQL). O seu software  in-house lê simplesmente os novos registos dessa base de dados.
    
- Vantagem: Muito mais simples de implementar se a sua equipa de IT preferir trabalhar apenas com SQL.
---
Outras opções mais simples

# DHI-ASI3213A-W

Cartão Facial e Senha:
https://www.pccomponentes.pt/controle-de-acesso-dahua-dhi-asi3213a-w-facial-cartao-e-senha-3000-usuarios-wifi-lcd 95€
- Limitação: A câmara deste modelo é otimizada para biometria facial. Embora alguns firmwares da Dahua permitam a leitura de QR Code via câmara nestes modelos, a performance (velocidade e distância) é inferior à do ASI6214J ou do SpeedFace[QR].
    
- Dica: Se o QR Code for o seu método principal, este modelo pode causar alguma frustração aos colaboradores por ser mais lento a focar o código.
    

### 2. Integração com a Opsdock

- CGI/HTTP API: Pode continuar a usar comandos JSON para comunicar com o terminal.
    
- Wi-Fi integrado: Como o nome indica (o "-W"), ele facilita a instalação se não tiver um ponto de rede por perto, embora para um sistema de ponto eu recomende sempre o cabo (Ethernet) para evitar atrasos na validação dos tais códigos de 2 minutos.


# DHI-ASI6214J-MFW
Cartão Facial e Senha:
https://www.worten.pt/produtos/dhi-asi6214j-mfw-dahua-leitor-de-controle-de-acesso-integrado-toque-cartao-de-senha-de-reconhecimento-facial-tela-lcd-4-3-camera-hd-2mp-mrkean-6939554948749?gad_source=1&gad_campaignid=17336356044&gclid=Cj0KCQjwy_fOBhC6ARIsAHKFB7-QNj4qP92w5nWscMmzPqOAKaxpHGSE9G6ralDv6XPKCm-rcXoC6LcaAvwbEALw_wcB €215,07

- Conectividade: Wi-Fi (2.4 GHz) e Ethernet (RJ-45).
    
- Biometria: Reconhecimento Facial e Impressão Digital (capacitivo).
    
- Capacidade: Até 6.000 faces, 6.000 impressões digitais e 150.000 registos.
    
- Extras: Ecrã tátil de 4.3 polegadas e proteção IP65 (resistente a poeiras e jatos de água).

---

## Solução rápida para testes

Para realizar testes o mais rápido possível sugiro a utilização de um tablet. Criamos uma app que gerar código qr a cada minuto, para não ser possível contornar o sistema. O utilizador lê o código e a app comunica via wi-fi com o ponto, o telemóvel passa o ID de utilizador. Não dispensa da geolocalização.

---

## Método de trabalho de dados com terminais

### 1. Integração via API

Alguns fabricantes, como a ControlID, já disponibilizam uma API REST nativa dentro do próprio equipamento.

Referência:
https://suporte.starsoft.com.br/portal/pt/kb/articles/conectividade-com-rel%C3%B3gios-de-ponto-controlid-via-api

Como funciona:

- o programa interno faz requisições HTTP POST/GET diretamente para o endereço IP do relógio na rede Wi-Fi

Vantagem:

- independe de linguagem de programação
- funciona bem com sistemas em nuvem

### 2. Uso de SDK

Esta é a solução clássica para um controlo mais granular. Muitos terminais vêm equipados com o chamado Push SDK.

Como funciona:

- o fabricante fornece bibliotecas, como DLLs ou pacotes para Java, Python, C# e outras linguagens, que o programador utiliza para integrar o sistema com o relógio

Vantagem:

- permite capturar eventos em tempo real
- permite gerir templates biométricos de forma eficiente

### 3. Middleware ou modo cliente

Alguns sistemas utilizam um middleware ou configuram o relógio para o modo cliente.

Referência:
https://www.youtube.com/watch?v=Xzcmr2IVS84&t=5s

Como funciona:

- o relógio liga-se ao Wi-Fi e procura ativamente o servidor, através de um IP ou DNS configurado no menu do aparelho, para descarregar os logs de picagem

Configuração:

- é necessário definir o IP do servidor e a porta de comunicação, por exemplo porta 3000 ou 3671, diretamente no menu do relógio

---

## Passo a passo técnico recomendado

1. Fixação de IP
Reservar um IP estático no router Wi-Fi para o relógio, para evitar mudança de endereço e perda de conexão com o software.

2. Habilitação no menu
Aceder às definições de Comunicação > Wi-Fi no relógio, ligá-lo à rede e verificar se o ícone de estado fica verde.

3. Captura de dados
Utilizar a documentação do fabricante para configurar o webhook ou o serviço de escuta no programa que receberá os dados de identificação e carimbo de tempo.




terminal de pé:
 https://www.orbitadigital.com/pt/controlo-de-acessos/terminal-termico/19114-hyu-855.html?gad_source=1&gad_campaignid=20767448601&gbraid=0AAAAADthsROXTb8b6ZpDKZa-AWnfqq0WS&gclid=Cj0KCQjwy_fOBhC6ARIsAHKFB79rOE9WmHbDL2p1Pw_uWgUDHhQQgOALDudIlhq475gzbPQchJ_52SAaAqZ1EALw_wcB