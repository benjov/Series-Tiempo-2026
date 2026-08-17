## Clase 00 — Introducción a las Series de Tiempo

**Tema:** Sección 1 del temario: La naturaleza de los datos de series de tiempo
**Datos:** `Base_1_TimeSeries.xlsx` — IGAE, IGAE primarias, ICC, ICC 12 meses, IPC BMV y tipo de cambio (mensual, ene-2002 a may-2025; INEGI, Banxico y BMV)
**Paquetes principales:** `readxl`, base R

### Objetivos
- Importar datos desde un archivo `.xlsx` y declarar series con `ts()` indicando inicio y frecuencia
- Construir gráficas comparativas de series económicas mexicanas con el sistema base de R
- Aplicar las dos transformaciones básicas: número índice y diferencias logarítmicas

### Archivos
| Archivo | Descripción |
|---|---|
| `Clase_00.Rmd` | Notebook principal |
| `Clase_00.html` | Versión renderizada |
| `Clase_00.R` | Script original, se conserva como referencia |
| `Base_1_TimeSeries.xlsx` | Datos de las seis series |
| `Base_1.RData` | Objeto guardado por el notebook al final de la sesión |
| `G2_ICC.jpg` | Índice de Confianza del Consumidor |
| `G3_IPC_TDC.jpg` | IPC de la BMV y tipo de cambio en niveles |
| `G4_IPC_TDC_I.jpg` | IPC y tipo de cambio reindexados (ene-2002 = 100) |
| `G5_DIFF_LOG.jpg` | Diferencias logarítmicas del IGAE, IPC y TDC |

### Notas
- Las gráficas de las diapositivas de la Sesión 1 (`clase-01.html` en la raíz del repositorio) se
  generan con estos mismos datos: `utils/exporta_series_web.R` los exporta al sitio del curso.
