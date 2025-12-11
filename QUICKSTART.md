# Quick Start Guide - Linux One-Liners

## 🚀 Forma más rápida de empezar (5 minutos)

### Opción 1: Docker Compose (Recomendado)

```bash
# 1. Construir e iniciar el contenedor
docker-compose up -d

# 2. Conectarte al entorno
docker-compose exec oneliners bash

# 3. Ejecutar el menú interactivo
menu
```

### Opción 2: Docker directo

```bash
# 1. Construir la imagen
docker build -t linux-oneliners .

# 2. Ejecutar el contenedor
docker run -it --rm linux-oneliners

# 3. El menú se muestra automáticamente
# O ejecuta: menu
```

### Opción 3: Instalación local

```bash
# 1. Verificar dependencias
./check-requirements.sh

# 2. Instalar las que falten (ejemplo Ubuntu)
sudo apt update && sudo apt install -y \
  procps psmisc lsof iproute2 netcat-openbsd \
  dnsutils tcpdump util-linux bsdmainutils \
  attr acl libcap2-bin ccze

# 3. Explorar los one-liners
cd one-liners/
less logs.md
```

## 📋 Primeros Pasos en el Menú Interactivo

Una vez dentro del contenedor, el menú te ofrece:

```
╔═══════════════════════════════════════════════════════════╗
║  🐧 Linux One-Liners Interactive Learning Menu 🐧        ║
╚═══════════════════════════════════════════════════════════╝

Select a category to explore:

  1) 📋 Logs Management
  2) ⚡ Productivity & Text Processing
  3) 💾 Disk Usage Analysis
  ...
  11) 🚀 Run Complete Demo  ← ¡Empieza aquí!
```

### Recomendación: Empieza con el Demo Completo

```bash
# Dentro del contenedor
menu
# Luego selecciona: 11 (Run Complete Demo)
```

Esto te dará un tour guiado de los comandos más útiles.

## 🎯 Comandos Útiles Dentro del Contenedor

```bash
# Abrir el menú interactivo
menu

# Ir al directorio de datos de prueba
testdata

# Ver la documentación
docs

# Listar todos los one-liners disponibles
ls /oneliners/docs/

# Ver un archivo específico
less /oneliners/docs/logs.md

# Probar un comando en los datos de prueba
grep -E "ERROR|WARN" /oneliners/test-data/logs/app.log
```

## 📚 Contenido Disponible

### Categorías de One-Liners

1. **logs.md** - Filtrado y análisis de logs
2. **productivity.md** - Procesamiento de texto y automatización
3. **disk-usage.md** - Análisis de uso de disco
4. **security.md** - Auditoría de seguridad
5. **processes.md** - Gestión de procesos
6. **file-search.md** - Búsqueda de archivos
7. **networking.md** - Comandos de red básicos
8. **filesystem-advanced.md** - Operaciones avanzadas de filesystem
9. **network-advanced.md** - Networking avanzado
10. **aliases.md** - Atajos útiles

## 🧪 Datos de Prueba

El entorno incluye datos de prueba en `/oneliners/test-data/`:

```
test-data/
├── logs/
│   ├── app.log       # Logs con errores, warnings, etc.
│   └── auth.log      # Logs de autenticación con IPs
├── files/
│   ├── small.txt     # Archivo de texto pequeño
│   ├── data.csv      # Datos CSV de ejemplo
│   ├── duplicates.txt # Para probar comandos de deduplicación
│   └── ...
├── config/
│   └── app.conf      # Archivo de configuración de ejemplo
└── project/
    ├── src/
    ├── bin/
    ├── docs/
    └── tests/
```

## 💡 Ejemplos Rápidos para Probar

### 1. Análisis de Logs

```bash
# Contar errores en logs
grep -c "ERROR" /oneliners/test-data/logs/app.log

# Extraer IPs únicas
grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" \
  /oneliners/test-data/logs/auth.log | sort -u

# Ver logs con colores
tail -20 /oneliners/test-data/logs/app.log | ccze -A
```

### 2. Procesamiento de Texto

```bash
# Contar palabras más frecuentes
tr -cs 'A-Za-z' '\n' < /oneliners/test-data/files/small.txt | \
  tr A-Z a-z | sort | uniq -c | sort -nr

# Eliminar duplicados preservando orden
awk '!seen[$0]++' /oneliners/test-data/files/duplicates.txt
```

### 3. Análisis de Sistema

```bash
# Procesos por CPU
ps -eo pid,comm,%cpu --sort=-%cpu | head -10

# Uso de disco
du -h --max-depth=1 /oneliners/test-data | sort -h

# Interfaces de red
ip -br addr
```

## 🔧 Solución de Problemas

### El contenedor no inicia

```bash
# Verificar que Docker está corriendo
docker --version
docker ps

# Limpiar contenedores previos
docker-compose down
docker system prune -f
```

### El menú no se muestra

```bash
# Ejecutar manualmente
/oneliners/test-menu.sh

# O agregar al PATH
export PATH=$PATH:/oneliners
menu
```

### Comando no encontrado

```bash
# Verificar dependencias en el contenedor
command -v <comando>

# La mayoría están en:
/usr/bin/
/usr/sbin/
```

## 📖 Siguientes Pasos

1. **Explorar el menú interactivo** - Prueba cada categoría
2. **Leer la documentación** - Cada archivo .md tiene explicaciones detalladas
3. **Experimentar** - Modifica los comandos, prueba variaciones
4. **Aplicar** - Usa los comandos en tu sistema (fuera del contenedor)

## 🌟 Consejos Pro

- Usa `Ctrl+C` para cancelar comandos largos
- Usa `Ctrl+D` o `exit` para salir del contenedor
- Los datos de prueba se recrean cada vez que inicias el contenedor
- Puedes editar los archivos en `one-liners/` desde tu host y se reflejarán en el contenedor

## 📞 Ayuda Adicional

- **Documentación completa**: [README.md](./README.md)
- **Dependencias**: [REQUIREMENTS.md](./REQUIREMENTS.md)
- **Informe de testing**: [revision.md](./revision.md)
- **Cómo contribuir**: [CONTRIBUTING.md](./CONTRIBUTING.md)

## 🎓 Recursos de Aprendizaje

### Para principiantes
1. Empieza con la categoría "Logs Management" (la más práctica)
2. Luego prueba "Productivity & Text Processing"
3. Continúa con "Disk Usage Analysis"

### Para intermedios
1. "Process Management"
2. "Security Auditing"
3. "Networking Basics"

### Para avanzados
1. "Advanced Filesystem"
2. "Advanced Networking"
3. Crea tus propios one-liners basados en los ejemplos

---

**¿Listo para empezar?** Ejecuta `docker-compose up -d && docker-compose exec oneliners bash` y escribe `menu`! 🚀
