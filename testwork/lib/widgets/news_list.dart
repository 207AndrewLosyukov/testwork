import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/news_cubit.dart';
import '../cubit/news_state.dart';
import '../dependencies.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Построение списка в зависимости от состояния кубита.
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsEmptyState) {
          return const Center(
              child: Text(
            "No news by this query",
            style: TextStyle(fontSize: 16),
          ));
        }

        if (state is NewsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is NewsLoadedState) {
          if (!state.isSortByDescending) {
            state.articles = state.articles.reversed.toList();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(0.0),
            scrollDirection: Axis.vertical,
            itemCount: state.articles.length,
            itemBuilder: (context, index) => Material(
              child: GestureDetector(
                onTap: () {
                  Dependencies.instance.navigator
                      .openCardScreen(state.articles[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            state.articles[index].image,
                            height: 100,
                            // Обработка незагружаемой картинки.
                            errorBuilder: (context, exception, stackTrace) {
                              return Image.network(
                                "https://avatars.mds.yandex.net/i?id=62270f769c2c58e673e1df935c1a9895_sr-5586404-images-thumbs&n=13",
                                height: 100,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: getSection(state.articles[index].title),
                        ),
                        Expanded(
                          child: getSection(state.articles[index].author),
                        ),
                        Expanded(
                          child: getSection(state.articles[index].publishedAt),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(
          child: Text("Неизвестная ошибка"),
        );
      },
    );
  }

  Widget getSection(String section) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 50.0),
      child: SizedBox(
        height: 120,
        child: Text(
          section,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
          overflow: TextOverflow.fade,
          maxLines: 3,
        ),
      ),
    );
  }
}
