# Network Advanced One-Liners

One-liners avanzados para análisis profundo de red en Linux. Incluye ARP, MTU, retransmisiones, colas, routing avanzado, neighbour discovery, estadísticas TCP y análisis de tráfico de bajo nivel.

**Objetivo, Explicación rápida, Casos de uso, Riesgos**.

---

## 1. Ver retransmisiones TCP (indicador de problemas de red)

```bash
ss -s | grep retransmits
```

**Objetivo**  
Detectar si hay pérdidas o degradación en la red.

**Explicación rápida**
- `ss -s` → estadísticas del stack TCP.
- "retransmits" alto implica problemas de red o congestión.

**Casos de uso**
- Diagnóstico de lentitud de aplicaciones.
- Detección de congestión real.

**Riesgos / advertencias**
- No indica causa; solo síntoma.

---

## 2. Ver tamaño de ventana TCP actual por conexión

```bash
ss -ti
```

**Objetivo**  
Inspeccionar parámetros TCP por conexión, incluida la ventana.

**Explicación rápida**
- `-i` → info TCP adicional.
- Muestra cwnd, rtt, retransmits.

**Casos de uso**
- Optimización de rendimiento.
- Tuning de TCP.

**Riesgos / advertencias**
- Requiere conocimientos de TCP avanzado.

---

## 3. Ver ARP actual y comprobar ARP poisoning

```bash
ip neigh
```

**Objetivo**  
Mostrar tabla ARP actual.

**Explicación rápida**
- Muestra MAC asociadas a IPs locales.

**Casos de uso**
- Detección de cambios sospechosos.

**Riesgos / advertencias**
- No detecta ataques pasivos.

---

## 4. Ver paquetes descartados o con errores por interfaz

```bash
ip -s link
```

**Objetivo**  
Revisar errores físicos o de capa 2.

**Explicación rápida**
- Muestra drops, overruns, errores.

**Casos de uso**
- Diagnóstico de NIC defectuosas.

**Riesgos / advertencias**
- Interpretación requiere experiencia.

---

## 5. Detectar mismatches de MTU (muy común en VPNs)

```bash
ping -M do -s 1472 8.8.8.8
```

**Objetivo**  
Comprobar si la MTU es demasiado grande y causa fragmentación.

**Explicación rápida**
- `-M do` → no fragmentar.
- `-s 1472` → tamaño que con overhead da MTU 1500.

**Casos de uso**
- Problemas en túneles VPN.

**Riesgos / advertencias**
- Algunos destinos bloquean ICMP.

---

## 6. Ver rutas activas con detalles avanzados

```bash
ip route show table all
```

**Objetivo**  
Ver todas las tablas de routing, no solo la principal.

**Explicación rápida**
- Incluye policy routing.

**Casos de uso**
- Sistemas con múltiples gateways.

**Riesgos / advertencias**
- Puede ser muy verboso.

---

## 7. Ver reglas de policy routing

```bash
ip rule show
```

**Objetivo**  
Identificar reglas que cambian el flujo del tráfico.

**Explicación rápida**
- Policy routing permite rutas por origen, marca, fwmark.

**Casos de uso**
- Configuraciones avanzadas de networking.

**Riesgos / advertencias**
- Requiere entender marcas de paquetes.

---

## 8. Ver colas de interfaces (qdisc) y su estado

```bash
tc qdisc show
```

**Objetivo**  
Auditar colas de tráfico: fq_codel, pfifo, etc.

**Explicación rápida**
- Útil para latencias anómalas.

**Casos de uso**
- Diagnóstico en routers Linux.

**Riesgos / advertencias**
- Modificar qdisc sin conocimiento puede romper tráfico.

---

## 9. Detección rápida de tráfico por puerto en tiempo real

```bash
sudo tcpdump -ni any port 443
```

**Objetivo**  
Ver tráfico relacionado con un puerto concreto.

**Explicación rápida**
- `any` captura en todas las interfaces.

**Casos de uso**
- Debug de TLS.

**Riesgos / advertencias**
- Puede mostrar datos sensibles.

---

## 10. Capturar solo cabeceras (sin payload) para análisis seguro

```bash
sudo tcpdump -s 96 -ni any
```

**Objetivo**  
Reducir riesgo de capturar datos sensibles.

**Explicación rápida**
- `-s 96` limita captura.

**Casos de uso**
- Auditoría sin riesgos legales.

**Riesgos / advertencias**
- No ves payload completo.

---

## 11. Ver estadísticas de sockets en uso

```bash
ss -an | awk '{print $1}' | sort | uniq -c | sort -nr | head
```

**Objetivo**  
Detectar estados TCP dominantes (SYN_SENT, TIME_WAIT…).

**Explicación rápida**
- Contabiliza estados TCP.

**Casos de uso**
- Detección de ataques SYN flood.

**Riesgos / advertencias**
- Requiere interpretar estados TCP.

---

## 12. Mostrar información del vecino IPv6 (ND)

```bash
ip -6 neigh show
```

**Objetivo**  
Ver resoluciones de vecinos IPv6.

**Explicación rápida**
- Similar a ARP en IPv6.

**Casos de uso**
- Diagnóstico de redes modernas.

**Riesgos / advertencias**
- Datos pueden expirar rápido.

---
