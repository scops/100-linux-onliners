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
  4) 🔐 Security Auditing
  5) 🔧 Process Management
  6) 🔍 File Search & Patterns
  7) 🌐 Networking Basics
  8) 📁 Advanced Filesystem
  9) 🌍 Advanced Networking
  10) 🎯 Useful Aliases
  11) 🔥 TOP 10 One-Liners  ← ¡NUEVO! Los mejores comandos

  12) 🚀 Run Complete Demo  ← ¡Empieza aquí!
  13) 📚 View Documentation
  14) 🧪 Open Test Data Directory
```

### Recomendación: Dos formas de empezar

**Opción A - Demo completo (5 min)**
```bash
# Dentro del contenedor
menu
# Luego selecciona: 12 (Run Complete Demo)
```

**Opción B - TOP 10 comandos más potentes (10 min)**
```bash
# Dentro del contenedor
menu
# Luego selecciona: 11 (TOP 10 One-Liners)
```

El **TOP 10** te muestra los comandos más transformadores para profesionales Linux, con explicaciones y ejemplos prácticos. El **Demo** te da un tour rápido de varias categorías.

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

1. **🔥 top-10.md** - **LOS 10 MEJORES** comandos para profesionales Linux
2. **logs.md** - Filtrado y análisis de logs
3. **productivity.md** - Procesamiento de texto y automatización
4. **disk-usage.md** - Análisis de uso de disco
5. **security.md** - Auditoría de seguridad
6. **processes.md** - Gestión de procesos
7. **file-search.md** - Búsqueda de archivos
8. **networking.md** - Comandos de red básicos
9. **filesystem-advanced.md** - Operaciones avanzadas de filesystem
10. **network-advanced.md** - Networking avanzado
11. **aliases.md** - Atajos útiles

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

## 🔥 TOP 10 - Ejemplos Destacados

Estos son algunos de los comandos más potentes del **TOP 10**:

### 1. Contador de frecuencias tipo SQL GROUP BY
```bash
# Contar ocurrencias de cada valor
echo -e 'apple\nbanana\napple\norange\napple\nbanana' | \
  awk '{ count[$1]++ } END { for (v in count) print v, count[v] }'

# Resultado:
# orange 1
# apple 3
# banana 2
```

### 2. Histograma de palabras
```bash
# Contar palabras más frecuentes en un archivo
tr -cs 'A-Za-z' '\n' < /oneliners/test-data/files/small.txt | \
  tr A-Z a-z | sort | uniq -c | sort -nr | head
```

### 3. Comparación sin archivos temporales
```bash
# Comparar dos archivos ordenados sin crear temporales
diff <(sort archivo1.txt) <(sort archivo2.txt)
```

### 4. Procesar archivos con nombres raros (espacios, etc.)
```bash
# Método seguro que funciona con CUALQUIER nombre
find . -type f -print0 | xargs -0 comando
```

### 5. Analizar tus comandos más usados
```bash
# Ver los 20 comandos que más ejecutas
history | awk '{print $2}' | sort | uniq -c | sort -nr | head -20
```

Ver todos los TOP 10 en el menú interactivo (opción 11) o en `/oneliners/docs/top-10.md`

---

## 💡 Ejemplos Rápidos para Probar

### Análisis de Logs

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

### Para TODOS los niveles - Comienza aquí
1. **🔥 TOP 10 One-Liners** (opción 11 del menú)
   - Los comandos más potentes y transformadores
   - Perfecto para entender qué hace a un profesional Linux
   - 10 minutos bien invertidos

### Para principiantes
1. Empieza con "Run Complete Demo" (opción 12) - tour de 5 minutos
2. Luego "Logs Management" (opción 1) - la más práctica
3. Continúa con "Productivity & Text Processing" (opción 2)
4. Prueba "Disk Usage Analysis" (opción 3)

### Para intermedios
1. "Process Management" (opción 5)
2. "Security Auditing" (opción 4)
3. "Networking Basics" (opción 7)

### Para avanzados
1. "Advanced Filesystem" (opción 8)
2. "Advanced Networking" (opción 9)
3. Crea tus propios one-liners basados en los ejemplos

---

**¿Listo para empezar?** Ejecuta `docker-compose up -d && docker-compose exec oneliners bash` y escribe `menu`! 🚀
