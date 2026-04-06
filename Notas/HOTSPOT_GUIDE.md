# Guia de Ativação do Hotspot

Este guia explica como ativar o hotspot Wi-Fi utilizando a linha de comandos (CLI) no Linux através do `nmcli` (NetworkManager CLI).

## Passos para Ativar

### 1. Listar as Ligações Disponíveis
Primeiro, verifica o nome exato da ligação do hotspot configurada no teu sistema:

```bash
nmcli connection show
```

Procura pela linha onde o `TYPE` é `wifi` e o nome da ligação (geralmente "Hotspot").

### 2. Ligar o Hotspot
Executa o seguinte comando para ativar a ligação:

```bash
nmcli connection up Hotspot
```

*Nota: Se o nome da tua ligação for diferente de "Hotspot", substitui o nome no comando acima.*

### 3. Verificar o Estado
Podes verificar se a ligação está ativa com:

```bash
nmcli connection show --active
```

## Solução de Problemas

Se a ligação falhar, tenta reiniciar o NetworkManager:

```bash
sudo systemctl restart NetworkManager
```

Ou verifica se o Wi-Fi está ligado:

```bash
nmcli radio wifi on
```
