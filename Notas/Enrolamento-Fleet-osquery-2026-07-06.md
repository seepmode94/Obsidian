---
data: 2026-07-06
tags: [it, fleet, osquery, endpoint, ssh, ansible]
maquina: seepmode94-ASUS-Vivobook-15-X1504VAPF-F1504VA
---

# Enrolamento no Fleet/osquery — 2026-07-06 (noite)

## Resumo

Depois das 18h de 06/07/2026, o portátil foi **inscrito remotamente no Fleet** (agente osquery de gestão de equipamentos), via **Ansible** a partir de outra máquina da LAN (`192.168.0.140`). Foram duas sessões curtas e complementares.

## O que aconteceu (cronologia)

### Sessão 1 — 19:55 → 19:57 (~2 min): preparar o acesso
- Arranque e login gráfico (lightdm) às 19:55:32.
- **19:56:27** — `apt install -y openssh-server` (instalou openssh-server + sftp-server). Abriu a porta a ligações SSH de entrada.
- Encerramento normal às 19:57:31.

### Sessão 2 — 20:06 → 20:13 (~7 min): o provisionamento
- Arranque e login às 20:06:49.
- Ligações SSH de entrada a partir de **192.168.0.140** (nó de controlo Ansible) — password e depois chave pública ED25519.
- Vários `sudo` a root com o padrão `COMMAND=/bin/sh -c 'echo BECOME-SUCCESS-…; /usr/bin/python3.12'` — assinatura inequívoca do Ansible (`become` + módulos Python).
- **20:07:57** — instalado o pacote **`fleet-osquery` 1.57.0** ("Fleet osquery — runtime and autoupdater").
- Encerramento às 20:13:32.

## Resultado / estado atual (verificado a 2026-07-07)

### 1. Agente Fleet/osquery (orbit)
- Serviço `orbit.service` **ativo e `enabled`** — arranca a cada boot (rearrancou hoje às 08:59).
- Enrolado no servidor **`https://fleet.cstaff.eu`** (com enroll secret); auto-atualiza a partir de `https://updates.fleetdm.com`.
- Processos: `orbit` (supervisor/autoupdater) + 2× `osqueryd` (worker + watchdog).
- Footprint real: **~157 MB de RSS** (orbit 38 + osqueryd 44 + 75). O valor de ~1.3–1.5 GB visto no `systemctl` é contabilidade de cgroup (inclui cache/downloads do autoupdater), não RAM viva.

**O que permite ao admin do Fleet:** consultar a máquina como uma base de dados (osquery = SELECTs sobre o SO) — software instalado, processos, utilizadores, hardware, cifragem de disco, estado de patches, config de rede, sessões ativas, dispositivos USB, etc., via queries agendadas e *live queries* à distância. É inventário + telemetria de segurança/compliance.

> **Âmbito:** o osquery em si é **só de leitura** (observação) — não instala software nem faz screenshots. Mas o orbit/Fleet também suporta execução de scripts e funcionalidades MDM se ativadas do lado do servidor; essa capacidade fica dependente da config em `fleet.cstaff.eu`.

### 2. Servidor SSH
- `openssh-server` instalado e a correr — a máquina passou a **aceitar SSH de entrada** (foi o que viabilizou o Ansible). Alteração persistente, para além do enrolamento.

## Conclusão

As duas sessões da noite serviram para **onboarding deste PC na gestão de frota Fleet**: agora é inventariável e auditável remotamente a partir de `fleet.cstaff.eu`, e aceita SSH. No momento da verificação não havia ligação aberta ao Fleet — normal, o orbit faz *polling* periódico.

## Privacidade — o que o Fleet consegue ver (análise 2026-07-07)

### Capacidades ativas (flags reais do processo `osqueryd`)
Confirmado nos argumentos do processo em execução:
- `--disable_distributed=false` → **live queries ATIVAS**: o admin pode consultar qualquer tabela osquery a pedido, em tempo real.
- `--disable_carver=false` + `--carver_disable_function=false` (blocos 8 MB) → **file carving ATIVO**: pode puxar ficheiros inteiros da máquina para o servidor.
- `--config_plugin=tls`, `--config_refresh=60` → config renova a cada 60 s de `fleet.cstaff.eu`.
- `--logger_plugin=tls,filesystem` → logs para o servidor e cópia local em `/opt/orbit/osquery_log`.
- Corre como **root**; host id `864df646-2caf-4206-ac39-61544bbc92fc`.

### Captura contínua de execuções: DESLIGADA
`disable_audit=true`, `disable_events=true`, `enable_bpf_events=false` → **sem stream contínuo** de cada comando/exec. A visibilidade é por *snapshot* (o que estiver a correr quando a query dispara) + o que fica persistido em ficheiro. Não é keylogging nem gravação de ecrã.

### Passwords
NÃO são visíveis — nenhuma query decifra/exfiltra passwords; sem keylogging, sem screenshots. As guardadas no browser ficam cifradas e não há tabela que as devolva.

### Identidade dos logins — em parte SIM
Query de inventário padrão já enviada pelo Fleet:
`SELECT email FROM google_chrome_profiles WHERE NOT ephemeral AND email <> ''`
→ o **email das contas Google no Chrome é reportado**. Também recolhe contas de utilizador (`uid, username, shell, groups`), cifragem de disco, SO, hardware, espaço em disco.

### Atividade no terminal / projetos — SIM (com prova nesta máquina)
- **Diretórios abertos (live):** `SELECT name, cwd FROM processes` revelou os terminais abertos, incl.:
  - `/home/seepmode94/Documentos/work/IT/OpsDock/OpsDock-development`
  - `/home/seepmode94/Documentos/work/IT/Luxury/LuxuryMobile`
- **Comandos escritos:** a tabela `shell_history` (uid=1000) devolveu **6664 comandos** — lê o `~/.zsh_history` inteiro (262 KB, 6530 linhas, atualizado ao vivo; histórico desde março). Inclui `cd`, `git`, `docker`, scripts **e qualquer segredo escrito na linha de comandos**.
- **Conteúdo do código:** tabela `file` lista os ficheiros; **carving (ativo)** pode puxar o conteúdo real.

### O que foi EFETIVAMENTE recolhido até agora
- `osqueryd.results.log` local **vazio (0 linhas)**; sem packs recorrentes a escrever localmente.
- Sem registos de scripts/carving nos logs do `orbit`.
- Ou seja: só correu o **inventário base** (incl. emails do Chrome, contas, cifragem). Capacidade armada, mas sem sinais de harvesting ativo. Nota: execução de scripts remotos do Fleet é controlada no servidor e não deixa flag no cliente — não confirmável a partir daqui.

### Mitigações (equipamento gerido, não privado)
- Não trabalhar em **projetos pessoais** aqui (caminho + comandos ficam visíveis).
- **Nunca** escrever segredos na linha de comandos (persistem no `.zsh_history`, lido por completo).
- Sair da sessão Google/Chrome pessoal; não guardar credenciais pessoais no browser/keychain desta máquina.
- Para pessoal, usar outro dispositivo ou uma VM não enrolada no Fleet.
- Quem controla `fleet.cstaff.eu` (IT) tem, na prática, alcance root a esta máquina, *on-demand* e sem notificação ao utilizador.

## Fontes (comandos)
- `journalctl --list-boots`, `last reboot`, `who -b`
- `journalctl -b -2` / `-b -1` (login, sshd, sudo, poweroff)
- `/var/log/apt/history.log`, `/var/log/dpkg.log`
- `dpkg -l | grep fleet`, `systemctl status orbit`
- `/etc/default/orbit` (`ORBIT_FLEET_URL`, `ORBIT_UPDATE_URL`)
- `sudo tr '\0' ' ' < /proc/<pid>/cmdline` (flags reais do `osqueryd`)
- `sudo osqueryd -S "SELECT ... FROM processes / shell_history / osquery_flags"` (prova de visibilidade)
