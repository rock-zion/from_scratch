import 'package:flutter/material.dart';
import 'package:from_scratch/constants.dart';
import 'package:from_scratch/route/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Nunito',
        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: kGreen,
            textStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(18),
            foregroundColor: kGreen,
            textStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        // Text theme
        textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 24, color: kDark),
            labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
      ),
      routerConfig: router,
    );
  }
}
