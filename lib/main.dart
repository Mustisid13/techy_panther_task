import 'package:flutter/material.dart';
import 'package:techy_panther_task/screens/user_list_screen.dart';
import 'package:techy_panther_task/utils/globals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(appBarTheme: const AppBarTheme(color: kPrimaryColor),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
            )
          )
          ),
      home: const UserListPage(),
    );
  }
}
