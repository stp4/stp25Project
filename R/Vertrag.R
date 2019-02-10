#' Vertrag Templat tEMPLAT
#'
#' @param name,adr,tel,email,knr,euro,h Kunde
#'
#' @return string
#' @export
#'
 
Vertrag<- function(name="Vorname Nachname",
                   adr="bitte ergänzen",
                   tel="bitte ergänzen",
                   email="bitte ergänzen",
                   knr="0",
                   euro="76",
                   h=" 5-9 Stunden" , Betreff="statistische Beratung"
                   
                   ){
  
  
  Kunde <- paste(
    "Name: ", name, "\n\n",
    "Anschrift: ", adr, "\n\n",
    "Telefon/Skype: ", tel, "\n\n",
    "E-Mail: ", email, "\n\n",    
    "KNr: ",  knr, "\n\n"
  )
  
  
  Kondition <- paste0("**Stundensatz: ", euro, " Euro**\n\n"		,
                     "**geschätzter Aufwand: ",	 h, "**\n") 
  
 msg<-  
paste(
"---
title: Vertrag über Betreuungstätigkeiten
author:
  - Statistik-Peter  
  - Dipl.-Ing. Wolfgang Peter
  - Innsbrucker Straße 14, 6176 Völs
date:  Völs, `r format(Sys.time(), '%d. %m. %Y')`
geometry: left=3cm, right=3cm, top=2.5cm, bottom=2.3cm
lang: de-DE
linestretch: 1.2
fontsize: 11pt
output: 
  pdf_document
---
  
  
Im Folgenden vereinbaren

",
Kunde,
"
		
nachfolgend Kunde genannt				

und

DI Wolfgang Peter		

einen Vertrag über eine ", Betreff, "

",

Kondition,
"		




## §1				
Die Firma Statistik-Peter hilft bei der eigenständigen Erstellung wissenschaftlichen Arbeit mit Schwerpunkt Methoden -Teil. Wir bieten in keiner Form eine Dienstleistung im Sinne von akademischen Ghostwriting an. 
D.h. wir erstellen keine Texte oder Text-Vorlagen. Was wir anbieten ist eine Hilfestellung für zukünftige Akademiker, ihre wissenschaftliche Arbeit selbständig zu erstellen. Wir beraten welche statistischen Methoden geeignet sind, eine wissenschaftliche Fragestellung zu prüfen. Wir arbeiten dabei interaktiv mit dem Diplomanden/in, wobei die Interpretation, Beschreibung und Verteidigung der Ergebnisse allein vom Diplomanden/in erfolgt.


## §2				
Die statistische Auswertung und Beratung wird von DI Wolfgang Peter nach bestem Wissen und Gewissen durchgeführt. Eine Erfolgsgarantie besteht nicht. Es gelten die DFG-Empfehlungen zur Sicherung guter wissenschaftlicher Praxis (www.dfg.de). 	

## §3				
Die Betreung kann jederzeit von einer der beiden Seiten beendet werden. In diesem Fall sind vom Kunden nur die geleisteten Stunden zu entgelten. 

## §4				
Jegliche Inhalte wissenschaftlicher Arbeiten werden vertraulich behandelt und Dritten nicht zugänglich gemacht.



## §5				
Das Honorar für die Auswertung berechnet sich aus der tatsächlich erbrachten Leistungen zum vereinbarten Stundensatz. Zwischenrechnungen werden erstellt, wenn ein Betrag von 350 Euro überschritten wird.				


## §6	


Die Tabellen und Grafiken werden von der Firma Statistik-Peter mit der Software R im APA-Style Format erstellt.	

## §7				
Für diese Geschäftsbeziehungen und die gesamten Rechtsbeziehungen der Vertragspartner gilt das Recht der Bundesrepublik Österreich. Ausschließlicher Gerichtsstand für alle, sich aus dem Vertragsverhältnis unmittelbar oder mittelbar ergebenden Streitigkeiten ist Innsbruck.


## Bankverbindung:	Raiffeisenbank Kematen			
+ IBAN: 	AT08 3626 0000 0052 4652			
+ BIC: 	RZTIAT22260			








# Anmerkung zur Auswertung und den verwendeten Methoden

Die von mir verwendeten statistischen Methoden basieren vor allem auf den Empfehlungen von Bortz [4] sowie Sachs [7].
Die Darstellung der Ergebnisse entspricht wissenschaftlicher Vorgaben, insbesondere halte ich mich bei den Tabellen und Grafiken sowie der Darstellung statistischer Kennzahlen an die Vorgaben von APA-Style[2]. (APA-Style ist im Kontext sozialwissenschaftlicher Forschung quasi der Gold-Standard hinsichtlich des Berichtens von Ergebnissen.)

Die Ergebnisse kann ich entweder in MS-Word, MS-Excel, Open-Office, LaTex, HTML sowie die Grafiken als PDF, jpg, gif oder Windows Metafile weitergeben. Rohdaten kann ich in einem für Statistik-Software lesbaren Format weitergeben z.B. für R, SPSS, Minitab.

Ich kann keine Ergebnis-Darstellungen in proprietären-Formaten wie z.B. MATLAB, Minitab, SPSS, SAS oder STATA erstellen. Die Auswertung erstelle ich mit der Software R [8].

Was ich explizit nicht mache, sind alle Tätigkeiten die das Arbeitsfeld von Grafikern beinhalten. Darunter fallen, das Einbinden von Schrifttypen, Einfügen von Hintergrundbildern und Logos, das designen von Grafiken und Tabellen nach künstlerischen Vorgaben, das Erstellen von Druckvorlagen, alles was mit dem Begriff corporate identity in Verbindung gebracht werden kann, sowie der Nachbau von z.B. Excel-Grafiken und Tabellen aus Vorlagen.


## Literatur

[1] Achim Bühl, (2014), SPSS 22 Einführung in die moderne Datenanalyse, 14. aktualisierte Auflage, Pearson

[2] APA, 2009, Publication Manual of the American Psychological Association

[3] Daniel Wollschläger (2012), Grundlagen der Datenanalyse mit R: Eine anwendungsorientierte Einführung 2. Aufl., Heidelberg: Springer

[4] Jürgen Bortz, Nicola Döring, (2006), Forschungsmethoden und Evaluation, Heidelberg: Springer

[5] Jürgen Bortz, Christof Schuster, (2010), Statistik für Human- und Sozialwissenschaftler, 7. Aufl., Heidelberg: Springer
[6] John Fox, Sanford Weisberg, (2011), An R Companion to Applied Regression, Second Edition, Sage

[7] Lothar Sachs, Jürgen Hedderich, (2006), Angewandte Statistik, 12.Aufl. Heidelberg: Springer

[8] R Core Team (2015). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL http://www.R-project.org/.			




# Datenschutzerklärung				


Wir verarbeiten Ihre personenbezogenen Daten, die unter folgende Datenkategorien fallen:				
  
  - Name/Firma,				
- Geschäftsanschrift und sonstige Adressen des Kunden,				
- Kontaktdaten (Telefonnummer, Telefaxnummer, E-Mail-Adresse, etc.)				

Sie haben uns Daten über sich freiwillig zur Verfügung gestellt und wir verarbeiten diese Daten auf Grundlage Ihrer Einwilligung zu folgenden Zwecken:				
  
  - Betreuung des Kunden				

Sie können diese Einwilligung jederzeit widerrufen. Ein Widerruf hat zur Folge, dass wir Ihre Daten ab diesem Zeitpunkt zu oben genannten Zwecken nicht mehr verarbeiten. Für einen Widerruf wenden Sie sich bitte an: Wolfgang Peter				
Die von Ihnen bereit gestellten Daten sind weiters zur Vertragserfüllung bzw. zur Durchführung vorvertraglicher Maßnahmen erforderlich. Ohne diese Daten können wir den Vertrag mit Ihnen nicht abschließen.				

Wir speichern Ihre Daten bis zur Beendigung der Auftragsarbeit. Für die Speicherung verwenden wir die Dienste von a1.net und dropbox.com sowie als Email-Provider gmail.com.				


Ihre Daten werden zumindest zum Teil auch außerhalb der EU bzw. des EWR verarbeitet, und zwar in USA. Das angemessene Schutzniveau ergibt sich aus einem Angemessenheitsbeschluss der Europäischen Kommission nach Art 45 DSGVO.				


## Rechtsbehelfsbelehrung			

Ihnen stehen grundsätzlich die Rechte auf Auskunft, Berichtigung, Löschung, Einschränkung, Datenübertragbarkeit und Widerspruch zu. Dafür wenden Sie sich an uns. Wenn Sie glauben, dass die Verarbeitung Ihrer Daten gegen das Datenschutzrecht verstößt oder Ihre datenschutzrechtlichen Ansprüche sonst in einer Weise verletzt worden sind, können Sie sich bei der Aufsichtsbehörde beschweren. In Österreich ist die Datenschutzbehörde zuständig.				
")
  
 
msg
 
  }