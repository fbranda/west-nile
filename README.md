<img src="https://www.iss.it/documents/20126/0/Logo+ISS+%281%29.jpg/ddab26c1-b8ee-b6e7-65a5-e8e1bb168364?t=1605615623448&imagePreview=1" alt="ISS" width="400" />

[Italiano](README.md) - [English](README_EN.md)<br><br>

# Dati West Nile Italia

[![GitHub license](https://img.shields.io/badge/License-Creative%20Commons%20Attribution%204.0%20International-blue)](https://github.com/fbranda/west-nile/blob/main/LICENSE.md)

[Sito dell'Istituto Superiore di Sanità - La sorveglianza dei casi umani di infezione da West Nile e Usutu virus
](https://www.epicentro.iss.it/westnile/bollettino)


In Italia, la sorveglianza epidemiologica dei casi umani di malattia da virus West Nile (Wnv) è regolata dal "[Piano Nazionale di prevenzione, sorveglianza e risposta alle Arbovirosi (PNA) 2020-2025" sottoscritta dalla Conferenza Stato, Regioni e Province autonome il 15 gennaio 2020](https://www.statoregioni.it/media/2371/p-1-csr-rep-n-1-15gen2020.pdf). Il documento integra in un unico Piano la sorveglianza veterinaria (animale ed entomologica) del West Nile virus (WNV) - essenziale per la stima del rischio - e quella dei casi umani. 

Le attività di sorveglianza dei casi umani importati e autoctoni si attuano per tutto l’anno su tutto il territorio nazionale e dai primi di maggio a tutto novembre in tutte le Regioni nelle quali sia stata identificata un’area endemica. In queste aree la sorveglianza dei casi umani deve essere rafforzata e deve essere posta particolare attenzione alla diagnosi di malattia da WNV nella popolazione. Il sistema di segnalazione raccoglie inoltre le positività per Wnv rilevate nei donatori di sangue, emoderivati e di organi, tessuti e cellule, finalizzati all’applicazione delle specifiche misure preventive ed eventuali forme cliniche febbrili riscontrate sul territorio nazionale.

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
│   │   ├── dati-sorveglianza-uccelli-bersaglio
│   │   │   ├── wn-ita-sorveglianza-uccelli-bersaglio-*.csv
│   │   ├── dati-sorveglianza-uccelli-selvatici
│   │   │   ├── wn-ita-sorveglianza-uccelli-selvatici-*.csv
```

## Aggiornamento e flusso dei dati

- Dati andamento West Nile Italia: ogni settimana di mercoledì

[drawing-1.pdf](https://github.com/fbranda/west-nile/files/10157709/drawing-1.pdf)


## Formato dei dati

- [Dati andamento West Nile Italia](dati-andamento-wnv-italia.md)<br>

## Esempio d'uso dei dati

**Download file (CSV)**: https://raw.githubusercontent.com/fbranda/west-nile/main/2022/dati/totale_casi.csv

**Python** (requires `pandas`):
```python
import pandas as pd
df = pd.read_csv("https://raw.githubusercontent.com/fbranda/west-nile/main/2022/dati/totale_casi.csv")
```

**R** (requires `httr`):
```r
library(httr)
df <- read.csv(text=content(GET("https://raw.githubusercontent.com/fbranda/west-nile/main/2022/dati/totale_casi.csv")))
```

## Licenza

[CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/deed.it) - [Visualizza licenza](https://github.com/fbranda/west-nile/blob/main/LICENSE.md)
