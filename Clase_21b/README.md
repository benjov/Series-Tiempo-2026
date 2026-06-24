## Clase 21b — Diferencias en Diferencias (DiD)

**Tema:** Sección 10 del temario: Modelos de Datos Panel — Evaluación de impacto
**Datos:** `baseModeloINPC_Oct2022.xlsx` — INPC sectorial con datos hasta octubre 2022
**Paquetes principales:** `ggplot2`, `dplyr`, `lmtest`, `plm`, `lubridate`

### Objetivos
- Especificar el estimador DiD: Y = α + β₁·Tratado + β₂·Post + β₃·(Tratado×Post) + ε
- Verificar el supuesto de tendencias paralelas en el periodo pre-tratamiento
- Interpretar β₃ como el Average Treatment Effect on the Treated (ATT)

### Archivos
| Archivo | Descripción |
|---|---|
| `Modelo Dif-in-Dif INPC Analisis Clinicos.Rmd` | Notebook principal |
| `Modelo-Dif-in-Dif-INPC-Analisis-Clinicos.html` | Versión renderizada |
| `baseModeloINPC_Oct2022.xlsx` | Datos INPC sectorial para el modelo DiD |

> **Relacionado:** Las pruebas de raíz unitaria para panel están en **Clase_21/**.
