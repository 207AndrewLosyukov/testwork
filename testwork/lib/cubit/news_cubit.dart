import 'package:flutter_bloc/flutter_bloc.dart';

import '../dependencies.dart';
import '../models/article.dart';
import '../models/network_article.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final dependenciesInstance = Dependencies.instance;

  NewsCubit() : super(NewsEmptyState());

  /* Загрузка всех статей по дате (дата берется из зависимостей),
  пришлось немного закостылять с календарем.
  */
  Future<void> fetchAllNewsByDate() async {
    try {
      emit(NewsLoadingState());
      String year = Dependencies.currSelected.year.toString();
      String month = Dependencies.currSelected.month.toString().length > 1
          ? Dependencies.currSelected.month.toString()
          : "0" + Dependencies.currSelected.month.toString();
      String day = Dependencies.currSelected.day.toString().length > 1
          ? Dependencies.currSelected.day.toString()
          : "0" + Dependencies.currSelected.day.toString();
      final List<Article> _loadedNews =
          await NetworkArticle.getData("$year-$month-$day");
      Dependencies.instance.articles = _loadedNews;
      emit(NewsLoadedState(articles: _loadedNews, isSortByDescending: true));
    } catch (_) {
      emit(NewsErrorState());
    }
  }

  // Поиск новости (локально).
  fetchNewsByQuery(text) {
    try {
      final List<Article> result = searchArticles(text);
      if (result.isNotEmpty) {
        emit(NewsLoadedState(articles: result, isSortByDescending: true));
      } else {
        emit(NewsEmptyState());
      }
    } catch (ex) {
      print(ex);
      emit(NewsErrorState());
    }
  }

  searchArticles(String text) {
    return dependenciesInstance.articles
        .where((element) =>
            (element.title).toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  // Разворот отсортированного списка (сортировка в другом порядке).
  Future<void> getNewsInOtherOrder(isSortByDescending) async {
    emit(NewsLoadedState(
        articles: dependenciesInstance.articles,
        isSortByDescending: isSortByDescending));
  }
}
