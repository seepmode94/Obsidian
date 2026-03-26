

**Resumo**  
Guia passo-a-passo para preparar um PC Linux (Ubuntu/Debian como referência) para desenvolvimento na Departamento de IT. Objetivo: ambiente consistente, ferramentas essenciais e boas práticas. 

---

## Índice
0. [Configurações Essenciais](#00---configurações-essenciais)  
00.1 [Atualizar o sistema](#001---atualizar-o-sistema)  
00.2 [VS Code — instalação](#002---vs-code--instalação)  
00.3 [Extensões essenciais do VS Code](#003---extensões-essenciais-do-vs-code)  
00.4 [GitHub + SSH](#004---github--ssh)  
00.5 [Docker + Docker-compose](#005---docker--docker-compose)  
00.6 [Postman](#006---postman)  
00.7 [Microsoft Teams](#007---microsoft-teams)  
00.8 [Mozilla Thunderbird](#008---mozilla-thunderbird)  
00.9 [Organização dos documentos](#009---organização-dos-documentos)  
00.10 [Checklist final](#0010---checklist-final)

1. [Configurações Essenciais de Organização](#02---configurações-essenciais-de-organização)  
02.1 [Obsidian — instalar e configurar](#021---obsidian--instalar-e-configurar)  
02.2 [Estrutura recomendada de documentos](#022---estrutura-recomendada-de-documentos)

3. [Configurações Opcionais](#03---configurações-opcionais)  
03.1 [zsh + Oh My Zsh + Powerlevel10k](#031---zsh--oh-my-zsh--powerlevel10k)  
03.2 [Extension Manager / GNOME extensions](#032---extension-manager--gnome-extensions)


---

## 00  - Configurações Essenciais
### 1 — Atualizar o sistema
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential curl wget git gnupg ca-certificates lsb-release
```

### 2 — VS Code (instalação)

```sh
sudo apt install -y software-properties-common apt-transport-https wget
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code
```

### 3 — Extensões essenciais do VS Code

```sh
- intellicode
- Hex editor (Útil para descodificar binários)
- git blame (ver author/changes por linha.)
- git lens (Ver versões do ficheiro em outros commits)
- eslint (controlo da qualidade do código)
- error lens (controlo da qualidade do código)
- path intelisense (edita automáticamente as referencias no código inteiro quando um determinado muda a localização)
- Prettier (formato código feito para ficar legivel, e.g. ficheiros minimizados de .js ou .css)
- python environments (gestão de diferentes versões de python)
- Remote - SSH
- Trailing spaces (essencial para controlo de código)
- vscode-pdf
- Database client (Game changer para consultares base de dados)
```

### 4 — GitHub + SSH

1. Gerar chave:

```sh
ssh-keygen -t ed25519 -C "teu.email@exemplo.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

2. Copiar a pública e adicionar ao GitHub:

```sh
cat ~/.ssh/id_ed25519.pub
```

**No GitHub: Settings → SSH and GPG keys → New SSH key**.

3. Testar:

```sh
ssh -T git@github.com
```

4. Configs globais:

```sh
git config --global user.name "Teu Nome"
git config --global user.email "teu.email@exemplo.com"
```



### 5 — Docker + Docker-compose

**Instalar Docker (Ubuntu/Debian)**

```sh
sudo apt remove -y docker docker-engine docker.io containerd runc || true
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER
# depois faz logout/login ou: newgrp docker
```

### 6 - Instalar Postman


### 7 - Microsoft Teams

Falar com coordenador para obter acessos


### 8 - Mozilla Thunderbird

Falar com coordenador para obter acessos


## 02  - Configurações Essenciais de Organização

### 1 - Instalar e configurar Obsidian para 

1. Fazer download da pasta _Obsidian-Volte_ e guardá-la em:

```bash
 ~/Documents
```


2. Instalar Obsidian

Instalar via snap ou repo online


## 2 - Organização dos documentos


```sh
home/user
├─ Documents
       ├─ Work
	       ├─ On-Route
       ├─ Obsidian
```

## 03  - Configurações Opcionais


### 1 - Instalar zsh

```sh
sudo apt update
sudo apt install zsh
```

- After installing, you can make Zsh your default shell by running:

```zsh
sudo chsh -s $(which zsh)
```

- Log out and log back in to see the change to Zsh.

- install Oh My Zsh using `curl`:

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Installing Powerlevel10k Theme

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```


- Then, set `ZSH_THEME="powerlevel10k/powerlevel10k"` in your `~/.zshrc` file:

```sh
sed -i 's|ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
```

- Open .zshrc 

```sh
nano ~/.zshrc
```

- Add the following line to the end of the file

```sh
ZSH_THEME="powerlevel10k/powerlevel10k"
```

- Apply the changes by sourcing the `.zshrc` file:

```sh
source ~/.zshrc
```

- Type the following command to start configurating powerlevel10k theme in the terminal

```sh
p10k configure
```

### 2 - Extension Manager


### 3 - Extensions Gnome
