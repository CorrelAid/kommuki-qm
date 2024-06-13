# Datenqualitätscheck Kommuki

HIntergrund: für das Datenvorhaben Kommuki wird ein CMS aufgebaut (Strapi). 
Die Daten liegen bisher bei Politik zum Anfassen e.V. als Google Sheets vor. 
Das Team von PzA sammelt gerade alle Google Sheets zusammen und stellt sicher, dass
die Daten in der [vorgegebenen Struktur](https://docs.google.com/spreadsheets/d/15cjCGNZHcAofvpUDDrsclkAp1BvolZFoO3GZetkFfE4/edit#gid=0) sind.

Die "finalen" Dateien sind in diesem [Google Ordner](https://drive.google.com/drive/folders/1ymtUBRhxO4o-yVhQ8hWD9AgPka-5MA6R).

Wenn kein Access, dann über HumHub Space von Monika/Gregor requesten.


# Setup

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

Rest dann nach Bedarf aka wenn Fehler auftauchen ;) 

## Daten 

- Daten aus Google Drive runterladen und entzippen
- in `raw_data` verschieben

# Report 

```
rmarkdown::render("kommuki_qm.Rmd")
```

oder `kommuki_qm.Rmd` öffnen und auf den blauen knit button drücken.


## was dahinter steckt
- in `kommuki_qm.Rmd` werden checks gefahren für jede Datei in raw data .
- funktionen sind in `functions.R`
- zwischenergebnisse werden rausgeschrieben in results als json.
- dann wird für jedes Excel ein Chunk geknittet (`datei_chunk.Rmd`). hier wird dann das jeweilige Json wieder eingelesen und die Ergebnisse werden dargestellt. 

it's all a big mess. ich war müde :((

