import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhome/logic/updateUserData.dart';
import 'package:greenhome/screen/dashboard.dart';
import 'package:greenhome/widget/appBar.dart';

class UserPattern extends StatefulWidget {
  final Map<String, dynamic> scanResult;
  const UserPattern({super.key, required this.scanResult});

  @override
  State<UserPattern> createState() => _UserPatternState();
}

Future<void> _updateData(scanResult) async {
  try {
    var result = await updateUserData(scanResult);
    // Handle result
  } catch (error) {
    // Handle error
  }
}

class _UserPatternState extends State<UserPattern> {
  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> userInfo = [
    //   {'name': 'Aircon', 'status': false, 'hours': 8.0, 'kwh': 1.0},
    //   {'name': 'Water Heater', 'status': false, 'hours': 1.0, 'kwh': 1.0},
    //   {'name': 'Refrigerator', 'status': false, 'hours': 24.0, 'kwh': 0.03},
    //   {'name': 'Washing Machine', 'status': false, 'hours': 0.5, 'kwh': 1.5},
    //   {'name': 'Computer', 'status': false, 'hours': 10.0, 'kwh': 0.5},
    //   {'name': 'Lighting', 'status': false, 'hours': 6.0, 'kwh': 0.187},
    //   {'name': 'Projector', 'status': false, 'hours': 3.0, 'kwh': 0.83},
    // ];
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: false,
        appBar:
            const GreenHomeAppBar(title: 'Usage Detail', isTransparent: false),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text('Projector',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text(
                'Our service does not require a physical sensor. However, we need to know how much you use the projector to give better information.',
                style: TextStyle(fontSize: 15),
              ),
              // add text that we found the approximated electricity usage of the projector
              const SizedBox(
                height: 20,
              ),
              Text(
                'We found that the approximated electricity usage of the ${widget.scanResult["Brand"]} - ${widget.scanResult["Model"]} projector is ${(widget.scanResult["EnergyConsumption"] / 12 / 30).toStringAsFixed(2)} kWh per hour.',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'How often do you use the projector in a day?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // container with round corners and left side will have icon and right side will have text. Color is primary theme color
                      GestureDetector(
                        onTap: () {
                          _updateData(widget.scanResult);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(
                                // userInfo: userInfo,
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
                              Image(
                                image: AssetImage(
                                    'asset/images/icon/use_rarely.png'),
                                width: 70,
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
                            Image(
                              image: AssetImage(
                                  'asset/images/icon/use_frequently.png'),
                              width: 70,
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
                            Image(
                              image: AssetImage(
                                  'asset/images/icon/use_sometimes.png'),
                              width: 70,
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
                            Image(
                              image:
                                  AssetImage('asset/images/icon/use_other.png'),
                              width: 70,
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
