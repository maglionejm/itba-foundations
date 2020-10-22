# **Entrega de TP final - Foundations phase ITBA**

# Objetivo
Validar conocimientos y aplicación sobre: 
- Docker
- Bases de datos relacionales
- Python 3.6 / 3.7 / 3.8

# Entregables
- Dockerfiles (Generación de imágenes, ejecución de ETL y ejecución de reportes).
- Script Bash
- Script Python

# Fuente de datos seleccionada

Fuente: https://ourairports.com/data/

Datasets:
- airports.csv (8,756,709 bytes, last modified Oct 22, 2020):
Archivo .csv que contiene información sobre aeropuertos.
- airport-frequencies.csv (1,217,897 bytes, last modified Oct 22, 2020):
Archivo .csv que contiene información sobre frecuencias de comunicación entre aeropuertos.
- runways.csv (3,047,325 bytes, last modified Oct 22, 2020):
Archivo .csv que contiene información sobre las pistas de aterrizaje/despegue de aeropuertos globalmente.
- navaids.csv (1,526,528 bytes, last modified Oct 22, 2020):
Archivo .csv que enumera las ayudas a la navegación por radio en todo el mundo.
- countries.csv (20,663 bytes, last modified Oct 22, 2020):
Archivo .csv que contiene una lista de países del mundo.
- regions.csv (369,543 bytes, last modified Oct 22, 2020):
Archivo .csv que contiene una lista de subregiones de los países.

# Metodología de consumo de fuente de datos
Se ha instanciado un storage en Google Cloud (GCP) para almacenar los diferentes archivos .csv zippeados en un bucket
![alt text](https://github.com/maglionejm/itba-foundations/blob/main/gcp_buckets.jpg?raw=true)
