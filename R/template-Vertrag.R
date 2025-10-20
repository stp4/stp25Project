#' @rdname CreateProjekt
#' @export
Vertrag<- function(
    KNr,
    Name,Email,Telfon,Aufwand,Stundensatz,
    Anrede,Betreff,
    Zwischenrechnung,
    bank,iban,bic){
  

Kunde <- paste(
    " ", Name, " \n\n",
    "Telefon: ", Telfon, ", E-Mail: ", Email, "\n\n"
  )
  
  
  Kondition <- paste0("**Stundensatz: ", Stundensatz, " Euro**\n\n"		,
                     "**geschätzter Aufwand: ",	 Aufwand, "**\n") 
  
  
paste(
"---
title: Vertrag über Betreuungstätigkeit
author:
  - Statistik-Peter
  - Dipl.-Ing. Wolfgang Peter
  - Innsbrucker Straße 14, 6176 Völs
date:  Völs, `r format(Sys.time(), '%d.%m.%Y')`
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
		
nachfolgend Kunde genannt	und

DI Wolfgang Peter (Statistik-Peter)

einen Vertrag über eine ", Betreff, ".

",

Kondition,
"

KNr: ",  KNr, 
"		


## §1				
Die Firma Statistik-Peter hilft bei der eigenständigen Erstellung 
wissenschaftlichen Arbeit mit Schwerpunkt Methoden -Teil. Wir bieten 
in keiner Form eine Dienstleistung im Sinne von akademischen Ghostwriting an. 
D.h. wir erstellen keine Texte oder Text-Vorlagen. Was wir anbieten 
ist eine Hilfestellung für zukünftige Akademiker, ihre wissenschaftliche 
Arbeit selbständig zu erstellen. Wir beraten welche statistischen Methoden 
geeignet sind, eine wissenschaftliche Fragestellung zu prüfen. Wir arbeiten 
dabei interaktiv mit dem Diplomanden/in, wobei die Interpretation, Beschreibung 
und Verteidigung der Ergebnisse allein vom Kunden erfolgt.


## §2				
Die statistische Beratung und Auswertung erfolgt nach bestem Wissen und Gewissen 
durch **DI Wolfgang Peter** unter Beachtung der **DFG-Empfehlungen zur Sicherung 
guter wissenschaftlicher Praxis** ([www.dfg.de](https://www.dfg.de)).  
Eine Erfolgsgarantie wird nicht übernommen.

Der Kunde verpflichtet sich, **aktiv an der Durchführung des Auftrags mitzuwirken**.  
Insbesondere hat der Kunde alle für die Bearbeitung erforderlichen Informationen, 
Unterlagen und Daten vollständig, korrekt und rechtzeitig bereitzustellen. Dies betrifft insbesondere:

- die **Forschungsfrage** und den **wissenschaftlichen Kontext** der Arbeit,  
- eine Beschreibung der **Datengrundlage** (z. B. Stichprobe, Erhebungsmethode, Messinstrumente),  
- sowie – sofern vorhanden – relevante **Literatur** oder theoretische Grundlagen des Fachgebiets.  

Der Kunde trägt dafür Sorge, dass alle übermittelten Daten und Informationen im Rahmen des Auftrags zulässig ist. 


## §3				
Die Betreung kann jederzeit von einer der beiden Seiten beendet werden. 
In diesem Fall sind vom Kunden nur die geleisteten Stunden zu entgelten. 


## §4				
Alle vom Kunden bereitgestellten Unterlagen und Informationen,
werden vertraulich behandelt und Dritten nicht zugänglich gemacht.
Diese Verpflichtung gilt zeitlich unbegrenzt, auch über das Vertragsende hinaus.  

Falls der Auftrag eine **hohe Anforderung an die Geheimhaltung** stellt, 
ist dies **vor Beginn der Bearbeitung** ausdrücklich zu klären und **vertraglich festzuhalten**.
Alle **auftragsbezogenen Daten** werden – sofern nicht anders vereinbart – **für die Dauer 
von einem Jahr** nach Abschluss des Projekts **aufbewahrt**, um eventuelle Rückfragen 
oder Folgeaufträge bearbeiten zu können.  
Nach Ablauf dieser Frist werden die Daten **vollständig und datenschutzkonform gelöscht**.


## §5				
Das Honorar für die Auswertung berechnet sich aus der tatsächlich erbrachten 
Leistungen zum vereinbarten Stundensatz. Zwischenrechnungen werden erstellt, 
wenn ein Betrag von ",Zwischenrechnung ," Euro überschritten wird.				


## §6	
Die Tabellen und Grafiken werden vom Auftragnehmer mit der Software R im APA-Style Format erstellt.	


## §7		
Hat der Auftragnehmer in Verletzung seiner vertraglichen Pflichten dem Kunden 
schuldhaft einen Schaden zugefügt, ist seine Haftung auf die vereinbarte Honorarsumme begrenzt.
Ansprüche des Kundens erlöschen sechs Monate nach Erbringung der jeweiligen Leistung.
Die Haftung für Folgeschäden und entgangenen Gewinn ist – auch bei grober Fahrlässigkeit – ausgeschlossen.
Für diese Geschäftsbeziehungen und die gesamten Rechtsbeziehungen der
Vertragspartner gilt das Recht der Bundesrepublik Österreich. Ausschließlicher 
Gerichtsstand für alle, sich aus dem Vertragsverhältnis unmittelbar oder mittelbar
ergebenden Streitigkeiten ist Innsbruck.


## Bankverbindung: 

", bank, "

IBAN: ", iban, "

BIC: ", bic, "


 



# Anmerkung zur Auswertung und den verwendeten Methoden

Die von mir verwendeten statistischen Methoden basieren vor allem auf den 
Empfehlungen von Bortz [4] sowie Sachs [7].
Die Darstellung der Ergebnisse entspricht wissenschaftlicher Vorgaben, 
insbesondere halte ich mich bei den Tabellen und Grafiken sowie der 
Darstellung statistischer Kennzahlen an die Vorgaben von APA-Style[2]. (Der APA-Style 
ist im Kontext sozialwissenschaftlicher Forschung quasi ein Gold-Standard 
hinsichtlich des Berichtens von Ergebnissen.)

## Technische Umsetzung

Tabellen und Grafiken werden mit der Software **R**[8] im **APA-Style-Format** erstellt.  
Die Ergebnisse können in folgenden Formaten bereitgestellt werden:

- **Text- und Tabellendaten:** MS Word, MS Excel, OpenOffice, LaTeX, HTML  
- **Grafiken:** PDF, JPG, GIF, Windows Metafile  
- **Rohdaten:** gängige Statistikformate (z. B. R, SPSS, Minitab)

Darstellungen in **proprietären Formaten** (z. B. MATLAB, SPSS, SAS, STATA) werden **nicht** erstellt.

Design- oder Layoutarbeiten (Einbindung von Logos, CI-Designs, Hintergrundbildern etc.) 
sind ausdrücklich **nicht Bestandteil der Leistung**.


## Hinweis zur Zusammenarbeit mit Betreuer:innen

Aus meiner Erfahrung hat es sich als äußerst hilfreich erwiesen, die jeweilige **Betreuerin oder den Betreuer** 
der wissenschaftlichen Arbeit frühzeitig darüber zu informieren, dass statistische Beratung in Anspruch genommen wird.  
In den meisten Fällen erleichtert dies die Zusammenarbeit erheblich und verhindert Missverständnisse.  
Ziel ist es, den Fokus auf die inhaltlich relevanten Analysen zu legen, statt Zeit mit unpassenden 
oder überflüssigen Auswertungen zu verbringen.



## Hinweis zum zeitgerechten Abschluss des Projekts

In der Regel kann ein Auftrag **im Kontext einer wissenschaftlichen Arbeit innerhalb 
von etwa 14 Tagen** abgeschlossen werden.  
Die tatsächliche Bearbeitungsdauer hängt jedoch maßgeblich von der **aktiven Mitwirkung 
des Kunden** sowie der **Komplexität der Fragestellung** ab.  
Im Verlauf eines Auftrags kann es vorkommen, dass **unvorhergesehene Probleme oder 
methodische Anpassungen** erforderlich werden, die den zeitgerechten Abschluss des Projekts verzögern.  
Aus diesem Grund kann **weder eine Erfolgsgarantie noch ein verbindlicher Fertigstellungstermin** zugesichert werden.



## Offenlegung meiner Erfahrungen und Qualifikationen

Ich bin seit 2006 als selbstständiger Statistiker tätig und arbeite aktuell als 
Universitätsassistent (Pre-Doc) am Institut für Allgemeinmedizin der Medizinischen Universität Innsbruck.
Meine Hauptaufgaben sind Forschung, Lehre und Datenanalyse.
Ich habe eine naturwissenschaftliche Ausbildung und bin Chemiker mit Vertiefung in Verfahrenstechnik. 
Darüber hinaus habe ich eine universitäre Informatikausbildung und war als Datenbankprogrammierer tätig. 


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

Sie haben uns Daten über sich freiwillig zur Verfügung gestellt und wir 
verarbeiten diese Daten auf Grundlage Ihrer Einwilligung zu folgenden Zwecken:				
  
  - Betreuung des Kunden				

Sie können diese Einwilligung jederzeit widerrufen. Ein Widerruf hat zur Folge, 
dass wir Ihre Daten ab diesem Zeitpunkt zu oben genannten Zwecken nicht mehr verarbeiten. 
Für einen Widerruf wenden Sie sich bitte an: Wolfgang Peter				
Die von Ihnen bereit gestellten Daten sind weiters zur Vertragserfüllung bzw. zur
Durchführung vorvertraglicher Maßnahmen erforderlich. Ohne diese Daten können wir 
den Vertrag mit Ihnen nicht abschließen.				

Wir speichern Ihre Daten bis zur Beendigung der Auftragsarbeit. Für die Speicherung 
verwenden wir die Dienste von a1.net und dropbox.com sowie als Email-Provider gmail.com.				


Ihre Daten werden zumindest zum Teil auch außerhalb der EU bzw. des EWR verarbeitet, 
und zwar in USA. Das angemessene Schutzniveau ergibt sich aus einem Angemessenheitsbeschluss 
der Europäischen Kommission nach Art 45 DSGVO.				


## Rechtsbehelfsbelehrung			

Ihnen stehen grundsätzlich die Rechte auf Auskunft, Berichtigung, Löschung, 
Einschränkung, Datenübertragbarkeit und Widerspruch zu. Dafür wenden Sie sich 
an uns. Wenn Sie glauben, dass die Verarbeitung Ihrer Daten gegen das Datenschutzrecht 
verstößt oder Ihre datenschutzrechtlichen Ansprüche sonst in einer Weise verletzt 
worden sind, können Sie sich bei der Aufsichtsbehörde beschweren. In Österreich ist 
die Datenschutzbehörde zuständig.				
", sep ="")
  
 
 
 
}


