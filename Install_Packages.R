##################################################
# En primer lugar, se requiere instalar y cargar los paquetes
# necesarios. 
# Este paso es largo y requiere tiempo pero la primera parte
# (instalación) solamente necesita ser ejecutado una vez

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
library(BiocManager)
BiocManager::install("RforProteomics", dependencies = TRUE)
BiocManager::install("oligo")
BiocManager::install("ShortRead")
BiocManager::install("Rsubread")

# Ejecutar en cada sesión

library(oligo)
library(mzR)
library(MSnbase)
library(ShortRead)
library(Rsubread)

###################################

# Elegir el directorio de trabajo

dir<-"~/." # Se puede seleccionar por el usuario
setwd(dir)

# Crear una carpeta "data" y una carpeta "results" en el 
# directorio de trabajo

dir.create("data")
dir.create("results")


