## Clase 10.5 — ARIMA V2: Modelos SARIMA

**Tema:** Sección 3.c del temario: Procesos ARMA/ARIMA (extensión estacional)
**Datos:** `Base_Transporte_ARIMA.xlsx` — INEGI transporte + dummies sismo 2017 y COVID-19
**Paquetes principales:** `forecast`, `lubridate`, `readxl`

### Objetivos
- Especificar y estimar modelos SARIMA con componente estacional
- Seleccionar orden óptimo (p,q,P,Q) por búsqueda en grilla con AIC
- Comparar el SARIMA contra ARIMA puro en ajuste y pronóstico

### Archivos
| Archivo | Descripción |
|---|---|
| `Clase_Aplicacion ARIMA(p, d, q) y ARMA(p, q) V2.Rmd` | Notebook principal |
| `Clase_Aplicacion ARIMA(p, d, q) y ARMA(p, q) V2.html` | Versión renderizada |
| `Base_Transporte_ARIMA.xlsx` | Datos de transporte con dummies |
| `Lag_Opt_ARIMA_Exog.R` | Selección óptima ARIMA por AIC |
| `Lag_Opt_SARIMA_Exog.R` | Selección óptima SARIMA por AIC (grilla p×q×P×Q) |
| `arroots.R`, `maroots.R`, `plot.armaroots.R` | Funciones para raíces |
