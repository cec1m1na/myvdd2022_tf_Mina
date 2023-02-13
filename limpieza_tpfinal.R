################################################################################
# Manejo y Visualización de Datos
# Maestria en Estadistica Aplicada - FCEyE - UNR
# TP Final
# Ma. Cecilia Mina 
################################################################################

#Librerias utilizadas en el trabajo
library(rjson)
library(tidyr)
library(dplyr)
library(readr)

#Cargo Todas las fichas relevantes
f1 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1714087" #Gainvest FF
f2 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719674" #Delta Ahorro Plus
f3 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719752" #Consultatio Renta Nacional
f4 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719820" #Schroder Renta Plus
f5 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719194" #IAM Renta Capital
f6 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1720037" #Quinquela Pesos
f7 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719353" #Megainver Liquidez Pesos
f8 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719713" #Consultatio Fondo de dinero
f9 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719196" #Mercado Fondo BIND
f10 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719171" #Gainvest Renta Fija Dolares
f11 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719359" #Megainver Renta Fija Dolares
f12 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719351" #Quinquela Renta Fija Dolares
f13 <-"https://api.cafci.org.ar/interfaz/semanal/resumen/cartera/1719192" #IAM Renta Dolares

#Defino una Funcion que Importa y limpia la data.Acá utilizo rjson 
# para lectura de archivo json y no jsonlite por el tipo de info 
# que requiero de salida
MiFuncion <- function(x) {readLines(x) %>% 
    paste () %>% 
    fromJSON() %>% # 
    data.frame() %>%
    select ("data.FondoId",
            "data.dataXML.Cabecera.FondoNombre",
            "data.dataXML.Cabecera.FechaReporte", 
            "data.dataXML.Cabecera.SGNombre",
            "data.dataXML.Cabecera.SDNombre", 
            "data.dataXML.Cabecera.Clasificacion", 
            "data.dataXML.Cabecera.Moneda", 
            "data.dataXML.Cabecera.Region", 
            "data.dataXML.Cabecera.Horizonte",
            "data.dataXML.Pie.PieValor") %>%
    rename (ID_FCI = data.FondoId, 
            Nombre_FCI = data.dataXML.Cabecera.FondoNombre,
            Fecha = data.dataXML.Cabecera.FechaReporte, 
            Soc_Gerente = data.dataXML.Cabecera.SGNombre,
            Depositaria = data.dataXML.Cabecera.SDNombre, 
            Clasificacion = data.dataXML.Cabecera.Clasificacion, 
            Moneda = data.dataXML.Cabecera.Moneda, 
            Region = data.dataXML.Cabecera.Region, 
            Horizonte = data.dataXML.Cabecera.Horizonte,
            Patrimonio_Neto = data.dataXML.Pie.PieValor
    )}
#Genero objetos ti que son data.frames de la info de cada ficha limpia
t1 <- data.frame (MiFuncion(f1))
t2 <- data.frame (MiFuncion(f2))
t3 <- data.frame (MiFuncion(f3))
t4 <- data.frame (MiFuncion(f4))
t5 <- data.frame (MiFuncion(f5))
t6 <- data.frame (MiFuncion(f6))
t7 <- data.frame (MiFuncion(f7))
t8 <- data.frame (MiFuncion(f8))
t9 <- data.frame (MiFuncion(f9))
t10 <- data.frame (MiFuncion(f10))
t11 <- data.frame (MiFuncion(f11))
t12 <- data.frame (MiFuncion(f12))
t13 <- data.frame (MiFuncion(f13))

#Agrupo distintas fichas en unica tabla que será la base para Shiny 
TablaFinal <- bind_rows(t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13)

#Exporto a archivo csv: Tabla limpia y terminada lista para Shiny 
write.csv (TablaFinal, file= "TablaFinal.csv")

