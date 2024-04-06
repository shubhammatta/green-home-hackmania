import 'package:flutter/material.dart';
import 'package:greenhome/screen/dashboard.dart';

class SelectHomeType extends StatefulWidget {
  const SelectHomeType({super.key});

  @override
  State<SelectHomeType> createState() => _SelectHomeTypeState();
}

class _SelectHomeTypeState extends State<SelectHomeType> {
  List<Map<String, dynamic>> devices = [
    {'name': 'Aircon', 'status': false, 'hours': 8.0, 'kwh': 1.0},
    {'name': 'Water Heater', 'status': false, 'hours': 1.0, 'kwh': 1.0},
    {'name': 'Refrigerator', 'status': false, 'hours': 24.0, 'kwh': 0.03},
    {'name': 'Washing Machine', 'status': false, 'hours': 0.5, 'kwh': 1.5},
    {'name': 'Computer', 'status': false, 'hours': 10.0, 'kwh': 0.5},
    {'name': 'Lighting', 'status': false, 'hours': 6.0, 'kwh': 0.187},
  ];
  List<String> homeType = [
    'HDB 1-Room',
    'HDB 2-Room',
    'HDB 3-Room',
    'HDB 4-Room',
    'HDB 5-Room',
    'HDB Executive',
    'Apartment',
    'Terrace',
    'Semi-Detached',
    'Bungalow'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Home Type'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: homeType.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the dashboard screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(
                    isNewUser: false,
                    homeType: homeType[index],
                    devices: devices,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
              ),
              margin: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  homeType[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
