import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhome/logic/getUserData.dart';
import 'package:greenhome/screen/dashboard.dart';
import 'package:greenhome/widget/appBar.dart';

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
  List<String> homeIcons = [
    'asset/images/icon/HDB_1bed.svg',
    'asset/images/icon/HDB_2bed.svg',
    'asset/images/icon/HDB_3bed.svg',
    'asset/images/icon/HDB_4bed.svg',
    'asset/images/icon/HDB_5bed.svg',
    'asset/images/icon/HDB_exec.svg',
    'asset/images/icon/Apartment.svg',
    'asset/images/icon/Terrace.svg',
    'asset/images/icon/SemiDetached.svg',
    'asset/images/icon/Bungalow.svg'
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
      extendBodyBehindAppBar: true,
      appBar: const GreenHomeAppBar(
        title: 'Select your home type',
        isTransparent: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/HomeBackground.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: homeIcons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.5,
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
                          color: const Color.fromARGB(184, 255, 255, 255),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          // set shadow for the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 15,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        child: Center(
                          child:
                              // add svg image
                              SvgPicture.asset(
                            homeIcons[index],
                            width: 70,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
