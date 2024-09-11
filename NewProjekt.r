#======================================================
 
Name      = "Clotting-Coils"    
Anrede    = "Sehr geehrter Herr" #  " # " Sehr geehrte  und Herren!" #   "Sehr geehrte Damen und Herren!"
Email     = "dr.m.dampf@gmail.com, dr.dr.hans@gmail.com"
Tel       = "  "
Adresse	  = "Department Radiologie, Anichstrasse 35, 6020 Innsbruck"
Aufwand	  = "6 bis 8 Stunden"
Thema	    = "Radiologie "

Kommentar = ""
Betreff   = "statistische Beratung im Zuge einer wissenschaftlichen Arbeit"
Templat   = "small"
 
#  80  Student
#  85  Doktorand berufsbegleitend
# 100  Klinik
# 135  Firmen
Stundensatz = 150
Zwischenrechnung = 700
Datum =  format(Sys.time(), "%d.%m.%Y")
Zeit = format(Sys.time(), "%H:%M")
Folder  = "C:/Users/stp4/Projekte"
 
# 
#=====================================================
 KNr      =    NA 
 Angebot = FALSE 
#=====================================================


angebot<- "Position                          Aufwand
Einarbeiten_ins_Thema_und_Kommunikation            2
Aufbereiten_der_Daten_und_Fehlerprüfung            2
Deskriptive_Analyse_in_Form_von_Tabelle            1
Deskriptive_Analyse_in_Form_von_Grafiken           1
Inferenzstatistische_Analyse_(Signifikanz_Test)    3
Ergebnisbericht_mit_Kommentaren	                   5

"



#===================================================

 
# CreateProjekt -----------------------------------------------------------



prkt <- stp25Project::CreateProjekt(
  Name,  Anrede,  Email,  Tel,  Adresse,
  Aufwand,
  Thema,  Kommentar,  Betreff,
  Stundensatz,  Datum,  Zeit,
  Folder,
  KNr,
  kunden_file = "C:/Users/stp4/Projekte/Verwaltung/Kunden.csv",
  FunktionsTest = FALSE,
  Templat = Templat,
  zwischenrechnung = Zwischenrechnung,
  
  BANK = "TIROLER SPARKASSE",
  IBAN = "AT89 2050 3033 0288 4626",
  BIC = "SPIHAT22XXX"
)



# Angebot -----------------------------------------------------------------


if(Angebot)  stp25Project::CreateAngebot(
  Name,  Anrede,  Email,  Tel,  Adresse,
  Datum,  
  Folder= paste(Folder, prkt, sep="/"),
  KNr,
  x=angebot, stundensatz=Stundensatz
  , Betreff="Aufwandseinschätzung"                
  , einleitung= "Vielen Dank für Ihre Anfrage!"                
  , text="Ich unterbreite Ihnen hiermit folgendes Angebot: "  
  , projekt ="Auswertung im Kontext einer wissenschaftlichen Arbeit"
  , text2= "Die nachfolgende Schätzung erfolgt auf Grund von Erfahrungswerten."
  , text3= paste("Die Abrechnung erfolgt auf geleistete Arbeitsstunden, der Stundensatz beträgt ",
                 Stundensatz, "Euro.",
                 "(Es wird keine Umsatzsteuer ausgewiesen, da die Umsätze gemäß § 6 Abs. 1 Z 27 UStG unecht USt.-befreit sind.)"
  )
  , closing= "Ich hoffe, dass Ihnen unser Angebot zusagt und würde mich über Ihren Auftrag sehr freuen."

  
  )
  
  
  
  
prkt
