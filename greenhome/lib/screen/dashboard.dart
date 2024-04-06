import 'package:flutter/material.dart';
import 'package:greenhome/main.dart';
import 'package:greenhome/widget/appBar.dart';
import 'package:greenhome/widget/gettingStarted.dart';

class Dashboard extends StatefulWidget {
  final bool isNewUser;
  const Dashboard({super.key, required this.isNewUser});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const GreenHomeAppBar(
          title: appName,
          isTransparent: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/images/HomeBackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: widget.isNewUser ? const GettingStartedMsg() : const Center(),
        ),
      ),
    );
  }
}
