# Series de Tiempo — Semestre 2027-I

Repositorio de scripts, notebooks y materiales de apoyo para el curso **Análisis de Series de Tiempo** (semestre 2027-I) de la Facultad de Economía, UNAM.

## Descripción del repositorio

Cada carpeta corresponde a una sesión del curso. Los datos y funciones compartidos entre varias clases se centralizan en `data/` y `utils/`; las carpetas de clase incluyen:

- Notebooks de R Markdown (`.Rmd`) y su versión renderizada (`.html`)
- Datos propios de la sesión (`.xlsx`, `.RData`) cuando no están en `data/`
- Gráficas generadas durante la sesión (`.png`, `.jpg`)

| Carpeta | Contenido |
|---|---|
| `data/` | Datos compartidos entre clases (INEGI, Banxico) |
| `utils/` | Funciones utilitarias reutilizables (`Lag_Opt_*`, `arroots`, etc.) |
| `Clase_IntroR/` | Introducción al lenguaje R |
| `Clase_ToolBox/` | Herramientas complementarias (LLMs, GPT API) |
| `Clase_00/` | Motivación y ejemplos de series de tiempo |
| `Clase_01/`–`Clase_20/` | Temas del temario (ver abajo) |
| `Clase_21/` | Datos Panel: pruebas de raíz unitaria (IPS, LLC) |
| `Clase_21b/` | Datos Panel: Diferencias en Diferencias (DiD) |
| `Clase_22/` | Panel VAR(p) |
| `Clase_23/` | Modelos de Cambio de Régimen (TAR) |

## Recursos del curso

1. **Notas de clase:** https://benjov.github.io/Series-Tiempo/index.html
2. **Este repositorio** (scripts y R Markdown): clonar y actualizar con `git pull`
3. **Google Drive** (temario, tareas, exámenes, bibliografía): https://drive.google.com/drive/folders/1hIO60B2-7wxbZ5C00myFlYL_hNVdGpDt?usp=sharing
4. **Pizarras de clase:** https://gamesecon-my.sharepoint.com/:o:/p/boliva/IgCs7koSvNxhQrj7aQW35ujrAVF0mQqV3B4OCF2PnyJRsco?e=StVEMs
5. **Grabaciones de clase:** https://www.youtube.com/playlist?list=PLlCKfRj1U6Swy56X0WAHPhQS4WhA_P-9U

## Temario

### 1. Introducción al Análisis de Series de Tiempo
- La naturaleza de los datos de series de tiempo
- Ejemplos y aplicaciones

### 2. Elementos de Ecuaciones en Diferencia
- Ecuaciones en diferencia homogéneas de primer orden y órdenes superiores
- Operadores de rezago y sus representaciones
- Representación de algunos procesos divergentes

### 3. Procesos Estacionarios Univariados
- Procesos Autorregresivos AR(p)
- Procesos de Medias Móviles MA(q)
- Procesos ARMA(p, q) y ARIMA(p, d, q)
- Función de Autocorrelación, Función de Autocorrelación Parcial y Pronósticos

### 4. Modelos Univariados de Volatilidad
- Modelos ARCH y GARCH
- Otros modelos de volatilidad

### 5. Procesos No Estacionarios
- Definición y formas de no estacionariedad
- Eliminación de la tendencia
- Pruebas de Raíz Unitaria: Dickey-Fuller, ADF, Phillips-Perron y de Cambio Estructural
- Descomposición de series de tiempo (filtros)

### 6. Procesos de Vectores Autorregresivos
- Causalidad de Granger
- Definición y representación del sistema VAR
- Análisis de Impulso-Respuesta (identificación de innovaciones estructurales)
- Modelos VAR(1), VAR(2) y VAR(p)
- Representación de Medias Móviles

### 7. Cointegración
- Definición y propiedades del proceso de cointegración
- Cointegración de modelos de una ecuación
- Cointegración de modelos VAR
- Cointegración y la teoría económica

### 8. Modelos Multivariados de Volatilidad
- M-ARCH y M-GARCH

### 9. Modelos ARDL

### 10. Modelos de Datos Panel y Panel VAR

### 11. Otros Modelos No Lineales
- Modelos de cambio de régimen
