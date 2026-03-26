
_Este ficheiro é um manual prático com os comandos mais comuns._

---

## Aviso rápido
- **Cuidado com `sudo` e `rm -rf`** — são poderosos e também perigosos.  Dão permissões de administrador para executar os comandos e não são reversíveis

---

## Índice
1. [Navegação e ficheiros](#navegação-e-ficheiros)  
2. [Ver ficheiros](#ver-ficheiros)  
3. [Editar ficheiros (rápido)](#editar-ficheiros-rápido)  
4. [Permissões e proprietários](#permissões-e-proprietários)  
5. [Compactar / descompactar](#compactar--descompactar)  
6. [Procurar ficheiros e texto](#procurar-ficheiros-e-texto)  
7. [Processos e serviços](#processos-e-serviços)  
8. [Rede e transferência](#rede-e-transferência)  
9. [Gestão de pacotes (Ubuntu/Debian)](#gestão-de-pacotes-ubuntudebian)  
10. [Git — o básico](#git--o-básico)  
11. [Docker — comandos úteis](#docker--comandos-úteis)  
12. [Ambiente e shells](#ambiente-e-shells)  
13. [Crontab (tarefas agendadas)](#crontab-tarefas-agendadas)  
14. [Logs e troubleshooting](#logs-e-troubleshooting)  
15. [Rsync e cópias eficientes](#rsync-e-cópias-eficientes)  
16. [Utilitários de texto (grep, awk, sed...)](#utilitários-de-texto-grep-awk-sed)  
17. [Atalhos e dicas rápidas](#atalhos-e-dicas-rápidas)  
18. [Aliases e dotfiles — exemplos](#aliases-e-dotfiles---exemplos)  
19. [Cheat sheet — resumo rápido](#cheat-sheet---resumo-rápido)

---

## Navegação e ficheiros

```bash
pwd                  # imprime o diretório atual
ls -la               # lista tudo, incluindo ficheiros ocultos, a long listing
cd /caminho/para/pasta
cd ..                # sobe um nível
mkdir nova_pasta
touch ficheiro.txt   # cria ficheiro vazio
cp origem destino    # copia ficheiro
cp -r pasta1 pasta2  # copia pasta recursivamente
mv origem destino    # move/renomeia
rm ficheiro.txt
rm -rf pasta/        # **ATENÇÃO** apaga recursivamente sem perguntar
file ficheiro        # diz o tipo do ficheiro
stat ficheiro        # mostra metadados (modificação, tamanho, etc.)
```

---

## Ver ficheiros

```bash
cat ficheiro.txt
tac ficheiro.txt          # de trás para a frente
less ficheiro.txt         # navegar ficheiros grandes (q para sair)
more ficheiro.txt
head -n 20 ficheiro.txt   # primeiras 20 linhas
tail -n 50 ficheiro.txt   # últimas 50 linhas
tail -f ficheiro.log      # ver em tempo real (logs)
nl ficheiro.txt           # numerar linhas
```

---

## Editar ficheiros (rápido)

- **nano** — simples e bom para principiantes:

```bash
nano ficheiro.txt
# Ctrl+O (grava), Ctrl+X (sair)
```

- **vim** — poderoso, curva de aprendizagem:

```bash
vim ficheiro.txt
# i (insert), Esc, :w (gravar), :q (sair), :wq (gravar+sair), :q! (sair sem gravar)
```


---

## Permissões e proprietários

```bash
ls -l                      # ver permissões e dono
chmod u+rwx,g+rx,o-r file  # permissões simbólicas
chmod 755 script.sh        # permissões numéricas (rwx r-x r-x)
chmod 644 ficheiro.txt     # (rw- r-- r--)
chown user:group ficheiro  # muda dono e grupo
sudo chown -R user:group /path  # recursivo
umask                      # ver máscara padrão de permissão
```

**Permissões numéricas — cheat:**  
- 7 = r(4)+w(2)+x(1) = 7  
- Ex.: 755 → dono rwx, grupo r-x, outros r-x

---

## Compactar / descompactar

```bash
tar -czvf arquivo.tar.gz pasta/      # criar tar.gz (c = compress, v = verbose)
tar -xzvf arquivo.tar.gz             # extrair tar.gz
tar -xjvf arquivo.tar.bz2            # extrair .bz2
zip -r arquivo.zip pasta/
unzip arquivo.zip
gzip ficheiro
gunzip ficheiro.gz
```

---

## Procurar ficheiros e texto


```bash
find /caminho -name "padrao*"                 # encontrar ficheiros por nome
find . -type f -iname "*.log" -mtime -7       # logs modificados nos últimos 7 dias
locate ficheiro                               # precisa de updatedb
grep -Rin "texto" .                            # procura recursiva, case-insensitive, com numeros de linha
grep -E "padrao|outra" ficheiro                # regex básico
# ripgrep (rg) é mais rápido: rg "texto"
```

---

## Processos e serviços

```bash
ps aux | grep nome_do_programa
top                        # ver processos em tempo real
htop                       # top mais friendly (se instalado)
kill <PID>
kill -9 <PID>              # força terminar (usar com cuidado)
pkill nome_do_processo
nice -n 10 comando         # correr com prioridade alterada
systemctl status nginx
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nome-servico
sudo systemctl enable nome-servico   # ativar ao boot
sudo systemctl disable nome-servico
journalctl -u nome-servico -f        # logs do systemd em tempo real
```

---

## Rede e transferência

```bash
ip addr show                # ver IPs
ip route                   # ver rotas
ping 8.8.8.8
traceroute google.com
curl -I https://exemplo.com   # cabeçalhos HTTP
curl -L https://exemplo.com    # segue redireções
wget https://exemplo.com/ficheiro.zip
ss -tuln     # sockets/listening ports
netstat -tulpn    # se disponível
ssh utilizador@host
scp ficheiro.txt utilizador@host:/remote/path
scp -r pasta/ utilizador@host:/remote/path
sftp utilizador@host:/remote/path
ssh-keygen -t ed25519 -C "teu.email@exemplo.com"
ufw status
sudo ufw allow 22/tcp
sudo ufw enable
```

---

## Gestão de pacotes (Ubuntu/Debian)

```bash
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt install pacote
sudo apt remove pacote
sudo apt purge pacote
apt-cache search termo
sudo apt autoremove
snap install nome --classic    # snaps
```

**Outras distros:**  
- Fedora → \`dnf\`  
- Arch → \`pacman\`  
A lógica é similar (update/install/remove).

---

## Git — o básico

```bash
git config --global user.name "Teu Nome"
git config --global user.email "teu@email"
git clone git@github.com:org/repo.git
git status
git add ficheiro
git commit -m "mensagem"
git push origin branch
git pull origin branch
git checkout -b nova-branch
git checkout main
git merge outra-branch
git log --oneline --graph
git stash            # guardar mudanças temporariamente
git stash pop
```

---

## Docker — comandos úteis

```bash
docker run --rm -it ubuntu bash        # correr container interativo
docker ps -a
docker images
docker stop <container>
docker rm <container>
docker rmi <image>
docker exec -it <container> bash      # entrar num container a correr
docker logs <container>
docker-compose up -d
docker-compose down
```


---

## Ambiente e shells

```bash
echo $PATH
export VAR=value
export PATH="$HOME/bin:$PATH"
printenv
source ~/.bashrc      # recarregar config
. ~/.bashrc           # mesmo que source
chsh -s $(which zsh)  # mudar shell por defeito
alias ll='ls -la'
```

---

## Crontab (tarefas agendadas)

```bash
crontab -e     # editar crontab do utilizador
# exemplo: executar script às 3:30 todos os dias
30 3 * * * /home/user/scripts/backup.sh >> /home/user/logs/backup.log 2>&1
```

Formato: \`min hour dom mon dow comando\`

---

## Logs e troubleshooting

```bash
sudo journalctl -xe
journalctl -u nginx.service -b    # logs do serviço desde o boot atual
tail -f /var/log/syslog
dmesg | tail
sudo lsof -i :3000                 # ver processo a usar a porta 3000
strace -c comando                  # trace system calls (útil para debugging)
```

---

## Rsync e cópias eficientes

```bash
rsync -avz origem/ destino/
rsync -avz --delete origem/ destino/   # manter origem e destino idênticos
# exemplo por SSH
rsync -avz -e ssh ~/projeto/ user@host:/var/www/projeto/
```

---

## Utilitários de texto (grep, awk, sed, cut...)

```bash
grep "erro" ficheiro.log
grep -R "TODO" src/
awk '{print $1, $3}' ficheiro.txt     # manipular colunas
sed -n '1,20p' ficheiro.txt           # imprimir linhas 1..20
sed -i 's/velho/novo/g' ficheiro.txt  # substituir no ficheiro
cut -d',' -f1,3 ficheiro.csv
sort ficheiro.txt
uniq -c ficheiro.txt                  # contar linhas duplicadas
wc -l ficheiro.txt                    # contar linhas
xargs -I {} echo "-> {}"              # aplicar comando a cada linha
tee ficheiro.txt                      # escreve no STDOUT e no ficheiro
watch -n 2 'ls -la'                   # executar comando a cada 2s
```

---

## Atalhos e dicas rápidas

- \`Tab\` — auto-complete (nomes ficheiros/comandos)  
- \`Ctrl+C\` — interrompe o processo atual  
- \`Ctrl+Z\` — suspende processo (podes \`fg\`/\`bg\`)  
- \`Ctrl+R\` — procura histórico (reverse-i-search)  
- \`!!\` — executa último comando  
- \`sudo !!\` — re-executa último comando com sudo  
- \`command > ficheiro\` — redireciona stdout  
- \`command 2> ficheiro\` — redireciona stderr  
- \`command &> ficheiro\` — stdout + stderr para o mesmo ficheiro  
- \`command1 | command2\` — pipe (output de 1 para 2)

---

## Aliases e dotfiles — exemplos
No \`~/.bashrc\` ou \`~/.zshrc\`:

```bash
# aliases
alias ll='ls -la'
alias gs='git status'
alias gp='git push'
alias gc='git commit -m'
alias cls='clear'

# funções
mkcd () { mkdir -p "$1"; cd "$1"; }

# path
export PATH="$HOME/bin:$PATH"
```

Guarda os teus dotfiles ( \`.bashrc\` , \`.zshrc\` , \`.vimrc\` ) num repo chamado \`dotfiles\`.

---

## Cheat sheet — resumo rápido
| Ação | Comando |
|---|---|
| Atualizar sistema | \`sudo apt update && sudo apt upgrade -y\` |
| Ver IP | \`ip addr show\` |
| Listar ficheiros | \`ls -la\` |
| Ver ficheiro | \`less ficheiro.txt\` |
| Editar (rápido) | \`nano ficheiro.txt\` |
| Permissões | \`chmod 755 ficheiro\` |
| Dono | \`sudo chown user:group ficheiro\` |
| Procurar texto | \`grep -R "texto" .\` |
| Processos | \`ps aux \| grep nome\` |
| Logs systemd | \`journalctl -u nome -f\` |
| Transferir via SSH | \`scp ficheiro user@host:/path\` |
| Sincronizar | \`rsync -avz origem/ destino/\` |
| Git básico | \`git status; git add .; git commit -m "x"; git push\` |

---

## Onde continuar
- Aprende \`grep\`, \`awk\`, \`sed\` aos poucos — são armas poderosas.  
- Cria um \`README-setup.md\` com os passos que usas na tua máquina (isso torna onboarding muito mais rápido).  
- Guarda chaves em \`~/.ssh\` e usa passphrases. Para secrets, usa um password manager.

---

## Última dica (muito útil)
Começa a colecionar **pequenos scripts** em \`~/bin\` (torna tudo repetível). Exemplo: \`~/bin/setup-project.sh\` que cria venv, instala dependências e abre o editor.

---