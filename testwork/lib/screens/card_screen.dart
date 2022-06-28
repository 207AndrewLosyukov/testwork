import 'package:flutter/material.dart';

import '../models/article.dart';

class NewsCard extends StatelessWidget {
  Article article;

  NewsCard({required this.article, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  height: 300,
                  width: 250,
                  child: Image.network(
                    article.image,
                    height: 100,
                    // Обработка ошибки загрузки фото.
                    errorBuilder: (context, exception, stackTrace) {
                      return Image.network(
                        "https://avatars.mds.yandex.net/i?id=62270f769c2c58e673e1df935c1a9895_sr-5586404-images-thumbs&n=13",
                        height: 100,
                      );
                    },
                  ),
                ),
              ),
              const Text(
                "Title",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 5, 159, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  article.title,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                "Author",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 5, 159, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  article.author,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                "Date",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 5, 159, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  article.publishedAt,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                "Url",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 5, 159, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  article.url,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
