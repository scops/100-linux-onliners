# 🔥 TOP 10 Linux One-Liners

Selección definitiva de los **10 one-liners más útiles, potentes y transformadores** para usuarios profesionales de Linux. No son "los más básicos", sino los que **mejor representan maestría real en consola**, productividad extrema y seguridad operativa.

Incluye explicación de por qué son importantes, ejemplos y advertencias cuando procede.

---

## **1. Re-ejecutar cualquier comando del historial — incluido corregir permisos al instante**

```bash
sudo !!      # Reejecuta el último comando con sudo
!1289        # Reejecuta directamente el comando número 1289 del historial
```

**Por qué es top**  
El operador `!` es uno de los superpoderes más desconocidos de Bash. No solo sirve para repetir el último comando con privilegios; también permite **recuperar y ejecutar cualquier comando del historial**, por largo o complejo que sea.

**Uso real**
- Intentaste algo y falló por permisos → `sudo !!` 
- Ejecutaste un comando larguísimo hace rato y quieres repetirlo → busca con `history | grep texto` y luego ejecuta `!<número>`

**Advertencia**  
Cuidado: ejecutar comandos históricos sin revisarlos primero puede ser peligroso.

---

## **2. "Asesino" visual de procesos con selección interactiva (fzf)**

```bash
kill -9 "$(ps -eo pid,cmd | fzf | awk '{print $1}')"
```

**Por qué es brutal**  
Convierte matar procesos en algo rápido, visual y sin errores. `fzf` te permite buscar por nombre, comando o cualquier parte de la línea.

**Brilla en**  
- Sistemas cargados con cientos de procesos
- Diagnóstico cuando no sabes el PID

---

## **3. Evitar borrar archivos accidentalmente al sobrescribir — el poder de `sponge`**

### ❌ Peligroso: esto destruye el archivo antes de leerlo
```bash
grep foo data.txt > data.txt
```

### ✔ Seguro: versión con `sponge`
```bash
grep foo data.txt | sponge data.txt
```

**Por qué es top**  
`>` trunca el fichero ANTES de que `grep` lo lea. `sponge` (de *moreutils*) absorbe toda la entrada primero y solo escribe cuando todo está listo.

**Útil para**  
- Limpieza de logs
- Filtros in-place
- Modificaciones seguras sin `sed -i`

**Advertencia**  
Puede consumir memoria con archivos muy grandes.

---

## **4. Contador profesional de frecuencias (análisis tipo GROUP BY en shell)**

```bash
awk '{ count[$1]++ } END { for (v in count) print v, count[v] }' input.txt
```

**Por qué es top**  
Define el "modo avanzado" de usar shell: estructuras de datos reales, deduplicación, análisis de logs… todo en una línea.

**Casos típicos**
- Contar IPs en logs
- Contar códigos HTTP
- Estadísticas rápidas sin Python ni SQL

---

## **5. Histograma completo de palabras con limpieza incluida**

```bash
tr -cs 'A-Za-z' '\n' < file | tr A-Z a-z | sort | uniq -c | sort -nr | head
```

**Por qué es top**  
Transforma texto desordenado en un análisis limpio y cuantitativo.

**Perfecto para**  
- Análisis exploratorio
- Logs, documentación, texto libre

---

## **6. Comparación instantánea sin ficheros temporales (Process Substitution)**

```bash
diff <(sort a.txt) <(sort b.txt)
```

**Por qué es top**  
Evita crear archivos intermedios. Permite comparar salidas de pipelines complejos como si fueran ficheros.

**Útil para**  
- Ver diferencias lógicas ignorando orden
- Comparar configuraciones

---

## **7. Ejecutar acciones sobre miles de ficheros de forma segura**

```bash
find . -type f -print0 | xargs -0 comando
```

**Por qué es top**  
El combo `-print0` + `-0` hace que este método funcione **con cualquier nombre de archivo**, incluso con espacios, saltos de línea y caracteres rotos.

**Fundamental para**  
- Operaciones masivas
- Automatización real

---

## **8. Los 20 comandos que más usas — radiografía de tu productividad**

```bash
history | awk '{print $2}' | sort | uniq -c | sort -nr | head -20
```

**Por qué es top**  
Analizar hábitos es la base de la optimización profesional.

**Para qué sirve**  
- Detectar comandos repetitivos y aliasificarlos
- Evaluar tu flujo de trabajo

---

## **9. Elimina TODO excepto lo que quieres conservar**

```bash
find . -type f ! -name "importante.txt" -delete
```

**Por qué es top**  
Es la expresión mínima del poder de find: selección + negación + acción.

**Advertencia**  
Extremadamente destructivo. Probar antes sin `-delete`:

```bash
find . -type f ! -name "importante.txt"
```

---

## **10. Diagnóstico instantáneo de problemas de red (TCP retransmissions)**

```bash
ss -s | grep retransmits
```

**Por qué es top**  
Una de las métricas más infravaloradas del rendimiento de red. Las retransmisiones indican:
- pérdida de paquetes
- congestión
- MTU incorrecta
- problemas de latencia

**Es el termómetro de salud TCP.**

---

# 🏁 Conclusión
Este TOP 10 no son "los comandos más usados", sino los que definen **competencia avanzada** y permiten trabajar con una mezcla de:
- potencia
- seguridad
- análisis
- productividad real

Si quieres los integramos también en el README o como `TOP10.md` en el repo oficial.
