#' Lag_Opt_GARCH
#'
#' Selecciona el orden óptimo (q, p) de un sGARCH(q, p) por criterio AIC,
#' usando distribución t de Student para los errores.
#'
#' @param X_t    Vector numérico. Serie de rendimientos o residuales a modelar.
#' @param q_max  Entero. Orden máximo del componente ARCH (rezagos de ε²).
#' @param p_max  Entero. Orden máximo del componente GARCH (rezagos de σ²).
#'
#' @return Matriz con columnas (q, p, AIC, Optimo).
#'         La columna Optimo vale 1 en la fila con AIC mínimo.
#'
#' @details Ajusta modelos sGARCH con media ARMA(0,0) y distribución "std"
#'          (t de Student) usando ugarchfit() del paquete rugarch.
#'          El AIC se extrae con infocriteria(model)[1].
#'
#' @examples
#' rendimientos <- diff(log(precio))
#' resultado <- Lag_Opt_GARCH(X_t = rendimientos, q_max = 3, p_max = 3)
#' resultado[resultado[, "Optimo"] == 1, ]
Lag_Opt_GARCH <- function(X_t, q_max, p_max){

  library(rugarch)
  # X_t: Serie de Tiempo modelada
  Criterio_AIC <- matrix(rep(0, 4*((q_max)*p_max)), ncol = 4)
  colnames(Criterio_AIC) <- c("q", "p", "AIC", "Optimo")
  grupo <- 1
  for(i in 1:p_max){
    for(j in 1:q_max){
      Criterio_AIC[grupo,1] <- i
      Criterio_AIC[grupo,2] <- j
      model.spec = ugarchspec(variance.model = list(model = 'sGARCH' , 
                                                    garchOrder = c(i,j)), 
                              mean.model = list(armaOrder = c(0,0)), 
                              distribution.model = "std")
      model <- ugarchfit(spec = model.spec, data = X_t)
      
      Criterio_AIC[grupo,3] <- infocriteria(model)[1]
      
      grupo <- grupo + 1
    }
  }
  Optimo <- min(Criterio_AIC[1:(p_max*q_max),3])
  for(i in 1:(p_max*q_max)){
    if(Criterio_AIC[i,3] == Optimo){
      Criterio_AIC[i,4] <- 1
    }
  }
  return(Criterio_AIC)
  #
}