## Clase 09 — Aplicación ARIMA(p,d,q) y ARMA(p,q)

**Tema:** Sección 3.c del temario: Procesos ARMA(p,q) y ARIMA(p,d,q)
**Datos:** `Base_Transporte_ARIMA.xlsx` — INEGI transporte + dummies sismo 2017 y COVID-19
**Paquetes principales:** `ggplot2`, `readxl`, `stats`

### Objetivos
- Estimar modelos ARIMA/ARMA con selección automática de orden por AIC
- Incorporar variables exógenas (ARIMAX)
- Comprender la búsqueda exhaustiva en grilla vs selección paso a paso

### Archivos
| Archivo | Descripción |
|---|---|
| `Clase_Aplicacion ARIMA(p, d, q) y ARMA(p, q).Rmd` | Notebook principal |
| `Clase_Aplicacion ARIMA(p, d, q) y ARMA(p, q).html` | Versión renderizada |
| `Base_Transporte_ARIMA.xlsx` | Datos de transporte con dummies |
| `Lag_Opt_ARIMA_Exog.R` | Función de selección óptima por AIC (grilla p×q) |
| `arroots.R`, `maroots.R`, `plot.armaroots.R` | Funciones auxiliares para raíces |
