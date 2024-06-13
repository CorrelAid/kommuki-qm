test_spaltennamen <- function(datensatz, spalten_vorgabe) {
  glues <- c()
  if (setequal(spalten_vorgabe, colnames(datensatz))) {
    return(list(is_ok = TRUE, glues = glues))
  }
  
  nicht_vorhanden <- setdiff(spalten_vorgabe, colnames(datensatz))
  
  if (length(nicht_vorhanden) > 0) {
    glues <- c(glues, glue::glue("Sollte vorhanden sein, ist aber nicht da: {nicht_vorhanden}"))
  }
  
  zu_viel <- setdiff(colnames(datensatz), spalten_vorgabe)
  if (length(zu_viel) > 0) {
    glues <- c(glues, glue::glue("Sollte so nicht vorhanden sein: {zu_viel}"))
  }
  return(list(is_ok = FALSE, glues = glues))
  
}

make_long <- function(datensatz, spaltenname) {
  datensatz <- datensatz %>% 
    tidyr::separate_longer_delim({{spaltenname}}, ",") 
    
  datensatz[[spaltenname]] <- trimws(datensatz[[spaltenname]])
  return(datensatz)
}

test_spaltenwerte <- function(datensatz, spaltenname, erlaubt, make_long = FALSE) {
  
  if(!is_spalte_available(datensatz, spaltenname)) {
    return(list(is_ok = FALSE, 
                glues = glue::glue("Variable {spaltenname} nicht im Datensatz. Bitte zuerst fixen"), 
                spaltenname = spaltenname))
  }
  if (make_long) {
    datensatz <- make_long(datensatz, spaltenname)
  }
  
  # reale werte 
  werte <- unique(datensatz[[spaltenname]])

  
  # na
  is_na_erlaubt <- NA %in% erlaubt
  has_nas <- NA %in% werte
  
  glues <- c()
  nicht_erlaubt <- setdiff(werte, erlaubt)
  
  if (length(nicht_erlaubt) > 0) {
    emoji <- emojifont::emoji("x")

    # NAs only flagged if not allowed 
    if (has_nas) {
      n_na <- sum(is.na(datensatz[[spaltenname]]))
      glues <- c(glues, glue::glue("{emoji} Die Spalte {spaltenname} darf keine leeren Werte enthalten, hat aber {n_na}."))
    }
      
    glues <- c(glues, glue::glue("{emoji} Dieser Wert für Spalte {spaltenname} ist nicht erlaubt: {nicht_erlaubt}"))

    return(list(is_ok = FALSE, glues = glues, spaltenname = spaltenname))
  } else {
    emoji <- emojifont::emoji("white_check_mark")
    list(is_ok = TRUE, glues = glues, spaltenname = spaltenname)
  }
}

get_unique_values <- function(datensatz, spaltenname) {
  if(!is_spalte_available(datensatz, spaltenname)) {
    emoji <- emojifont::emoji("x")
    return(list(is_ok = FALSE, 
                glue::glue("{emoji} Variable {spaltenname} nicht im Datensatz. Bitte zuerst fixen"),
                spaltenname = spaltenname))
  }
  
  unique_vals <- unique(datensatz[[spaltenname]])
  list(is_ok = TRUE, 
       glues = glue::glue("Werte für diese Variable: {unique_vals}"),
       spaltenname = spaltenname)
} 

is_spalte_available <- function(datensatz, spaltenname) {
  return(spaltenname %in% colnames(datensatz))
}
