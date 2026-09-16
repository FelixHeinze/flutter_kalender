/* get services für historische ereignisse erstellen  */

import 'package:flutter_kalender/services/get_model.dart';
import 'package:http/http.dart' as http;







getServices() async {
  //aktuelles datum monat und jahr ermitteln und in die url einfügen
  var url = Uri.parse('https://de.wikipedia.org/api/rest_v1/feed/onthisday/events/6/9');
  var response = await http.get(url);
try {
   if (response.statusCode == 200) { // erfolgreiche antwort 200 standarderfolg bei get , put anfragen
    final wikiModel = wikiModelFromJson(response.body); 
    return wikiModel.events;
  }
}catch (e) {
  print(e.toString()); //fehlerausgabe bswp 404
}
 
}