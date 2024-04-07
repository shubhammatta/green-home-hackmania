import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greenhome/screen/dashboard.dart';

StatefulWidget home(BuildContext context) {
  List<Map<String, dynamic>> userInfo = [
    {'name': 'Aircon', 'status': false, 'hours': 8.0, 'kwh': 1.0},
    {'name': 'Water Heater', 'status': false, 'hours': 1.0, 'kwh': 1.0},
    {'name': 'Refrigerator', 'status': false, 'hours': 24.0, 'kwh': 0.03},
    {'name': 'Washing Machine', 'status': false, 'hours': 0.5, 'kwh': 1.5},
    {'name': 'Computer', 'status': false, 'hours': 10.0, 'kwh': 0.5},
    {'name': 'Lighting', 'status': false, 'hours': 6.0, 'kwh': 0.187},
  ];
  return MaterialApp(
    // set theme color
    theme: ThemeData(
      primaryColor: const Color.fromARGB(255, 42, 191, 193),
    ),
    home: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 50,
                color: const Color(0x00f9fcfe),
              ),
              const Image(
                image: AssetImage('asset/images/SP_MainTop.png'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 249, 252, 254),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(
                            isNewUser: true,
                          ),
                        ),
                      );
                    },
                    child: const Image(
                      image: AssetImage('asset/images/mainWidget.png'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )),
              const Image(
                image: AssetImage('asset/images/SP_MainBottom.png'),
                width: double.infinity,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
