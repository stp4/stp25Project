#======================================================
Name      = "Jessica Liebaert"  # M Medizin Z Zahnmedizin
Anrede    = "Sehr geehrte Frau"
# Dr Artzt #v Veterinär
# B BWL  P Psychologie PH Pädagogische Hochschule OÖ
# U Umit/FH-gesund  X Alles ander
# F Firma <jessica.liebaert@me.com>
Email     = "jessica.liebaert@me.com"
Tel       = "+43 660 8134660"
Adresse	  = " "
Aufwand	  = "2-5 Stunden"
Thema	    = "Forschung und Entwicklung"

Kommentar = "kein Kommentar"
Betreff  = "statistische Beratung im Zuge einer wissenschaftlichen Arbeit"
#=====================================================
#  75  Student
#  80  Doktorand berufsbegleitend
#  90  Klinik
# 125  Firmen
Stundensatz = 75
Datum =  format(Sys.time(), "%d.%m.%Y")
Zeit = format(Sys.time(), "%H:%M")
Folder  = "C:/Users/wpete/Dropbox/1_Projekte"
#=====================================================
KNr      = 534
#=====================================================






stp25Project::CreateProjekt(
  Name,
  Anrede,
  Email,
  Tel,
  Adresse,
  Aufwand,
  Thema,
  Kommentar,
  Betreff,
  Stundensatz,
  Datum,
  Zeit,
  Folder,
  KNr,
  kunden_file = "C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv",
  FunktionsTest = FALSE,
  useGoogel = FALSE
)

