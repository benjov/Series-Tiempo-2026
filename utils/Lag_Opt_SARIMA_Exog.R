#' Lag_Opt_SARIMA_Exog
#'
#' Selecciona el orden óptimo (p, q, P, Q) de un SARIMA(p,i,q)(P,I,Q)_m por
#' criterio AIC, con soporte opcional para variables exógenas.
#'
#' @param p_max  Entero. Orden máximo del componente AR no estacional.
#' @param q_max  Entero. Orden máximo del componente MA no estacional.
#' @param P_max  Entero. Orden máximo del componente AR estacional.
#' @param Q_max  Entero. Orden máximo del componente MA estacional.
#' @param X_t    Vector numérico. Serie de tiempo dependiente.
#' @param Ex     Indicador lógico (0/1). 1 = incluir variables exógenas; 0 = modelo puro.
#' @param Z_t    Vector o matriz de variables exógenas. Ignorado si Ex == 0.
#'
#' @return Matriz con columnas (Rezago p, Rezago q, Rezago P, Rezago Q, AIC, Optimo).
#'         La columna Optimo vale 1 en la fila con AIC mínimo.
#'
#' @details Evalúa la grilla completa p×q×(P+1)×(Q+1). El periodo estacional m
#'          se hereda de X_t si es objeto ts (e.g., freq=12 para mensual).
#'          La diferenciación (i, I) debe aplicarse antes de llamar esta función.
#'          Advertencia: el número de modelos evaluados crece rápidamente;
#'          valores grandes de p_max, q_max, P_max, Q_max pueden ser lentos.
#'
#' @examples
#' # Búsqueda en grilla pequeña, sin exógenas
#' resultado <- Lag_Opt_SARIMA_Exog(2, 2, 1, 1, X_t = serie_est, Ex = 0, Z_t = NULL)
#' resultado[resultado[, "Optimo"] == 1, ]
Lag_Opt_SARIMA_Exog <- function(p_max, q_max, P_max, Q_max, X_t, Ex, Z_t){
  
  if(Ex == 0){
    Criterio_AIC <- matrix(rep(0, 6*(p_max*q_max*(P_max+1)*(Q_max+1))), ncol = 6)
    colnames(Criterio_AIC) <- c("Rezago p", "Rezago q","Rezago P", "Rezago Q", "AIC", "Optimo")
    grupo <- 1
    
    for(i in 1:p_max){
      for(j in 1:q_max){
        for(k in 0:P_max){
          for (m in 0:Q_max){
            Criterio_AIC[grupo,1] <- i
            Criterio_AIC[grupo,2] <- j
            Criterio_AIC[grupo,3] <- k
            Criterio_AIC[grupo,4] <- m
            Criterio_AIC[grupo,5] <- AIC(arima(X_t, order = c(i, 0, j), 
                                               seasonal = c(k, 0, m), method = "ML"))
            grupo = grupo+1
            
          }
        }
      }
    }      
    
    Criterio_AIC[Criterio_AIC[,5] == min(Criterio_AIC[,5]),6] = 1
    
    return(Criterio_AIC)
    #
  } else {
    Criterio_AIC <- matrix(rep(0, 6*(p_max*q_max*(P_max+1)*(Q_max+1))), ncol = 6)
    colnames(Criterio_AIC) <- c("Rezago p", "Rezago q","Rezago P", "Rezago Q", "AIC", "Optimo")
    grupo <- 1
    for(i in 1:p_max){
      for(j in 1:q_max){
        for(k in 0:P_max){
          for(m in 0:Q_max){
            Criterio_AIC[grupo,1] <- i
            Criterio_AIC[grupo,2] <- j
            Criterio_AIC[grupo,3] = k
            Criterio_AIC[grupo,4] <- m
            Criterio_AIC[grupo,5] <- AIC(arima(X_t, order = c(i, 0, j), 
                                               seasonal = c(k, 0, m), 
                                               xreg = Z_t, method = "ML"))
            grupo = grupo+1
            
          }
        }
      }
    }
    Criterio_AIC[Criterio_AIC[,5] == min(Criterio_AIC[,5]),6] = 1
    return(Criterio_AIC)
  }
  
}

