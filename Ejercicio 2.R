

library(tidyverse)
library(sf)


#Para comenzar, cargamos el dataset de *casos de COVID-19*:
  

casos_covid19 <- read.csv("Data/casos_covid19.csv", 
                          encoding = "UTF-8", stringsAsFactors = TRUE)


summary(covid_CABA)



#A continuación, cargamos los datasets espaciales (*operativos detectAR* y *barrios de CABA*):
  

hospitales <- st_read("Data/hospitales_gcba_WGS84.shp", stringsAsFactors = TRUE)

summary(hospitales)


operativo_detectar <- st_read("Data/operativo-detectar/programa_detectar_WGS84.shp", stringsAsFactors = TRUE)

summary(operativo_detectar)


barrios <- st_read("Data/barrios_badata.shp", stringsAsFactors = TRUE)

summary(barrios)


#Ordenamos y transfomamos datos:

  
casos_covid19 <- filter(casos_covid19, provincia=="CABA")

casos_covid19 <- filter(casos_covid19, clasificacion=="confirmado")

casos_covid19 <- rename(casos_covid19, nro_caso=X.U.FEFF.numero_de_caso)

casos_covid19 <- rename(casos_covid19, fecha_apertura=fecha_apertura_snvs)

casos_covid19 <- select(casos_covid19, nro_caso, fecha_apertura, fecha_toma_muestra, fecha_clasificacion, provincia, barrio, comuna, genero, edad, tipo_contagio)

casos_covid19 <- mutate(casos_covid19, FUENTE="DataBA")

casos_covid19 <- arrange(casos_covid19, barrio, comuna, provincia)

head(casos_covid19)

casos_agrupado <- casos_covid19 %>%
  group_by(barrio, comuna) %>%
  summarise(cantidad=n())


