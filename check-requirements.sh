#!/bin/bash

# Linux One-Liners - Dependency Checker
# Verifies that all required tools are installed

set -e

echo "=== Verificando Dependencias de Linux One-Liners ==="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
total=0
installed=0
missing=0
optional_missing=0

check_command() {
    local cmd=$1
    local package=$2
    local optional=${3:-false}

    total=$((total + 1))

    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $cmd (instalado)"
        installed=$((installed + 1))
        return 0
    else
        if [ "$optional" = true ]; then
            echo -e "${YELLOW}○${NC} $cmd (opcional, no instalado) - Paquete: $package"
            optional_missing=$((optional_missing + 1))
        else
            echo -e "${RED}✗${NC} $cmd (falta) - Instalar paquete: $package"
            missing=$((missing + 1))
        fi
        return 1
    fi
}

# Detect OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
    else
        OS=$(uname -s)
        VER=$(uname -r)
    fi
    echo -e "${BLUE}Sistema detectado:${NC} $OS $VER"
    echo ""
}

# Core Utilities
echo -e "${BLUE}━━━ Core Utilities ━━━${NC}"
check_command bash bash
check_command grep grep
check_command sed sed
check_command awk gawk
check_command find findutils
check_command xargs findutils
check_command sort coreutils
check_command uniq coreutils
check_command tail coreutils
check_command head coreutils
check_command wc coreutils
check_command cat coreutils
check_command tr coreutils

echo ""
echo -e "${BLUE}━━━ Process Management ━━━${NC}"
check_command ps procps
check_command pstree psmisc
check_command lsof lsof
check_command top procps
check_command iotop iotop true

echo ""
echo -e "${BLUE}━━━ Networking ━━━${NC}"
check_command ip iproute2
check_command ss iproute2
check_command ping iputils-ping
check_command nc netcat
check_command dig dnsutils true
check_command tcpdump tcpdump

echo ""
echo -e "${BLUE}━━━ System Tools ━━━${NC}"
check_command column util-linux
check_command mount util-linux
check_command df coreutils
check_command du coreutils
check_command watch procps
check_command tree tree true

echo ""
echo -e "${BLUE}━━━ Security & Permissions ━━━${NC}"
check_command getfattr attr
check_command getfacl acl
check_command getcap libcap2-bin
check_command lsattr e2fsprogs

echo ""
echo -e "${BLUE}━━━ Optional/Specialized ━━━${NC}"
check_command ccze ccze true
check_command journalctl systemd true
check_command btrfs btrfs-progs true
check_command xfs_db xfsprogs true
check_command repquota quota true

echo ""
echo "═══════════════════════════════════════════════════"
echo -e "${BLUE}Resumen de Verificación${NC}"
echo "═══════════════════════════════════════════════════"
echo ""
echo -e "Total de herramientas verificadas: ${BLUE}$total${NC}"
echo -e "Instaladas:                        ${GREEN}$installed${NC}"
echo -e "Faltantes (requeridas):            ${RED}$missing${NC}"
echo -e "Opcionales no instaladas:          ${YELLOW}$optional_missing${NC}"
echo ""

if [ $missing -eq 0 ]; then
    echo -e "${GREEN}✓ Todas las dependencias requeridas están instaladas!${NC}"
    echo ""
    if [ $optional_missing -gt 0 ]; then
        echo -e "${YELLOW}⚠ Algunas herramientas opcionales no están instaladas.${NC}"
        echo "  Los comandos que las usan funcionarán con limitaciones."
    fi
    exit 0
else
    echo -e "${RED}✗ Faltan $missing dependencias requeridas.${NC}"
    echo ""

    # Provide installation commands based on OS
    detect_os

    echo -e "${BLUE}Comandos de instalación sugeridos:${NC}"
    echo ""

    case $OS in
        ubuntu|debian)
            echo "Para Ubuntu/Debian:"
            echo "  sudo apt update && sudo apt install -y \\"
            echo "    coreutils findutils grep sed gawk \\"
            echo "    procps psmisc lsof \\"
            echo "    iproute2 iputils-ping netcat-openbsd \\"
            echo "    util-linux bsdmainutils \\"
            echo "    attr acl libcap2-bin e2fsprogs"
            ;;
        rhel|centos|fedora)
            echo "Para RHEL/CentOS/Fedora:"
            echo "  sudo yum install -y \\"
            echo "    coreutils findutils grep sed gawk \\"
            echo "    procps-ng psmisc lsof \\"
            echo "    iproute iputils nmap-ncat \\"
            echo "    util-linux \\"
            echo "    attr acl libcap e2fsprogs"
            ;;
        alpine)
            echo "Para Alpine Linux:"
            echo "  apk add --no-cache \\"
            echo "    bash coreutils findutils grep sed gawk \\"
            echo "    procps psmisc lsof \\"
            echo "    iproute2 iputils busybox-extras \\"
            echo "    util-linux \\"
            echo "    attr acl libcap e2fsprogs"
            ;;
        *)
            echo "Sistema no reconocido: $OS"
            echo "Por favor consulta REQUIREMENTS.md para tu distribución."
            ;;
    esac

    echo ""
    echo "Para instalación completa incluyendo opcionales, ver: REQUIREMENTS.md"
    exit 1
fi
