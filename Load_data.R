######################################################
# Cargar los datos de trabajo:
# En primer lugar, seleccionar el tipo de datos.
# Para ello, cambiar el tipo de datos ("type") segun lo siguiente:
# Para datos de microarray: "array"
# Para datos de secuenciacion: "seq"
# Para datos de espectrometria: "MS"

type<-"array" # A cambiar por el usuario

# Posteriormente, se debe introducir el nombre del archivo
# que contenga los datos fenotipicos en su caso

pheno<-"namepheno.csv" # A cambiar por el usuario
phdata<-read.AnnotatedDataFrame(pheno)

# En caso de datos procedentes de array, fijar el nombre
# del array utilizado

array.name<-"array.name.db" # A cambiar por el usuario

# En caso de tratarse de analisis de datos de secuenciacion, 
# se debe aportar el archivo para la creacion del indice

genome<- "namegenome.fa" # A cambiar por el usuario

# Para datos de espectrometría de masas, seleccionar el método
# de cuantificación y los reporters:

qmethod <- "NSAF" # Cambiar segun la documentacion
rep <- reporters # A cambiar por el usuario

######################

if (type=="array"){ # Si los datos proceden de un array
  
  # Se comprueba la extension de los archivos 
  
  ex.cel <- grepl("*.cel$", ignore.case = TRUE)
  ex.txt <- grepl("*.txt$", ignore.case = TRUE)
  
  # Si los datos tienen formato .cel
  
  if (ex.cel){
    names<-list.celfiles("data",full.names = TRUE)
    
    # Se crea el archivo de datos
    rawdata<-read.celfiles(names, phenoData=phdata)
    
  }else if (ex.txt){ # Si los datos tienen formato .txt
    
    names<-list.files("data", pattern = "*.txt$", full.names = TRUE, ignore.case = TRUE)
    files<-read.AnnotatedDataFrame(names)
    
    # Se crea el archivo de datos
    rawdata<-ExpressionSet(files, phenoData = phdata)
  }
  
} else if(type=="seq"){
  
  # Se crea una lista de los archivos en formato fastq. 
  # Este paso es necesario para pasos posteriores.
  
  names<-list.files("data", pattern = "*.fastq$", full.names= TRUE, ignore.case = TRUE)
  
  # Se cargan los datos
  
  rawdata<- readFastq("data")
  
  # Se crea el genoma indice para el alineamiento
  
  buildindex("indexgenome", genome)
  
} else if(type=="MS"){ # Si los datos son de espectrometria
  
  names <- list.files(filepath, pattern=".mzML",
                      full.names=TRUE, ignore.case=TRUE)
  data<- readMSData(names, pdata = phdata)
  
   # Se define el metodo de recuento:
   
  data.quant <- quantify(rawdata, reporters = rep, method = qmethod) 
  
  # Para operar con el paquete "DEP", en primer lugar 
  # se convierte el MsnSet a un objeto de tipo SummarizedExperiment
  
  rawdata <- as(data.quant, "SummarizedExperiment")
} 

# Resultado: un objeto, "rawdata", que sera empleado en analisis posteriores.
