## Clase 06 — Aplicación AR(2)

**Tema:** Sección 3.a del temario: Procesos Autoregresivos AR(p)
**Datos:** `Base_Transporte.xlsx` — INEGI, transporte aéreo y metro CDMX (mensual)
**Paquetes principales:** `ggplot2`, `readxl`

### Objetivos
- Estimar AR(2) e interpretar sus raíces características
- Verificar estacionariedad: módulo de raíces < 1
- Detectar ciclos implícitos cuando las raíces son complejas

### Archivos
| Archivo | Descripción |
|---|---|
| `Clase_Aplicacion AR(2).Rmd` | Notebook principal |
| `Clase_Aplicacion AR(2).html` | Versión renderizada |
| `Base_Transporte.xlsx` | Datos de transporte INEGI |
| `arroots.R` | Función auxiliar para calcular raíces AR |
| `maroots.R` | Función auxiliar para calcular raíces MA |
| `plot.armaroots.R` | Función auxiliar para graficar raíces en el plano complejo |
| `G_Pax_Nal.png` | Gráfica de pasajeros nacionales |
| `G_Roots_AR2.png` | Raíces del AR(2) en el plano complejo |
