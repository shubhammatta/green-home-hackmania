import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greenhome/screen/dashboard.dart';
import 'package:greenhome/widget/appBar.dart';

class UserPattern extends StatelessWidget {
  const UserPattern({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> devices = [
      {'name': 'Aircon', 'status': false, 'hours': 8.0, 'kwh': 1.0},
      {'name': 'Water Heater', 'status': false, 'hours': 1.0, 'kwh': 1.0},
      {'name': 'Refrigerator', 'status': false, 'hours': 24.0, 'kwh': 0.03},
      {'name': 'Washing Machine', 'status': false, 'hours': 0.5, 'kwh': 1.5},
      {'name': 'Computer', 'status': false, 'hours': 10.0, 'kwh': 0.5},
      {'name': 'Lighting', 'status': false, 'hours': 6.0, 'kwh': 0.187},
      {'name': 'Projector', 'status': false, 'hours': 3.0, 'kwh': 0.83},
    ];
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: false,
        appBar:
            const GreenHomeAppBar(title: 'Usage Detail', isTransparent: false),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Usage habits for: Projector'),
              const Text(
                  'Our service does not require a physical sensor. However, we need to know how much you use {Appliance Name} to give better recommendations.'),
              const Text(
                  'How often do you use each {Appliance Name} in a day?'),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // container with round corners and left side will have icon and right side will have text. Color is primary theme color
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(
                                devices: devices,
                                isNewUser: false,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: screenWidth / 2 - 30,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.light_mode,
                                color: Colors.white,
                              ),
                              Text(
                                'Rarely',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth / 2 - 20,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.light_mode,
                              color: Colors.white,
                            ),
                            Text(
                              'Frequently',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // container with round corners and left side will have icon and right side will have text. Color is primary theme color
                      Container(
                        width: screenWidth / 2 - 30,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.light_mode,
                              color: Colors.white,
                            ),
                            Text(
                              'Sometimes',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth / 2 - 20,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.light_mode,
                              color: Colors.white,
                            ),
                            Text(
                              'Other',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
