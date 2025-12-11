# Filesystem Advanced One-Liners

One-liners avanzados para diagnóstico, auditoría, análisis y operación de sistemas de ficheros en Linux. Incluye inodos, ACLs, atributos extendidos, locks, montajes, corrupción, deduplicación y más.

**Objetivo, Explicación rápida, Casos de uso, Riesgos**.

---

## 1. Ver el uso de inodos por directorio (no solo por FS)

```bash
find . -xdev -printf '%h\n' | sort | uniq -c | sort -nr | head
```

**Objetivo**  
Detectar carpetas que contienen un número masivo de ficheros (síntoma común de problemas de rendimiento).

**Explicación rápida**
- `%h` → imprime directorio padre del archivo.
- `uniq -c` → cuenta ocurrencias.
- `sort -nr` → orden descendente.

**Casos de uso**
- Sistemas que se quedan sin inodos.
- Detección de "explosión" de logs temporales o colas.

**Riesgos / advertencias**
- No mide tamaño, solo cantidad.

---

## 2. Ver atributos extendidos (xattrs) de todos los ficheros del directorio
**Requisitos**: Instalar: `apt install attr` (Debian/Ubuntu) o `yum install attr` (RHEL/CentOS)
```bash
getfattr -R -d . 2>/dev/null
```

**Objetivo**  
Auditar atributos extendidos (ACLs, marcas de seguridad, flags especiales).

**Explicación rápida**
- `-R` → recursivo.
- `-d` → muestra atributos en formato legible.

**Casos de uso**
- SELinux, AppArmor, atributos de backup.
- Ficheros que no se comportan "como deberían".

**Riesgos / advertencias**
- Verboso en estructuras grandes.

---

## 3. Ver ACLs de forma recursiva
**Requisitos**: Instalar: `apt install acl` (Debian/Ubuntu) o `yum install acl` (RHEL/CentOS)
```bash
getfacl -R . 2>/dev/null
```

**Objetivo**  
Identificar ACLs que puedan estar sobrescribiendo permisos POSIX.

**Explicación rápida**
- ACLs tienen precedencia sobre permisos estándar.

**Casos de uso**
- Auditar problemas de acceso.
- Diagnóstico de permisos "misteriosos".

**Riesgos / advertencias**
- Salida extensa.

---

## 4. Ver archivos con un número anormal de hardlinks

```bash
find . -type f -links +1 -printf '%n %p\n'
```

**Objetivo**  
Detectar archivos con múltiples hardlinks (útil en deduplicación o comportamiento sospechoso).

**Explicación rápida**
- `%n` → número de enlaces.

**Casos de uso**
- Análisis de dedupe.
- Auditoría de malware que utiliza hardlinks.

**Riesgos / advertencias**
- No confundir con softlinks.

---

## 5. Ver qué ficheros están bloqueados por procesos

```bash
sudo lsof | grep "(deleted)"
```

**Objetivo**  
Identificar archivos borrados pero aún consumiendo espacio.

**Explicación rápida**
- Muchas apps rotan logs borrando el fichero mientras está abierto.

**Casos de uso**
- Servidores con disco lleno "fantasma".

**Riesgos / advertencias**
- No analiza tamaño exacto sin añadir flags.

---

## 6. Ver montajes con opciones completas

```bash
mount | column -t
```

**Objetivo**  
Revisar flags de montaje (rw, noexec, nodev, relatime, etc.).

**Explicación rápida**
- `column -t` → salida tabulada.

**Casos de uso**
- Auditoría de seguridad.
- Diagnóstico de rendimiento.

**Riesgos / advertencias**
- Con systemd, algunos montajes no aparecen (usar `/proc/self/mountinfo`).

---

## 7. Comprobar errores de filesystem sin desmontar

```bash
dmesg | grep -iE "ext4|xfs|btrfs|io error|corrupt"
```

**Objetivo**  
Detectar errores de filesystem reportados por el kernel.

**Explicación rápida**
- `dmesg` captura logs del kernel.

**Casos de uso**
- Diagnóstico de corrupción.
- Problemas de discos o controladoras.

**Riesgos / advertencias**
- Mensajes antiguos pueden confundir.

---

## 8. Mostrar espacio ocupado por metadata vs datos (Btrfs)
**Requisitos**: Solo funciona en filesystems Btrfs. Requiere `btrfs-progs` instalado.
```bash
sudo btrfs filesystem df /
```

**Objetivo**  
Entender uso real del FS en Btrfs.

**Explicación rápida**
- Muestra data, metadata y system.

**Casos de uso**
- Auditoría en servidores modernos.

**Riesgos / advertencias**
- Solo para Btrfs.

---

## 9. Ver fragmentation en XFS

```bash
xfs_db -c frag -r /dev/sda1
```

**Objetivo**  
Medir fragmentación real del FS.

**Explicación rápida**
- `-r` → modo solo lectura.

**Casos de uso**
- Problemas de IO.

**Riesgos / advertencias**
- Solo útil en XFS.

---

## 10. Localizar directorios que consumen más inodos

```bash
find / -xdev -printf '%h\n' | sort | uniq -c | sort -nr | head
```

**Objetivo**  
Detectar estructuras que saturan inodos.

**Explicación rápida**
- Similar al nº1 pero aplicado al FS raíz.

**Casos de uso**
- Sistemas donde `df -i` muestra 100% de inodos.

**Riesgos / advertencias**
- No identifica tamaño.

---

## 11. Ver flags especiales de archivos (immutable, append-only)

```bash
lsattr -R .
```

**Objetivo**  
Detectar ficheros con flags especiales.

**Explicación rápida**
- `i` → immutable.
- `a` → append-only.

**Casos de uso**
- Seguridad avanzada.
- Protección de configuraciones.

**Riesgos / advertencias**
- Cambiar flags requiere `chattr` y privilegios.

---

## 12. Comprobar qué FS soportan cuotas y estado de las mismas
**Requisitos**: Las cuotas deben estar habilitadas en el filesystem. Ver documentación de `quotaon`.
```bash
repquota -a
```

**Objetivo**  
Ver uso de cuotas por usuario/grupo.

**Explicación rápida**
- Muestra límites y consumo.

**Casos de uso**
- Servidores multiusuario.

**Riesgos / advertencias**
- Requiere tener cuotas habilitadas.

---
