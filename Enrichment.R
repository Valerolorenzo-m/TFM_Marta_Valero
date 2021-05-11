#######################################
# Analisis de enriquecimiento

# Definir el universo de genes a analizar
universo<- # A Definir por el usuario

if (type!="MS"){
  
  # Se lleva a cabo el análisis de enriquecimiento
  genes<-data_annot
  enrich.result <- enrichPathway(gene = genes,
                                 pvalueCutoff = 0.05,
                                 pAdjustMethod = "BH", # Se puede definir 
                                 organism = ,
                                 universe = universo)
  
  # Se guardan los resultados como .CSV y un plot (cnetplot)
  # En caso de que el archivo de enriquecimiento no esté vacío
  
  if (length(rownames(enrich.result@result)) != 0) {
    write.csv(as.data.frame(enrich.result), 
              file =paste0("./results/","ReactomePA.Results.",contraste_int,".csv"), 
              row.names = FALSE)
    
    png(file = paste0("./results/","cnetplot.",contraste_int,".png"))
    print(cnetplot(enrich.result, categorySize = "geneNum", showCategory = 15, 
                   vertex.label.cex = 0.75))
    dev.off()
  }
  
}else if(type=="MS"){
  
  enrich.result <- test_diff(data_annot, type = "manual",
    design_formula = matriz_dis, test = contrasts)
  
  if (length(rownames(enrich.result@result)) != 0) {
    write.csv(as.data.frame(enrich.result), 
              file =paste0("./results/","DEP.Results.",contraste_int,".csv"), 
              row.names = FALSE)
    
    png(file = paste0("./results/","cnetplot.",contraste_int,".png"))
    print(cnetplot(enrich.result, vertex.label.cex = 0.75))
    dev.off()
  
  
}
