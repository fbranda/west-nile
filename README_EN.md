<img src="https://github.com/fbranda/west-nile/blob/main/assets/img/logo-wn.jpg" alt="WNV" data-canonical-src="https://github.com/fbranda/west-nile/blob/main/assets/img/logo-wn.jpg" width="900"/>

[Italiano](README.md) - [English](README_EN.md)<br><br>

# Italian West Nile data

[![GitHub license](https://img.shields.io/badge/License-Creative%20Commons%20Attribution%204.0%20International-blue)](https://github.com/fbranda/west-nile/blob/main/LICENSE.md)

[Sito dell'Istituto Superiore di Sanità - La sorveglianza dei casi umani di infezione da West Nile e Usutu virus (IT)](https://www.epicentro.iss.it/westnile/bollettino)


In Italy, the epidemiological surveillance of West Nile virus (WNV) infections in humans is regulated by the "[“National prevention, surveillance and response plan for arboviral diseases (PNA) 2020-2025"](https://www.statoregioni.it/media/2371/p-1-csr-rep-n-1-15gen2020.pdf). 
The document integrates veterinary (animal and entomological) surveillance of West Nile virus (WNV) - essential for risk estimation - and human cases into a single plan. 

Surveillance of imported and local human infections is carried out all year round throughout the country, and between early May and late November in Regions where an endemic area has been identified. In these areas the surveillance of human cases must be strengthened and special attention must be paid to the diagnosis of WNV disease in the population. The reporting system also collects positivities for WNV detected in donors of blood, blood derivatives and organs, tissues and cells, with a view to the application of specific preventive measures and any febrile clinical forms found in the country.

Human surveillance is coordinated at national level by the Istituto Superiore di Sanità (ISS) and the Ministry of Health, which transmits the data to the European Commission and the ECDC. The Regions, in full autonomy, define the regulatory-programmatic documents for epidemiological and laboratory surveillance on their territory and transmit the data to the ISS and the Ministry. The Department of Infectious Diseases of the Istituto Superiore di Sanità, with the coordination of Office V of the Directorate General for Prevention of the Ministry of Health and in collaboration with the Centre for the Study of Exotic Diseases (Cesme) of the Experimental Zooprophylactic Institute of Abruzzo and Molise 'Giuseppe Caporale' (IZS Teramo), publishes the data of the surveillance system in a periodical bulletin.

In order to inform citizens and make the collected data available, which is only useful for communication and information purposes, the following information is made available under the CC-BY-4.0 licence

- National evolution data
- Regional data
- Provincial data
- Summary bulletins

## Repository structure
```
west-nile/
│
├── */
│   ├── bulletins/
│   │   ├── WN_News_*.pdf
│   ├── national-trend/
│   │   ├── wn-ita-national-trend-*.csv
│   ├── human-surveillance/
│   │   ├── wn-ita-provinces-human-surveillance-*.csv
│   │   ├── wn-ita-regions-human-surveillance-*.csv
│   ├── mosquito-surveillance/
│   │   ├── wn-ita-mosquito-surveillance-*.csv
│   ├── equids-surveillance/
│   │   ├── wn-ita-equids-surveillance-*.csv
│   ├── birds-surveillance/
│   │   ├── wn-ita-target-birds-surveillance-*.csv
│   │   ├── wn-ita-wild-birds-surveillance-*.csv

```

## Data updates

- Evoulution data about West Nile Italy:  every week on Wednesday

<img src="https://github.com/fbranda/west-nile/blob/main/assets/img/esempio-flusso.jpg" alt="WNV" data-canonical-src="https://github.com/fbranda/west-nile/blob/main/assets/img/esempio-flusso.jpg"/>


## Data formats

- [Evoulution data about West Nile Italy (IT)](dati-andamento-wnv-italia.md)<br>

## Example of data use

**Direct download (CSV)**: https://raw.githubusercontent.com/fbranda/west-nile/main/2022/dati-andamento-nazionale/wn-ita-andamento-nazionale-2022.csv

**Python** (requires `pandas`):
```python
import pandas as pd
df = pd.read_csv("https://raw.githubusercontent.com/fbranda/west-nile/main/2022/dati-andamento-nazionale/wn-ita-andamento-nazionale-2022.csv")
```

**R** (requires `httr`):
```r
library(httr)
df <- read.csv(text=content(GET("https://raw.githubusercontent.com/fbranda/west-nile/main/2022/dati-andamento-nazionale/wn-ita-andamento-nazionale-2022.csv")))
```
## Contributions
1) [Mingione, M., Branda, F., Maruotti, A. et al. Monitoring the West Nile virus outbreaks in Italy using open access data. Sci Data 10, 777 (2023)](https://www.nature.com/articles/s41597-023-02676-0)

## License

[CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/deed.it) - [View license](https://github.com/fbranda/west-nile/blob/main/LICENSE.md)
