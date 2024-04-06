import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenhome/main.dart';
import 'package:greenhome/screen/scan.dart';
import 'package:greenhome/screen/selectHome.dart';
import 'package:greenhome/widget/anomalyGraphWidget.dart';
import 'package:greenhome/widget/appBar.dart';
import 'package:greenhome/widget/graphWidget.dart';

const String startMsg =
    'Start saving on your electricity bill today! \n\nLog your appliances and usage habits on our smart platform, and receive personalized insights to optimize your energy consumption.';

class Dashboard extends StatefulWidget {
  final String? homeType;
  final bool isNewUser;
  static const double ELECTRICITY_TARIFF = 29.89;
  const Dashboard({super.key, this.homeType, required this.isNewUser});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showNewUserMsg = true;

  @override
  void initState() {
    showNewUserMsg = widget.isNewUser;
    debugPrint(widget.homeType.toString());
    widget.homeType != null ? showNewUserMsg = false : '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
    return Opacity(
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
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: title == 'MyHome'
                  ? Image(
                      image: const AssetImage('asset/images/icon/My Home.png'),
                      width: width / 2.5,
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
    );
  }

  Widget deviceCards(screenWidth, screenHeight) {
    List<Map<String, dynamic>> devices = [
      {'name': 'Aircon', 'status': false, 'hours': 8.0, 'kwh': 1.0},
      {'name': 'Water Heater', 'status': false, 'hours': 1.0, 'kwh': 1.0},
      {'name': 'Refrigerator', 'status': false, 'hours': 24.0, 'kwh': 0.03},
      {'name': 'Washing Machine', 'status': false, 'hours': 0.5, 'kwh': 1.5},
      {'name': 'Computer', 'status': false, 'hours': 10.0, 'kwh': 0.5},
      {'name': 'Lighting', 'status': false, 'hours': 6.0, 'kwh': 0.187},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: devices.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: screenWidth / (screenHeight / 4),
        crossAxisCount: 2, // Number of items in a row
        crossAxisSpacing: 10, // Spacing between items horizontally
        mainAxisSpacing: 10, // Spacing between items vertically
      ),
      itemBuilder: (ctx, index) {
        if (index == devices.length - 1) {
          return cardTemplate(
            title: 'Add Device',
            width: screenWidth / 2.5,
            isNew: true,
          );
        }
        return cardTemplate(
          title: devices[index]['name'],
          width: screenWidth / 2.5,
          isNew: devices[index]['status'],
          hrs: devices[index]['hours'],
          cost: double.parse((devices[index]['kwh'] *
                  devices[index]['hours'] *
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
          child: showNewUserMsg
              ? gettingStartedMsg()
              : Padding(
                  padding:
                      EdgeInsets.only(top: AppBar().preferredSize.height * 2),
                  child: Column(
                    children: [
                      Center(
                        child: cardTemplate(title: 'MyHome', width: 300),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: screenHeight / 2,
                        child: PageView(
                          children: <Widget>[
                            SingleChildScrollView(
                              child: SizedBox(
                                height: screenHeight / 2,
                                child: deviceCards(screenWidth, screenHeight),
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
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
