######################################################
# Cargar los datos de trabajo:
# En primer lugar, seleccionar el tipo de datos.
# Para ello, cambiar el tipo de datos ("type") según lo siguiente:
# Para datos de microarray: "array"
# Para datos de secuenciación: "seq"
# Para datos de espectrometría: "MS"

type<-"array" # A cambiar por el usuario

# En caso de datos genómicos/transcriptómicos, 
# se debe fijar el tipo de datos ("DNA"/"RNA"):

nucleic.acid<-"DNA" # A cambiar por el usuario

# Posteriormente, se debe introducir el nombre del archivo
# que contenga los datos fenotípicos en su caso

pheno<-"namepheno.csv" # A cambiar por el usuario
phdata<-read.AnnotatedDataFrame(pheno)

# En caso de tratarse de análisis de datos de secuenciación, 
# se debe aportar el archivo para la creación del índice

genome<- "namegenome.fa" # A cambiar por el usuario

##########

if (type=="array"){ # Si los datos proceden de un array
  
  # Se comprueba la extensión de los archivos de datos
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
  
  # Se crea el genoma índice para el alineamiento
  
  buildindex("indexgenome", genome)
  
} else if(type=="MS"){ # Si los datos son de espectrometría
  
  names <- list.files(filepath, pattern=".mzML",
                      full.names=TRUE, ignore.case=TRUE)
  rawdata<- readMSData(names, pdata = phdata)
} 

# Resultado: un objeto "rawdata" que será empleado en análisis posteriores.
