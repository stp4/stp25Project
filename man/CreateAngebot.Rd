% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Angebot.R
\name{CreateAngebot}
\alias{CreateAngebot}
\title{Angebot erstellen}
\usage{
CreateAngebot(
  Name = "Vorname Name",
  Anrede = "Sehr geehrte Frau",
  Email = " ",
  Tel = " ",
  Adresse = " ",
  Datum = format(Sys.time(), "\%d.\%m.\%Y"),
  Folder = "C:/Users/wpete/Dropbox/1_Projekte",
  KNr = "000",
  x =
    "Position  Aufwand  \\n  Einarbeiten_ins_Thema_und_Kommunikation  2\\n  Aufbereiten_der_Daten_und_Fehlerprüfung  1.5\\n  Deskriptive_Analyse_in_Form_von_Tabelle  0.5 \\n  Deskriptive_Analyse_in_Form_von_Grafiken   3 \\n  Inferenzstatistische_Analyse_(signifikanz_Test)  0.5\\n  Ergebnisbericht_mit_stichwortartigen_Kommentaren\\t 2\\n  ",
  stundensatz = 100,
  Betreff = "Aufwandseinschätzung",
  einleitung = "Vielen Dank für Ihre Anfrage!",
  text = "Ich unterbreite Ihnen hiermit folgendes Angebot: ",
  projekt = "Auswertung im Kontext einer wissenschaftlichen Arbeit",
  text2 = "Die nachfolgende Schätzung erfolgt auf Grund von Erfahrungswerten.",
  text3 =
    paste("Die Abrechnung erfolgt auf geleistete Arbeitsstunden, der Stundensatz beträgt ",
    stundensatz, "Euro.",
    "(Es wird keine Umsatzsteuer ausgewiesen, da die Umsätze gemäß § 6 Abs. 1 Z 27 UStG unecht USt.-befreit sind.)"),
  closing =
    "Ich hoffe, dass Ihnen unser Angebot zusagt und würde mich über Ihren Auftrag sehr freuen.",
  sep = "\\n\\n"
)
}
\arguments{
\item{Name, Anrede, Email, Tel, Adresse}{Kunde}

\item{Datum, Zeit, Folder}{Allgemeine Parameter}

\item{KNr, save_KNr}{Kundennummer normal ist NA}

\item{Aufwand, Thema, Kommentar, Betreff, Stundensatz}{Projekt Daten}
}
\value{
nichts
}
\description{
Angebot erstellen
}
