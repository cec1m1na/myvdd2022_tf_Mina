# myvdd2022_tf_Mina
Trabajo Final. Asignatura: Manejo de Datos. Maestría en Estadística Aplicada.
Información General
- Objetivos: 
1. Desarrollar una Herramienta que permita la limpieza automática de información pública, generando una rápida visualización y comparación de ciertas características de Fondos Comunes de Inversión, en este caso por Patrimonio Neto pero ampliable a otros atributos. Considerando que las composiciones de los Fondos varían a diario pero sólo se informan cada 15 días a la Cámara en cuestión. 
2. Automatizar todo el proceso, desde la captura de la información hasta la generación de la Shiny
- Desarrollo y elección del tema. La idea inicial era aplicar “web scraping” para la captura de la info pero dado que el proceso me topé con apis para cada ficha terminé por investigar importación de archivos tipo json. La elección del tema se debe a que me desempeñé durante 10 años como analista de Fondos y manejé algunos de ellos. 
- Breve Descripción: El Trabajo consta de 2 archivos de R:
“limpiezatpfinal.R”: se listaron las url de las fichas de fondos relevantes y se realizó la manipulación y limpieza a través de una función propia, para la posterior generación de una tabla unificada exportada en forma automática a un archivo csv llamado “TablaFinal.csv”.
“apptpfinal.R”: aloja la Shiny que comienza con la Importación de la tabla, generada en archivo previo, como Datos de base para finalmente ser presentada la información contenida en forma comparativa permitiendo la interacción con usuario.
- Fuente: Cámara Argentina de Fondos Comunes de Inversión.
