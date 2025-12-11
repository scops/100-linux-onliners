# Networking one-liners

One-liners para diagnosticar, inspeccionar y comprender el estado de red en sistemas Linux. Pensados para administradores, SREs y técnicos que necesitan respuestas inmediatas y fiables.

Objetivo, explicación, casos de uso y riesgos.

---

## 1. Saber qué proceso escucha en un puerto

```bash
sudo lsof -iTCP:443 -sTCP:LISTEN -Pn
```

**Objetivo**  
Identificar rápidamente qué proceso está escuchando en un puerto concreto.

**Explicación rápida**
- `-iTCP:443` → filtra tráfico TCP en el puerto 443.
- `-sTCP:LISTEN` → solo sockets en estado LISTEN.
- `-Pn` → evita resoluciones DNS lentas.

**Casos de uso**
- ¿Quién está usando el puerto 80/443/8080?
- Conflictos entre servicios (Nginx, Apache, Node, Java...).

**Riesgos / advertencias**
- Requiere `sudo` para ver procesos ajenos.

---

## 2. Ver conexiones activas, sin ruido y en formato legible

```bash
ss -tupan | column -t
```

**Objetivo**  
Mostrar conexiones TCP/UDP activas, asociadas a procesos, de forma clara.

**Explicación rápida**
- `ss` → reemplazo moderno de `netstat`, mucho más rápido.
- `-tu` → TCP + UDP.
- `-p` → muestra proceso.
- `-a` → todo.
- `-n` → no resolver DNS.
- `column -t` → formato tabla.

**Casos de uso**
- Detección de conexiones sospechosas.
- Debug de aplicaciones que abren demasiados sockets.

**Riesgos / advertencias**
- Mostrar procesos puede requerir permisos elevados.

---

## 3. Testear conectividad sin usar curl ni navegador

```bash
echo | nc -vz google.com 443
```

**Objetivo**  
Comprobar si se puede establecer conexión TCP contra un host/puerto.

**Explicación rápida**
- `nc -vz` → modo "verbose" y "zero-I/O".
- Si conecta, el puerto está accesible.

**Casos de uso**
- Diagnóstico rápido de firewalls.
- Verificar si un servicio remoto está vivo.

**Riesgos / advertencias**
- Algunos sistemas no tienen `nc` instalado.

---

## 4. Medir latencia hacia un host sin resolver DNS

```bash
ping -n -c4 1.1.1.1
```

**Objetivo**  
Evitar que las resoluciones lentas oculten el verdadero RTT.

**Explicación rápida**
- `-n` → no resolver nombres.
- `-c4` → solo 4 paquetes.

**Casos de uso**
- Determinar si hay latencia real o problema DNS.

**Riesgos / advertencias**
- Ping puede estar bloqueado por el firewall.

---

## 5. Ver la tabla de enrutamiento de forma rápida

```bash
ip route show
```

**Objetivo**  
Conocer qué rutas usa el sistema (incluyendo default gateway).

**Explicación rápida**
- `ip route` → parte del stack moderno iproute2.

**Casos de uso**
- Detección de rutas incorrectas.
- Ver qué interfaz usa el tráfico saliente.

**Riesgos / advertencias**
- Solo muestra rutas del namespace actual.

---

## 6. Ver interfaz, MAC, IP y estado de un vistazo

```bash
ip -br addr
```

**Objetivo**  
Visualizar interfaces y direcciones IP en modo “brevity”.

**Explicación rápida**
- `-br` → formato corto y legible.

**Casos de uso**
- Diagnóstico rápido.
- Evitar el ruido de `ip addr` tradicional.

**Riesgos / advertencias**
- Ninguno relevante.

---

## 7. Ver errores, drops y estadísticas de red

```bash
ip -s link
```

**Objetivo**  
Mostrar estadísticas completas de las interfaces de red.

**Explicación rápida**
- `-s` → stats: paquetes, errores, drops, overruns.

**Casos de uso**
- Diagnóstico de problemas físicos o de congestión.
- Comprobar si hay paquetes descartados.

**Riesgos / advertencias**
- Leer correctamente métricas requiere experiencia.

---

## 8. Detectar quién está resolviendo DNS y qué tiempos da

```bash
dig +stats example.com | grep Query
```

**Objetivo**  
Obtener tiempos de resolución DNS de forma simple.

**Explicación rápida**
- `dig +stats` → incluye métricas.
- `grep Query` → extrae la línea relevante.

**Casos de uso**
- Sospechas de DNS lento.
- Ver si las respuestas vienen del servidor correcto.

**Riesgos / advertencias**
- `dig` puede no venir instalado por defecto.

---

## 9. Ver tráfico en una interfaz en tiempo real (solo cabeceras)

```bash
sudo tcpdump -ni eth0 -c20
```

**Objetivo**  
Capturar los primeros 20 paquetes de una interfaz sin resolución DNS.

**Explicación rápida**
- `-n` → no DNS.
- `-i eth0` → interfaz.
- `-c20` → solo 20 paquetes.

**Casos de uso**
- Confirmar si hay tráfico real en una interfaz.
- Diagnóstico rápido antes de hacer capturas grandes.

**Riesgos / advertencias**
- `tcpdump` requiere permisos.
- Capturas pueden contener datos sensibles.

---

## 10. Testear apertura de puertos locales sin herramientas externas

```bash
ss -ltn
```

**Objetivo**  
Ver todos los puertos TCP abiertos en el sistema.

**Explicación rápida**
- `-l` → listening.
- `-t` → TCP.
- `-n` → no DNS.

**Casos de uso**
- Auditoría de puertos abiertos.
- Comprobación post-deploy.

**Riesgos / advertencias**
- No muestra qué proceso abrió el puerto (añadir `-p` si se necesita).

---
