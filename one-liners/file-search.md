# File Search & Pattern Hunting One-Liners

One-liners para búsqueda avanzada de archivos, análisis de contenido, detección de patrones y auditoría del filesystem en Linux. Diseñados para administradores, SREs y equipos de seguridad que necesitan velocidad y precisión.

**Objetivo, Explicación rápida, Casos de uso y Riesgos**.

---

## 1. Encontrar los 20 ficheros más grandes del sistema

```bash
sudo find / -type f -printf '%s %p\n' 2>/dev/null | sort -nr | head -20
```

**Objetivo**  
Localizar rápidamente los ficheros más pesados del sistema.

**Explicación rápida**
- `-printf '%s %p'` → imprime tamaño (bytes) + ruta.
- `sort -nr` → orden numérico descendente.
- `head -20` → muestra los 20 más grandes.

**Casos de uso**
- Recuperación urgente en sistemas con disco lleno.
- Auditoría de crecimiento anómalo.

**Riesgos / advertencias**
- Requiere `sudo` para resultados completos.
- Puede tardar en sistemas gigantes.

---

## 2. Buscar archivos modificados en las últimas 2 horas

```bash
find . -type f -mmin -120
```

**Objetivo**  
Identificar archivos recientes tras un incidente o despliegue.

**Explicación rápida**
- `-mmin -120` → modificados hace menos de 120 minutos.

**Casos de uso**
- Detectar cambios inesperados.
- Revisar actividad tras una intrusión.

**Riesgos / advertencias**
- La hora del sistema debe estar correctamente sincronizada.

---

## 3. Buscar archivos que contienen una cadena ignorando mayúsculas/minúsculas

```bash
grep -Ri "cadena" .
```

**Objetivo**  
Localizar parámetros, contraseñas, rutas o configuraciones distribuidas.

**Explicación rápida**
- `-R` → recursivo.
- `-i` → case-insensitive.

**Casos de uso**
- Búsquedas globales en código o configs.
- Identificación de secretos expuestos.

**Riesgos / advertencias**
- Puede mostrar resultados en binarios si no se filtra.

---

## 4. Identificar líneas con emails o patrones complejos

```bash
grep -RHoE "([0-9]{3}-){2}[0-9]{4}|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+" .
```

**Objetivo**  
Detectar datos sensibles como correos o identificadores.

**Explicación rápida**
- `-o` → muestra solo la coincidencia.
- `-E` → expresión regular avanzada.
- Incluye patrón simple de teléfono + email.

**Casos de uso**
- Auditoría de fuga de datos.
- Revisiones de compliance.

**Riesgos / advertencias**
- Regex puede necesitar adaptación por idioma/país.

---

## 5. Buscar ficheros grandes por extensión

```bash
find . -type f -name "*.log" -size +10M
```

**Objetivo**  
Localizar logs descontrolados.

**Explicación rápida**
- `-size +10M` → archivos mayores de 10 MB.

**Casos de uso**
- Sistemas con `/var` saturado.
- Análisis de servicios que generan demasiados logs.

**Riesgos / advertencias**
- Los tamaños pueden ser engañosos en sistemas con compresión.

---

## 6. Ver las 10 carpetas más profundas o grandes en estructura

```bash
find . -type d -printf '%d %p\n' | sort -n | tail -10
```

**Objetivo**  
Identificar estructuras enormes o problemáticas.

**Explicación rápida**
- `%d` → profundidad del directorio.
- Orden ascendente → los más profundos al final.

**Casos de uso**
- Detectar sistemas que generan millones de ficheros.
- Diagnóstico de árboles "monstruo".

**Riesgos / advertencias**
- No indica tamaño de disco, solo profundidad.

---

## 7. Buscar archivos pertenecientes a un usuario concreto

```bash
find / -user usuario -type f 2>/dev/null
```

**Objetivo**  
Enumerar archivos propiedad de un usuario.

**Explicación rápida**
- Útil para auditorías y trazabilidad.

**Casos de uso**
- Preparación de bajas de usuarios.
- Revisión de propietarios incorrectos.

**Riesgos / advertencias**
- Puede generar mucha salida.

---

## 8. Localizar ficheros con permisos peligrosos (world-writable)

```bash
find / -type f -perm -0002 2>/dev/null
```

**Objetivo**  
Detectar archivos donde cualquier usuario puede escribir.

**Explicación rápida**
- `-perm -0002` → bit de escritura para "others".

**Casos de uso**
- Hardening.
- Investigación de escaladas de privilegios.

**Riesgos / advertencias**
- Muchos ficheros legítimos pueden aparecer (ej. `/tmp`).

---

## 9. Mostrar archivos con SUID activo (riesgo de escalada)

```bash
find / -perm -4000 -type f 2>/dev/null
```

**Objetivo**  
Detectar binarios que se ejecutan con UID root.

**Explicación rápida**
- SUID es un vector clásico de explotación si hay binarios vulnerables.

**Casos de uso**
- Auditoría de seguridad.
- Validación tras instalaciones.

**Riesgos / advertencias**
- No todos los SUID son peligrosos; requiere análisis.

---

## 10. Buscar dentro de ficheros enormes sin romperse con binarios

```bash
grep -RIZ "texto" .
```

**Objetivo**  
Buscar cadenas en estructuras de directorios mixtas evitando fallos por binarios.

**Explicación rápida**
- `-Z` → separa resultados con null-byte.
- Ideal para ficheros que podrían contener binarios.

**Casos de uso**
- Auditoría de configuraciones.
- Búsqueda masiva en proyectos gigantes.

**Riesgos / advertencias**
- Formato con `-Z` es ideal para pipelines, no para lectura manual.

---
