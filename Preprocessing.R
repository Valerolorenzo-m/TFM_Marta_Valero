######################################
# Pretratamiento de los datos
# Se podran realizar las siguientes operaciones de forma opcional
# Es recomendable ajustar los parametros segun los resultados del 
# control de calidad

# Para datos de espectrometría de masas, seleccionar el método
# de cuantificación y los reporters:

qmethod <- "NSAF" # Cambiar segun la documentacion
rep <- reporters # A cambiar por el usuario

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
   
  data.quant <- quantify(rawdata, reporters = rep, method = qmethod) 
  
  # Para operar con el paquete "DEP", en primer lugar 
  # se convierte el MsnSet a un objeto de tipo SummarizedExperiment
  
  data.se <- as(data.quant, "SummarizedExperiment")
  
  # Se filtran los datos NA, y se normalizan los datos
  
  data.filt <- filter_missval(data.se, thr = 0)
  data <- normalize_vsn(data.filt)

}
