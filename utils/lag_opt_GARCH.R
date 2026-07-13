#' Lag_Opt_GARCH
#'
#' Selecciona el orden óptimo (q, p) de un sGARCH(q, p) por criterio AIC,
#' usando distribución t de Student para los errores.
#'
#' @param X_t    Vector numérico. Serie de rendimientos o residuales a modelar.
#' @param q_max  Entero. Orden máximo del componente ARCH (rezagos de ε²).
#' @param p_max  Entero. Orden máximo del componente GARCH (rezagos de σ²).
#' @param arma   Vector de dos enteros. Orden (p, q) del ARMA de la media
#'               condicional. Default c(0, 0) (media constante).
#'
#' @return Matriz con columnas (q, p, AIC, Optimo).
#'         La columna Optimo vale 1 en la fila con AIC mínimo.
#'         Si un modelo no converge, su AIC se reporta como NA.
#'
#' @details Ajusta modelos sGARCH con media ARMA(arma) y distribución "std"
#'          (t de Student) usando ugarchfit() del paquete rugarch con
#'          solver = "hybrid". Cada ajuste va dentro de un tryCatch, de modo
#'          que un fallo de convergencia no detiene la búsqueda: el modelo
#'          problemático queda con AIC = NA y se excluye del óptimo.
#'          El AIC se extrae con infocriteria(model)[1].
#'
#' @examples
#' rendimientos <- diff(log(precio))
#' resultado <- Lag_Opt_GARCH(X_t = rendimientos, q_max = 3, p_max = 3)
#' resultado[resultado[, "Optimo"] == 1, ]
#' # Con media condicional AR(2):
#' resultado <- Lag_Opt_GARCH(X_t = rendimientos, q_max = 4, p_max = 4, arma = c(2, 0))
Lag_Opt_GARCH <- function(X_t, q_max, p_max, arma = c(0, 0)){

  library(rugarch)
  # X_t: Serie de Tiempo modelada
  Criterio_AIC <- matrix(rep(0, 4 * (q_max * p_max)), ncol = 4)
  colnames(Criterio_AIC) <- c("q", "p", "AIC", "Optimo")
  grupo <- 1

  for(i in 1:p_max){
    for(j in 1:q_max){
      Criterio_AIC[grupo, 1] <- i
      Criterio_AIC[grupo, 2] <- j

      model.spec <- ugarchspec(
        variance.model = list(model = "sGARCH", garchOrder = c(i, j)),
        mean.model     = list(armaOrder = arma),
        distribution.model = "std"
      )

      # tryCatch evita que un fallo de convergencia detenga el loop
      aic_val <- tryCatch({
        model <- ugarchfit(spec = model.spec, data = X_t, solver = "hybrid")
        infocriteria(model)[1]
      }, error = function(e) NA_real_)

      Criterio_AIC[grupo, 3] <- aic_val
      grupo <- grupo + 1
    }
  }

  Optimo <- min(Criterio_AIC[1:(p_max * q_max), 3], na.rm = TRUE)
  for(i in 1:(p_max * q_max)){
    if(!is.na(Criterio_AIC[i, 3]) && Criterio_AIC[i, 3] == Optimo){
      Criterio_AIC[i, 4] <- 1
    }
  }
  return(Criterio_AIC)
}
