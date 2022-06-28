import 'package:testwork/dependencies.dart';

import '../models/article.dart';

abstract class NewsState {}

class NewsEmptyState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  List<Article> articles;
  bool isSortByDescending = true;

  NewsLoadedState({required this.articles, required this.isSortByDescending});
}

class NewsErrorState extends NewsState {}
