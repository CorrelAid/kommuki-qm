# Datenqualitätscheck Kommuki

Hintergrund: für das Datenvorhaben Kommuki gibt es ein CMS (Strapie), in das die Daten geladen werden über eine Hochlademaske.

Die Daten liegen bei Politik zum Anfassen e.V. als Google Sheets vor und müssen einer Struktur entsprechen.

Dieses Projekt enthält 2 Dinge:

1. einen Datenqualitätsreport (`kommuki_datenqualitaet.Rmd`)
2. ein Datenbereinigungsskript um final noch ein paar kleinere Dinge zu bereinigen (`clean_data.R`) und ein csv zu erstellen, was in die Upload-Maske hochgeladen werden kann

# Installation & Setup

Für beide Dinge benötigen wir R Pakete. Diese installieren wir in der R Console. Hierzu den Command kopieren und mit Enter ausführen.

## Packages 

renv installieren: 

```
install.packages("renv")
```

Packages installieren:

```
renv::restore()
```

falls das nicht funktioniert hier die wichtigsten packages:

```
install.packages("tidyverse")
install.packages("rmarkdown")
install.packages("emojifont")
install.packages("fs")
```

Rest dann nach Bedarf aka wenn Fehler auftauchen.


## Daten 

- Daten aus Google Drive runterladen und entzippen
- in `data/raw_data` verschieben

# Datenqualitätsreport

in der R Console:

```
rmarkdown::render("kommuki_datenqualitaet.Rmd")
```

oder `kommuki_datenqualitaet.Rmd` öffnen und auf den blauen knit Button mit dem Wollknäuel drücken.


## Wie es funktioniert 

- in `kommuki_qm.Rmd` werden checks gefahren für jede Datei in raw data .
- funktionen sind in `functions.R`
- Zwischenergebnisse werden rausgeschrieben in `data/results` als json.
- dann wird für jedes Excel ein Chunk geknittet (`single_sheet.Rmd`). hier wird dann das jeweilige JSON wieder eingelesen und die Ergebnisse werden dargestellt. 

geht sicher effizienter und schöner, aber war in der Kürze der Zeit das, was funktioniert hat. 

# Datenbereinigungsskript

1. `daten_bereinigen.R` öffnen und 


# Lizenz

## Daten

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

umfasst: alle Dateien in `data`

Datensatz Kommuki, Politik zum Anfassen e.V., lizensiert unter [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/).

## Code 

umfasst: alle Dateien außerhalb von `data`. 

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

MIT Lizenz, CorrelAid e.V.


