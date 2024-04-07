import 'package:flutter/material.dart';
import 'package:greenhome/logic/getUserData.dart';
import 'package:greenhome/screen/dashboard.dart';

class SelectHomeType extends StatefulWidget {
  const SelectHomeType({super.key});

  @override
  State<SelectHomeType> createState() => _SelectHomeTypeState();
}

class _SelectHomeTypeState extends State<SelectHomeType> {
  bool isLoading = false;

  Map<String, dynamic> userInfo = {};
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
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var data = await getUserData(1234);
      userInfo = data;
    } catch (error) {
      print(error); // Handle the error
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Home Type'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
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
                          userInfo_: userInfo,
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
