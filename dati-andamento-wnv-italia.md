<img src="https://github.com/fbranda/west-nile/blob/main/assets/img/logo-wn.jpg" alt="WNV" data-canonical-src="https://github.com/fbranda/west-nile/blob/main/assets/img/logo-wn.jpg" width="900"/>

# Dati andamento West Nile Italia

## Aggiornamento dei dati

- Dati andamento West Nile Italia: ogni mercoledì

## Formato dei dati

### Sorveglianza umana

### Dati per Regione

**Directory:**  dati-sorveglianza-umana<br>
**Struttura file regionale:** wn-ita-regioni-sorveglianza-umana-yyyy.csv (wn-ita-regioni-sorveglianza-umana-2012.csv)<br>


| Nome campo                  | Descrizione                       | Description                            | Formato                       | Esempio             |
|-----------------------------|-----------------------------------|----------------------------------------|-------------------------------|---------------------|
| **url_bollettino**              | Link del bollettino in formato pdf | Link to the bulletin in pdf format     | Testo | https://github.com/fbranda/west-nile/blob/main/2012/bollettini/WN_News_2012_01.pdf	|
| **data**                        | Data dell'informazione            | Date of notification                   | YYYY-MM-DD | 2012-09-27	|
| **codice_regione**              | Codice della Regione (ISTAT) | Code of the Region (ISTAT)        | Numero                        | 6                  |
| **denominazione_regione**       | Denominazione della Regione       | Name of the Region                     | Testo                         | Friuli Venezia Giulia             |
| **lat**                         | Latitudine                        | Latitude                               | WGS84                         | 45.6494354          |
| **long**                        | Longitudine                       | Longitude                              | WGS84                         | 13.76813649        |
| **nuovi_casi**  | Nuovi attualmente positivi (casi_totali giorno corrente - casi_totali giorno precedente)       | News amount of current positive cases (casi_totali current day - casi_totali previous day)  | Numero                        | 2                |
| **casi_totali**                 | Totale casi positivi              | Total amount of positive cases         | Numero                        | 3                   |
| **tipo_infezione**              | Note sui casi testati                  | Notes on the cases tested                       | Testo                        | neuroinvasiva                   |



### Dati per Provincia

**Directory:**  dati-sorveglianza-umana<br>
**Struttura file regionale:** wn-ita-province-sorveglianza-umana-yyyy.csv (wn-ita-province-sorveglianza-umana-2012.csv)<br>

| Nome campo              | Descrizione                         | Description                     | Formato            | Esempio              |
|-------------------------|-------------------------------------|---------------------------------|--------------------|----------------------|
| **url_bollettino**              | Link del bollettino in formato pdf | Link to the bulletin in pdf format     | Testo | https://github.com/fbranda/west-nile/blob/main/2012/bollettini/WN_News_2012_01.pdf	|
| **data**                    | Data dell'informazione              | Date of notification            | YYYY-MM-DD           | 2012-09-27	 |                   |
| **codice_regione**          | Codice della Regione (ISTAT)   | Code of the Region (ISTAT) | Numero             | 6                   |
| **denominazione_regione**   | Denominazione della Regione         | Name of the Region              | Testo              | Friuli Venezia Giulia              |
| **codice_provincia**        | Codice della Provincia (ISTAT) | Code of the Province            | Numero             | 31                  |
| **denominazione_provincia** | Denominazione della provincia       | Name of the Province            | Testo              | Gorizia               |
| **sigla_provincia**         | Sigla della Provincia               | Province abbreviation           | Testo              | GO                  |
| **lat**                     | Latitudine                          | Latitude                        | WGS84              | 45.94149817           |
| **long**                    | Longitudine                         | Longitude                       | WGS84              | 13.62212502          |
| **eta**  | Eta dei casi testati (`<=14`, `15-44`, `45-64`, `65-74`, `>=75`)        | Age of the cases tested (`<=14`, `15-44`, `45-64`, `65-74`, `>=75`)  | Testo    |      45-64 |
| **nuovi_casi**  | Nuovi attualmente positivi (casi_totali giorno corrente - casi_totali giorno precedente)       | News amount of current positive cases (casi_totali current day - casi_totali previous day)  | Numero                        | 2                |
| **casi_totali**                 | Totale casi positivi              | Total amount of positive cases         | Numero                        | 3                   |
| **tipo_infezione**              | Note sui casi testati                  | Notes on the cases tested                       | Testo                        | neuroinvasiva                   |



### Licenza
**Licenza:** [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/deed.it) - [Visualizza licenza](https://github.com/fbranda/west-nile/blob/main/LICENSE.md)<br>

