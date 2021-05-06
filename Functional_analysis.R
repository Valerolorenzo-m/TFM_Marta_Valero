##############################################
# Analisis funcional: alineamiento de los datos
# Determinacion de genes diferencialmente expresados/presentes

# En el caso de microarrays:
# Definir las matrices de diseño y de contrastes:

groups<-c() # Un vector con los grupos. A completar por el usuario
matriz_dis<- model.matrix(~ 0 + groups)
colnames(matriz_dis)<-levels(groups)
matriz_cont<-makeContrasts( , levels = matriz_dis) # A definir por el usuario
contrasts<-c() # Crear un vector con los nombres de los contrastes
               # (Deben coincidir con sus nombres en la matriz)
contraste_int<- # Seleccionar el contraste de interes ("casos")
universo<- # Definir el universo de genes a testar

# En el caso de secuencias:

organism<-"organismo.db" # A completar por el usuario
groups<-phdata$ # Guardar a partir del objeto phdata los grupos de interés

##############################

if (type=="array"){
  
  annotation(data) <- array.name #Cambiar 
  
  # Alinea los resultados del array a los genes incluidos en el mismo
  # y filtra los resultados con mayor varianza 
  # es decir, genes expresados o variantes presentes en la muestra
  
  data_filtered <- nsFilter(data,var.cutoff=0.75,
                       filterByQuantile=TRUE)
  eset_filtered<-data_filtered$eset
  
  # Se ajusta el modelo
  
  mod<-lmFit(eset_filtered, matriz_dis)
  modelo<-contrasts.fit(mod, matriz_cont)
  modelo<-eBayes(modelo)
  
  # Se crean a partir del modelo objetos TopTable para cada contraste:
  
  data_annot<-topTable (modelo, number=nrow(modelo), coef=contraste_int)
  
  # Se asocian los genes presentes en el objeto topTab a sus ID (anotación):
  
  whichGenes<-data_annot["adj.P.Val"]<0.15
  selectedIDs <- rownames(data_annot)[whichGenes]
  EntrezIDs<- select(array.name, selectedIDs, c("ENTREZID"))
  EntrezIDs <- EntrezIDs$ENTREZID
  names(data_annot)<-names(EntrezIDs)
  
}else if(type=="seq"){
  
  # Se realiza el alineamiento
  
  align(index=indexgenome, readfiles1= rawdata)
  
  # Se guarda el nombre de los archivos .bam generados
  
  bam.files <- list.files("data", pattern = ".BAM$", full.names = TRUE, ignore.case = TRUE)
  
  # Se genera el archivo de "counts"
  
  count_data<-featureCounts(bam.files, annot.inbuilt="indexgenome")
  counts<-count_data$counts
  
  # Se guardan los nombres de las filas como los ID 
  
  rownames(counts)<-count_data$annotation[1]
  
  # Se crea un archivo DGEList
  
  data_aligned<-DGEList(counts)
  
  # Se añade la informacion fenotipica
  
  data_aligned$samples$group<-groups
  
  # Se anotan los genes para añadir su nombre completo y reducido (symbol)
  
  annotation <- select(organism,keys=rownames(data_aligned$counts),columns=c("ENTREZID","SYMBOL","GENENAME"))
  data_aligned$genes<-annotation
  data_annotated<-data_aligned
  
  if (nucleic.acid=="RNA"){
    
    # Se filtran los genes poco expresados
    
    CPM <- cpm(data_annotated)
    threshold<- CPM > 0.5
    
    # Mantenemos los genes que al menos presentan dos entradas con CMP>0.5
    
    keep <- rowSums(thresh) >= 2
    data_annotated<-keep
    
  }else{
    
    data_annotated<-data_annotated}
  
}else if(type=="MS"){
  
  
  
}

