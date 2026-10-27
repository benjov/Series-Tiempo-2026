## Clase 17 — VAR estructural: identificación recursiva, de largo plazo y de signo

**Tema:** Sección 6.d del temario: Análisis de Impulso-Respuesta (identificación estructural)
**Paquetes principales:** `vars`, `svars`, `seasonal`, `lubridate`, `readxl`, `ggplot2`

### Estructura de la carpeta

```
Clase_17/
├── VAR Recursivo/                       ← sesión 1: SVAR recursivo (Cholesky)
│   ├── Clase_VAR(p) - IRF-Recursivo.Rmd
│   └── VAR_Recursivo.xlsx
└── VAR Estructural/                     ← sesión 2: largo plazo y signos
    ├── Largo-Plazo/BQ1989/              ← Blanchard y Quah (1989) en R
    ├── Restricción-Signos/Uhlig2005/    ← Uhlig (2005) en R
    └── VAR-Toolbox/                     ← Toolbox MATLAB de Cesa-Bianchi (v2 y v3), sólo referencia
```

### Objetivos
- Implementar un SVAR recursivo con restricciones de corto plazo y justificar el orden de las variables
- Aplicar ajuste estacional previo al VAR con X-13
- Identificar choques con restricciones de largo plazo (Blanchard-Quah) y de signo (Uhlig)

### Archivos principales
| Archivo | Descripción |
|---|---|
| `VAR Recursivo/Clase_VAR(p) - IRF-Recursivo.Rmd` | Notebook principal: choque de incertidumbre comercial de EE.UU. sobre consumo e inversión en México |
| `VAR Recursivo/Clase_VAR-p----IRF-Recursivo.html` | Versión renderizada (abrir en navegador) |
| `VAR Recursivo/VAR_Recursivo.xlsx` | Datos mensuales 1999-2025 (`Hoja1`) y notas de fuentes (`Hoja2`) |
| `VAR Estructural/Largo-Plazo/BQ1989/Clase_SVAR_Largo_Plazo_BQ1989.Rmd` | Replicación en R de la Figura 2 de Blanchard y Quah (1989) con `vars::BQ()` (y su `.html`) |
| `VAR Estructural/Restricción-Signos/Uhlig2005/Clase_SVAR_Restricciones_Signos_Uhlig2005.Rmd` | Replicación en R de la Figura 6 de Uhlig (2005); el algoritmo de rotaciones está programado paso a paso (y su `.html`) |
| `VAR Estructural/*/GO_*.m`, `*_Replication.pdf` | Scripts originales en MATLAB y sus figuras, para comparar resultados |
| `VAR Estructural/VAR-Toolbox/` | Toolbox MATLAB completa de Cesa-Bianchi (material de referencia, no se requiere para la clase) |
