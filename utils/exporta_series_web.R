#' Exporta las series de Clase_00 al sitio del curso
#'
#' Genera `assets/data/series.js`, el archivo que alimenta las graficas de las
#' diapositivas de la Sesion 1 (`clase-01.html`). Se escribe como script de
#' JavaScript —y no como JSON— para que la presentacion tambien funcione
#' abriendo el archivo directamente desde el disco, sin servidor local.
#'
#' Uso: correr desde la raiz del repositorio
#'   Rscript utils/exporta_series_web.R
#'
#' @details Fuente: `Clase_00/Base_1_TimeSeries.xlsx` (INEGI, Banco de Mexico y
#'   Bolsa Mexicana de Valores), mensual desde enero de 2002. Al actualizar esa
#'   base basta con volver a correr este script para que las graficas del sitio
#'   queden al dia.

library(readxl)
library(jsonlite)

entrada <- "Clase_00/Base_1_TimeSeries.xlsx"
salida  <- "assets/data/series.js"

if (!file.exists(entrada)) {
  stop("No se encontro ", entrada, ". Corre el script desde la raiz del repositorio.")
}

Base_1 <- as.data.frame(read_excel(entrada, sheet = "Hoja 1", col_names = TRUE))

redondea <- function(x, d) round(as.numeric(x), d)

datos <- list(
  meta = list(
    inicio     = Base_1$Periodo[1],
    fin        = Base_1$Periodo[nrow(Base_1)],
    n          = nrow(Base_1),
    frecuencia = 12,
    fuente     = "INEGI, Banco de Mexico y Bolsa Mexicana de Valores",
    origen     = entrada
  ),
  periodo   = Base_1$Periodo,
  igae      = redondea(Base_1$IGAE_2018, 3),
  igae_prim = redondea(Base_1$IGAE_PRIM_2018, 3),
  icc       = redondea(Base_1$ICC, 3),
  icc_lag   = redondea(Base_1$ICC_LAG, 3),
  ipc       = redondea(Base_1$IPC_BMV, 2),
  tdc       = redondea(Base_1$TDC, 4)
)

js <- paste0(
  "// Series generadas desde ", entrada, " (INEGI, Banxico, BMV).\n",
  "// No editar a mano: regenerar con utils/exporta_series_web.R\n",
  "window.SERIES = ", toJSON(datos, auto_unbox = TRUE, digits = NA), ";\n"
)

writeLines(js, salida, useBytes = TRUE)
cat("Escrito:", salida, "-", nrow(Base_1), "observaciones de",
    datos$meta$inicio, "a", datos$meta$fin, "\n")
