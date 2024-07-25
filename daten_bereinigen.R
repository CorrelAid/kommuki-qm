library(tidyverse)
excel_dateien <- list.files("data/raw_data/", full.names = TRUE)


all_data <- purrr::map_dfr(excel_dateien, function(dateiname) {
  gsheet_name <- fs::path_ext_remove(fs::path_file(dateiname))
  datensatz <- readxl::read_xlsx(dateiname, sheet = 1)
  if (is.character(datensatz$Einwohnerzahl)) {
    print(gsheet_name)
  }
  # temporary fix
  datensatz$Klassenstufe <- as.character(datensatz$Klassenstufe)
  return(datensatz)
})

# AGS - remove whitespace
all_data <- all_data %>% 
  mutate(AGS = str_trim(str_remove_all(as.character(AGS), " ")))

# mit newlines
# all_data %>% 
#   readr::write_csv("data/cleaned/all_with_newlines.csv", na = "")

# newlines entfernen/ersetzen 
all_data <- all_data %>% 
  mutate(Beschlussempfehlung = str_replace_all(Beschlussempfehlung, "\n", "")) %>% 
  mutate(Begründung = str_replace_all(Begründung, "\n", ""))

all_data %>% 
  readr::write_csv("data/cleaned/alle_ideen_ohne_newlines.csv", na = "")
