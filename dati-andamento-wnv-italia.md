<img src="https://github.com/fbranda/west-nile/blob/main/assets/img/logo-wn.jpg" alt="WNV" data-canonical-src="https://github.com/fbranda/west-nile/blob/main/assets/img/logo-wn.jpg" width="900"/>

# Dati andamento West Nile Italia

## Aggiornamento dei dati

- Dati andamento West Nile Italia: ogni mercoledì

## Formato dei dati

### Sorveglianza umana

**Directory:**  dati-sorveglianza-umana<br>
**Struttura file regionale:** wn-ita-regioni-sorveglianza-umana-yyyy.csv (wn-ita-regioni-sorveglianza-umana-2012.csv)<br>


| Nome campo                  | Descrizione                       |Formato                       | Esempio             |
|-----------------------------|-----------------------------------|-------------------------------|---------------------|
| **url_bollettino**              | Link del bollettino in formato pdf | Testo | https://github.com/fbranda/west-nile/blob/main/2012/bollettini/WN_News_2012_01.pdf	|
| **data**                        | Data dell'informazione            | YYYY-MM-DD | 2012-09-27	|
| **codice_regione**              | Codice della Regione (ISTAT) | Numero                        | 6                  |
| **denominazione_regione**       | Denominazione della Regione       | Testo                         | Friuli Venezia Giulia             |
| **lat**                         | Latitudine                       | WGS84                         | 45.6494354          |
| **long**                        | Longitudine                       | WGS84                         | 13.76813649        |
| **nuovi_casi**  | Nuovi attualmente positivi (casi_totali giorno corrente - casi_totali giorno precedente)       | Numero                        | 2                |
| **casi_totali**                 | Totale casi positivi              | Numero                        | 3                   |
| **tipo_infezione**              | Note sui casi testati              | Testo                        | neuroinvasiva                   |


**Directory:**  dati-sorveglianza-umana<br>
**Struttura file regionale:** wn-ita-province-sorveglianza-umana-yyyy.csv (wn-ita-province-sorveglianza-umana-2012.csv)<br>

| Nome campo              | Descrizione                         | Formato            | Esempio              |
|-------------------------|-------------------------------------|--------------------|----------------------|
| **url_bollettino**              | Link del bollettino in formato pdf | Testo | https://github.com/fbranda/west-nile/blob/main/2012/bollettini/WN_News_2012_01.pdf	|
| **data**                    | Data dell'informazione              | YYYY-MM-DD           | 2012-09-27	 |                   |
| **codice_regione**          | Codice della Regione (ISTAT)  | Numero             | 6                   |
| **denominazione_regione**   | Denominazione della Regione        | Testo              | Friuli Venezia Giulia              |
| **codice_provincia**        | Codice della Provincia (ISTAT) | Numero             | 31                  |
| **denominazione_provincia** | Denominazione della provincia       | Testo              | Gorizia               |
| **sigla_provincia**         | Sigla della Provincia               | Testo              | GO                  |
| **lat**                     | Latitudine                          | WGS84              | 45.94149817           |
| **long**                    | Longitudine                         | WGS84              | 13.62212502          |
| **eta**  | Eta dei casi testati (`<=14`, `15-44`, `45-64`, `65-74`, `>=75`) | Testo    |      45-64 |
| **nuovi_casi**  | Nuovi attualmente positivi (casi_totali giorno corrente - casi_totali giorno precedente)      | Numero                        | 2                |
| **casi_totali**                 | Totale casi positivi              | Numero                        | 3                   |
| **tipo_infezione**              | Note sui casi testati             | Testo                        | neuroinvasiva                   |


### Sorveglianza entomologica

**Directory:**  dati-sorveglianza-entomologica<br>
**Struttura file regionale:** wn-ita-regioni-sorveglianza-entomologica-yyyy.csv (wn-ita-regioni-sorveglianza-entomologica-2017.csv)<br>

| Nome campo                  | Descrizione                       | Formato                       | Esempio             |
|-----------------------------|-----------------------------------|-------------------------------|---------------------|
| **url_bollettino**              | Link del bollettino in formato pdf | Testo | https://github.com/fbranda/west-nile/blob/main/2017/bollettini/WN_News_2017_01.pdf	|
| **data**                    | Data dell'informazione              | YYYY-MM-DD           | 2017-08-02		 |                   |
| **codice_regione**          | Codice della Regione (ISTAT)   | Numero             | 8                  |
| **denominazione_regione**   | Denominazione della Regione       | Testo              | Emilia-Romagna              |
| **codice_provincia**        | Codice della Provincia (ISTAT) | Numero             | 37                  |
| **denominazione_provincia** | Denominazione della provincia       | Testo              | Bologna              |
| **sigla_provincia**         | Sigla della Provincia               | Testo              | BO                  |
| **lat**                     | Latitudine                          | WGS84              | 44.49436681           |
| **long**                    | Longitudine                         | WGS84              | 11.3417208          |
| **nuovi_casi**  | Nuovi attualmente positivi (casi_totali giorno corrente - casi_totali giorno precedente)     | Numero                        | 2                |
| **casi_totali**                 | Totale casi positivi              | Numero                        | 3                   |


### Sorveglianza equidi

**Directory:**  dati-sorveglianza-equidi<br>
**Struttura file regionale:** wn-ita-regioni-sorveglianza-equidi-yyyy.csv (wn-ita-regioni-sorveglianza-equidi-2017.csv)<br>

| Nome campo                  | Descrizione                       | Formato                       | Esempio             |
|-----------------------------|-----------------------------------|-------------------------------|---------------------|
| **url_bollettino**              | Link del bollettino in formato pdf | Testo | https://github.com/fbranda/west-nile/blob/main/2017/bollettini/WN_News_2017_01.pdf	|
| **data**                    | Data dell'informazione             | YYYY-MM-DD           | 2017-08-02		 |                   |
| **codice_regione**          | Codice della Regione (ISTAT)   | Numero             | 5                  |
| **denominazione_regione**   | Denominazione della Regione      | Testo              | Veneto              |
| **codice_provincia**        | Codice della Provincia (ISTAT) | Numero             | 29                  |
| **denominazione_provincia** | Denominazione della provincia      | Testo              | Rovigo             |
| **sigla_provincia**         | Sigla della Provincia               | Testo              | RO                  |
| **lat**                     | Latitudine                         | WGS84              | 45.07107289	           |
| **long**                    | Longitudine                        | WGS84              | 11.79007	          |
| **nuovi_casi**  | Nuovi attualmente positivi (casi_totali giorno corrente - casi_totali giorno precedente)    | Numero                        | 1               |
| **casi_totali**                 | Totale casi positivi              | Numero                        | 1                   |
| **nuovi_morti_abbattuti**                 | Nuovi attualmente deceduti (totale_morti_abbattuti giorno corrente - totale_morti_abbattuti giorno precedente)               | Numero                        | 0                   |
| **totale_morti_abbattuti**                 | Totale casi deceduti             | Numero                        | 0                   |
| **equidi_presenti_focolaio**                 | Totale equidi presenti nel focolaio            | Numero                        | 0                   |








### Licenza
**Licenza:** [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/deed.it) - [Visualizza licenza](https://github.com/fbranda/west-nile/blob/main/LICENSE.md)<br>

