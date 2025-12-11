# Linux 100 One-Liners (spoiler: hay más de cien...😄)

Colección profesional de one-liners para Linux orientados a productividad, resolución rápida de incidencias y administración real de sistemas. Todos los comandos están documentados con objetivo, explicación, casos de uso y riesgos.

Esta repo está pensada tanto para técnicos en activo como para alumnos del curso oficial **IFCT114PO – Linux**, donde se profundiza en administración del sistema, redes, servicios y seguridad.

👉 Más información del curso (subvencionado y dirigido a trabajadores):  
https://subvencionada.sinensia.com/ifct114po-linux

---

## Objetivo de la colección

- Reunir comandos potentes, concisos y útiles en entornos profesionales de Linux.
- Enseñar *cómo pensar* detrás de cada comando, no solo memorizarlo.
- Construir una referencia práctica para troubleshooting, optimización y administración.
- Complementar el temario del curso IFCT114PO con práctica aplicada.

---

## 🚀 Quick Start - Entorno Interactivo con Docker

La forma más rápida de empezar a aprender y practicar es usando nuestro entorno Docker interactivo:

```bash
# Opción 1: Docker Compose (Recomendado)
docker-compose up -d
docker-compose exec oneliners bash
# Dentro del contenedor, ejecuta: menu

# Opción 2: Docker directo
docker build -t linux-oneliners .
docker run -it --rm linux-oneliners
# Dentro del contenedor, ejecuta: menu
```

**¿Qué incluye el entorno Docker?**
- ✅ Todas las herramientas preinstaladas (100+ comandos)
- ✅ Datos de prueba listos para usar
- ✅ Menú interactivo con ejemplos ejecutables
- ✅ Entorno seguro para experimentar sin miedo
- ✅ Documentación integrada

Ver [REQUIREMENTS.md](./REQUIREMENTS.md) para instalación manual en tu sistema.

---

## 📂 Contenido por categorías


### 🔹 Gestión de disco
`one-liners/disk-usage.md`


### 🔹 Procesos y rendimiento
`one-liners/processes.md`


### 🔹 Networking (básico)
`one-liners/networking.md`


### 🔹 Networking (avanzado)
`one-liners/network-advanced.md`


### 🔹 Logs y troubleshooting
`one-liners/logs.md`


### 🔹 Backups y sincronización
`one-liners/backup.md`


### 🔹 Búsqueda de archivos y patrones
`one-liners/file-search.md`


### 🔹 Filesystem avanzado
`one-liners/filesystem-advanced.md`


### 🔹 Seguridad y auditoría
`one-liners/security.md`


### 🔹 Productividad, pipes, xargs y magia de shell
`one-liners/productivity.md`


### 🔸 Bonus: alias de sistema
`one-liners/aliases.md`



Cada fichero contiene entre 5 y 20 one-liners, agrupados por temática, con explicación detallada y riesgos.

---

## ¿Por qué esta colección es diferente?

- No es una lista de comandos aleatorios: cada oneliner resuelve un problema real.
- Está escrita por un formador y consultor con experiencia en entornos de producción.
- Muchos comandos incluyen variantes y ajustes poco conocidos pero extremadamente útiles.
- Está orientada a *productividad profesional*, no a principiantes copiando y pegando.

---

## Relación con el curso IFCT114PO – Linux

Esta repo complementa los contenidos del curso subvencionado **IFCT114PO – Linux**, que cubre:

- Introducción a UNIX/Linux
- Sistema de ficheros, permisos y edición
- Procesos, usuarios, servicios
- Redes, topologías, DHCP, DNS, SSH, FTP
- Proxy, Gateway, Firewall
- Servidores: Web, Correo, Samba, NFS

El curso combina teoría + ejercicios prácticos y está dirigido a profesionales en activo que quieran elevar su nivel técnico.

➡️ Inscripción e información oficial:  
https://subvencionada.sinensia.com/ifct114po-linux

---

## 🧪 Modo Interactivo - Aprende Haciendo

Este repositorio incluye un **menú interactivo** que te guía a través de los comandos con ejemplos ejecutables:

```bash
# Dentro del contenedor Docker
menu
```

El menú interactivo incluye:
- 📋 **10 categorías organizadas**: Logs, Networking, Security, Processes, etc.
- 💻 **Ejemplos ejecutables**: Ve el comando, su explicación y ejecútalo inmediatamente
- 🎯 **Demo completa**: Tour guiado por los comandos más útiles
- 📚 **Acceso a documentación**: Navega por todos los one-liners
- 🧪 **Datos de prueba**: Archivos y logs de ejemplo para practicar

### Captura de pantalla del menú

```
╔═══════════════════════════════════════════════════════════╗
║  🐧 Linux One-Liners Interactive Learning Menu 🐧        ║
╚═══════════════════════════════════════════════════════════╝

Select a category to explore:

  1) 📋 Logs Management
  2) ⚡ Productivity & Text Processing
  3) 💾 Disk Usage Analysis
  4) 🔐 Security Auditing
  5) 🔧 Process Management
  6) 🔍 File Search & Patterns
  7) 🌐 Networking Basics
  8) 📁 Advanced Filesystem
  9) 🌍 Advanced Networking
  10) 🎯 Useful Aliases

  11) 🚀 Run Complete Demo
  12) 📚 View Documentation
  13) 🧪 Open Test Data Directory

  0) 🚪 Exit
```

---

## 📋 Verificación y Testing

### Informe de Revisión

Se han probado todos los one-liners en un entorno Ubuntu 22.04. Ver [revision.md](./revision.md) para:
- ✅ Estado de cada comando (funciona/requiere corrección)
- 🐛 Problemas identificados y soluciones propuestas
- 📦 Dependencias necesarias
- ⚠️ Limitaciones por distribución o entorno

### Estadísticas de Testing
- **85%** de comandos funcionan perfectamente
- **8%** requieren dependencias adicionales documentadas
- **3%** necesitan correcciones menores
- **4%** tienen limitaciones de entorno (contenedores, systemd)

---

## 🛠️ Requisitos y Dependencias

Ver [REQUIREMENTS.md](./REQUIREMENTS.md) para documentación completa sobre:
- Instalación por distribución (Ubuntu, RHEL, Alpine)
- Lista completa de dependencias categorizadas
- Script de verificación automática
- Diferencias entre distribuciones
- Limitaciones conocidas

### Verificación rápida de dependencias

```bash
# Descargar y ejecutar el script de verificación
chmod +x check-requirements.sh
./check-requirements.sh
```

---

## 🎓 Uso Didáctico

Este repositorio está diseñado con un enfoque educativo:

1. **Para instructores**:
   - Usa el entorno Docker para demos en vivo
   - El menú interactivo es perfecto para workshops
   - Cada comando incluye explicación pedagógica

2. **Para estudiantes**:
   - Entorno seguro para experimentar
   - Progresión de básico a avanzado
   - Ejemplos con datos reales

3. **Para autodidactas**:
   - Aprende a tu ritmo con el menú interactivo
   - Documentación completa de cada comando
   - Casos de uso del mundo real

---

## 🛡️ Tips de Seguridad

Antes de ejecutar comandos desconocidos en producción:

### 1. Usa el entorno Docker para probar

```bash
docker-compose up -d
docker-compose exec oneliners bash
# Prueba el comando aquí primero
```

El entorno Docker proporciona un espacio seguro donde puedes experimentar sin riesgo de dañar tu sistema.

### 2. Para comandos de búsqueda/borrado, quita la acción destructiva primero

```bash
# ❌ NO hagas esto directamente:
find . -name "*.tmp" -delete

# ✅ SIEMPRE primero verifica qué se va a borrar:
find . -name "*.tmp"
# Revisa la lista cuidadosamente, LUEGO añade -delete
```

### 3. Usa echo para ver qué haría un comando

```bash
# Ver qué archivos se borrarían:
find . -name "*.tmp" -exec echo rm {} \;

# Una vez verificado, quita 'echo':
find . -name "*.tmp" -exec rm {} \;
```

### 4. Haz respaldos antes de modificaciones masivas

```bash
# Con sed, usa -i.bak para crear respaldos:
sed -i.bak 's/old/new/g' archivo.txt

# Con rsync, mantén versiones anteriores:
rsync -av --backup --backup-dir=~/backups/ source/ dest/
```

### 5. Verifica permisos y rutas

```bash
# Antes de ejecutar con sudo, verifica que estás en el directorio correcto:
pwd
ls -la

# Y entiende qué hace el comando:
man comando
comando --help
```

---

## Contribuciones

- Pull Requests bienvenidas.
- Se aceptan nuevos one-liners siempre que cumplan:
  - Simplicidad
  - Utilidad real
  - Riesgos explicados
  - Memorizables

---

## Licencia

MIT License.

---

## Primeros ficheros disponibles

Los ficheros se irán completando progresivamente:
- `disk-usage.md` → Diagnóstico de espacio y uso de disco
- `processes.md` → Gestión y análisis de procesos
- `networking.md` → Comandos de red, puertos, sockets, diagnóstico
- `logs.md` → Lectura eficiente de logs en tiempo real
- `backup.md` → Copias de seguridad, sincronización y rsync avanzado

---

## ¿Quieres formación más avanzada?

El curso IFCT114PO está diseñado para profesionales que quieran dominar Linux con una base sólida y aplicable.

📌 **IFCT114PO – Linux (40 horas, modalidad presencial o bimodal)**  
**Subvencionado. Dirigido prioritariamente a trabajadores en activo.**  
https://subvencionada.sinensia.com/ifct114po-linux

---

## Bonus: crear tus propios shortcuts con alias de sistema

Los alias permiten convertir comandos largos en atajos memorables, aumentando tu productividad diaria.

Ejemplo básico:
```bash
alias ll='ls -lha'
```

Alias más productivo:
```bash
alias disk='du -h --max-depth=1 2>/dev/null | sort -h'
```

Para que sean permanentes, añádelos a `~/.bashrc` o `~/.zshrc`:
```bash
echo "alias disk='du -h --max-depth=1 2>/dev/null | sort -h'" >> ~/.bashrc
source ~/.bashrc
```

Ventajas:
- Reduces escritura repetitiva.
- Evitas errores en comandos largos.
- Estandarizas shortcuts entre máquinas.

En la repo añadiremos un fichero dedicado: `one-liners/aliases.md`, con alias listos para producción.

Contáctame en https://www.sinensia.com

