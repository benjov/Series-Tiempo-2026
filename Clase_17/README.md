## Clase 17 — VAR Estructural e IRF Recursivo

**Tema:** Sección 6.d del temario: Análisis de Impulso-Respuesta (identificación estructural)
**Paquetes principales:** `vars`, `svars`, `seasonal`, `lubridate`

### Estructura de la carpeta

```
Clase_17/
├── VAR Recursivo/          ← notebook principal en R
│   ├── Clase_VAR(p) - IRF-Recursivo.Rmd
│   └── VAR_Recursivo.xlsx
└── VAR Estructural/
    ├── Restriccion-Signos/Uhlig2005/   ← replicación Uhlig (2005)
    ├── Largo-Plazo/BQ1989/             ← replicación Blanchard & Quah (1989)
    └── VAR-Toolbox/                    ← Toolbox MATLAB de Cesa-Bianchi (v2 y v3)
```

### Objetivos
- Implementar SVAR recursivo con restricciones de corto plazo
- Aplicar ajuste estacional previo al VAR con X-13
- Conocer los esquemas alternativos de identificación (largo plazo, restricciones de signo) como referencia avanzada

### Archivos principales
| Archivo | Descripción |
|---|---|
| `VAR Recursivo/Clase_VAR(p) - IRF-Recursivo.Rmd` | Notebook principal en R |
| `VAR Recursivo/VAR_Recursivo.xlsx` | Datos para el SVAR |
| `VAR Estructural/Largo-Plazo/BQ1989/` | Replicación de Blanchard & Quah (1989) en MATLAB |
| `VAR Estructural/Restriccion-Signos/Uhlig2005/` | Replicación de Uhlig (2005) en MATLAB |
| `VAR Estructural/VAR-Toolbox/` | Toolbox MATLAB completa de Cesa-Bianchi (material de referencia avanzada) |
