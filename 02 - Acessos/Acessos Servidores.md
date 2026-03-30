## 01 - Staging OpsDock

User:

```sh

```

Pass:

```sh

```


## 02 - Staging SuiteCRM
User:

```sh
ssh antonio@192.168.0.8
```

Pass:

```
%94BsSeep$
```


🌐 Guia de Acesso ao Servidor e Configuração Web (Apache)

  Este guia documenta como aceder ao servidor Debian via SSH e localizar os ficheiros de configuração do site mdemo.seepmode.com.

  1. Acesso Remoto (SSH)
  Para entrar no servidor, utiliza o terminal do teu computador:

   2. Comando de Ligação:
   1    ssh antonio@192.168.0.8
   3. Autenticação: Insere a tua palavra-passe quando solicitado.

  ---

  4. Localização dos Ficheiros de Configuração
  O servidor utiliza o Apache2 para gerir os sites. As configurações estão organizadas em dois diretórios principais:

   * Caminho Base: /etc/apache2/
   * Ficheiros Disponíveis: /etc/apache2/sites-available/ (Onde guardamos as configurações originais).
   * Sites Ativos: /etc/apache2/sites-enabled/ (Onde estão os links para os sites que o servidor está a mostrar na internet).

  Como chegar lá (Comandos):

   1 # Entrar na pasta do Apache
   2 cd /etc/apache2/
   3
   4 # Entrar na pasta onde estão as configurações dos sites
   5 cd sites-available/
   6
   7 # Listar todos os ficheiros de configuração
   8 ls -la

  ---

  3. Gestão do Site mdemo.seepmode.com
  O ficheiro específico para este site chama-se seepmode.conf.

  Para ler o conteúdo (Sem editar):
   1 cat seepmode.conf

  Para editar o ficheiro (Requer permissões de administrador):

   1 sudo nano seepmode.conf
   * Para Guardar: Ctrl + O -> Enter
   * Para Sair: Ctrl + X

  ---

  4. Comandos de Manutenção (Após Alterações)
  Sempre que fizeres uma alteração no ficheiro .conf, deves seguir estes passos para que o site se atualize no browser:

   5. Validar a Sintaxe: (Garante que não há erros de escrita)
   1    sudo apache2ctl configtest
   6. Recarregar o Servidor: (Aplica as mudanças sem desligar o site)
   1    sudo systemctl reload apache2

  ---

  Notas de Suporte
   * Utilizador: antonio
   * IP do Servidor: 192.168.0.8
   * Editor Recomendado: nano (Simples e direto no terminal).

