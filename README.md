# Linux 100 One-Liners

Colección profesional de one-liners para Linux orientados a productividad, resolución rápida de incidencias y administración real de sistemas. Todos los comandos están documentados con objetivo, explicación, casos de uso y riesgos.

Esta repo está pensada tanto para técnicos en activo como para alumnos del curso oficial **IFCT114PO – Linux**, donde se profundiza en administración del sistema, redes, servicios y seguridad.

👉 Más información del curso (subvencionado y dirigido a trabajadores):  
https://subvencionada.sinensia.com/ifct114po-linux

---

## Objetivo de la colección

- Reunir comandos potentes, concisos y útiles en entornos profesionales de Linux.
- Enseñar *cómo pensar* detrás de cada comando, no solo memorizarlo.
- Construir una referencia práctica para troubleshooting, optimización y administración.
- Complementar el temario del curso IFCT114PO con práctica aplicada.

---

## Estructura de la repo

```
one-liners/
  disk-usage.md
  processes.md
  networking.md
  logs.md
  backup.md
README.md
```

Cada fichero contiene entre 5 y 20 one-liners, agrupados por temática, con explicación detallada y riesgos.

---

## ¿Por qué esta colección es diferente?

- No es una lista de comandos aleatorios: cada oneliner resuelve un problema real.
- Está escrita por un formador y consultor con experiencia en entornos de producción.
- Muchos comandos incluyen variantes y ajustes poco conocidos pero extremadamente útiles.
- Está orientada a *productividad profesional*, no a principiantes copiando y pegando.

---

## Relación con el curso IFCT114PO – Linux

Esta repo complementa los contenidos del curso subvencionado **IFCT114PO – Linux**, que cubre:

- Introducción a UNIX/Linux
- Sistema de ficheros, permisos y edición
- Procesos, usuarios, servicios
- Redes, topologías, DHCP, DNS, SSH, FTP
- Proxy, Gateway, Firewall
- Servidores: Web, Correo, Samba, NFS

El curso combina teoría + ejercicios prácticos y está dirigido a profesionales en activo que quieran elevar su nivel técnico.

➡️ Inscripción e información oficial:  
https://subvencionada.sinensia.com/ifct114po-linux

---

## Contribuciones

- Pull Requests bienvenidas.
- Se aceptan nuevos one-liners siempre que cumplan:
  - Simplicidad
  - Utilidad real
  - Riesgos explicados
  - Memorizables

---

## Licencia

MIT License.

---

## Primeros ficheros disponibles

Los ficheros se irán completando progresivamente:
- `disk-usage.md` → Diagnóstico de espacio y uso de disco
- `processes.md` → Gestión y análisis de procesos
- `networking.md` → Comandos de red, puertos, sockets, diagnóstico
- `logs.md` → Lectura eficiente de logs en tiempo real
- `backup.md` → Copias de seguridad, sincronización y rsync avanzado

---

## ¿Quieres formación más avanzada?

El curso IFCT114PO está diseñado para profesionales que quieran dominar Linux con una base sólida y aplicable.

📌 **IFCT114PO – Linux (40 horas, modalidad presencial o bimodal)**  
**Subvencionado. Dirigido prioritariamente a trabajadores en activo.**  
https://subvencionada.sinensia.com/ifct114po-linux

---

## Bonus: crear tus propios shortcuts con alias de sistema

Los alias permiten convertir comandos largos en atajos memorables, aumentando tu productividad diaria.

Ejemplo básico:
```bash
alias ll='ls -lha'
```

Alias más productivo:
```bash
alias disk='du -h --max-depth=1 2>/dev/null | sort -h'
```

Para que sean permanentes, añádelos a `~/.bashrc` o `~/.zshrc`:
```bash
echo "alias disk='du -h --max-depth=1 2>/dev/null | sort -h'" >> ~/.bashrc
source ~/.bashrc
```

Ventajas:
- Reduces escritura repetitiva.
- Evitas errores en comandos largos.
- Estandarizas shortcuts entre máquinas.

En la repo añadiremos un fichero dedicado: `one-liners/aliases.md`, con alias listos para producción.
