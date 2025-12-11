# Processes one-liners

One-liners para diagnosticar, monitorizar y entender procesos en Linux de forma profesional.
Todos los comandos incluyen objetivo, explicación, casos de uso y riesgos.

---

## 1. Ver los procesos que más CPU consumen (estilo top, pero scriptable)

```bash
watch -n1 'ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head'
```

**Objetivo**  
Obtener una vista actualizada cada segundo de los procesos que más CPU consumen.

**Explicación rápida**
- `watch -n1`: ejecuta el comando cada 1 segundo.
- `ps -eo pid,comm,%cpu,%mem`: muestra PID, comando, %CPU y %MEM.
- `--sort=-%cpu`: orden descendente.
- `head`: limita la salida a los más relevantes.

**Casos de uso**
- Cuando `top`/`htop` no están disponibles.
- Automatización y debugging en scripts.

**Riesgos / advertencias**
- `watch` refresca continuamente, puede saturar la consola.

---

## 2. Ver el árbol completo de procesos

```bash
pstree -p | less
```

**Objetivo**  
Visualizar jerarquías de procesos para entender qué ha lanzado a qué.

**Explicación rápida**
- `pstree` → dibuja un árbol de procesos.
- `-p` → incluye PIDs.
- `less` → permite navegar.

**Casos de uso**
- Diagnosticar forks excesivos.
- Ver la estructura de servicios, especialmente en sistemas legacy.

**Riesgos / advertencias**
- En sistemas con muchos procesos puede producir un árbol muy largo.

---

## 3. Saber qué mantiene un fichero, puerto o recurso abierto

```bash
sudo lsof /ruta/del/fichero
```

**Objetivo**  
Identificar qué proceso tiene abierto un fichero, socket o directorio.

**Explicación rápida**
- `lsof` → lista ficheros abiertos.
- Funciona con ficheros, sockets, dispositivos, pipes, etc.

**Casos de uso**
- “No puedo borrar este fichero, dice que está en uso”.
- Detectar qué proceso usa un certificado, un log, un socket, un volumen, etc.

**Riesgos / advertencias**
- Requiere `sudo` para información completa.

---

## 4. Encontrar procesos zombies

```bash
ps -eo pid,ppid,stat,comm | grep -w Z
```

**Objetivo**  
Listar procesos en estado zombie (`Z`).

**Explicación rápida**
- `stat` muestra el estado del proceso.
- Zombie = proceso terminado cuyo padre no ha recogido su `wait()`.

**Casos de uso**
- Diagnóstico cuando un servicio crea zombies continuamente.
- Detección de problemas de programación o supervisión.

**Riesgos / advertencias**
- Los zombies no consumen CPU, pero sí entradas en la tabla de procesos.

---

## 5. Averiguar el comando completo con el que se lanzó un proceso

```bash
ps -p <PID> -o args=
```

**Objetivo**  
Ver la línea completa de comando usada para lanzar un proceso.

**Explicación rápida**
- `-p <PID>` → filtra por proceso concreto.
- `-o args=` → muestra solo el comando completo.

**Casos de uso**
- Ver qué parámetros está usando `java`, `python`, `nginx`, etc.
- Debugging en servicios donde la configuración depende de flags.

**Riesgos / advertencias**
- En procesos muy largos la línea puede truncarse según sistema y kernel.

---

## 6. Ver procesos que consumen más memoria

```bash
ps -eo pid,comm,%mem,%cpu --sort=-%mem | head
```

**Objetivo**  
Detectar rápidamente qué procesos consumen más memoria RAM.

**Explicación rápida**
- Igual que el comando de CPU, pero ordenando por `%mem`.

**Casos de uso**
- Detectar fugas de memoria.
- Priorizar acciones en un servidor con OOMKills.

**Riesgos / advertencias**
- Los valores de `%MEM` son relativos al total disponible del sistema.

---

## 7. Ver procesos con sus límites (ulimits) aplicados

```bash
cat /proc/<PID>/limits
```

**Objetivo**  
Conocer los límites de recursos aplicados a un proceso concreto.

**Explicación rápida**
- `/proc/<PID>/limits` → muestra límites de memoria, ficheros, CPU, etc.

**Casos de uso**
- Diagnóstico de procesos que fallan por límites de ficheros abiertos.
- Configuración de servicios críticos.

**Riesgos / advertencias**
- Requiere entender el modelo de límites soft/hard.

---

## 8. Ver el entorno (variables) con el que se lanzó un proceso

```bash
sudo strings /proc/<PID>/environ | tr '\0' '\n'
```

**Objetivo**  
Ver todas las variables de entorno con las que se ejecuta un proceso.

**Explicación rápida**
- `strings` → convierte binario a texto legible.
- `tr '\0' '\n'` → cada variable en una línea.

**Casos de uso**
- Diagnóstico de fallos por variables mal configuradas.
- Ver parámetros reales en procesos gestionados por systemd o supervisores.

**Riesgos / advertencias**
- **Puede mostrar secretos / passwords en variables de entorno.**

---

## 9. Identificar procesos que más IO están realizando
**Requisitos**: Instalar iotop: `apt install iotop` (Debian/Ubuntu) o `yum install iotop` (RHEL/CentOS)
```bash
sudo iotop -ao
```

**Objetivo**  
Ver qué procesos están generando más operaciones de IO acumuladas.

**Explicación rápida**
- `-a` → muestra IO acumulado.
- `-o` → solo procesos con actividad real.

**Casos de uso**
- Servidores lentos por disco.
- Detección de procesos que escriben logs sin control.

**Riesgos / advertencias**
- Requiere permisos elevados.
- No está disponible en todas las distros por defecto.

---

## 10. Mostrar procesos junto con el usuario y tiempo activo

```bash
ps -eo user,pid,etime,comm --sort=etime | tail
```

**Objetivo**  
Ver qué procesos llevan más tiempo ejecutándose y bajo qué usuario.

**Explicación rápida**
- `etime` → tiempo desde que se lanzó el proceso.
- `sort=etime` → ordena por tiempo de ejecución.

**Casos de uso**
- Detectar demonios antiguos, procesos huérfanos, jobs que no terminan.
- Auditoría y revisión de servicios legacy.

**Riesgos / advertencias**
- Interpretar correctamente formatos tipo `dd-hh:mm:ss`.

---
