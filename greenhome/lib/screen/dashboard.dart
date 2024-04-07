import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhome/logic/getUserData.dart';
import 'package:greenhome/main.dart';
import 'package:greenhome/screen/scan.dart';
import 'package:greenhome/screen/selectHome.dart';
import 'package:greenhome/screen/userPattern.dart';
import 'package:greenhome/widget/anomalyGraphWidget.dart';
import 'package:greenhome/widget/appBar.dart';
import 'package:greenhome/widget/graphWidget.dart';

const String startMsg =
    'Start saving on your electricity bill today! \n\nLog your appliances and usage habits on our smart platform, and receive personalized insights to optimize your energy consumption.';

class Dashboard extends StatefulWidget {
  final String? homeType;
  final bool isNewUser;
  final Map<String, dynamic> userInfo_;
  static const double ELECTRICITY_TARIFF = 29.89;
  const Dashboard(
      {super.key,
      this.homeType,
      required this.isNewUser,
      this.userInfo_ = const {}});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showNewUserMsg = true;
  bool isLoading = false;
  Map<String, dynamic> userInfo = {};
  final PageController _pageController = PageController();

  @override
  void initState() {
    fetchData();
    userInfo = widget.userInfo_;
    showNewUserMsg = widget.isNewUser;
    debugPrint(widget.homeType.toString());
    widget.homeType != null ? showNewUserMsg = false : '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      userInfo = await getUserData(1234);
    } catch (error) {
      print(error); // Handle the error
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget gettingStartedMsg() {
    return Center(
      child: Opacity(
        opacity: 0.85,
        child: Container(
          width: 281,
          height: 317,
          decoration: ShapeDecoration(
            color: const Color(0xFFFFFDFD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Getting Started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  startMsg,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showNewUserMsg
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SelectHomeType(),
                            ),
                          )
                        : '';
                    showNewUserMsg = false;
                  });
                },
                child: const Text('Start'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardTemplate(
      {required String title,
      double width = 200,
      isNew = false,
      double hrs = 0.0,
      double cost = 0.0}) {
    return GestureDetector(
      onDoubleTap: () {
        // show alert
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Recommend Replacement'),
              content: const Text(
                  'Your electronic device is consuming 15% more energy than your neighbors. Would you like to see some energy-efficient models?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: const Text('See Models'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Next Time'),
                ),
              ],
            );
          },
        );
      },
      child: Opacity(
        opacity: 0.85,
        child: Container(
          height: 150,
          width: width,
          decoration: ShapeDecoration(
            color: const Color(0xFFFFFDFD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: title == 'MyHome'
                    ? Image(
                        image:
                            const AssetImage('asset/images/icon/My Home.png'),
                        width: width / 2.5,
                      )
                    : title == 'Add Device'
                        ? //empty box
                        const SizedBox(
                            width: 1,
                          )
                        : SvgPicture.asset(
                            'asset/images/icon/$title.svg',
                            width: width / 2.5,
                            height: width / 2.5,
                            placeholderBuilder: (BuildContext context) =>
                                const Icon(Icons.error),
                          ),
              ),
              SizedBox(
                width: width - (width / 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isNew
                      ? [
                          Text(title),
                          IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScanAppliance(),
                                ),
                              );
                              // push to the userPattern screen with result variable
                              if (mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserPattern(
                                      scanResult: result,
                                    ),
                                  ),
                                );
                              }
                              print('Result from ScanPage: $result');
                            },
                            icon: const Icon(
                              Icons.add_circle,
                            ),
                          )
                        ]
                      : [
                          // if text is large then line break
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            '$hrs hours',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            '\$$cost',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget liveCard(
      {required String level, double kwh = 0.0, double cost = 0.0}) {
    return Opacity(
      opacity: 0.85,
      child: Stack(children: [
        Container(
          height: 150,
          width: 300,
          decoration: ShapeDecoration(
            color: const Color(0xFFFFFDFD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Image(
                      image: AssetImage('asset/images/icon/My Home.png'),
                      width: 100,
                    ),
                  ),
                  Text('Live Reading',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 42, 191, 193))),
                ],
              ),
              SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$level level',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      '$kwh kw/h',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      '\$$cost',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              }),
        ),
      ]),
    );
  }

  Widget deviceCards(screenWidth, screenHeight) {
    // List<Map<String, dynamic>> devices = [
    //   {'name': 'Aircon', 'status': false, 'hours': 8.0, 'kwh': 1.0},
    //   {'name': 'Water Heater', 'status': false, 'hours': 1.0, 'kwh': 1.0},
    //   {'name': 'Refrigerator', 'status': false, 'hours': 24.0, 'kwh': 0.03},
    //   {'name': 'Washing Machine', 'status': false, 'hours': 0.5, 'kwh': 1.5},
    //   {'name': 'Computer', 'status': false, 'hours': 10.0, 'kwh': 0.5},
    //   {'name': 'Lighting', 'status': false, 'hours': 6.0, 'kwh': 0.187},
    // ];

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: userInfo['devices'].length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: screenWidth / (screenHeight / 4),
        crossAxisCount: 2, // Number of items in a row
        crossAxisSpacing: 10, // Spacing between items horizontally
        mainAxisSpacing: 10, // Spacing between items vertically
      ),
      itemBuilder: (ctx, index) {
        if (index == userInfo['devices'].length) {
          return cardTemplate(
            title: 'Add Device',
            width: screenWidth / 2.5,
            isNew: true,
          );
        }
        return cardTemplate(
          title: userInfo['devices'][index]['name'],
          width: screenWidth / 2.5,
          isNew: userInfo['devices'][index]['status'],
          hrs:
              double.tryParse(userInfo['devices'][index]['hours'].toString()) ??
                  0.0,
          cost: double.parse((userInfo['devices'][index]['kwh'] *
                  userInfo['devices'][index]['hours'] *
                  Dashboard.ELECTRICITY_TARIFF *
                  0.01)
              .toStringAsFixed(2)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 42, 191, 193),
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const GreenHomeAppBar(
          title: appName,
          isTransparent: true,
        ),
        body: isLoading
            ? Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/images/HomeBackground.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(
                  width: screenHeight / 2,
                  height: screenHeight / 2,
                  // make CircularProgressIndicator is centered and 100x100 in size
                  child: const Center(child: CircularProgressIndicator()),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/images/HomeBackground.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: showNewUserMsg
                    ? gettingStartedMsg()
                    : Padding(
                        padding: EdgeInsets.only(
                            top: AppBar().preferredSize.height * 2),
                        child: Column(
                          children: [
                            Center(
                              child: liveCard(
                                  level: 'Green', kwh: 2.5, cost: 1.75),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: screenHeight / 2 + 30,
                              child: PageView(
                                controller: _pageController,
                                children: <Widget>[
                                  SingleChildScrollView(
                                    child: SizedBox(
                                      height: screenHeight / 2 + 20,
                                      child: deviceCards(
                                          screenWidth, screenHeight),
                                    ),
                                  ),
                                  const Center(
                                    child: GraphWidget(
                                        userId: 1234), // To Add Graph Widget
                                  ),
                                  const Center(
                                    child: GraphAnomalyWidget(
                                        userId: 1234), // To Add Graph Widget
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Opacity(
                              opacity: 0.85,
                              child: SizedBox(
                                height: 60,
                                width: screenWidth * 0.95,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  child: PageView(
                                    children: const <Widget>[
                                      Center(
                                          child: Text(
                                        "In 2019, Singapore's total primary energy consumption was around 16 million tonnes of oil equivalent (Mtoe), which represented a 2.5% increase from 2018.",
                                        textAlign: TextAlign.center,
                                      )),
                                      Center(
                                          child: Text(
                                        "The main sources of energy in Singapore's primary energy mix in 2019 were natural gas (95.2%) and others (4.8%), which included oil, coal, and renewable energy sources.",
                                        textAlign: TextAlign.center,
                                      )),
                                      Center(
                                          child: Text(
                                        "Singapore has been actively pursuing renewable energy sources, particularly solar power, to diversify its energy mix. As of 2019, the country had around 350 megawatts (MW) of installed solar photovoltaic capacity.",
                                        textAlign: TextAlign.center,
                                      )),
                                      Center(
                                          child: Text(
                                        "The building and transportation sectors are the largest energy consumers in Singapore, accounting for around 40% and 35% of total energy consumption respectively in 2019.",
                                        textAlign: TextAlign.center,
                                      )),
                                      Center(
                                          child: Text(
                                        "Singapore has set a target to reduce its emissions intensity (emissions per unit of GDP) by 36% from 2005 levels by 2030, and to stabilize its greenhouse gas emissions.",
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
