import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greenhome/screen/dashboard.dart';

StatefulWidget home(BuildContext context) {
  List<Map<String, dynamic>> devices = [
    {'name': 'Aircon', 'status': false, 'hours': 8.0, 'kwh': 1.0},
    {'name': 'Water Heater', 'status': false, 'hours': 1.0, 'kwh': 1.0},
    {'name': 'Refrigerator', 'status': false, 'hours': 24.0, 'kwh': 0.03},
    {'name': 'Washing Machine', 'status': false, 'hours': 0.5, 'kwh': 1.5},
    {'name': 'Computer', 'status': false, 'hours': 10.0, 'kwh': 0.5},
    {'name': 'Lighting', 'status': false, 'hours': 6.0, 'kwh': 0.187},
  ];
  return MaterialApp(
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
                          builder: (context) => Dashboard(
                            devices: devices,
                            isNewUser: true,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                      ),
                      margin: const EdgeInsets.only(top: 20),
                      child: const Center(
                        child: Text(
                          'Welcome to GreenHome',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
