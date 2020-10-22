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


Debajo se visualizan las diferentes tablas de la BBDD que formaremos con los diferentes .csv:

![](https://github.com/maglionejm/itba-foundations/blob/main/tp-itba-foundations-2/img/bbdd_ourairports.png)

# Metodología de consumo de fuente de datos
Se ha instanciado un storage en Google Cloud (GCP) para almacenar los diferentes archivos .csv zippeados en un bucket:

![](https://github.com/maglionejm/itba-foundations/blob/main/tp-itba-foundations-2/img/gcp_buckets.JPG)


![](https://github.com/maglionejm/itba-foundations/blob/main/tp-itba-foundations-2/img/ourairports_zip.png)

Exponemos los datos a través de una URL pública: https://storage.googleapis.com/baseball-itba/ourairports4.zip


# Proceso para levantar los contenedores, crear el schema de la BBDD, cargar los datos y correr las queries

1. El primer paso consiste en crear la red que utilizaremos para que se comuniquen los componentes, ejecutando en consola el siguiente comando: 

```
$ docker network create itba
```


2. Ahora levantamos la base de datos (PostgreSQL) y generaremos la estructura de la misma (BBDD, tablas, constraints):

```
$ cd tp-itba-foundations-2
$ cd infra 
$ docker-compose up
```


3. Con el schema y las tablas creadas entonces es momento de poblar la base de datos. La cargaremos corriendo un ETL. Para esto vamos a buildear una imagen de Docker que contiene un script de Python.

```
$ cd tp-itba-foundations-2
$ cd etl 
$ docker build -t etl .
$ docker run --rm -e DATABASE_HOST=pg-docker \
-e DATABASE_PORT=5432 \
-e DATABASE=postgres \
-e DATABASE_USER=postgres \
-e DATABASE_PASSWORD=docker \
--network=itba etl
```

Una vez ejecutado esto, se visualizarán los logs y la evidencia de la carga de la base de datos con los archivos de ourairports (en GCP), y se cargarán en la tabla que corresponda.



4. Posteriormente, ya con los datos cargados, correremos las queries de la siguiente forma:

```
$ cd ../reports
$ docker build -t reports .
$ docker run --rm -e DATABASE_HOST=pg-docker \
-e DATABASE_PORT=5432 \
-e DATABASE=postgres \
-e DATABASE_USER=postgres \
-e DATABASE_PASSWORD=docker \
-v $PWD/results:/app/results \
--network=itba reports
```

# Queries

Query_1:¿Cuáles son los aeropuertos con menor elevación y en qué región se encuentran (Top 10)?

||name| iso_region|  elevation_ft|
|--|--|--|--|
|0|Bar Yehuda Airfield|       IL-D|         -1266|
|1|Furnace Creek Airport|      US-CA|          -210|
|2|Cliff Hatfield Memorial Airport|      US-CA|          -182|
|3|Ein Yahav Airfield|       IL-D|          -164|
|4|Brawley Municipal Airport|      US-CA|          -128|
|5|Riverside County Sheriff Thermal Heliport|      US-CA|          -117|
|6|Jacqueline Cochran Regional Airport|      US-CA|          -115|
|7|Pioneers Memorial Hospital Heliport|     US-CA|           -99|
|8|O'Connell Brothers Airport|      US-CA|           -99|
|9|Salton Sea Airport|      US-CA|           -84|



Query_2:¿Qué aeeropuertos tienen una longitud de pista de entre 24 y 25 pies?

| name | length_ft                                         |    |
|------|---------------------------------------------------|----|
| 0    | Acadiana One Office Bldg Heliport                 | 24 |
| 1    | Dearborn County Hospital Heliport                 | 24 |
| 2    | Chevron Intracoastal Heliport                     | 24 |
| 3    | Galvez-Lake Vfd Heliport                          | 24 |
| 4    | Arco Morgan City Heliport                         | 24 |
| 5    | Bastian Bay Heliport                              | 24 |
| 6    | Diamond Shamrock Heliport                         | 24 |
| 7    | Barataria Bay Heliport                            | 24 |
| 8    | Lawrence Administrative Services Inc Heliport     | 24 |
| 9    | KTSP Heliport                                     | 24 |
| 10   | Chevron Intracoastal Heliport                     | 24 |
| 11   | Jane Todd Crawford Hospital Heliport              | 24 |
| 12   | Chevron Intracoastal Heliport                     | 24 |
| 13   | Chevron Intracoastal Heliport                     | 24 |
| 14   | White O'Morn Heliport                             | 24 |
| 15   | Jackson Heliport                                  | 24 |
| 16   | Chevron Intracoastal Heliport                     | 24 |
| 17   | Liberty Park Heliport                             | 24 |
| 18   | Hospital Pad Heliport                             | 24 |
| 19   | Windy Hill Heliport                               | 24 |
| 20   | Dakota Air Ranch Airport                          | 24 |
| 21   | Dakota Air Ranch Airport                          | 24 |
| 22   | Promedica Memorial Hospital Heliport              | 24 |
| 23   | Horseman Heliport                                 | 24 |
| 24   | Gainey Heliport                                   | 24 |
| 25   | Green Hill Compressors Heliport                   | 24 |
| 26   | Dorothy Roeber Memorial Heliport                  | 24 |
| 27   | Little Lake Heliport                              | 24 |
| 28   | Allegheny Power-Hagerstown Corp Ctr Heliport      | 24 |
| 29   | Steuart Office Pad Heliport                       | 24 |
| 30   | Clay County Hospital Heliport                     | 24 |
| 31   | Holzer Heliport                                   | 24 |
| 32   | Whitwell Medical Center Heliport                  | 24 |
| 33   | Methodist Lebonheur Healthcare Heliport           | 24 |
| 34   | Ware Mountain Heliport                            | 24 |
| 35   | Ware Mountain Heliport                            | 24 |
| 36   | KVUE-TV Heliport                                  | 24 |
| 37   | Fraundorfer Heliport                              | 24 |
| 38   | De Kalb General Hospital Heliport                 | 24 |
| 39   | Fudruckers Heliport                               | 24 |
| 40   | Skaggs Heliport                                   | 24 |
| 41   | Manatee Memorial Hospital Heliport                | 24 |
| 42   | Joey Anderson Heliport                            | 24 |
| 43   | Goldfield Ghost Town Heliport                     | 24 |
| 44   | Chevron Intracoastal Heliport                     | 24 |
| 45   | Matthews Heliport                                 | 25 |
| 46   | Inspira Medical Center, Inc / Elmer Hospital H... | 25 |
| 47   | Spears Heliport                                   | 25 |
| 48   | Fairview Park Hospital Heliport                   | 25 |
| 49   | Valley Fire/Rescue Dist & Emerg Service Heliport  | 25 |
| 50   | Schaumburg Municipal Helistop                     | 25 |
| 51   | Chevron Fourchon Heliport                         | 25 |
| 52   | La Haye Center Heliport                           | 25 |
| 53   | Millbury Savings/West Heliport                    | 25 |
| 54   | Pin Oak Stables Heliport                          | 25 |
| 55   | Palm Petroleum Corporation Heliport               | 25 |
| 56   | Mc Murry Heliport                                 | 25 |
| 57   | Hummingbird Nest Heliport                         | 25 |
| 58   | Anthony Hospital Heliport                         | 25 |
| 59   | Sprint/Carolina Telephone Heliport                | 25 |
| 60   | Jernigan Drilling Heliport                        | 25 |
| 61   | Bass Heliport                                     | 25 |
| 62   | White Pine Heliport                               | 25 |
| 63   | Monument Heliport                                 | 25 |
| 64   | Nason Hill Heliport                               | 25 |
| 65   | Baystate Medical Ctr Heliport                     | 25 |
| 66   | North Carolina Helicopters Heliport               | 25 |
| 67   | Craighead Heliport                                | 25 |
| 68   | Rmz Heliport                                      | 25 |
| 69   | Atlantic Research Corp Heliport                   | 25 |
| 70   | Malheur Memorial Hospital Heliport                | 25 |
| 71   | Mc Donald's Plaza Heliport                        | 25 |
| 72   | Adams Executive Heliport                          | 25 |
| 73   | Rider Private Heliport                            | 25 |
| 74   | Mountain Bell Heliport                            | 25 |
| 75   | Mountain Bell Heliport                            | 25 |
| 76   | Atc Heliport                                      | 25 |
| 77   | Ball Park Heliport                                | 25 |
| 78   | North Port Ems Heliport                           | 25 |
| 79   | Allied Northborough Heliport                      | 25 |
| 80   | AdventHealth Kissimmee Heliport                   | 25 |
| 81   | Amber Glen Business Center Hp Heliport            | 25 |
| 82   | Capra Farms Heliport                              | 25 |
| 83   | Mt Vernon Medical Center Heliport                 | 25 |
| 84   | Aero Heliport                                     | 25 |
| 85   | Nierenberg Estate Heliport                        | 25 |
| 86   | Conner Heliport                                   | 25 |
| 87   | Air Logistics Sabine Heliport                     | 25 |
| 88   | Ohio Department of Transportation Dist 6 Heliport | 25 |
| 89   | LZ Phantom Heliport                               | 25 |
| 90   | Durand Ambulance Service Heliport                 | 25 |
| 91   | C.C.A. Heliport                                   | 25 |
| 92   | Quail Lakes Heliport                              | 25 |
| 93   | Drummond Heliport                                 | 25 |
| 94   | Uams Heliport                                     | 25 |
| 95   | Baptist Memorial Hospital-Blytheville Heliport    | 25 |
| 96   | KPNX-TV Studios Heliport                          | 25 |
| 97   | Sanger Heliport                                   | 25 |
| 98   | The McConnell Foundation Heliport                 | 25 |
| 99   | A.I.Dupont Institute Heliport                     | 25 |
| 100  | Mosquito Ctl Heliport                             | 25 |
| 101  | Lake Wales Heliport                               | 25 |
| 102  | Motorsports Complex Vip Heliport                  | 25 |
| 103  | Motorsports Complex Ems Heliport                  | 25 |
| 104  | Calhoun Sheriff's Heliport                        | 25 |
| 105  | Dekalb Police Dept Heliport                       | 25 |
| 106  | Myrtue Memorial Hospital Heliport                 | 25 |
| 107  | St Alphonsus Heliport                             | 25 |
| 108  | International Crossroads Heliport                 | 25 |
| 109  | Mianecki Heliport                                 | 25 |
| 110  | Medicant Island Heliport                          | 25 |
| 111  | Raceland Station Heliport                         | 25 |
| 112  | Amax Metals Recovery Inc. Heliport                | 25 |
| 113  | Lake Charles Office Heliport                      | 25 |
| 114  | Compaq Marlboro Heliport                          | 25 |
| 115  | Compaq Marlboro Heliport                          | 25 |
| 116  | Gmh Heliport                                      | 25 |
| 117  | Mineral County Hospital Heliport                  | 25 |
| 118  | C.S.S. Heliport                                   | 25 |
| 119  | Blue Light Heliport                               | 25 |
| 120  | Hunter Construction Heliport                      | 25 |
| 121  | Dewitt Heliport                                   | 25 |
| 122  | Fuller Heliport                                   | 25 |
| 123  | Columbia Aviation Heliport                        | 25 |
| 124  | C.C. Hospital Heliport                            | 25 |
| 125  | Mazzuca Heliport                                  | 25 |
| 126  | Downtown Providence Helistop                      | 25 |
| 127  | E M M D Plant Heliport                            | 25 |
| 128  | Milliken & Company Heliport                       | 25 |
| 129  | Community Memorial Hospital Heliport              | 25 |
| 130  | Lcf Heliport                                      | 25 |
| 131  | Denton Regional Medical Ctr - Flow Campus Heli... | 25 |
| 132  | Front Yard Landing Area Heliport                  | 25 |
| 133  | Beechwood Heliport                                | 25 |
| 134  | Donagher Residence Heliport                       | 25 |
| 135  | Davis Hospital & Medical Center Heliport          | 25 |
| 136  | Reedsburg Area Medical Center Heliport            | 25 |
| 137  | Landry's Warehouse Heliport                       | 25 |
| 138  | Graco Mechanical Inc Heliport                     | 25 |
| 139  | Ac & R Components Heliport                        | 25 |
| 140  | Hillwood Heliport                                 | 25 |
| 141  | Hansen Heliport                                   | 25 |
| 142  | Valley Grain Heliport                             | 25 |
| 143  | Riverside Hospital Airlift Heliport               | 25 |
| 144  | Kauffman Heliport                                 | 25 |
| 145  | West Hackberry Heliport                           | 25 |
| 146  | Lleia Kyle O'Meara Heliport                       | 25 |
| 147  | New York State Police Heliport                    | 25 |
| 148  | Henry Valve Company Heliport                      | 25 |
| 149  | Cleveland Clinic, Union Hospital Heliport         | 25 |
| 150  | Galleria Heliport                                 | 25 |
| 151  | Station 241 Heliport                              | 25 |
| 152  | Grace Hospital Heliport                           | 25 |
| 153  | Schultz Field                                     | 25 |
| 154  | Airc Helistop                                     | 25 |
| 155  | S R P Tolleson Center Heliport                    | 25 |
| 156  | Manairco Heliport                                 | 25 |
| 157  | Global Development Facility Heliport              | 25 |
| 158  | Global Development Facility Heliport              | 25 |
| 159  | Caleb Heliport                                    | 25 |
| 160  | Furst Ranch Heliport                              | 25 |
| 161  | Heli-Ray Heliport                                 | 25 |
| 162  | Turnberry Ranch Heliport                          | 25 |
| 163  | Dept. Of Water And Power Granada Hills Heliport   | 25 |
| 164  | Grape Community Hospital Heliport                 | 25 |
| 165  | Burgess Health Center Heliport                    | 25 |
| 166  | Il.Dept Of Transportation Heliport                | 25 |
| 167  | Jet Line South Heliport                           | 25 |
| 168  | Washington County Hospital Heliport               | 25 |
| 169  | TGP Station 542 Heliport                          | 25 |
| 170  | Kwp Heliport                                      | 25 |
| 171  | Titus Regional Medical Center Heliport            | 25 |
| 172  | Rychlk Heliport                                   | 25 |
| 173  | Southern Tennessee Medical Center Heliport        | 25 |
| 174  | Cobb General Hospital Heliport                    | 25 |
| 175  | Print Pad Heliport                                | 25 |
| 176  | Long Point Heliport                               | 25 |
| 177  | Knobel Heliport                                   | 25 |
| 178  | Police Department Helicopter Maint Facility He... | 25 |
| 179  | Police Department Helicopter Maint Facility He... | 25 |
| 180  | Police Department Helicopter Maint Facility He... | 25 |
| 181  | Elkins Heliport                                   | 25 |
| 182  | Heavenly Flights Heliport                         | 25 |
| 183  | Falcons Nest Heliport                             | 25 |
| 184  | Meadowlands Hospital Medical Center Heliport      | 25 |



Query_3: ¿Cuáles son los 10 países con más aeropuertos del mundo?

||country|total|
|--|--|--|
|0 |   United States |23673|
|1 |         Brazil  | 5206|
|2 |         Canada  | 2801|
|3 |      Australia  | 2021|
|4 |         Mexico  | 1461|
|5 |    South Korea  | 1374|
|6 | United Kingdom  | 1238|
|7 |         Russia  | 1122|
|8 |        Germany  | 959 |
|9 |         France  |  895|



Query 4:¿Cuáles son los aeropuertos que tienen una pista de GRVL, no tienen iluminación y miden 2500 ft?

|    | name                           | municipality    | iso_country |
|----|--------------------------------|-----------------|-------------|
| 0  | Crowley Ranch Airstrip         | Crowley         | US          |
| 1  | Lowell Field                   | Anchor Point    | US          |
| 2  | Norwood Airport                | Norwood         | CA          |
| 3  | Snettisham Airport             | Snettisham      | US          |
| 4  | Wilderness Airport             | Bly             | US          |
| 5  | South Gasline Airport          | Sterling        | US          |
| 6  | Robin'S Landing                | Point Mackenzie | US          |
| 7  | Westberg-Rosling Farms Airport | Roggen          | US          |
| 8  | Anchor River Airpark           | Anchor Point    | US          |
| 9  | Swanson Ranch 3 Airport        | Battle Mountain | US          |
| 10 | J K D Farms Airport            | Ellensburg      | US          |



Query 5:


