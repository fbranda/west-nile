<img src="https://github.com/fbranda/west-nile/blob/main/assets/img/logo-wn.jpg" alt="WNV" data-canonical-src="https://github.com/fbranda/west-nile/blob/main/assets/img/logo-wn.jpg" width="900"/>

[Italiano](README.md) - [English](README_EN.md)<br><br>

# Dati West Nile Italia

[![GitHub license](https://img.shields.io/badge/License-Creative%20Commons%20Attribution%204.0%20International-blue)](https://github.com/fbranda/west-nile/blob/main/LICENSE.md)

[Sito dell'Istituto Superiore di Sanità - La sorveglianza dei casi umani di infezione da West Nile e Usutu virus
](https://www.epicentro.iss.it/westnile/bollettino)


In Italia, la sorveglianza epidemiologica dei casi umani di malattia da virus West Nile è regolata dal "[Piano Nazionale di prevenzione, sorveglianza e risposta alle Arbovirosi (PNA) 2020-2025" sottoscritta dalla Conferenza Stato, Regioni e Province autonome il 15 gennaio 2020](https://www.statoregioni.it/media/2371/p-1-csr-rep-n-1-15gen2020.pdf). Il documento integra in un unico Piano la sorveglianza veterinaria (animale ed entomologica) del West Nile virus (WNV) - essenziale per la stima del rischio - e quella dei casi umani. 

Le attività di sorveglianza dei casi umani importati e autoctoni si attuano per tutto l’anno su tutto il territorio nazionale e dai primi di maggio a tutto novembre in tutte le Regioni nelle quali sia stata identificata un’area endemica. In queste aree la sorveglianza dei casi umani deve essere rafforzata e deve essere posta particolare attenzione alla diagnosi di malattia da WNV nella popolazione. Il sistema di segnalazione raccoglie inoltre le positività per WNV rilevate nei donatori di sangue, emoderivati e di organi, tessuti e cellule, finalizzati all’applicazione delle specifiche misure preventive ed eventuali forme cliniche febbrili riscontrate sul territorio nazionale.

La sorveglianza umana è coordinata al livello nazionale dall’Istituto Superiore di Sanità e dal Ministero della Salute che trasmette i dati alla Commissione europea e all’ECDC. Le Regioni, in piena autonomia definiscono i documenti normativo-programmatici per la Sorveglianza epidemiologica e di laboratorio sul loro territorio e trasmettono i dati all’ISS e al Ministero. Il Dipartimento di Malattie infettive dell’Istituto Superiore di Sanità, con il coordinamento dell’Ufficio V della Direzione Generale della Prevenzione del ministero della Salute e in collaborazione con il Centro studi malattie esotiche (Cesme) dell’Istituto zooprofilattico sperimentale dell'Abruzzo e del Molise “Giuseppe Caporale” (Izs Teramo), pubblica i dati del sistema di sorveglianza in un bollettino periodico.

Per informare i cittadini e mettere a disposizione i dati raccolti, utili ai soli fini comunicativi e di informazione, vengono rese disponibili, con licenza CC-BY-4.0, le seguenti informazioni:

- Dati Andamento nazionale
- Dati regioni
- Dati province
- Bollettini riepilogativi

## Struttura del repository
```
west-nile/
│
├── */
│   ├── bollettini/
│   │   ├── WN_News_*.pdf
│   ├── dati-andamento-nazionale/
│   │   ├── wn-ita-andamento-nazionale-*.csv
│   ├── dati-sorveglianza-umana/
│   │   ├── wn-ita-province-sorveglianza-umana-*.csv
│   │   ├── wn-ita-regioni-sorveglianza-umana-*.csv
│   ├── dati-sorveglianza-entomologica/
│   │   ├── wn-ita-sorveglianza-entomologica-*.csv
│   ├── dati-sorveglianza-equidi/
│   │   ├── wn-ita-sorveglianza-equidi-*.csv
│   ├── dati-sorveglianza-uccelli/
│   │   ├── wn-ita-sorveglianza-uccelli-bersaglio-*.csv
│   │   ├── wn-ita-sorveglianza-uccelli-selvatici-*.csv

```

## Aggiornamento e flusso dei dati

- Dati andamento West Nile Italia: ogni settimana di mercoledì

<img src="https://github.com/fbranda/west-nile/blob/main/assets/img/esempio-flusso.jpg" alt="WNV" data-canonical-src="https://github.com/fbranda/west-nile/blob/main/assets/img/esempio-flusso.jpg"/>


## Formato dei dati

- [Dati andamento West Nile Italia](dati-andamento-wnv-italia.md)<br>

## Esempio d'uso dei dati

**Download diretto (CSV)**: https://raw.githubusercontent.com/fbranda/west-nile/main/2022/national-trend/wn-ita-national-trend-2022.csv

**Python** (richiede `pandas`):
```python
import pandas as pd
df = pd.read_csv("https://raw.githubusercontent.com/fbranda/west-nile/main/2022/national-trend/wn-ita-national-trend-2022.csv")
```

**R**:
```r
df <- read.csv("https://raw.githubusercontent.com/fbranda/west-nile/main/2022/national-trend/wn-ita-national-trend-2022.csv")
```
## Contributi
1) [Mingione, M., Branda, F., Maruotti, A. et al. Monitoring the West Nile virus outbreaks in Italy using open access data. Sci Data 10, 777 (2023)](https://www.nature.com/articles/s41597-023-02676-0)
   
## Licenza

[CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/deed.it) - [Visualizza licenza](https://github.com/fbranda/west-nile/blob/main/LICENSE.md)
