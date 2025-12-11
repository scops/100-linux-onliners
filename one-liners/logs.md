# Logs one-liners

One-liners para leer, filtrar y analizar logs en sistemas Linux de forma rápida y profesional. Incluye técnicas pensadas para incident response, debugging y operaciones.

---

## 📁 Rutas de Logs Según Distribución

Las rutas de logs varían entre distribuciones. Usa esta tabla como referencia:

| Tipo de Log | Ubuntu/Debian | RHEL/CentOS/Fedora | Alpine Linux |
|-------------|---------------|---------------------|--------------|
| System      | `/var/log/syslog` | `/var/log/messages` | `/var/log/messages` |
| Auth        | `/var/log/auth.log` | `/var/log/secure` | `/var/log/auth.log` |
| Kernel      | `/var/log/kern.log` | `/var/log/messages` | `/var/log/messages` |
| Boot        | `/var/log/boot.log` | `/var/log/boot.log` | N/A |

> 💡 **Tip para portabilidad**: Usa variables para detectar la ruta correcta automáticamente:
> ```bash
> SYSLOG=$([ -f /var/log/syslog ] && echo /var/log/syslog || echo /var/log/messages)
> tail -f $SYSLOG
> ```

> 💡 **Para logs de servicios específicos**: Muchos servicios crean sus propios logs en `/var/log/`:
> - Nginx: `/var/log/nginx/access.log`, `/var/log/nginx/error.log`
> - Apache: `/var/log/apache2/` (Debian) o `/var/log/httpd/` (RHEL)
> - MySQL: `/var/log/mysql/error.log` o `/var/log/mysqld.log`

---

## 1. Seguir solo errores y avisos en tiempo real

```bash
tail -F /var/log/syslog | grep --line-buffered -E "ERROR|WARN|FAIL|CRIT"
```

**Objetivo**  
Monitorizar logs relevantes sin ruido durante un incidente.

**Explicación rápida**
- `tail -F` → sigue el fichero incluso si rota.
- `grep --line-buffered` → imprime en tiempo real.
- `-E` → permite múltiples patrones.

**Casos de uso**
- Incidentes donde necesitas ver errores inmediatamente.
- Debug sin leer miles de líneas irrelevantes.

**Riesgos / advertencias**
- Depende de la ubicación del syslog (Ubuntu vs CentOS vs systemd).

---

## 2. Leer el journal (systemd) solo con mensajes de nivel error

> ⚠️ **Requisito**: Este comando requiere systemd. No funciona en:
> - Contenedores Docker estándar
> - Sistemas con sysvinit/OpenRC
> - Alpine Linux (usa OpenRC)
>
> **Alternativa**: Usar logs tradicionales:
> ```bash
> tail -F /var/log/syslog | grep -E "ERROR|WARN|FAIL"
> ```

```bash
journalctl -p err -f
```

**Objetivo**
Filtrar mensajes de systemd por nivel de severidad en tiempo real.

**Explicación rápida**
- `-p err` → errores (también soporta emerg, alert, crit, warning...).
- `-f` → seguimiento tipo tail.

**Casos de uso**
- Servidores modernos donde /var/log/syslog no se usa.
- Debug de servicios gestionados por systemd.

**Riesgos / advertencias**
- Requiere permisos para ver ciertos logs.
- No disponible en todos los entornos (ver requisito arriba).

---

## 3. Ver solo las últimas N líneas de un log de forma humana

```bash
tail -n 200 /var/log/auth.log
```

**Objetivo**  
Obtener de forma rápida contexto reciente sin leer el fichero completo.

**Explicación rápida**
- `-n 200` → muestra las últimas 200 líneas.

**Casos de uso**
- Revisar intentos de login.
- Contexto antes de un fallo.

**Riesgos / advertencias**
- Depende de la ubicación del log por distribución.

---

## 4. Filtrar logs por fecha concreta

```bash
grep "2025-01-12" /var/log/syslog
```

**Objetivo**  
Localizar eventos en una fecha exacta.

**Explicación rápida**
- La mayoría de logs timestamp consistentes.

**Casos de uso**
- Auditorías.
- Reconstrucción de línea temporal.

**Riesgos / advertencias**
- Formatos de fecha pueden variar según el servicio.

---

## 5. Ver eventos de un servicio gestionado por systemd

> ⚠️ **Requisito**: Este comando requiere systemd. No funciona en:
> - Contenedores Docker estándar
> - Sistemas con sysvinit/OpenRC
>
> **Alternativa**: Ver logs del servicio directamente:
> ```bash
> # Para nginx:
> tail -f /var/log/nginx/error.log
> tail -f /var/log/nginx/access.log
> ```

```bash
journalctl -u nginx --since "1 hour ago"
```

**Objetivo**
Filtrar logs de un servicio específico en un rango temporal.

**Explicación rápida**
- `-u nginx` → unidad systemd.
- `--since` → rango temporal (también: "today", "yesterday", "2 days ago").

**Casos de uso**
- Análisis después de un deploy.
- Ver errores recientes de un servicio específico.

**Riesgos / advertencias**
- Requiere acceso a logs del servicio.

---

## 6. Contar cuántas veces ocurre un patrón (muy útil en incidentes)

```bash
grep -c "timeout" /var/log/syslog
```

**Objetivo**  
Medir rápidamente la frecuencia de un error.

**Explicación rápida**
- `-c` → cuenta coincidencias.

**Casos de uso**
- Confirmar si un problema es intermitente o masivo.

**Riesgos / advertencias**
- `grep -c` cuenta líneas, no apariciones múltiples en una línea.

---

## 7. Ver logs en tiempo real pero con coloreado automático
**Requisitos**: Instalar ccze: `apt install ccze` (Debian/Ubuntu) o `yum install ccze` (RHEL/CentOS)
```bash
tail -F /var/log/syslog | ccze -A
```

**Objetivo**  
Hacer los logs mucho más legibles mediante colores.

**Explicación rápida**
- `ccze` → coloreador de logs.
- `-A` → color ANSI.

**Casos de uso**
- Sesiones largas de lectura de logs.
- Mejor visibilidad en eventos repetitivos.

**Riesgos / advertencias**
- `ccze` puede no estar instalado.

---

## 8. Extraer las IP que aparecen en un log y ordenarlas por frecuencia

```bash
grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" /var/log/auth.log | sort | uniq -c | sort -nr | head
```

**Objetivo**  
Detectar IPs que generan más actividad (intentos de acceso, errores, etc.).

**Explicación rápida**
- `grep -oE` → extrae solo IPs.
- `uniq -c` → cuenta apariciones.
- `sort -nr` → orden descendente.

**Casos de uso**
- Identificar ataques de fuerza bruta.
- Análisis de accesos.

**Riesgos / advertencias**
- Logs con formatos especiales pueden requerir regex adaptada.

---

## 9. Ver cuánto ha crecido un log en los últimos minutos

> ⚠️ **En contenedores Docker**: Configurar TERM primero para evitar error:
> ```bash
> export TERM=xterm
> watch -n5 "wc -l /var/log/syslog"
> ```
> Sin TERM configurado verás: `Error opening terminal: unknown`

```bash
watch -n5 "wc -l /var/log/syslog"
```

**Objetivo**
Observar la velocidad de crecimiento de un log en tiempo real.

**Explicación rápida**
- `wc -l` → cuenta líneas.
- `watch` → refresco cada pocos segundos.

**Casos de uso**
- Detectar spam de logs.
- Ver actividad anómala en servicios.

**Riesgos / advertencias**
- Alto crecimiento puede significar loops o errores masivos.

---

## 10. Filtrar logs por PID para aislar un proceso concreto

```bash
grep "\[1234\]" /var/log/syslog
```

**Objetivo**  
Aislar los logs generados por un proceso concreto con PID conocido.

**Explicación rápida**
- La mayoría de demonios formatean mensajes con `[PID]`.

**Casos de uso**
- Debug de procesos que generan ruido compartido.

**Riesgos / advertencias**
- No todos los servicios incluyen el PID en formato `[1234]`.

---
