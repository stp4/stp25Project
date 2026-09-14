#' @rdname CreateProjekt
#' @export
#' @return character LaTex String
#' @examples
#' # example code
#' 
#' 
#'  Rechnung(
#' KNr = "123",
#' Name = "Hans Dampf",
#' Telefon = "+43 123 456789",
#' Email = "Hans_dampf@hotmail.com",
#' Anrede = "Sehr geehrter Herr",
#' bank = "TIROLER SPARKASSE",
#' iban = "AT89 2050 3033 XXXX XXXX",
#' bic = "SPIHAXXXXXX",
#' file_rechnung="Rechnung.qmd")
#' 
Rechnung <- function(
    KNr = "000",
    Name = "Vorname Nachname",
    Telefon = "+43 123 456789",
    Email = "v.n@hotmail.com",
    Anrede = "Sehr geehrter Herr",
    Betreff = "statistische Beratung im Zuge einer wissenschaftlichen Arbeit",
    bank = "TIROLER SPARKASSE",
    iban = "AT89 2050 3033 XXXX XXXX",
    bic = "SPIHAXXXXXX",
    Adresse = "", # not used
    stundenliste = "stundenliste.R",
    file_rechnung = NULL, #   "Rechnung.qmd", #not used
    ...
){
  
  
  Email <-  gsub("_", "\\\\\\_", Email)
  invoice <- paste0(format(Sys.time(), '%m%d'), KNr)
  nachname <- tryCatch(stringr::str_split(Name, " ")[[1]][2], error = function(e) Name)
  if(is.na(nachname)) nachname <- Name
  
  qmd_rcng <- glue::glue('
---
format:
  pdf:
    documentclass: scrlttr2
    papersize: a4
    pdf-engine: pdflatex
    keep-tex: false
    include-in-header:
      - text: |
          \\usepackage[ngerman]{babel}
          \\usepackage{booktabs}
          \\KOMAoptions{
            fontsize=12pt,
            paper=a4,
            enlargefirstpage=true,
            pagenumber=botright
          }
          \\setkomavar{fromname}{Dipl.-Ing. Wolfgang Peter}
          \\setkomavar{fromaddress}{Innsbrucker Straße 14\\\\6176 Völs}
          \\setkomavar{fromphone}{+43 699 8153 12345}
          \\setkomavar{fromemail}{w.peter@statistik.at}
          \\setkomavar{subject}{Honorarnote}
          \\setkomavar{invoice}{<<invoice>>}
          \\setkomavar{customer}{<<KNr>>}
          \\setkomavar{date}{\\today}
---


```{r setup-knit, include=FALSE}
library(knitr)
opts_chunk$set(echo = FALSE,warning = FALSE)
RECHNUNG <- TRUE
source("stundenliste.R")
```



```{=latex}
\\begin{letter}{%
  <<Name>>\\\\\\
  
  <<Telefon>>\\\\\\
  
  <<Email>>%
}

\\opening{<<Anrede>> <<nachname>>,}

ich erlaube mir, Ihnen für die <<Betreff>> folgende Honorarnote zu übermitteln.

In der Rechnung wird keine Umsatzsteuer ausgewiesen, da die Umsätze gemäß § 6 Abs. 1 Z 27 UStG (Kleinunternehmer) unecht USt.-befreit sind.

Steuer-Nr. 81 248/5589, Leistungszeitraum: `r leistungszeitraum `



`r knitr::kable(Stundenliste, format = "latex", booktabs = TRUE)`

\\vspace{1em}
Zu zahlender Betrag `r paste0(sprintf("%1.1f", euro), "0")` Euro

\\vspace{1.5em}
Bankverbindung: <<bank>>

IBAN: <<iban>>

BIC: <<bic>>

Ich ersuche Sie, den Rechnungsbetrag auf 
mein Geschäftskonto zu überweisen und danke für Ihren Auftrag.

\\closing{Mit freundlichen Grüßen}
\\end{letter}

', 
.open = "<<", 
.close = ">>")
  
  
  if (!is.null(file_rechnung)) {
    rty <- file(file_rechnung, encoding = "UTF-8")
    write(qmd_rcng, file = rty)
    close(rty)
    message("Quarto-Rechnung erfolgreich generiert: ", file_rechnung)
    return(NULL)
  }
  else
    return(qmd_rcng)
}

