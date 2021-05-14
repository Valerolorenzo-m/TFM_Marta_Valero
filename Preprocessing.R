######################################
# Pretratamiento de los datos
# Se podran realizar las siguientes operaciones de forma opcional
# Es recomendable ajustar los parametros segun los resultados del 
# control de calidad


if (type=="array"){

  # Normalizacion
  
  data<-rma(rawdata)
  
  
}else if(type=="seq"){
  
  data <- filterAndTrim(rawdata, truncLen=c(240,160),
                       maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                       compress=TRUE, multithread=FALSE)
  
}else if(type=="MS"){
  
  # Se filtran los NA, y se normalizan los datos
  
  data.filt <- filter_missval(rawdata, thr = 0)
  data <- normalize_vsn(data.filt)

}
