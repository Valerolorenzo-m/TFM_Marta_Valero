##############################################
# Analisis funcional: alineamiento de los datos

if (type=="array"){
  
  annotation(data) <- "hgu133plus2.db" #Cambiar 
  
  # Alinea los resultados del array a los genes incluidos en el mismo
  # y filtra los resultados con mayor varianza 
  # es decir, genes expresados o variantes presentes en la muestra
  
  data_aligned <- nsFilter(data,var.cutoff=0.75,
                       filterByQuantile=TRUE)
  
}else if(type=="seq"){
  
  # Se realiza el alineamiento
  
  align(index=indexgenome, readfiles1= rawdata)
  
  # Se guarda el nombre de los archivos .bam generados
  
  bam.files <- list.files("data", pattern = ".BAM$", full.names = TRUE, ignore.case = TRUE)
  
  # Se genera el archivo de "counts"
  
  data_aligned<-featureCounts(bam.files, annot.inbuilt="indexgenome")
  
}else if(type=="MS"){
  
  
  
}

