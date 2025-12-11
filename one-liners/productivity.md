# Productivity One-Liners

One-liners avanzados para maximizar la eficiencia en Linux: manipulación de texto, loops en una línea, xargs profesional, pipes inteligentes, ordenación, contadores e inspección rápida. Pensado para administradores, desarrolladores y SREs que necesitan velocidad sin perder precisión.

**Objetivo, Explicación rápida, Casos de uso y Riesgos**.

---

## 1. Ejecutar un comando sobre cada fichero sin usar bucles explícitos

```bash
find . -type f -print0 | xargs -0 -I{} echo {}
```

**Objetivo**  
Procesar ficheros de forma segura incluso con espacios.

**Explicación rápida**
- `-print0` + `-0` → evita problemas con nombres raros.
- `-I{}` → placeholder.

**Casos de uso**
- Procesamiento masivo de archivos.

**Riesgos / advertencias**
- Cuidado con comandos destructivos.

---

## 2. Crear un histogramas de ocurrencias de palabras

```bash
tr -cs 'A-Za-z' '\n' < fichero | tr A-Z a-z | sort | uniq -c | sort -nr | head
```

**Objetivo**  
Analizar frecuencia de palabras.

**Explicación rápida**
- Normaliza a minúsculas, separa, cuenta.

**Casos de uso**
- Análisis de logs, texto, código.

**Riesgos / advertencias**
- No distingue contextos.

---

## 3. Mostrar solo las líneas duplicadas de un fichero

```bash
sort fichero | uniq -d
```

**Objetivo**  
Detectar duplicados.

**Explicación rápida**
- `uniq -d` muestra solo entradas repetidas.

**Casos de uso**
- Limpieza de listas.

**Riesgos / advertencias**
- Requiere orden previo.

---

## 4. Ejecutar una acción N veces sin escribir bucles

```bash
seq 5 | xargs -I{} echo "Iteración {}"
```

**Objetivo**  
Simular bucles rápidos.

**Explicación rápida**
- `seq` genera números.
- `xargs` ejecuta.

**Casos de uso**
- Testing, repetición.

**Riesgos / advertencias**
- Básico pero útil.

---

## 5. Extraer solo columnas específicas de una salida

```bash
awk '{print $1, $3}' fichero
```

**Objetivo**  
Analizar estructuras tabulares.

**Explicación rápida**
- `awk` maneja campos automáticamente.

**Casos de uso**
- Logs, CSV, reportes.

**Riesgos / advertencias**
- Necesita conocer estructura.

---

## 6. Sustitución de procesos (process substitution)

```bash
diff <(sort a.txt) <(sort b.txt)
```

**Objetivo**  
Comparar outputs sin ficheros temporales.

**Explicación rápida**
- `<(cmd)` genera un descriptor FIFO.

**Casos de uso**
- Comparación avanzada.

**Riesgos / advertencias**
- No funciona en shells muy antiguas.

---

## 7. Ver cuánto tarda un comando

```bash
time ls > /dev/null
```

**Objetivo**  
Medir rendimiento.

**Explicación rápida**
- `time` mide wall clock, user, sys.

**Casos de uso**
- Optimización.

**Riesgos / advertencias**
- Varía según carga del sistema.

---

## 8. Sustituir una expresión en múltiples ficheros sin sed -i

```bash
grep -Rl "foo" . | xargs sed 's/foo/bar/g'
```

**Objetivo**  
Evitar sed in-place en entornos restringidos.

**Explicación rápida**
- `grep -Rl` encuentra archivos.
- `xargs` aplica sed.

**Casos de uso**
- Refactor de código.

**Riesgos / advertencias**
- No sobrescribe ficheros; redirigir si se desea.

---

## 9. Ver los 20 comandos más usados

```bash
history | awk '{print $2}' | sort | uniq -c | sort -nr | head -20
```

**Objetivo**  
Auditar hábitos y productividad.

**Explicación rápida**
- Extrae comando principal.

**Casos de uso**
- Optimización personal.

**Riesgos / advertencias**
- Historia puede estar truncada.

---

## 10. Crear varios directorios con un solo comando usando expansión

```bash
mkdir -p proyecto/{src,bin,docs,tests}
```

**Objetivo**  
Crear árboles completos.

**Explicación rápida**
- Expansión de llaves.

**Casos de uso**
- Inicio de proyectos.

**Riesgos / advertencias**
- Ninguno relevante.

---

## 11. Borrar todos los ficheros excepto uno

```bash
find . -type f ! -name "importante.txt" -delete
```

**Objetivo**  
Limpieza selectiva extrema.

**Explicación rápida**
- `! -name` → exclusión.

**Casos de uso**
- Limpieza rápida.

**Riesgos / advertencias**
- **Extremadamente destructivo**.

---

## 12. Mostrar tamaño total por extensión de fichero

```bash
find . -type f -printf '%f %s\n' | awk -F. '{print $NF, $2}' | awk '{arr[$1]+=$2} END {for (i in arr) print i, arr[i]}' | sort -k2 -nr
```

**Objetivo**  
Ver qué tipos de archivos consumen más espacio.

**Explicación rápida**
- Suma tamaño por extensión.

**Casos de uso**
- Optimizar proyectos.

**Riesgos / advertencias**
- Ficheros sin extensión se agrupan como uno.

---

## 13. Listar líneas únicas preservando orden

```bash
awk '!seen[$0]++' fichero
```

**Objetivo**  
Eliminar duplicados sin reordenar.

**Explicación rápida**
- Hash associative.

**Casos de uso**
- Limpieza de listas.

**Riesgos / advertencias**
- Memory-bound para ficheros masivos.

---

## 14. Mostrar solo líneas entre dos patrones

```bash
sed -n '/INICIO/,/FIN/p' fichero
```

**Objetivo**  
Extraer secciones.

**Explicación rápida**
- Rango de sed.

**Casos de uso**
- Logs, configuraciones.

**Riesgos / advertencias**
- Patrones deben ser únicos.

---

## 15. Ejecutar comandos en paralelo

```bash
printf "cmd1\ncmd2\ncmd3" | xargs -P 3 -I{} sh -c "{}"
```

**Objetivo**  
Acelerar tareas.

**Explicación rápida**
- `-P 3` → paralelismo.

**Casos de uso**
- Automatización.

**Riesgos / advertencias**
- Condiciones de carrera si se manejan ficheros.

---
