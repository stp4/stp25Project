#======================================================
 
Name      = "Hansi Dampfl"    
Anrede    = "Sehr geehrter Herr" #Sehr geehrte  und Herren!" #   "Sehr geehrte Damen und Herren!"
Email     = "hans.dampfl@gmx.net"
 
Telfon       = "+43 664 630 72 98"
Adresse	  = " "
Aufwand	  = "6-12 Stunden"
Thema	    = ""

Kommentar = "Pflegewissenschaften"
Betreff   = "statistische Beratung im Zuge einer wissenschaftlichen Arbeit"





VPI = c(  "2020" = 1.4,  "2021" = 2.8,  "2022" = 8.6,  "2023" = 7.8)
#Stundensatz = stp25Project::Stundensatz("Firma", VPI)
Stundensatz = 95 #  stp25Project::Stundensatz("Student", VPI)
Zwischenrechnung = 700
Datum =  format(Sys.time(), "%d.%m.%Y")
Zeit = format(Sys.time(), "%H:%M")
Folder  = "C:/Users/wpete/Dropbox/1_Projekte"
#    /010-Kinderheilkunde   
#    /004-Paediatrics
#    /007-Radiologie
#    /008 Biogena
#    /009-Allgemeinmedizin
#    /002-NURMI
#    /003-Chirurgie-Innsbruck-VTT
#    /006-Forum-Skisport"
#    "C:/Users/wpete/Dropbox/1_Projekte"

# 
#=====================================================
KNr      =    NA 
#=====================================================

angebot <- 
"Position                          Aufwand
Einarbeiten_ins_Thema_und_Kommunikation            2
Aufbereiten_der_Daten_und_Fehlerprüfung            7
Deskriptive_Analyse_in_Form_von_Tabelle            1
Deskriptive_Analyse_in_Form_von_Grafiken           1
Inferenzstatistische_Analyse_(Signifikanz_Test)    3
Ergebnisbericht_mit_Kommentaren	                   5
"
# Angebot -----------------------------------------------------------------


# if(Angebot)  stp25Project::CreateAngebot(
#   Name,  Anrede,  Email,  Tel,  Adresse,
#   Datum,  
#   Folder= paste(Folder, prkt, sep="/"),
#   KNr,
#   x=# Angebot -----------------------------------------------------------------


# if(Angebot)  stp25Project::CreateAngebot(
#   Name,  Anrede,  Email,  Tel,  Adresse,
#   Datum,  
#   Folder= paste(Folder, prkt, sep="/"),
#   KNr,
#   x=angebot, stundensatz=Stundensatz
#   , Betreff="Aufwandseinschätzung"                
#   , einleitung= "Vielen Dank für Ihre Anfrage!"                
#   , text="Ich unterbreite Ihnen hiermit folgendes Angebot: "  
#   , projekt ="Auswertung im Kontext einer wissenschaftlichen Arbeit"
#   , text2= "Die nachfolgende Schätzung erfolgt auf Grund von Erfahrungswerten."
#   , text3= paste("Die Abrechnung erfolgt auf geleistete Arbeitsstunden, der Stundensatz beträgt ",
#                  Stundensatz, "Euro.",
#                  "(Es wird keine Umsatzsteuer ausgewiesen, da die Umsätze gemäß § 6 Abs. 1 Z 27 UStG unecht USt.-befreit sind.)"
#   )
#   , closing= "Ich hoffe, dass Ihnen unser Angebot zusagt und würde mich über Ihren Auftrag sehr freuen."
#   
#   
# ), stundensatz=Stundensatz
#   , Betreff="Aufwandseinschätzung"                
#   , einleitung= "Vielen Dank für Ihre Anfrage!"                
#   , text="Ich unterbreite Ihnen hiermit folgendes Angebot: "  
#   , projekt ="Auswertung im Kontext einer wissenschaftlichen Arbeit"
#   , text2= "Die nachfolgende Schätzung erfolgt auf Grund von Erfahrungswerten."
#   , text3= paste("Die Abrechnung erfolgt auf geleistete Arbeitsstunden, der Stundensatz beträgt ",
#                  Stundensatz, "Euro.",
#                  "(Es wird keine Umsatzsteuer ausgewiesen, da die Umsätze gemäß § 6 Abs. 1 Z 27 UStG unecht USt.-befreit sind.)"
#   )
#   , closing= "Ich hoffe, dass Ihnen unser Angebot zusagt und würde mich über Ihren Auftrag sehr freuen."
#   
#   
# )
#===================================================


# CreateProjekt -----------------------------------------------------------



prkt <- stp25Project::CreateProjekt(
  
  KNr,
  Name,
  Email,
  Telfon,
  Aufwand,
  Stundensatz,
  Thema,
  Kommentar,
  Anrede,
  Betreff,
  Folder,                                       
  Datum = format(Sys.time(), "%d.%m.%Y"),
  Zeit = 0,
  Zwischenrechnung=999,
  Status ="AGB",
  kunden_file = "C:/Users/wpete/Dropbox/1_Projekte/Verwaltung/Kunden.csv",
  bank = "TIROLER SPARKASSE",
  iban = stp25Project::IBAN(),
  bic = "SPIHAT22XXX"
)







prkt
