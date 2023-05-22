// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:from_scratch/constants.dart';
import 'package:from_scratch/models/auth.dart';
import 'package:from_scratch/route/index.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SignupModel>(
            create: (context) => SignupModel(),
          ),
          ChangeNotifierProvider<LoginModel>(
            create: (context) => LoginModel(),
          ),
        ],
        child: MaterialApp.router(
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
                labelMedium:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                bodyMedium:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              // Divider theme
              dividerTheme:
                  const DividerThemeData(color: kDivider, thickness: 1)),
          routerConfig: router,
        ));
  }
}
