# Disk usage one-liners

One-liners para diagnosticar rápidamente el uso de disco en sistemas Linux, pensados para entornos profesionales.

Cada comando incluye objetivo, explicación breve, casos de uso y riesgos.

---

## 1. Ver qué subdirectorios del directorio actual consumen más espacio

```bash
du -h --max-depth=1 2>/dev/null | sort -h
```

**Objetivo**  
Obtener una visión rápida del consumo de espacio por subdirectorio en el directorio actual, ordenado de menor a mayor.

**Explicación rápida**
- `du -h` → uso de disco en formato legible (K, M, G).
- `--max-depth=1` → solo un nivel de profundidad, evita ruido.
- `2>/dev/null` → oculta errores de permisos.
- `sort -h` → ordena respetando unidades.

**Casos de uso**
- Detectar qué carpeta “pesa” más en un proyecto.
- Primer paso antes de borrar cosas en un sistema con poco espacio.

**Riesgos / advertencias**
- Puede tardar con muchos ficheros pequeños, pero suele ser manejable.

---

## 2. Radiografía rápida del uso de disco en la raíz del sistema

```bash
sudo du -sh /* 2>/dev/null | sort -h
```

**Objetivo**  
Ver cuánto ocupa cada directorio de primer nivel en `/` (/, /var, /home, /opt, etc.).

**Explicación rápida**
- `du -sh /*` → tamaño total de cada directorio de primer nivel.
- `-s` → solo el total (summary), no desglosa recursivamente.
- `2>/dev/null` → ignora errores de permisos.
- `sort -h` → ordena de menor a mayor tamaño.

**Casos de uso**
- Averiguar si el problema de espacio está en `/var`, `/home`, `/opt`, etc.
- Diagnóstico inicial en un servidor que se está quedando sin disco.

**Riesgos / advertencias**
- Requiere `sudo` para ver directorios del sistema sin errores.
- No distingue puntos de montaje, solo tamaños aparentes.

---

## 3. Saber qué usuario (home) está usando más disco

```bash
sudo du -sh /home/* 2>/dev/null | sort -h
```

**Objetivo**  
Identificar qué directorios de usuarios en `/home` son los más pesados.

**Explicación rápida**
- `du -sh /home/*` → tamaño total de cada subdirectorio en `/home`.
- `2>/dev/null` → oculta errores de permisos.
- `sort -h` → ordena de menor a mayor tamaño.

**Casos de uso**
- Entornos multiusuario: developers llenando `/home`.
- Justificación objetiva antes de pedir a un usuario que limpie su home.

**Riesgos / advertencias**
- Requiere `sudo` en muchos entornos para ver tamaños completos.

---

## 4. Ver uso de disco de todos los sistemas de ficheros de forma limpia
**Requisitos**: En sistemas minimalistas instalar: `apt install bsdmainutils` (Debian/Ubuntu)
```bash
df -hP | column -t
```

**Objetivo**  
Listar el uso de disco por sistema de ficheros de forma alineada y legible.

**Explicación rápida**
- `df -hP` → tamaño legible y salida “portable” (una línea por FS).
- `column -t` → alinea columnas automáticamente en formato tabla.

**Casos de uso**
- Comprobar qué partición está realmente llena.
- Diferenciar rápido `/`, `/var`, `/home`, volúmenes de Docker, etc.

**Riesgos / advertencias**
- `column` suele estar disponible por defecto, pero no en todas las imágenes ultraminimalistas.

---

## 5. Detectar problemas de inodos (muchos ficheros pequeños)

```bash
df -i | sort -k5 -h
```

**Objetivo**  
Revisar el uso de inodos por sistema de ficheros para detectar si el disco “lleno” es en realidad falta de inodos.

**Explicación rápida**
- `df -i` → muestra inodos totales, usados y porcentaje de uso.
- `sort -k5 -h` → ordena por la columna del porcentaje de uso de inodos.

**Casos de uso**
- Cuando `df -h` dice que hay espacio, pero no se pueden crear más ficheros.
- Diagnóstico de sistemas con millones de ficheros pequeños (logs, tmp, etc.).

**Riesgos / advertencias**
- Ninguno relevante, es solo lectura.

---

## 6. Encontrar los ficheros gigantes que están llenando el disco

```bash
sudo find / -xdev -type f -size +500M -printf '%s %p\n' 2>/dev/null | sort -n | tail
```

**Objetivo**  
Localizar los ficheros más grandes (mayores de 500 MB) en el sistema de ficheros raíz.

**Explicación rápida**
- `find / -xdev` → busca en `/` sin cruzar a otros sistemas de ficheros.
- `-type f` → solo ficheros regulares.
- `-size +500M` → mayores de 500 MB.
- `-printf '%s %p'` → imprime tamaño en bytes y ruta.
- `sort -n | tail` → muestra los más grandes.

**Casos de uso**
- Cuando el disco está al límite y necesitas identificar “las ballenas”.
- Detección de logs o dumps gigantes olvidados en `/var`, `/tmp`, etc.

**Riesgos / advertencias**
- Puede tardar bastante en discos grandes.
- Requiere `sudo` para resultados completos.
- No eliminar ficheros sin entender su función.

---

## 7. Ver qué parte de `/var/log` está creciendo sin control

```bash
sudo du -h /var/log --max-depth=1 2>/dev/null | sort -h
```

**Objetivo**  
Identificar qué subdirectorios dentro de `/var/log` están consumiendo más espacio.

**Explicación rápida**
- `du -h /var/log --max-depth=1` → tamaños por subdirectorio en `/var/log`.
- `2>/dev/null` → oculta errores.
- `sort -h` → ordena por tamaño.

**Casos de uso**
- Servidores donde `/var` o `/` se llenan por exceso de logs.
- Determinar si el problema es `journal`, `nginx`, `apache2`, `mysql`, etc.

**Riesgos / advertencias**
- El borrado agresivo de logs puede impactar auditorías o troubleshooting.
- Valorar rotación y políticas de retención antes de borrar.

---
