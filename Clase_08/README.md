## Clase 08 — Aplicación MA(q)

**Tema:** Sección 3.b del temario: Procesos de Medias Móviles MA(q)
**Datos:** `Base_Transporte_ARIMA.xlsx` — INEGI transporte + dummies sismo 2017 y COVID-19
**Paquetes principales:** `ggplot2`, `readxl`

### Objetivos
- Estimar MA(q) e interpretar coeficientes
- Verificar invertibilidad mediante raíces del polinomio MA
- Modelar eventos extremos con variables dummy como regresores exógenos

### Archivos
| Archivo | Descripción |
|---|---|
| `Clase_Aplicacion MA(q).Rmd` | Notebook principal |
| `Clase_Aplicacion MA(q).html` | Versión renderizada |
| `Base_Transporte_ARIMA.xlsx` | Datos de transporte con variables dummy |
| `arroots.R` | Función auxiliar para raíces AR |
| `maroots.R` | Función auxiliar para raíces MA |
| `plot.armaroots.R` | Función auxiliar para graficar raíces |
