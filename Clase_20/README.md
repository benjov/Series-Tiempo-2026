## Clase 20 — Modelos de Volatilidad: ARCH, GARCH y M-GARCH

**Tema:** Secciones 4 y 8 del temario: Modelos de Volatilidad Univariados y Multivariados
**Datos:** `data/BTC_USD.RData` (snapshot Bitcoin 2014–2026, corte 2026-07-07), datos de Yahoo Finance/FRED (descarga online), datos macro México 1993–2009, `Ejemplo/Datos_1200_V2.xls`
**Paquetes principales:** `rugarch`, `FinTS`, `quantmod`, `MTS`, `rmgarch`, `xts`

### Objetivos
- Detectar y modelar clustering de volatilidad con ARCH/GARCH
- Estimar modelos M-GARCH para analizar transmisión de volatilidad entre variables
- Calcular correlaciones condicionales dinámicas (DCC-GARCH)

### Archivos
| Archivo | Descripción |
|---|---|
| `ARCH_GARCH.Rmd` | Notebook principal ARCH/GARCH univariado |
| `ARCH_GARCH.html` | Versión renderizada |
| `Multivariate GARCH.Rmd` | M-GARCH: tipo de cambio, inflación e IGAE México |
| `Multivariate GARCH.html` | Versión renderizada |
| `Multivariate GARCH Case 2.Rmd` | M-GARCH: S&P500 y MXN/USD (datos en tiempo real) |
| `Multivariate GARCH Case 2.html` | Versión renderizada |
| `Ejemplo/Aplicacion Multivariate GARCH.Rmd` | Ejemplo adicional con dataset propio |
| `Ejemplo/Datos_1200_V2.xls` | Datos del ejemplo adicional |

La función de selección de orden óptimo GARCH por AIC está centralizada en `../utils/lag_opt_GARCH.R`.

> **Nota:** `ARCH_GARCH.Rmd` usa la serie congelada `../data/BTC_USD.RData` para garantizar reproducibilidad; el código de descarga viva desde Yahoo Finance quedó comentado en el notebook. `Multivariate GARCH.Rmd` y `Multivariate GARCH Case 2.Rmd` sí requieren conexión a internet para descargar datos.
