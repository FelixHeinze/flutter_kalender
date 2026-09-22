/* get services für historische ereignisse erstellen  */

import 'dart:convert';

import 'package:flutter_kalender/services/get_model.dart';
import 'package:http/http.dart' as http;







class GetServices {
  Future<WikiModel?> getServices() async {
    final now = DateTime.now();
    final month = now.month;
    final day = now.day;

    final url = Uri.parse(
      'https://de.wikipedia.org/api/rest_v1/feed/onthisday/events/09/22',
    );

    final response = await http.Client().get(url);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return WikiModel.fromJson(decoded);
      }
    }

    return null;
  }
}