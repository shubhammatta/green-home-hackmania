import 'package:flutter/material.dart';

import 'package:greenhome/screen/landing.dart';
import 'package:greenhome/screen/registration.dart';

const String appName = 'Green Home';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 42, 191, 193),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingScreen(context: context),
        '/dashboard': (context) => const Dashboard(
              isNewUser: true,
            ),
      },
    );
  }
}
