/* get services für historische ereignisse erstellen  */

import 'package:flutter_kalender/services/get_model.dart';
import 'package:http/http.dart' as http;







class GetServices{

  Future<WikiModel?> getServices() async {
  final now = DateTime.now();
  final month = now.month;
  final day = now.day; // aktuellen tag und monat ermitteln und in url einfügen für anfrage 
  var data = http.Client();
  var url = Uri.parse('https://de.wikipedia.org/api/rest_v1/feed/onthisday/events/09/16');
  var response = await data.get(url);
  if (response.statusCode == 200){
    var jsonString = response.body;
    return  WikiModel.fromJson(jsonString as Map<String, dynamic>);
  } return null;
  }
 
}