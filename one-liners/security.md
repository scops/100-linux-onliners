# Security One-Liners

One-liners avanzados para auditoría, hardening, detección de riesgos, análisis forense ligero y revisión de seguridad en sistemas Linux. **Objetivo, Explicación rápida, Casos de uso y Riesgos**.

---

## 1. Listar todos los binarios con SUID activo (riesgo clásico de escalada)

```bash
find / -perm -4000 -type f 2>/dev/null
```

**Objetivo**  
Identificar binarios ejecutados con UID root.

**Explicación rápida**
- `-perm -4000` → bit SUID.
- Riesgo si el binario tiene vulnerabilidades.

**Casos de uso**
- Auditorías.
- Hardening.

**Riesgos / advertencias**
- No eliminar SUID de binarios críticos sin conocer su función.

---

## 2. Ver capabilities asignadas a binarios (menos visibles que SUID)

```bash
getcap -r / 2>/dev/null
```

**Objetivo**  
Detectar binarios con capabilities que permiten acciones privilegiadas.

**Explicación rápida**
- Capabilities dividen privilegios root en permisos granulares.

**Casos de uso**
- Revisiones de seguridad modernas.

**Riesgos / advertencias**
- Algunas capabilities son necesarias para servicios legítimos.

---

## 3. Ver qué puertos están abiertos y qué procesos los manejan

```bash
sudo ss -tulnp
```

**Objetivo**  
Auditar la superficie expuesta del sistema.

**Explicación rápida**
- `-tulnp` → TCP, UDP, listening, numeric, process.

**Casos de uso**
- Descubrir servicios no documentados.

**Riesgos / advertencias**
- Requiere privilegios.

---

## 4. Mostrar archivos world-writable

```bash
find / -type f -perm -0002 2>/dev/null
```

**Objetivo**  
Detectar ubicaciones donde cualquier usuario puede escribir.

**Explicación rápida**
- Riesgo típico de escalada o plantación de backdoors.

**Casos de uso**
- Hardening inmediato.

**Riesgos / advertencias**
- `/tmp` y similares son normales; analizar contexto.

---

## 5. Detectar directorios world-writable con sticky bit ausente

```bash
find / -type d -perm -0002 ! -perm -1000 2>/dev/null
```

**Objetivo**  
Directorio escribible por todos pero sin sticky bit = peligro.

**Explicación rápida**
- Sticky bit (`+t`) evita borrar archivos ajenos.

**Casos de uso**
- Revisiones de permisos.

**Riesgos / advertencias**
- No confundir con directorios controlados por apps.

---

## 6. Ver qué usuarios pueden usar sudo sin contraseña

```bash
grep -R "NOPASSWD" /etc/sudoers /etc/sudoers.d 2>/dev/null
```

**Objetivo**  
Detectar accesos privilegiados sin control.

**Explicación rápida**
- Buscar reglas peligrosas.

**Casos de uso**
- Auditoría interna.

**Riesgos / advertencias**
- Reglas pueden estar justificadas (automatización).

---

## 7. Ver intentos de acceso SSH fallidos
**Nota**: En RHEL/CentOS usar `/var/log/secure` en lugar de `/var/log/auth.log`
```bash
grep "Failed password" /var/log/auth.log | tail
```

**Objetivo**  
Detectar ataques de fuerza bruta.

**Explicación rápida**
- `auth.log` contiene eventos de autenticación.

**Casos de uso**
- Monitorización de seguridad.

**Riesgos / advertencias**
- Ubicación varía según distro.

---

## 8. Buscar claves privadas expuestas en el sistema

```bash
grep -R "BEGIN RSA PRIVATE KEY" / 2>/dev/null
```

**Objetivo**  
Descubrir claves sensibles guardadas donde no deben estar.

**Explicación rápida**
- Detecta material criptográfico.

**Casos de uso**
- Auditoría de secretos.

**Riesgos / advertencias**
- Puede mostrar falsos positivos de backups.

---

## 9. Ver conexiones de red establecidas ordenadas por cantidad

```bash
ss -tan | awk '{print $1}' | sort | uniq -c | sort -nr | head
```

**Objetivo**  
Detectar patrones de conexión sospechosos.

**Explicación rápida**
- Cuenta tipos de estados TCP.

**Casos de uso**
- Detección de bots o malware.

**Riesgos / advertencias**
- Interpretar estados requiere conocimientos de TCP.

---

## 10. Detectar módulos del kernel recientemente cargados

```bash
dmesg | grep -i "module loaded"
```

**Objetivo**  
Identificar drivers o módulos inesperados.

**Explicación rápida**
- Útil para detectar rootkits antiguos.

**Casos de uso**
- Auditorías del kernel.

**Riesgos / advertencias**
- Muchos módulos legítimos se cargan dinámicamente.

---

## 11. Mostrar usuarios conectados y su origen

```bash
who -a
```

**Objetivo**  
Ver sesiones activas.

**Explicación rápida**
- Incluye información de TTY, tiempo y origen.

**Casos de uso**
- Detección de accesos no autorizados.

**Riesgos / advertencias**
- Usuarios de sistema pueden aparecer listados.

---

## 12. Ver binarios ejecutables que no pertenecen a root

```bash
find /bin /usr/bin -type f ! -user root
```

**Objetivo**  
Detectar binarios alterados.

**Explicación rápida**
- Binarios del sistema deberían ser root:root.

**Casos de uso**
- Forense ligero.

**Riesgos / advertencias**
- Sistemas personalizados pueden ser legítimos.

---

## 13. Listar ficheros modificados en las últimas 24h fuera de /home

```bash
sudo find / -path /home -prune -o -mtime -1 -type f -print
```

**Objetivo**  
Detectar cambios inesperados en el sistema.

**Explicación rápida**
- `-prune` excluye /home.

**Casos de uso**
- Investigación de intrusiones.

**Riesgos / advertencias**
- Cambios legítimos pueden aparecer.

---

## 14. Ver procesos con conexiones remotas sospechosas

```bash
sudo lsof -i -P -n | grep ESTABLISHED
```

**Objetivo**  
Ver comunicaciones activas.

**Explicación rápida**
- Muestra procesos + IPs remotas.

**Casos de uso**
- Análisis de beaconing.

**Riesgos / advertencias**
- Requiere interpretación.

---

## 15. Ver comandos ejecutados recientemente por root

```bash
sudo tail -n 50 /root/.bash_history
```

**Objetivo**  
Auditar actividad administrativa.

**Explicación rápida**
- Revisión rápida de operaciones recientes.

**Casos de uso**
- Investigación forense.

**Riesgos / advertencias**
- Puede estar deshabilitado o editado.

---
