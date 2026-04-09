

## Identificação por reconhecimento facial de duplo sensor, cartão EM, impressão digital, PIN e/ou combinações
Produto  Anviz W2-FACE :
https://www.orbitadigital.com/pt/controlo-de-acessos/terminais/79126-anviz-w2-face-controlo-de-acesso-e-presenca-facial-impressao.html?gad_source=1&gad_campaignid=20767448601&gclid=CjwKCAjwnN3OBhA8EiwAfpTYekNfeiQz2e3vvEzB-x-F-3N2wp2KCBUUl6l6JFqKOC0JezzcwzqHCRoCUZ0QAvD_BwE  (217€)
Link da Página:
https://www.anviz.com/product/smart-face-fingerprint-recognition-access-attendace-terminal.html


## Controlo biométrico por impressão digital e cartão
Produto  Anviz W2 Pro:
https://www.pccomponentes.pt/controle-de-acesso-anviz-w2-pro-impressao-digital-teclado-e-cartao-3000-usuarios-rele?srsltid=AfmBOoqAtM6vroPRnuMTDLFSlTLq0VNwP7qyfG9mXRl5fsr6aPMLx2AC (113€)


## Proposta da IDONIC

![[Pasted image 20260409150239.png]]

Link: https://idonic.pt/pt/artigo/idonic-chronos-219-s/6364

**Biometria na ordem do dia**  
O IDONIC CHRONOS 219 S é um relógio de ponto para registo de assiduidade por impressão digital, cartão de proximidade (RFID 125KHz e Mifare) e código pin.  
  
**Perspicaz na validação**  
Com um tempo de verificação de menos de 1 segundo, este terminal de assiduidade permite uma rápida picagem de ponto, tornando-se uma ótima opção para empresas com um grande número de funcionários a cumprirem o mesmo horário de trabalho.  
  
**Um visionário na comunicação**  
Equipado com Wi-Fi ou com 4G, o IDONIC CHRONOS 219 S está à frente dos seus pares! Graças a estas duas formas de comunicação sem fios, este equipamento torna-se uma opção versátil e sempre online.

(Sem preço)





## METODO DE TRABALHO DE DADOS

#### Integração via API (A mais moderna) 

Alguns fabricantes (como a [ControlID](https://suporte.starsoft.com.br/portal/pt/kb/articles/conectividade-com-rel%C3%B3gios-de-ponto-controlid-via-api)) já disponibilizam uma **API REST** nativa dentro do próprio equipamento. 

- **Como funciona**: O seu programa interno faz requisições HTTP (POST/GET) diretamente para o endereço IP do relógio na rede Wi-Fi.
- **Vantagem**: Independe de linguagem de programação; funciona bem com sistemas em nuvem. 

#### Uso de SDK (Software Development Kit)

Esta é a solução clássica para um controle mais granular. Muitos terminais vêm equipados com o chamado **Push SDK**. 

- **Como funciona**: O fabricante fornece bibliotecas (DLLs ou pacotes para Java, Python, C#, etc.) que o seu desenvolvedor utiliza para "ensinar" o seu programa a falar a língua do relógio.
- **Vantagem**: Permite capturar eventos em tempo real (push) e gerir templates biométricos de forma eficiente.


#### Alguns sistemas utilizam um middleware ou configuram o relógio para o **Modo Cliente**. 
https://www.youtube.com/watch?v=Xzcmr2IVS84&t=5s

- **Como funciona**: O relógio liga-se ao Wi-Fi e "procura" ativamente o seu servidor (através de um IP/DNS configurado no menu do aparelho) para descarregar os logs de picagem.
- **Configuração**: É necessário definir o IP do seu servidor e a porta de comunicação (ex: porta 3000 ou 3671) diretamente no menu do relógio. 

Passo a Passo Técnico Recomendado:

1. **Fixação de IP**: No seu router Wi-Fi, reserve um **IP estático** para o relógio para evitar que ele mude de endereço e perca a conexão com o seu software.
2. **Habilitação no Menu**: Aceda às definições de **Comunicação > Wi-Fi** no relógio, conecte-o à rede e verifique se o ícone de status fica verde (conectado).
3. **Captura de Dados**: Utilize a documentação do fabricante para configurar o "webhook" ou o serviço de escuta no seu programa que receberá os dados de identificação e carimbo de tempo.

Para testes mais rápido sugiro a utilização de um tablet, criamos uma app que gerar codigo qr a cada minuto, o utilizador lê o código e a app comunica via wi-fi com o ponto, o telemóvel passa o ID de utilizador. Não dispensa da geolocalização. 