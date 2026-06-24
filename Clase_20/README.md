## Clase 20 — Modelos de Volatilidad: ARCH, GARCH y M-GARCH

**Tema:** Secciones 4 y 8 del temario: Modelos de Volatilidad Univariados y Multivariados
**Datos:** Datos de Yahoo Finance/FRED (descarga online), datos macro México 1993–2009, `Ejemplo/Datos_1200_V2.xls`
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
| `lag_opt_GARCH.R` | Función de selección de orden óptimo GARCH por AIC |
| `Ejemplo/Aplicacion Multivariate GARCH.Rmd` | Ejemplo adicional con dataset propio |
| `Ejemplo/Datos_1200_V2.xls` | Datos del ejemplo adicional |

> **Nota:** `ARCH_GARCH.Rmd` y `Multivariate GARCH Case 2.Rmd` requieren conexión a internet para descargar datos.
