# Contributing to Linux One-Liners

¡Gracias por tu interés en contribuir! Este documento te guiará sobre cómo puedes ayudar a mejorar este repositorio.

## 🎯 Tipos de Contribuciones

### 1. Nuevos One-Liners
Puedes añadir nuevos comandos útiles que:
- Resuelvan problemas reales
- Sean concisos y memorables
- Sigan el formato establecido

### 2. Correcciones
- Errores en comandos existentes
- Typos en documentación
- Mejoras en explicaciones

### 3. Mejoras de Documentación
- Casos de uso adicionales
- Ejemplos más claros
- Traducciones

### 4. Testing
- Reportar comandos que no funcionan
- Probar en diferentes distribuciones
- Añadir tests automatizados

## 📝 Formato de One-Liners

Cada comando debe seguir esta estructura:

```markdown
## N. Título descriptivo del comando

\`\`\`bash
comando completo aquí
\`\`\`

**Objetivo**
Breve descripción de qué hace y por qué es útil.

**Explicación rápida**
- Desglose de las partes principales del comando
- Opciones relevantes explicadas

**Casos de uso**
- Situación 1 donde este comando es útil
- Situación 2 donde este comando es útil

**Riesgos / advertencias**
- Cualquier peligro o limitación
- Requisitos especiales (permisos, paquetes, etc.)
```

### Ejemplo Real

```markdown
## 5. Ver los procesos que más CPU consumen

\`\`\`bash
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -10
\`\`\`

**Objetivo**
Identificar rápidamente qué procesos están consumiendo más recursos de CPU.

**Explicación rápida**
- `ps -eo` → muestra procesos con campos personalizados
- `--sort=-%cpu` → ordena por uso de CPU descendente
- `head -10` → muestra solo los 10 primeros

**Casos de uso**
- Servidor lento, necesitas identificar el culpable
- Monitoreo rápido sin instalar herramientas adicionales

**Riesgos / advertencias**
- El porcentaje de CPU puede variar rápidamente
- En sistemas con muchos cores, %CPU puede superar 100%
```

## 🔍 Criterios de Calidad

Para que un one-liner sea aceptado debe:

1. **Ser útil**: Resolver un problema real, no ser un comando trivial
2. **Ser conciso**: Preferiblemente una línea, máximo 2-3 líneas con pipes
3. **Ser portable**: Funcionar en múltiples distribuciones (Ubuntu, RHEL, etc.)
4. **Estar documentado**: Incluir las 4 secciones (Objetivo, Explicación, Casos, Riesgos)
5. **Ser seguro**: No incluir comandos destructivos sin advertencias claras
6. **Estar probado**: Verificar que funciona antes de enviar

## 🚀 Proceso de Contribución

### 1. Fork y Clone

```bash
# Fork el repositorio en GitHub
# Luego clona tu fork
git clone https://github.com/scops/100-linux-onliners.git
cd 100-linux-onliners
```

### 2. Crear una Rama

```bash
git checkout -b feature/nuevo-comando-logs
# o
git checkout -b fix/correccion-networking
```

### 3. Hacer Cambios

- Añade tus one-liners al archivo correspondiente en `one-liners/`
- Asegúrate de seguir el formato establecido
- Prueba el comando en el entorno Docker:

```bash
docker build -t linux-oneliners .
docker run -it --rm linux-oneliners
# Prueba tu comando aquí
```

### 4. Commit con Mensaje Descriptivo

```bash
git add one-liners/logs.md
git commit -m "Add command to filter logs by date range

- Added grep with date pattern example
- Includes timezone handling
- Tested on Ubuntu 22.04"
```

### 5. Push y Pull Request

```bash
git push origin feature/nuevo-comando-logs
```

Luego crea un Pull Request en GitHub con:
- Título descriptivo
- Descripción de qué añades/corriges
- Capturas de pantalla si es relevante
- Menciona si probaste en el entorno Docker

## ✅ Checklist Pre-PR

Antes de enviar tu Pull Request, verifica:

- [ ] El comando funciona correctamente
- [ ] Sigue el formato establecido
- [ ] Incluye las 4 secciones obligatorias
- [ ] No hay typos evidentes
- [ ] Se probó en el entorno Docker (si es posible)
- [ ] Las advertencias de seguridad están presentes (si aplica)
- [ ] El mensaje de commit es descriptivo

## 🧪 Testing

### Probar en Docker

```bash
# Construir imagen
docker build -t linux-oneliners-test .

# Probar comando
docker run -it --rm linux-oneliners-test bash -c "tu-comando-aqui"
```

### Probar en Múltiples Distros

Si es posible, prueba en:
- Ubuntu 22.04 (base)
- Debian 11
- RHEL/CentOS 8
- Alpine Linux

## 🐛 Reportar Problemas

Si encuentras un problema:

1. Verifica que no esté ya reportado en [Issues](../../issues)
2. Crea un nuevo issue con:
   - Título claro y descriptivo
   - Descripción del problema
   - Comando que falla
   - Distribución y versión
   - Output del error
   - Pasos para reproducir

### Template de Issue

```markdown
**Descripción**
El comando X no funciona en Ubuntu 22.04

**Comando**
\`\`\`bash
grep -Z "pattern" file.txt
\`\`\`

**Error**
\`\`\`
grep: invalid option -- 'Z'
\`\`\`

**Entorno**
- Distribución: Ubuntu 22.04
- Kernel: 5.15.0
- grep version: 3.7

**Solución propuesta**
Cambiar `-Z` por `-z` (minúscula)
```

## 📚 Estructura del Repositorio

```
.
├── one-liners/           # Documentación de comandos por categoría
│   ├── logs.md
│   ├── networking.md
│   ├── security.md
│   └── ...
├── Dockerfile            # Entorno de pruebas
├── docker-compose.yml    # Orquestación
├── test-menu.sh          # Menú interactivo
├── check-requirements.sh # Verificador de dependencias
├── REQUIREMENTS.md       # Documentación de dependencias
├── revision.md           # Informe de testing
└── README.md            # Documentación principal
```

## 🏆 Reconocimiento

Los contribuidores serán reconocidos en:
- Lista de contributors de GitHub
- Sección de agradecimientos (si la contribución es significativa)
- Comentarios en el código cuando sea relevante

## 💬 Comunicación

- Issues de GitHub para bugs y features
- Pull Requests para código
- Discusiones para ideas generales

## 📜 Código de Conducta

### Nuestro Compromiso

- Ser respetuoso y profesional
- Aceptar críticas constructivas
- Enfocarse en lo mejor para la comunidad
- Mostrar empatía hacia otros

### Comportamiento Inaceptable

- Lenguaje ofensivo o discriminatorio
- Acoso de cualquier tipo
- Spam o autopromoción excesiva
- Cualquier conducta no profesional

## ❓ Preguntas

Si tienes dudas sobre cómo contribuir:
1. Revisa este documento
2. Busca en Issues cerrados
3. Abre un Issue con la etiqueta "question"

## 📄 Licencia

Al contribuir, aceptas que tu contribución será licenciada bajo la misma licencia del proyecto (MIT License).

---

¡Gracias por hacer de Linux One-Liners un mejor recurso para todos! 🐧
