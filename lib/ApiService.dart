import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String endpoint = 'https://api.waqi.info/feed/';
  final String? key = dotenv.env['AIR_API_KEY'];

  Future<Map<String, dynamic>> getAirQuality(String keyword) async {
    String url = '$endpoint$keyword/?token=$key';

    http.Response response = await http.get(Uri.parse(url));
    log(response.body.toString());

    Map<String, dynamic> jsonBody = json.decode(response.body);
    return jsonBody;
  }
}
