##################################################
# En primer lugar, se requiere instalar y cargar los paquetes
# necesarios. 
# Este paso es largo y requiere tiempo pero la primera parte
# (instalacion) solamente necesita ser ejecutado una vez

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
library(BiocManager)
BiocManager::install("RforProteomics", dependencies = TRUE)
BiocManager::install("oligo")
BiocManager::install("ShortRead")
BiocManager::install("Rsubread")
BiocManager::install("genefilter")
BiocManager::install("edgeR")
BiocManager::install("limma")
BiocManager::install("DEP")
BiocManager::install("MSGFplus")
install.packages("stats")

# Cambiar por el paquete del array correspondiente, en su caso:

BiocManager::install("hgu133plus2.db")

# Ejecutar en cada sesion

library(oligo)
library(mzR)
library(MSnbase)
library(ShortRead)
library(Rsubread)
library(genefilter)
library(stats)
library(edgeR)
library(limma)
library(DEP)
library(MSGFplus)
library(hgu133plus2.db) # Cambiar por el paquete correspondiente

###################################

# Elegir el directorio de trabajo

dir<-"~/." # Se puede seleccionar por el usuario
setwd(dir)

# Crear una carpeta "data" y una carpeta "results" en el 
# directorio de trabajo

dir.create("data")
dir.create("results")


