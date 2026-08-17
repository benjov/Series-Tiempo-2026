# Series de Tiempo — Semestre 2027-I

Repositorio de scripts, notebooks y materiales de apoyo para el curso **Análisis de Series de Tiempo** (semestre 2027-I) de la Facultad de Economía, UNAM.

## Sitio del curso

**https://benjov.github.io/Series-Tiempo-2026/**

- Portada con temario, índice de las 28 sesiones (enlazadas a los notebooks ya renderizados), evaluación y recursos.
- **Diapositivas de la Sesión 1** (`clase-01.html`): presentación de introducción al curso, con las gráficas generadas a partir de los datos de `Clase_00`. Funciona sin conexión, se navega con las flechas y se exporta a PDF imprimiendo la página.

## Descripción del repositorio

Cada carpeta corresponde a una sesión del curso. Los datos y funciones compartidos entre varias clases se centralizan en `data/` y `utils/`; las carpetas de clase incluyen:

- Notebooks de R Markdown (`.Rmd`) y su versión renderizada (`.html`)
- Datos propios de la sesión (`.xlsx`, `.RData`) cuando no están en `data/`
- Gráficas generadas durante la sesión (`.png`, `.jpg`)

| Carpeta | Contenido |
|---|---|
| `data/` | Datos compartidos entre clases (INEGI, Banxico) |
| `utils/` | Funciones utilitarias reutilizables (`Lag_Opt_*`, `arroots`, etc.) |
| `assets/` | Hojas de estilo, JavaScript y datos del sitio del curso (GitHub Pages) |
| `Temario/` | Temario oficial del semestre en PDF |
| `Clase_IntroR/` | Introducción al lenguaje R |
| `Clase_ToolBox/` | Herramientas complementarias (LLMs, GPT API) |
| `Clase_00/` | Motivación y ejemplos de series de tiempo |
| `Clase_01/`–`Clase_20/` | Temas del temario (ver abajo) |
| `Clase_21/` | Datos Panel: pruebas de raíz unitaria (IPS, LLC) |
| `Clase_21b/` | Datos Panel: Diferencias en Diferencias (DiD) |
| `Clase_22/` | Panel VAR(p) |
| `Clase_23/` | Modelos de Cambio de Régimen (TAR) |

## Recursos del curso

1. **Sitio del curso** (temario, sesiones y diapositivas): https://benjov.github.io/Series-Tiempo-2026/
2. **Notas de clase:** https://benjov.github.io/Series-Tiempo/index.html
3. **Este repositorio** (scripts y R Markdown): clonar y actualizar con `git pull`
4. **Google Drive** (temario, tareas, exámenes, bibliografía): https://drive.google.com/drive/folders/1hIO60B2-7wxbZ5C00myFlYL_hNVdGpDt?usp=sharing
5. **Pizarras de clase:** https://gamesecon-my.sharepoint.com/:o:/p/boliva/IgCs7koSvNxhQrj7aQW35ujrAVF0mQqV3B4OCF2PnyJRsco?e=StVEMs
6. **Grabaciones de clase:** https://www.youtube.com/playlist?list=PLlCKfRj1U6Swy56X0WAHPhQS4WhA_P-9U

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

## Mantenimiento del sitio

El sitio se publica con GitHub Pages desde la **raíz de la rama `main`**
(*Settings → Pages → Deploy from a branch → main / (root)*). Archivos que lo componen:

| Archivo | Función |
|---|---|
| `index.html` | Portada del curso: temario, índice de sesiones, evaluación y recursos |
| `clase-01.html` | Diapositivas de la Sesión 1 |
| `assets/css/base.css` | Tokens de color, tipografía y estilos de las gráficas |
| `assets/css/site.css` | Estilos de la portada |
| `assets/css/slides.css` | Estilos de las diapositivas |
| `assets/js/charts.js` | Gráficas de línea en SVG (sin dependencias externas) |
| `assets/js/slides.js` | Navegación de las diapositivas |
| `assets/js/theme.js` | Tema claro / oscuro |
| `assets/data/series.js` | Series de `Clase_00` usadas por las gráficas |
| `.nojekyll` | Publica los archivos tal cual, sin procesarlos con Jekyll |

Al actualizar `Clase_00/Base_1_TimeSeries.xlsx`, regenerar los datos del sitio con:

```bash
Rscript utils/exporta_series_web.R
```

No hay paso de compilación: basta con hacer `git push` para que los cambios queden publicados.
GitHub tarda unos minutos en reconstruir el sitio, así que conviene empujar con margen antes de
la clase. Todo funciona también abriendo los archivos directamente desde el disco, sin conexión.

### Cómo usar las diapositivas

| Tecla | Acción |
|---|---|
| `→` `espacio` / `←` | Avanzar / retroceder (los puntos marcados aparecen uno a uno) |
| `Inicio` / `Fin` | Primera / última diapositiva |
| `o` | Índice de diapositivas |
| `f` | Pantalla completa |
| `t` | Tema claro / oscuro |
| `c` | Cronómetro de la sesión |
| `?` | Ayuda |

Las gráficas son interactivas: al pasar el puntero se muestra el valor de cada serie en el mes
señalado. Para exportar a PDF, imprimir la página (⌘P) en horizontal y con "gráficos de fondo"
activado: cada diapositiva sale en su propia página de 16:9.

### Cómo hacer diapositivas de otra sesión

El motor es genérico, así que una presentación nueva es un HTML que copia la estructura de
`clase-01.html`:

1. Copiar `clase-01.html` con otro nombre (por ejemplo `clase-13.html`).
2. Cada lámina es una `<section class="slide" data-title="…">`; el `data-title` es lo que
   aparece en el índice. La portada y el cierre llevan además la clase `cover`.
3. Dentro de la lámina: `.kicker` (etiqueta superior), `<h2>` (título), `.dek` (entrada),
   `.body` (contenido) y `.note` (la línea al pie). Para maquetar hay `.two`, `.three`,
   `.stack`, `.panel`, `.panel.accent`, `.qcard` y tablas simples.
4. Un elemento con clase `frag` aparece hasta el siguiente avance; sirve para construir la
   lámina por partes.
5. Para una gráfica: un `<div id="mi-grafica">` y una llamada a `Charts.line()` al final del
   archivo. Recibe `periods`, `series` (hasta tres, con `c: 1|2|3` para el color) y opciones de
   ejes; `Charts.indexar()` y `Charts.diffLog()` transforman una serie antes de graficarla.
6. Enlazar la presentación desde `index.html`.

Los colores de serie (`--s1` azul, `--s2` naranja, `--s3` verde) están validados para contraste
y daltonismo en ambos temas: conviene usarlos en ese orden y no meter una cuarta serie en la
misma gráfica.
