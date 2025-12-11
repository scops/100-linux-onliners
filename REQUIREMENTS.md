# Requirements - Linux One-Liners

Este documento describe todas las dependencias y requisitos para ejecutar los one-liners de este repositorio.

## Índice
- [Requisitos Generales](#requisitos-generales)
- [Dependencias por Categoría](#dependencias-por-categoría)
- [Instalación por Distribución](#instalación-por-distribución)
- [Entorno Docker (Recomendado)](#entorno-docker-recomendado)
- [Verificación de Dependencias](#verificación-de-dependencias)

---

## Requisitos Generales

### Sistema Operativo
- Linux kernel 3.10+ (recomendado 4.x+)
- Distribuciones soportadas: Ubuntu, Debian, RHEL, CentOS, Fedora, Alpine

### Shell
- bash 4.x+ (algunos comandos requieren características modernas)
- zsh también es compatible con la mayoría de comandos

### Permisos
Muchos comandos requieren privilegios elevados (`sudo`/`root`) para:
- Acceso a logs del sistema
- Información de procesos de otros usuarios
- Configuración de red
- Búsqueda en todo el filesystem

---

## Dependencias por Categoría

### 📦 Core Utilities (Usualmente preinstalados)
Comandos fundamentales que deben estar presentes:

```bash
# Verificar presencia
command -v bash grep sed awk find tail head sort uniq wc cat
```

**Paquetes**:
- `coreutils` - ls, cat, head, tail, wc, sort, uniq, tr, etc.
- `findutils` - find, xargs
- `grep` - búsqueda de patrones
- `sed` - editor de stream
- `gawk` o `mawk` - procesamiento de texto

---

### 🔧 System Monitoring & Processes

#### ps (procps/procps-ng)
**Usado en**: processes.md, aliases.md
```bash
ps -eo pid,comm,%cpu,%mem --sort=-%cpu
```
**Instalar**:
- Debian/Ubuntu: `apt install procps`
- RHEL/CentOS: `yum install procps-ng`

#### pstree (psmisc)
**Usado en**: processes.md línea 35
```bash
pstree -p
```
**Instalar**:
- Debian/Ubuntu: `apt install psmisc`
- RHEL/CentOS: `yum install psmisc`

#### lsof
**Usado en**: processes.md línea 58, networking.md línea 12, filesystem-advanced.md línea 99
```bash
lsof /path/to/file
lsof -iTCP:443 -sTCP:LISTEN
```
**Instalar**:
- Debian/Ubuntu: `apt install lsof`
- RHEL/CentOS: `yum install lsof`

#### iotop
**Usado en**: processes.md línea 188
```bash
iotop -ao
```
**Instalar**:
- Debian/Ubuntu: `apt install iotop`
- RHEL/CentOS: `yum install iotop`
- **Nota**: Requiere kernel con I/O accounting habilitado

---

### 🌐 Networking Tools

#### iproute2
**Usado en**: networking.md, network-advanced.md
```bash
ip addr
ip route show
ip neigh
ss -tupan
tc qdisc show
```
**Instalar**:
- Debian/Ubuntu: `apt install iproute2`
- RHEL/CentOS: `yum install iproute`

#### netcat (nc)
**Usado en**: networking.md línea 61
```bash
nc -vz google.com 443
```
**Instalar**:
- Debian/Ubuntu: `apt install netcat-openbsd` o `netcat-traditional`
- RHEL/CentOS: `yum install nmap-ncat`

#### dnsutils / bind-utils
**Usado en**: networking.md línea 166
```bash
dig +stats example.com
```
**Instalar**:
- Debian/Ubuntu: `apt install dnsutils`
- RHEL/CentOS: `yum install bind-utils`

#### tcpdump
**Usado en**: networking.md línea 189, network-advanced.md
```bash
tcpdump -ni eth0 -c20
```
**Instalar**:
- Debian/Ubuntu: `apt install tcpdump`
- RHEL/CentOS: `yum install tcpdump`
- **Requiere**: Privilegios root o CAP_NET_RAW capability

---

### 📊 System Information

#### util-linux
**Usado en**: disk-usage.md, filesystem-advanced.md
```bash
column -t
mount
lsblk
```
**Instalar**:
- Debian/Ubuntu: `apt install util-linux`
- RHEL/CentOS: `yum install util-linux`

#### bsdmainutils / bsdextrautils
**Usado en**: disk-usage.md línea 84, networking.md línea 35
```bash
column -t
```
**Instalar**:
- Debian/Ubuntu: `apt install bsdmainutils`
- RHEL/CentOS: incluido en `util-linux`

---

### 🎨 Log Colorization

#### ccze
**Usado en**: logs.md línea 139
```bash
tail -F /var/log/syslog | ccze -A
```
**Instalar**:
- Debian/Ubuntu: `apt install ccze`
- RHEL/CentOS: `yum install ccze` (requiere EPEL)
- **Alternativa**: `lnav`, `grc` (Generic Colouriser)

---

### 🔐 Security & Permissions

#### attr
**Usado en**: filesystem-advanced.md línea 35
```bash
getfattr -R -d .
```
**Instalar**:
- Debian/Ubuntu: `apt install attr`
- RHEL/CentOS: `yum install attr`

#### acl
**Usado en**: filesystem-advanced.md línea 57
```bash
getfacl -R .
```
**Instalar**:
- Debian/Ubuntu: `apt install acl`
- RHEL/CentOS: `yum install acl`

#### libcap2-bin / libcap
**Usado en**: security.md línea 32
```bash
getcap -r /
```
**Instalar**:
- Debian/Ubuntu: `apt install libcap2-bin`
- RHEL/CentOS: `yum install libcap`

---

### 💾 Filesystem-Specific Tools

#### btrfs-progs
**Usado en**: filesystem-advanced.md línea 161
```bash
btrfs filesystem df /
```
**Instalar**:
- Debian/Ubuntu: `apt install btrfs-progs`
- RHEL/CentOS: `yum install btrfs-progs`
- **Nota**: Solo funciona en filesystems Btrfs

#### xfsprogs
**Usado en**: filesystem-advanced.md línea 181
```bash
xfs_db -c frag -r /dev/sda1
```
**Instalar**:
- Debian/Ubuntu: `apt install xfsprogs`
- RHEL/CentOS: `yum install xfsprogs`
- **Nota**: Solo funciona en filesystems XFS

#### quota
**Usado en**: filesystem-advanced.md línea 243
```bash
repquota -a
```
**Instalar**:
- Debian/Ubuntu: `apt install quota`
- RHEL/CentOS: `yum install quota`
- **Nota**: Requiere cuotas habilitadas en el filesystem

---

### 🔄 Systemd (Opcional)

#### systemd
**Usado en**: logs.md líneas 33, 97
```bash
journalctl -p err -f
journalctl -u nginx --since "1 hour ago"
```
**Notas**:
- No disponible en contenedores Docker estándar
- No disponible en sistemas con sysvinit o OpenRC
- **Alternativa para logs**: Usar `tail -F /var/log/syslog` o archivos de log específicos

---

## Instalación por Distribución

### Ubuntu / Debian (apt)

#### Instalación Mínima
```bash
sudo apt update && sudo apt install -y \
  coreutils findutils grep sed gawk \
  procps psmisc lsof \
  iproute2 iputils-ping netcat-openbsd \
  util-linux bsdmainutils \
  attr acl libcap2-bin
```

#### Instalación Completa (Incluye herramientas adicionales)
```bash
sudo apt update && sudo apt install -y \
  coreutils findutils grep sed gawk \
  procps psmisc lsof iotop \
  iproute2 iputils-ping netcat-openbsd dnsutils tcpdump \
  util-linux bsdmainutils \
  attr acl libcap2-bin \
  ccze \
  btrfs-progs xfsprogs quota
```

---

### RHEL / CentOS / Fedora (yum/dnf)

#### Instalación Mínima
```bash
sudo yum install -y \
  coreutils findutils grep sed gawk \
  procps-ng psmisc lsof \
  iproute iputils nmap-ncat \
  util-linux \
  attr acl libcap
```

#### Instalación Completa
```bash
# Habilitar EPEL para paquetes adicionales
sudo yum install -y epel-release

sudo yum install -y \
  coreutils findutils grep sed gawk \
  procps-ng psmisc lsof iotop \
  iproute iputils nmap-ncat bind-utils tcpdump \
  util-linux \
  attr acl libcap \
  ccze \
  btrfs-progs xfsprogs quota
```

---

### Alpine Linux (apk)

#### Instalación Completa
```bash
apk add --no-cache \
  bash coreutils findutils grep sed gawk \
  procps psmisc lsof iotop \
  iproute2 iputils busybox-extras bind-tools tcpdump \
  util-linux \
  attr acl libcap \
  btrfs-progs xfsprogs quota
```

**Nota**: ccze no está disponible en Alpine, usar alternativas como `lnav`

---

## Entorno Docker (Recomendado)

La forma más fácil de tener un entorno completo y reproducible es usar Docker:

```bash
# Construir la imagen
docker build -t linux-oneliners .

# Ejecutar el contenedor interactivo
docker run -it --rm linux-oneliners

# O usar docker-compose
docker-compose up -d
docker-compose exec oneliners bash
```

Ver [Dockerfile](./Dockerfile) para detalles de la imagen.

---

## Verificación de Dependencias

### Script de Verificación Rápida

Guarda este script como `check-requirements.sh`:

```bash
#!/bin/bash

echo "=== Verificando Dependencias de Linux One-Liners ==="
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_command() {
    local cmd=$1
    local package=$2
    local optional=${3:-false}

    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $cmd (instalado)"
        return 0
    else
        if [ "$optional" = true ]; then
            echo -e "${YELLOW}○${NC} $cmd (opcional, no instalado) - Paquete: $package"
        else
            echo -e "${RED}✗${NC} $cmd (falta) - Instalar paquete: $package"
        fi
        return 1
    fi
}

echo "Core Utilities:"
check_command bash bash
check_command grep grep
check_command sed sed
check_command awk gawk
check_command find findutils
check_command xargs findutils

echo ""
echo "Process Management:"
check_command ps procps
check_command pstree psmisc
check_command lsof lsof
check_command iotop iotop true

echo ""
echo "Networking:"
check_command ip iproute2
check_command ss iproute2
check_command nc netcat
check_command dig dnsutils true
check_command tcpdump tcpdump

echo ""
echo "System Tools:"
check_command column util-linux
check_command mount util-linux

echo ""
echo "Security & Permissions:"
check_command getfattr attr
check_command getfacl acl
check_command getcap libcap2-bin

echo ""
echo "Optional/Specialized:"
check_command ccze ccze true
check_command journalctl systemd true
check_command btrfs btrfs-progs true
check_command xfs_db xfsprogs true

echo ""
echo "=== Verificación Completa ==="
```

Ejecutar:
```bash
chmod +x check-requirements.sh
./check-requirements.sh
```

---

## Diferencias entre Distribuciones

### Rutas de Logs

| Archivo | Ubuntu/Debian | RHEL/CentOS | Alpine |
|---------|---------------|-------------|--------|
| System log | `/var/log/syslog` | `/var/log/messages` | `/var/log/messages` |
| Auth log | `/var/log/auth.log` | `/var/log/secure` | `/var/log/auth.log` |

### Nombres de Paquetes

| Herramienta | Debian/Ubuntu | RHEL/CentOS | Alpine |
|-------------|---------------|-------------|--------|
| Procesos | `procps` | `procps-ng` | `procps` |
| Network | `iproute2` | `iproute` | `iproute2` |
| DNS tools | `dnsutils` | `bind-utils` | `bind-tools` |
| Netcat | `netcat-openbsd` | `nmap-ncat` | `busybox-extras` |

---

## Limitaciones Conocidas

### Contenedores Docker
Los siguientes comandos tienen limitaciones en contenedores:
- `journalctl` - Requiere systemd (no disponible en contenedores estándar)
- `watch` - Requiere variable TERM configurada
- Comandos de red avanzados pueden requerir `--privileged` o `--cap-add=NET_ADMIN`

**Soluciones**:
```bash
# Para watch en contenedor
export TERM=xterm

# Para privilegios de red
docker run --cap-add=NET_ADMIN ...
```

### Sistemas sin Systemd
Si tu sistema usa sysvinit, OpenRC u otro init:
- No usar comandos `journalctl`
- Usar logs tradicionales en `/var/log/`
- Adaptar comandos de gestión de servicios

---

## Recursos Adicionales

- [GNU Coreutils Manual](https://www.gnu.org/software/coreutils/manual/)
- [iproute2 Documentation](https://wiki.linuxfoundation.org/networking/iproute2)
- [Linux man pages](https://man7.org/linux/man-pages/)
- [Dockerfile reference](./Dockerfile)

---

## Contribuir

Si encuentras una dependencia no documentada o una incompatibilidad, por favor:
1. Abre un issue describiendo el problema
2. Incluye tu distribución y versión
3. Incluye el comando que falla y el error

---

**Última actualización**: 2025-12-11
