// ignore_for_file: depend_on_referenced_packages

import 'package:globo_gym/data/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  //https://api.openweathermap.org/data/2.5/weather?q=London&appid=a93298df7d63f4f8790032189988b372
  // This address is made of 4 parts the https ,thee domain or authority, the path and the paramerters
  // in this call the protocol is https
  //  the domain or authority is api.openweaathermap.org
  // the path is 'data/2.5/weather
  // the parameter is ?q.....
  final String authority = 'api.openweathermap.org';
  final String path = 'data/2.5/weather';
  final String apikey = 'a93298df7d63f4f8790032189988b372';

  Future<Weather> getWather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appId': apikey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response result = await http.get(uri);
    Map<String, dynamic> data = json.decode(result.body);
    Weather weather = Weather.fromJson(data);

    return weather;
  }
}
