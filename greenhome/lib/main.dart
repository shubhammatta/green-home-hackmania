import 'package:flutter/material.dart';
import 'package:greenhome/screen/home.dart';

import 'package:greenhome/screen/landing.dart';
import 'package:greenhome/screen/dashboard.dart';
import 'package:greenhome/screen/scan.dart';
import 'package:greenhome/screen/selectHome.dart';

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
        // '/': (context) => const ScanAppliance(),
        '/home': (context) => home(context),
        '/dashboard': (context) => const Dashboard(
              isNewUser: true,
            ),
        '/selecthome': (context) => const SelectHomeType(),
      },
    );
  }
}
