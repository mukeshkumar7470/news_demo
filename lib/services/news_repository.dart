import 'dart:convert';

import 'package:http/http.dart' as http;

import '../consts/Consts.dart';
import '../models/api_model.dart';

class NewsRepository {
  Future<List<Articles>> fetchNews() async {
    var response = await http.get(Uri.parse(Consts.news_url));
    var data = jsonDecode(response.body);

    List<Articles> _articleModelList = [];

    if (response.statusCode == 200) {
      for (var item in data["articles"]) {
        Articles _artcileModel = Articles.fromJson(item);
        _articleModelList.add(_artcileModel);
      }
      return _articleModelList;
    } else {
      return _articleModelList; // empty list
    }
  }
}
