# Aliases one-liners

Atajos de productividad real para Linux. Alias diseñados para administradores, desarrolladores y SREs que quieren velocidad, limpieza y precisión.

Incluye alias para disco, procesos, red, logs, backups y utilidades generales.

---

## 1. Alias para el diagnóstico de uso de disco

```bash
alias disk='du -h --max-depth=1 2>/dev/null | sort -h'
```

**Descripción**  
Diagnóstico inmediato de qué subdirectorios consumen más espacio.

---

```bash
alias big='sudo find . -type f -size +100M -exec ls -lh {} \; | sort -k5 -h'
```

**Descripción**  
Listar los ficheros grandes del directorio actual.

---

## 2. Alias para procesos

```bash
alias pscpu="ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head"
```

**Descripción**  
Ver los procesos que más CPU consumen.

---

```bash
alias psmem="ps -eo pid,comm,%mem,%cpu --sort=-%mem | head"
```

**Descripción**  
Ver los procesos que más RAM consumen.

---

```bash
alias psg='ps aux | grep -v grep | grep -i'
```

**Descripción**  
Buscar procesos por nombre.

---

## 3. Alias de red

```bash
alias ports='ss -ltn'
```

**Descripción**  
Ver puertos abiertos en el sistema.

---

```bash
alias listen='sudo lsof -i -P -n | grep LISTEN'
```

**Descripción**  
Ver qué procesos están escuchando en puertos.

---

```bash
alias myip='curl -s ifconfig.me'
```

**Descripción**  
Obtener IP pública.

---

## 4. Alias para logs

```bash
alias flog='tail -F /var/log/syslog'
```

**Descripción**  
Seguir logs del sistema en tiempo real.

---

```bash
alias elog='journalctl -p err -f'
```

**Descripción**  
Seguir solo errores del journal.

---

```bash
alias slowlogs='watch -n5 "wc -l /var/log/syslog"'
```

**Descripción**  
Medir velocidad de crecimiento de logs.

---

## 5. Alias para backups

```bash
alias bkup='rsync -av --delete'
```

**Descripción**  
Invocar rsync preparado para backups espejo.

---

```bash
alias tarfast='tar -czf archive-$(date +%F).tar.gz'
```

**Descripción**  
Crear rápidamente un tar.gz con timestamp.

---

## 6. Alias de productividad general

```bash
alias ll='ls -lha --color=auto'
```

**Descripción**  
Listar contenido con formato largo y colores.

---

```bash
alias la='ls -A'
```

**Descripción**  
Listar archivos ocultos.

---

```bash
alias path='echo -e ${PATH//:/\n}'
```

**Descripción**  
Mostrar el PATH en líneas separadas.

---

## 7. Alias avanzados (bonus nivel ninja)

```bash
alias please='sudo $(fc -ln -1)'
```

**Descripción**  
Re-ejecutar el último comando con sudo.

---

```bash
alias histg='history | grep'
```

**Descripción**  
Buscar en el histórico.

---

```bash
alias fixnet='sudo systemctl restart NetworkManager || sudo systemctl restart networking'
```

**Descripción**  
Intento automático de restaurar la red.

---

## Cómo hacer persistentes estos alias

Añadirlos a `~/.bashrc` o `~/.zshrc`:

```bash
echo "alias disk='du -h --max-depth=1 2>/dev/null | sort -h'" >> ~/.bashrc
source ~/.bashrc
```

---

Estos alias pueden integrarse en un fichero completo `~/.aliases` y ser cargados así:

```bash
echo "source ~/.aliases" >> ~/.bashrc
```
