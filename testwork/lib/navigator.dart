import 'package:flutter/material.dart';
import 'package:testwork/screens/calendar_screen.dart';
import 'package:testwork/screens/card_screen.dart';

import 'models/article.dart';

class AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  // Открытие страницы с новостью.
  openCardScreen(Article article) =>
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => NewsCard(article: article),
      ));

  /*
   Открытие календаря (было очень больно, но 
   кубит пришлось передать, чтобы прокинуть событие обновления списка по изменению даты).
   */
  openCalendarScreen(cubit) => navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => TableBasicsExample(cubit: cubit),
        ),
      );

  pop() => navigatorKey.currentState?.pop();
}
