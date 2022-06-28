import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testwork/screens/main_screen.dart';
import 'cubit/news_cubit.dart';
import 'dependencies.dart';
import 'navigator.dart';

void main() async {
  await Dependencies.init();
  runApp(
    MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      title: 'News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: BlocProvider<NewsCubit>(
        create: (context) => NewsCubit(),
        child: const MainScreen(),
      ),
    ),
  );
}
