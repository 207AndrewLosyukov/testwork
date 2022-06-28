import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testwork/cubit/news_cubit.dart';
import 'package:testwork/dependencies.dart';
import 'package:testwork/widgets/news_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState({Key? key});
  bool isSortByDescending = true;
  TextEditingController searchController = TextEditingController();
  late final NewsCubit cubit;

  @override
  void initState() {
    super.initState();
    // Инициализация кубита.
    cubit = BlocProvider.of<NewsCubit>(context);
    cubit.fetchAllNewsByDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Текстовое поле.
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 60.0),
            child: SizedBox(
              height: 80,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Get News!',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                        255,
                        5,
                        159,
                        255,
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                autocorrect: true,
                controller: searchController,
                onChanged: cubit.fetchNewsByQuery,
              ),
            ),
          ),
          //  Верхние кнопочки.
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 5, 159, 255)),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: TextButton(
                      child: isSortByDescending
                          ? const Text(
                              "Sort by ascending date",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 5, 159, 255),
                              ),
                            )
                          : const Text(
                              "Sort by descending date",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 5, 159, 255),
                              ),
                            ),
                      onPressed: () {
                        // Засетил текст на кнопочке, чтобы не писать отдельную логику кубита.
                        setState(() {
                          isSortByDescending = !isSortByDescending;
                        });
                        cubit.getNewsInOtherOrder(isSortByDescending);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 5, 159, 255)),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: TextButton(
                        child: const Text(
                          "Select date",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 5, 159, 255),
                          ),
                        ),
                        onPressed: () {
                          Dependencies.instance.navigator
                              .openCalendarScreen(cubit);
                        }),
                  ),
                ),
              ),
            ],
          ),
          // Подписи к столбцам.
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15.0),
            child: Row(
              children: [
                getHeadline("Preview"),
                getHeadline("Title"),
                getHeadline("Author"),
                getHeadline("Date"),
              ],
            ),
          ),
          const Expanded(
            child: NewsList(),
          ),
        ],
      ),
    );
  }

  // Для декомпозиции кода.
  Widget getHeadline(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
        overflow: TextOverflow.fade,
        maxLines: 3,
      ),
    );
  }
}
