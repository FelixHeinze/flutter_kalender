
/*   document.title = "Heute ist der " + tag + "." + monat + "." + jahr;
    document.getElementById("mainHeadline").innerHTML = "Kalenderblatt vom " + tag + "." + monat + "." + jahr;
    document.getElementById("datumAusgeschrieben").innerHTML = tag + " " + monatAusgeschrieben + " " + jahr;
    document.getElementById("wochentag").innerHTML = tagAusgeschrieben;
    document.getElementById("wieviele").innerHTML = Math.floor((tag - 1) / 7) + 1 + ".";
    document.getElementById("wochentagAusgeschrieben").innerHTML = tagAusgeschrieben;
    const monatsnamen = document.getElementsByClassName("monatsname"); //vereinfachung in schleife wenn mehrere elemente mit der gleichen klasse vorhanden sind
    for (let i = 0; i < monatsnamen.length; i++) {
        monatsnamen[i].innerHTML = monatAusgeschrieben;
    }
    document.getElementById("jahreszahl").innerHTML = jahr;
    document.getElementById("xTag").innerHTML = (Math.floor((_objectDatum - _objectXtag) / (1000 * 60 * 60 * 24)) + 1);
    document.getElementById("xJahresende").innerHTML = (Math.round((_objectXjahr - _objectDatum) / (1000 * 60 * 60 * 24)));
    document.getElementById("monatstage").innerHTML = (new Date(jahr, monat, 0).getDate());
    // dynamische inhalte für html elemente mit id, die in der index.html datei vorhanden sind, werden hier geschrieben
    document.getElementById("ereignisseDatum").innerHTML = tag + "." + monat + "." + jahr;
*/
import 'package:flutter/material.dart';

class InfoDay extends StatelessWidget {
 const InfoDay({super.key});

 @override
 Widget build(BuildContext context) {
 return const Scaffold(
 body: Center(
 child: Text('Hello World'),
 //vorgabe aus vorheriger aufgabe siehe oben
 //hier wird nur statisch die info zu dem akutellem tag ausgegeben ( der wievielte usw)
 
 ),
 );
 }
}