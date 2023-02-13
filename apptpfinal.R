#Librerias a utilizar
library(shiny) 
library(readr)
library(tidyr)
library(dplyr)
library(stringr)
library(ggplot2) 
library(plotly) 
library(readxl)

#Importo Datos Base y realizo algunas tareas de manipulacion. 
# Utilizo read_csv porque es la unica que lee la col PN como num
TablaFinal <- read_csv ("TablaFinal.csv") %>% 
  select (-"...1") %>%  #elimino 1ra col generada al pasar el dataframe a un archivo a csv
  mutate (Patrimonio_Neto = (Patrimonio_Neto/1000000)) #cambio la unidad de PN a millones
table(TablaFinal$Patrimonio_Neto)

#Widget. Listado de tipos y Monedas disponibles
opciones_clasificacion <- TablaFinal %>% 
  separate_rows(Clasificacion, sep = ", ") %>% 
  pull(Clasificacion) %>% 
  unique()

opciones_moneda <- TablaFinal %>% 
  separate_rows(Moneda, sep = ", ") %>% 
  pull(Moneda) %>% 
  unique()

#ui. Definicion de aspecto. 2 Widgets
MiInterfaz <- fluidPage(
  
  titlePanel("Buscador de Fondos Comunes de Inversion"), 
  sidebarLayout( 
    sidebarPanel(
    selectInput(
      inputId = "Tipo", 
      label = "Seleccione Tipo de Fondo:",
      choices = opciones_clasificacion
      ),
      radioButtons(
        inputId = "Mon", #id del widget
        label = "Escoga Moneda", #Titulo 
        choices = sort(opciones_moneda), #opciones disponibles
        selected = "Peso Argentina" #opcion seleccionada por defecto
      ),
    "Fuente: Camara Argentina de Fondos Comunes de Inversion"
    ) ,
    mainPanel(
      plotlyOutput("MiGrafico")
    )
  )
)
#SERVER
MiServidor <- function(input, output) {
  
  clasificacion_reactivo <- reactive({input$Tipo})
  moneda_reactivo <- reactive({input$Mon})
  
  output$MiGrafico <- renderPlotly({
    
    grafico <- TablaFinal %>% 
      filter(
        Clasificacion == clasificacion_reactivo(),
        Moneda == moneda_reactivo()
        ) %>% 
      ggplot() +
      aes(x=Nombre_FCI, y=Patrimonio_Neto,) +
      geom_bar(stat="identity", fill="darkblue", alpha=.6, width=.4) +
      coord_flip() +
      ggtitle(paste0 ("Ranking por PN de FCIS de ", 
              clasificacion_reactivo())) +
      labs (x = "Fondo",  y = paste0 ("Patrimonio Neto en ", moneda_reactivo()," (en millones)")) + 
      theme_bw()
    ggplotly(grafico)
    
  })
}

shinyApp(ui = MiInterfaz, server = MiServidor)