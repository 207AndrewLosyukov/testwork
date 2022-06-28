import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'article.dart';

class NetworkArticle {
  /* Парсинг json'а.
   Сортировка по сути происходит здесь, потому что ее можно указать в теле запроса.
   Единственный параметр - дата.
   */
  static Future<List<Article>> getData(String date) async {
    Uri url = Uri.parse(
        'https://newsapi.org//v2/everything?q=iOS&from=$date&to=$date&sortBy=publishedAt');
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "bfe5e164806e4323b4b62460dadc4a41"
      },
    );

    var decodedData = jsonDecode(response.body);

    if (decodedData['status'] != 'ok') throw Exception();

    List<Article> articles = [];

    int count = min(decodedData['totalResults'], 100);
    decodedData = decodedData['articles'];

    for (int i = 0; i < count; ++i) {
      articles.add(
        Article(
          author: decodedData[i]['author'] ?? "Unknown",
          title: decodedData[i]['title'] ?? "Unknown",
          publishedAt: decodedData[i]['publishedAt'] ?? "Unknown",
          image: decodedData[i]['urlToImage'] ??
              "https://avatars.mds.yandex.net/i?id=62270f769c2c58e673e1df935c1a9895_sr-5586404-images-thumbs&n=13",
          url: decodedData[i]['url'] ?? "No url",
        ),
      );
    }
    return articles;
  }
}
