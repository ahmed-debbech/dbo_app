import 'dart:convert';

import 'package:dbo_app/dto/News.dart';
import 'package:http/http.dart' as http;
import '../global.dart' as globals;

class NewsService{
  void getAll() async {
    globals.newsList = [];
    try {
      final response = await http.get(Uri.parse(globals.api + '/app/news'));
      List<dynamic> data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        data.sort((a, b) =>
              int.parse(b["time"]) - int.parse(a["time"]));
        for (int i = 0; i <= data.length - 1; i++) {
          globals.newsList.add(News.fromJson(data[i]));
        }
        return;
      }
      globals.newsList = [];
    } catch (e) {
      globals.newsList = [];
    }
  }
}