######################################
# Pretratamiento de los datos
# Se podran realizar las siguientes operaciones de forma opcional
# Es recomendable ajustar los parametros segun los resultados del 
# control de calidad

if (type=="array"){

  # Normalizacion
  
  data<-rma(rawdata)
  
  # Opcional: generar un informe de calidad de los datos
  
  arrayQualityMetrics(data_norm, outdir="results/arrayQualityMetrics_report")
  
}else if(type=="seq"){
  
  data <- filterAndTrim(rawdata, truncLen=c(240,160),
                       maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                       compress=TRUE, multithread=FALSE)
  
}else if(type=="MS"){
  
  # Se define el metodo de recuento:
  
  qmethod <- "NSAF" # Cambiar segun la documentacion
  
  data.quant <- quantify(rawdata, method = qmethod)
  
  # Se guardan los datos de intensidad en un dataframe
  
  data<-data.frame(Signal = rowSums(exprs(data.quant)))
  
}