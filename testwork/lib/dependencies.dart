import 'models/article.dart';
import 'navigator.dart';
import 'models/network_article.dart';

// Зависимости.
class Dependencies {
  /* Статьи, чтобы не выгружать по каждому запросу,
  обновляются только при изменении даты. Поиск производится локально.
  Изначально выгружались в отсортированном порядке, сортировка в другую
  сторону - переворотом списка.
  */
  List<Article> articles;
  // Навигатор.
  final AppNavigator navigator;
  static final DateTime today = DateTime.now();
  static DateTime currSelected = DateTime.now();

  static late Dependencies _instance;

  Dependencies._(this.navigator, this.articles);

  static Future<Dependencies> init() async {
    return _instance = Dependencies._(
      AppNavigator(),
      // Инициализация.
      await NetworkArticle.getData("${today.year}-${today.month}-${today.day}"),
    );
  }

  static Dependencies get instance => _instance;
}
