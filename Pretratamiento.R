######################################
# Pretratamiento de los datos
# Se podrán realizar las siguientes operaciones de forma opcional
# Es recomendable ajustar los parámetros según los resultados del 
# control de calidad

if (type=="array"){

  # Normalización
  
  data<-rma(rawdata)
  
  # Opcional: generar un informe de calidad de los datos
  
  arrayQualityMetrics(data_norm, outdir="results/arrayQualityMetrics_report")
  
}else if(type=="seq"){
  
  data <- filterAndTrim(rawdata, truncLen=c(240,160),
                       maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                       compress=TRUE, multithread=FALSE)
  
}else if(type=="MS"){
  
}