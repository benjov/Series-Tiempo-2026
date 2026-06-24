#' Lag_Opt_ARIMA_Exog
#'
#' Selecciona el orden óptimo (p, q) de un ARIMA(p, i, q) por criterio AIC,
#' con soporte opcional para variables exógenas (modelos ARIMAX).
#'
#' @param p_max  Entero. Orden máximo del componente AR a evaluar.
#' @param q_max  Entero. Orden máximo del componente MA a evaluar.
#' @param X_t    Vector numérico. Serie de tiempo dependiente.
#' @param Ex     Indicador lógico (0/1). 1 = incluir variables exógenas; 0 = modelo puro.
#' @param Z_t    Vector o matriz de variables exógenas. Ignorado si Ex == 0.
#'
#' @return Matriz con columnas (Rezago p, Rezago q, AIC, Optimo).
#'         La columna Optimo vale 1 en la fila con AIC mínimo.
#'
#' @details Evalúa todos los modelos ARIMA(p, 0, q) con p en 1:p_max y q en 1:q_max.
#'          La diferenciación (componente i) debe aplicarse a X_t antes de llamar
#'          esta función. Estimación por máxima verosimilitud (method = "ML").
#'
#' @examples
#' # Selección óptima sin exógenas para una serie diferenciada
#' resultado <- Lag_Opt_ARIMA_Exog(p_max = 4, q_max = 4, X_t = diff(serie), Ex = 0, Z_t = NULL)
#' resultado[resultado[, "Optimo"] == 1, ]
Lag_Opt_ARIMA_Exog <- function(p_max, q_max, X_t, Ex, Z_t){
    
    if(Ex == 0){
      Criterio_AIC <- matrix(rep(0, 4*(p_max*q_max)), ncol = 4)
      colnames(Criterio_AIC) <- c("Rezago p", "Rezago q", "AIC", "Optimo")
      grupo <- 0
      for(i in 1:p_max){
        for(j in (1 + grupo):(q_max + grupo)){
          Criterio_AIC[j,1] <- i
          Criterio_AIC[j,2] <- j - grupo
          Criterio_AIC[j,3] <- AIC(arima(X_t, order = c(i, 0, (j - grupo)), method = "ML"))
        }
        grupo <- grupo + q_max
      }
      Optimo <- min(Criterio_AIC[1:(p_max*q_max),3])
      for(i in 1:(p_max*q_max)){
        if(Criterio_AIC[i,3] == Optimo){
          Criterio_AIC[i,4] <- 1
        }
      }
      return(Criterio_AIC)
#
    } else {
      Criterio_AIC <- matrix(rep(0, 4*(p_max*q_max)), ncol = 4)
      colnames(Criterio_AIC) <- c("Rezago p", "Rezago q", "AIC", "Optimo")
      grupo <- 0
      for(i in 1:p_max){
        for(j in (1 + grupo):(q_max + grupo)){
          Criterio_AIC[j,1] <- i
          Criterio_AIC[j,2] <- j - grupo
          Criterio_AIC[j,3] <- AIC(arima(X_t, order = c(i, 0, (j - grupo)), xreg = Z_t, method = "ML"))
        }
        grupo <- grupo + q_max
      }
      Optimo <- min(Criterio_AIC[1:(p_max*q_max),3])
      for(i in 1:(p_max*q_max)){
        if(Criterio_AIC[i,3] == Optimo){
          Criterio_AIC[i,4] <- 1
        }
      }
      return(Criterio_AIC)
    }
  }
