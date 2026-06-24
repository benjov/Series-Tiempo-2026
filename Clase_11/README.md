## Clase 11 — Desestacionalización con X-13ARIMA-SEATS

**Tema:** Sección 5.d del temario: Descomposición de Series de Tiempo (Filtros)
**Datos:** `Base_VAR.xlsx` — INPC, TC FIX, CETE28, IGAE (mensual, Banxico/INEGI)
**Paquetes principales:** `seasonal`, `seasonalview`, `shiny`

### Objetivos
- Aplicar el método X-13ARIMA-SEATS para ajuste estacional
- Descomponer series en tendencia, ciclo, estacionalidad e irregular
- Generar el objeto `Datos_Ad.RData` usado en las clases 12–18

### Archivos
| Archivo | Descripción |
|---|---|
| `Clase_Aplicacion Modelos de Desestacionalizacion.Rmd` | Notebook principal |
| `Clase_Aplicacion Modelos de Desestacionalizacion.html` | Versión renderizada |
| `Base_VAR.xlsx` | Datos macroeconómicos de Banxico/INEGI |
| `Datos_Ad.RData` | Datos originales y ajustados por estacionalidad (generado por este script) |
