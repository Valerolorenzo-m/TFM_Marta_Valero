##############################################
# Análisis funcional: alineamiento de los datos

if (type=="array"){
  
  # Se define la función "annotatedTopTable"
  # Para un objeto topTab y un paquete de anotación
  annotatedTopTable <- function(topTab, anotPackage)
  {
    # Se crea el objeto topTab, igual al inicial pero con una nueva columna
    # en su inicio, correspondiente a los nombres de las filas (nombres de los
    # genes según el desarrollador del array)
    topTab <- cbind(PROBEID=rownames(topTab), topTab)
    # Se define myProbes como el nombre de los genes a analizar
    myProbes <- rownames(topTab)
    # Se define thePackage como el contenido del paquete de anotación
    thePackage <- eval(parse(text = anotPackage))
    # Se seleccionan los genes en el paquete
    geneAnots <- select(thePackage, myProbes, c("SYMBOL", "ENTREZID", "GENENAME"))
    # El resultado se dará al combinar la búsqueda con la columna de identificadores 
    # creada al inicio de la tabla (PROBEID)
    annotatedTopTab<- merge(x=geneAnots, y=topTab, by.x="PROBEID", by.y="PROBEID")
    return(annotatedTopTab)
  }
  
}else if(type=="seq"){
  
  # Se realiza el alineamiento
  
  align(index=indexgenome, readfiles1= rawdata)
  
  # Se guarda el nombre de los archivos .bam generados
  
  bam.files <- list.files("data", pattern = ".BAM$", full.names = TRUE, ignore.case = TRUE)
  
  # Se genera el archivo de "counts"
  
  data_aligned<-featureCounts(bam.files, annot.inbuilt="indexgenome")
  
}else if(type=="MS"){
  
}

